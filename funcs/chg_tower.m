function status = chg_tower(readfile_ID,writefile_ID,inputvec);
%CHG_TOWER Changes material properties of the tower file

% Get the data from the template file
data = gather_up(readfile_ID);

% We will edit the 20th and 21st lines
% We will edit the 3rd and 4th columns
columns = [4,5]; % column to edit (...,FA,SS)
% The input format is [N1FA,N2FA,N1SS,N2SS]
iter = 1;
for i = 20:21
    txt = split(data(i));
    txt1 = " "+txt{2} + "  " + txt{3}+"  ";% Keep the first two entries 
    form_vector = [txt1,"FA","  ","SS"];
    formats = {form_vector,[0,1,0,1]};
    edit_type = {{"multiply",inputvec(iter)},{"multiply",inputvec(iter+2)}};
    iter = iter+1;
    data{i} = editor(formats, columns, edit_type, data{i},1);
end
check = lay_down(data, writefile_ID);
status = "Succesful tower properties update.";
end

