function status = chg_wnd(readfile_ID,writefile_ID,input)
    %CHG_WND Changes the wind file
    % Wind type is assumed to be 3 (for .bts type)
    data = gather_up(readfile_ID);
    % Edit the 22 line
    form_vector = ["entry",...
        "               FileName_BTS - Name of the Full field wind file to use (.bts)]"];
    formats = {form_vector,[1,0]};
    columns = [1];
    input = "Wind/"+input;
    edit_type = {{"replace",input}};
    data{22} = editor(formats, columns, edit_type, data{22},0);
    check = lay_down(data, writefile_ID);
    status = "Successful wind update";
end

