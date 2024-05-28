function status = setup(tableRow, auxiliary)
    %SETUP This function drives all of the helper functions. 
    % After the files are changed, the output channels are selected.  Finally,
    % this function calls the testdriver function to do the simulation.

    TempID = auxiliary{6};
    testNum = auxiliary{4};
    testDur = auxiliary{2};
    DT = auxiliary{3};
    
    % ******************************
    % Section One: Simulation set up
    % ******************************
     
    % Make the README file for the test
    readmeTempID = TempID+"/README_TEMPLATE.txt";
    header = make_readme(tableRow,readmeTempID,testNum,testDur,DT);
    
    % Specify the wind conditions in the InflowFile 
    wind_input = string(tableRow(1,1).Variables);
    readfile_ID = TempID + "/IEA-15-240-RWT/IEA-15-240-RWT_InflowFile.dat";
    writefile_ID = "Simulate" + "/IEA-15-240-RWT/IEA-15-240-RWT_InflowFile.dat";
    status = chg_wnd(readfile_ID,writefile_ID,wind_input);
    
    % Change the main .fst file
    expName = auxiliary{1};
    readfile_ID = TempID + "/IEA-15-240-RWT-Monopile/IEA-15-240-RWT-Monopile.fst";
    writefile_ID = "Simulate" + "/IEA-15-240-RWT-Monopile/" + header + ".fst";
    status = make_fst(readfile_ID,writefile_ID,header,testDur,DT,expName,testNum);
    
    % Change the tower file
    inputvec = tableRow(1,2:5).Variables;
    readfile_ID = TempID + "/IEA-15-240-RWT-Monopile/IEA-15-240-RWT-Monopile_ElastoDyn_tower.dat";
    writefile_ID = "Simulate" + "/IEA-15-240-RWT-Monopile/IEA-15-240-RWT-Monopile_ElastoDyn_tower.dat";
    status = chg_tower(readfile_ID,writefile_ID,inputvec);

    % Change the hydrodyn file
    inputvec = tableRow(1,6:9).Variables;
    readfile_ID = TempID + "/IEA-15-240-RWT-Monopile/IEA-15-240-RWT-Monopile_HydroDyn.dat";
    writefile_ID = "Simulate" + "/IEA-15-240-RWT-Monopile/IEA-15-240-RWT-Monopile_HydroDyn.dat";
    status = chg_hydroDyn(readfile_ID,writefile_ID,inputvec);
    
    % Set up is complete
    status = "All files updated";

    % ******************************
    % Section Two: Outputs
    % ******************************
    
    % Now we have to set up the output channels
    disp("Modifying Output Channels for...")
    structure = "Simulate/IEA-15-240-RWT";
    fileIDs = {"/IEA-15-240-RWT_InflowFile.dat",...
        "-Monopile/IEA-15-240-RWT-Monopile_ServoDyn.dat",...
        "-Monopile/IEA-15-240-RWT-Monopile_HydroDyn.dat",...
        "-Monopile/IEA-15-240-RWT-Monopile_ElastoDyn.dat"};
    OutChanID = "OutputChannels.txt";
    startlines = [67,107,148,121];
    status = outputfunc(structure,fileIDs,OutChanID,startlines);

    % ******************************
    % Section Three: Run and Clean-Up
    % ******************************

    % Now we are ready to run the simulation 
    StatusFileID = auxiliary{5};
    status = testdriver(header,expName);

    % As we go, write down the result folder of each completed test to status file:
    ExperimentID = "Data/"+expName;
    if testNum==auxiliary{7}
        test_cell{1,1} = ExperimentID+"/"+header;
    else
        data = gather_up(StatusFileID);
        for j = 1:numel(data)
            test_cell{1,j} = data{1,j};
        end
        test_cell{1,j+1} = ExperimentID+"/"+header;
    end
    fileID = fopen(StatusFileID,'w');
    fprintf(fileID,'%s\n',test_cell{:});
    fclose(fileID);
    % Indicate the progress:
    display = ['Currently finished with test ',num2str(testNum)];
    disp(display)
    status = header + " simulation is complete";
end

