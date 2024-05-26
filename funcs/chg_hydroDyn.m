function  status = chg_hydroDyn(readfile_ID,writefile_ID,inputvec)
%CHG_HYDRODYN Modify the rows of the HydroDyn.dat file
%   Detailed explanation goes here

% Get the data from the template file
data = gather_up(readfile_ID);

% Format of inputvec: ["waveMod","waveHs","waveTp","waveDir"]

% Change the WaveMod
txt = "   WaveMod        - Incident wave kinematics model {0: none=still water, 1: regular (periodic), 1P#: regular with user-specified phase, 2: JONSWAP/Pierson-Moskowitz spectrum (irregular), 3: White noise spectrum (irregular), 4: user-defined spectrum from routine UserWaveSpctrm (irregular), 5: Externally generated wave-elevation time series, 6: Externally generated full wave-kinematics time series [option 6 is invalid for PotMod/=0]} (switch)";
form_vector = ["             ","entry",txt];
columns = [2];
formats = {form_vector,[0,1,0]};
edit_type = {{"replace",string(inputvec(1))}}; 
data{9} = editor(formats, columns, edit_type, data{9},1);

% Change the WaveHs
txt = "   WaveHs        - Significant wave height of incident waves (meters) [used only when WaveMod=1, 2, or 3]";
form_vector = ["            ","entry",txt];
columns = [2];
formats = {form_vector,[0,1,0]};
edit_type = {{"replace",string(inputvec(2))}}; 
data{13} = editor(formats, columns, edit_type, data{13},1);

% Change the WaveTp
txt = "	 WaveTp         - Peak-spectral period of incident waves       (sec) [used only when WaveMod=1 or 2]";
form_vector = ["            ","entry",txt];
columns = [2];
formats = {form_vector,[0,1,0]};
edit_type = {{"replace",string(inputvec(3))}}; 
data{14} = editor(formats, columns, edit_type, data{14},1);

% Change the WaveDir
txt = "    WaveDir        - Incident wave propagation heading direction";
form_vector = ["            ","entry",txt];
columns = [2];
formats = {form_vector,[0,1,0]};
edit_type = {{"replace",string(inputvec(4))}}; 
data{18} = editor(formats, columns, edit_type, data{18},1);

check = lay_down(data, writefile_ID);
status = "Succesful HydroDyn properties update.";
end

