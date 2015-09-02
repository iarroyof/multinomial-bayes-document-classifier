%% This script implements a Multinomial Bayes Classifier. The input
%% parametrs are:
%% Voc --> Vocabulary considered for classification
%% Pc  --> Probability of that class 'c' being predicted
%% Ptc --> Probability of that term 't' appears in class 'c'
%% CDs --> Cell array containing Definitory Contexts as input documets to 
%%         be classified
%% This fucntion returns the class predicted in argMAXc(c) which
%% corresponds the input document at iteration i.

function argMAXc = multBayesClassifier (Voc, Pc, Ptc, CDs)
argMAXc = zeros(length(CDs), 1);
  for i = 1:length(CDs)
    W = extractTermsFromCD (Voc, CDs{i}); %Extracting Voc-terms labels, present in i-th CD
    score = zeros (size(Pc));
    
    for c = 1:length (Pc)
        score(c) = Pc(c);%log10(Pc(c));
        for t = 1:length(W)
            if W(t)
                score(c) = score(c) * Ptc(W(t),c);%+ log10(Ptc(W{t},c)); 
            end
        end
    end
    [ma argMAXc(i)] = max(score);
  end
    