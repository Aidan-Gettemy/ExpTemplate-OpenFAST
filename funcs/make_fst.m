function status = make_fst(readfile_ID,writefile_ID,header,testDur,DT,expName,num)
    %MAKE_FST This will save the name of the experiment into the fast file, and
    %it will change the test duration and time step within the fast file

    data = gather_up(readfile_ID);

    % Retitle the .fst file
    ttl = "Experiment: "+expName+", Test # "+num2str(num)+"; "+ header;
    data{2} = ttl;

    % Change the test duration in the 6th line
    form_vector2 = ["         ","entry_one",...
        "   TMax            - Total run time (s)"];
    formats = {form_vector2,[0,1,0]};
    columns = [1];
    edit_type = {{"replace",testDur}};
    data{6} = editor(formats, columns, edit_type, data{6},0);

    % Change the time step in the 7th line
    form_vector2 = ["         ","entry_one",...
        "   DT              - Recommended module time step (s)"];
    formats = {form_vector2,[0,1,0]};
    columns = [1];
    edit_type = {{"replace",DT}};
    data{7} = editor(formats, columns, edit_type, data{7},0);
    
    check = lay_down(data, writefile_ID);
    status = "Successful .fst update";
end

