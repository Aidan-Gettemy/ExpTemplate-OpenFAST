function header = make_readme(tableRow,readmeTempID,testNum,testDur,DT)
    %MAKE_README This function makes the readme to document this specific test
    %       input_vector: this holds the following in this order:
    
    % ["windfileID","N1FAS","N2FAS","N1SS","N2SS"]

    %   Output:
    %        header: this is the name for the test

    % Make the header
    windfileID = tableRow(1,1).Variables;
    windname = split(string(windfileID),'-');
    name = windname(2,1); % The seed number is extracted
    for i = 2:5
        var = num2str(tableRow(1,i).Variables);
        name = name + "_" + var;
    end
    
    header = "Test" + num2str(testNum) + "_" + name;

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
    edit_type = {{"replace",string(windfileID)}};
    data{4} = editor(formats,columns,edit_type,data{4},0);

    % Change the Tower Properties
    for i = 9:12
        ttle = split(data{i});
        formats = {[ttle(1),"entry"],[0,1]};
        columns = [2];
        edit_type = {{"replace",tableRow(1,i-7).Variables}};
        data{i} = editor(formats,columns,edit_type,data{i},0);
    end
    
    % Change the test duration and the time step
    formats = {["Simulation_time: ","entry"],[0,1]};
    columns = [2];
    edit_type = {{"replace",testDur}};
    data{15} = editor(formats,columns,edit_type,data{15},0);

    formats = {["DT: ","entry"],[0,1]};
    columns = [2];
    edit_type = {{"replace",DT}};
    data{16} = editor(formats,columns,edit_type,data{16},0);
    
    % Save the new README
    showthis = ['Test Header ', header, ' --- Test Duration: ',testDur];
    disp(showthis)
    save_name = "Simulate/" + header + "_README.txt";
    lay_down(data,save_name)

end

