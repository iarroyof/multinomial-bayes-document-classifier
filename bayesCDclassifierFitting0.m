%%Call this function like this:
%%[Pc Ptc] = bayesCDclassifierFitting0(C,'C:\Documents and
%%Settings\nacho\Mis
%%documentos\Dropbox\matlabDescribe\','salidaDescribeDeVirus.txt','stopWords_0.txt');

function [V prior priorCond] = bayesCDclassifierFitting0 (Ck, trainingSetFileRute, trainingFile, stopWordsFile)
% Extracting vocabulary (V) and text (docus) from training set of documents
% stored into a file (trainingFile).
[V N docus T] = Term (trainingSetFileRute, trainingFile, stopWordsFile); 
% N --> total number of CDs (documents) in the trainig set. 
% T --> total number of terms of V contained in the training set.
Nclasses = max(Ck); %Just Here can be set the number of clusters found by LAMDA (for instance).
prior = zeros (1, Nclasses);
text_Ck = {'',''};
priorCond = zeros (length(V), Nclasses);
% This function separates the documents 'docus' in 'Nclasses' different
% sets of documents, corresponding to labels in 'Ck':
text_Ck = concatenateCDs(docus, Ck);
for c = 1:Nclasses
    Nc = checkNumberScoreInside (Ck, c); % Calculating the number of training documents contained in the class 'c'. 
    prior(c) = Nc/N;                     % Calculating P(c_k)
    Tck = termScoreByClass (text_Ck(1:Nc, c), V);  % Calculating instance frequency of each term contained in vocabulary for class 'c'
    priorCond(:, c) = (Tck + 1) / ( sum(Tck) + length(V) ); %sum(Tck) is the total number of terms of V, that are present in training documents of class c.
    Tck = 0;
end
clear text_Ck;

