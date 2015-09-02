%Use: 
% [D Ts E Es] = divideRand_0 (fileRute, trainF, Eg, TrPercent)
%
% This script extracts random indices from the whole input set stored in
% 'trainF' at the route 'fileRoute'. It uses the examples (original
% labels) in 'Eg' for label the resultant training set with respectives 
% indices. The training set is stored in file 'trainSet.txt' at the same 
% route. The script also returns the training set in cell array 'D' with 
% its respectives labels in array 'E'. Also it returns the validation set
% in 'Ts' (stored in 'validationSet.txt' at the same route) and its 
% respective examples in 'Es'. Dividing is performed in proportion to
% 'TrPercent' which indicates what percentaje of the input set is assigned
% to the training set. Parameter above must be etered by user as a 1-100
% ranged integer (1-100%).
%
% Using example:
% TrPercent = 80;
% [TD Ts E Es] = divideRand_0 ('C:\folder\','fileName.txt', Eg, TrPercent)


function [D Ts E Es] = divideRand_0 (fileRute, trainF, Eg, TrPercent)
file = importdata([fileRute trainF]);
trSize = ceil((TrPercent*0.01)*length(Eg));
D = {[];[]};
Ts = {[];[]};
E = zeros(trSize,1);
Es = zeros(length(Eg)-trSize,1);
%%%%%%
%Creating disordering of indices
indTr = randperm(length(Eg));
%Assign to D according to the new order until percentaje indicated by
%trSize
for i = 1:trSize
    D{i} = file{indTr(i)};
    E(i) = Eg(indTr(i));
end
%Assign remaining CDs to Ts according to the new order until ending of
%file{}.
d = 1;
while i <= length(Eg)
    Ts{d} = file{indTr(i)};
    Es(d) = Eg(indTr(i));
    i = i + 1;
    d = d + 1;
end
%Saving resulting sets at HardDisk
outFileName = 'trainSet.txt';
fid = fopen([fileRute outFileName], 'wt');
for i=1:length(D)
    fprintf(fid, '%s\n', D{i});
end
fclose(fid);

outFileName = ['validationSet' trainF(length(trainF)-12:length(trainF)-4) '.txt'];
fid = fopen([fileRute outFileName], 'wt');
for i=1:length(Ts)
    fprintf(fid, '%s\n', Ts{i});
end
fclose(fid);