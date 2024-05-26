function header = make_readme(tableRow,readmeTempID,testNum,testDur,DT)
    %MAKE_README This function makes the readme to document this specific test
    %       input_vector: this holds the following in this order:
    
    % ["windfileID","N1FAS","N2FAS","N1SS","N2SS",...
   % "waveMod","waveHt","waveHs","waveTp","waveDir"]

    %   Output:
    %        header: this is the name for the test

    % Make the header name
    % <damagecase>_<turbsize>_<type>_<meanWS>_<waveH>_<peakSpec>_<seed>

    sum = 0;
    for i = 1:4
        sum = sum + tableRow(1,1+i).Variables;
    end
    if sum<4
        name = "100"; % Tower damage
    else
        name = "000"; % Healthy
    end
    turbineSize = "15MW";
    name = name+"_"+turbineSize;
    type = "Mono";
    name = name+"_"+type;
    windfile = tableRow(1,1).Variables;
    components = split(windfile,"_");
    seed = components(3,1);
    ws = split(components(2,1),"ms");
    ws = split(ws(1,1),".");
    ws = ws(1,1)+"pt"+ws(2,1);
    name = name+"_"+ws;
    HS = string(tableRow(1,7).Variables);
    HS = split(HS,".");
    Hs = HS(1,1)+"pt"+HS(2,1);
    name = name+"_HS"+Hs;
    TP = string(tableRow(1,8).Variables);
    TP = split(TP,".");
    try
        TP = TP(1,1)+"pt"+TP(2,1);
    catch
        TP = TP(1,1)+"pt0";
    end
    name = name + "_TP"+TP;
    header = "Test" + num2str(testNum) + "_" + name + "_"+seed;

    % Use gather_up to put the template ReadMe lines into a cell
    data = gather_up(readmeTempID);
    
    % Change the README to reflect current test

    % Change the title
    formats = {["READ ME: ","entry"],[0,1]};
    columns = [2];
    edit_type = {{"replace",header}};
    data{2} = editor(formats,columns,edit_type,data{2},0);

    % Change the WindFileID
    ttle = split(data{4});
    formats = {[ttle(1),"entry"],[0,1]};
    columns = [2];
    edit_type = {{"replace",string(tableRow(1,1).Variables)}};
    data{4} = editor(formats,columns,edit_type,data{4},0);

    % Change the Tower Properties
    for i = 9:12
        ttle = split(data{i});
        formats = {[ttle(1),"entry"],[0,1]};
        columns = [2];
        edit_type = {{"replace",tableRow(1,i-7).Variables}};
        data{i} = editor(formats,columns,edit_type,data{i},0);
    end
    
    % Change all of the wave properties
    for i = 17:20
        ttle = split(data{i});
        formats = {[ttle(1),"entry"],[0,1]};
        columns = [2];
        edit_type = {{"replace",string(tableRow(1,i-11).Variables)}};
        data{i} = editor(formats,columns,edit_type,data{i},0);
    end

    % Change the test duration and the time step
    formats = {["Simulation_time: ","entry"],[0,1]};
    columns = [2];
    edit_type = {{"replace",testDur}};
    data{23} = editor(formats,columns,edit_type,data{23},0);

    formats = {["DT: ","entry"],[0,1]};
    columns = [2];
    edit_type = {{"replace",DT}};
    data{24} = editor(formats,columns,edit_type,data{24},0);
    
    % Save the new README
    showthis = ['Test Header ', header, ' --- Test Duration: ',testDur];
    disp(showthis)
    save_name = "Simulate/IEA-15-240-RWT-Monopile/" + header + "_README.txt";
    lay_down(data,save_name)

end

