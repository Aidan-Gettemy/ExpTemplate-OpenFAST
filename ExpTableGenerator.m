clc;close;clear;
%% Run this code to generate a table of inputs for an experiment

% Name of the experiment
expName = "TwBaseDamage1";

% Input Table ID
inTableID = expName+"_inTable.txt";

% The input column names
invarNames = ["windfileID","N1FAS","N2FAS","N1SS","N2SS"...
    ];

% Build the matrix of input values/names

% Number of tests
num = 2;
% Number of numerical inputs
dim = 5;
% windfileID
windfileID = "IEA15MW_ws08.0-1_Seed1.bts";
M = cell(num,dim);
M(1,:) = {categorical(windfileID),1,1,1,1};
M(2,:) = {categorical(windfileID),.8,.8,.8,.8};

% Build the table and save it
inputDesignTab = cell2table(M,"VariableNames",invarNames);
writetable(inputDesignTab,inTableID)
