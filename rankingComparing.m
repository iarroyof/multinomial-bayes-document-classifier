% Use:
% [perTr perV fails scrClasses] = rankingComparing (Ctr, Ct, Cs, Cv)
%
% This script give us statistical data about classification results. 'perTr'
% is the percentage of precision obtained from classifying the training set,
% 'perV' is the percentaje of precision obtained from classifying the
% validation set, for 'fails{1}' each indice represents each class present
% in feature space partition and each element represents frequency of bad
% classification made by classifier; in the other hand, each indice of 
% 'fails{2}' represents each CD in the validation set and its elements are
% ones (classification failed) or zeros (successful classification). Finally 
% each indice of 'scrClasses' represents same than'fails{1}' but its 
% elements represents how many elements are present in each class according
% to feature space partition made previously.
% Concerning to input parameters, 'Ctr' is the example vector for the 
% training set made by training professor, 'Cr' is the classification vector 
% obtained by classifier, 'Cs' is the examples vector for the validation set 
% made by the training professor. 'Cv' is the classification result obtained
% from the classifier for the validation set.

function [perTr perV fails scrClasses] = rankingComparing (Ctr, Ct, Cs, Cv)
score = 0;
freqFails = zeros (1, max([max(Ctr) max(Cs)]));
indicesVFailed = zeros (length(Cs), 1);
scrClasses = zeros (2, max([max(Ctr) max(Cs)]));
for i = 1:length(Ctr)
    if Ctr(i) ~= Ct(i)
        score = score + 1;
        freqFails(Ctr(i)) = freqFails(Ctr(i)) + 1;
    end
    scrClasses(1,Ctr(i)) = scrClasses(1,Ctr(i)) + 1;
end
perTr = 100-(score/length(Ctr))*100;

score = 0;
for i = 1:length(Cs)
    if Cv(i) ~= Cs(i)
        score = score + 1;
        freqFails(Cs(i)) = freqFails(Cs(i)) + 1;
        indicesVFailed(i) = 1;
    end
    scrClasses(2,Cs(i)) = scrClasses(2,Cs(i)) + 1;
end
perV = 100-(score/length(Cs))*100;
fails = {freqFails;indicesVFailed};
