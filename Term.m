%%This script extracts vocabulary contained in a text file which is
%%obtained by describe.com.mx scientific definition browser. Output 'Voc' of this
%%script we hope to be fed to a naive Bayes classifier at the begining.

function [Voc LT file coint] = Term(fileRute, trainF, stopWF)
     
    file = importdata([fileRute trainF]);
    LT = length(file);
    stopW = importdata([fileRute stopWF]);
    terminos = {};
%% This code segment extracts all words from the file
%     for i = 1:LT
%         tl = file{i};
%         inds = isstrprop(tl, 'alpha');
%         a = 0;
%         for j = 1:length(tl)       
%             if inds(j) == 1
%                 term(c) = tl(j); 
%                 c = c + 1;
%                 a = 1;
%             else
%                 if a == 1
%                     terminos{t} = '';
%                     terminos{t} = term;
%                     term = '';
%                     t = t + 1;
%                     c = 1;
%                 end
%                 a = 0;
%                 continue;
%             end 
%         end
%     end
%%All words are in elements of terms[]
    words = regexp(file,'\w+','match');
    for i =1:length(words)
        terminos = [terminos words{i}];
    end
    terms = lower (terminos);
    
    aux = terms;
    file = lower (file);
    all_terms = lower(terms);
%%This segment deteles all terms that are repeated and puts a empty string
%%instead them. Furthermore, it sets in termScore[] the score of each term inside whole training set.
    for i = 1:length(terms)
        if strcmpi('',terms{i})
            continue;
        end
        coin = strmatch(terms{i}, terms, 'exact');
        for j = 2:length(coin)
            terms{coin(j)} = '';
        end
        coin = 0;
    end
    t = 1;
%% This segment eliminates all empty strings and let at R all existing terms 
%% in the file without multi-instances. All words in R are different, there
%% are not case sencitive. All terms are released in lower case by
%% convenience
    for i = 1:length(terms)
        if ~strcmpi('',terms{i})
            aux{t} = '';
            if length(terms{i})<3
                aux{t} = [terms{i}, ' '];
            else
                aux{t} = terms{i};
            end
            t = t + 1;
        end
    end
    R = aux(1:t-1);
    aux = R;
    
    for i = 1:length(all_terms)
        all_terms{i} = [all_terms{i} ' '];
    end
%% This segment eliminates the stopwords from output terms vector and from all_terms vector:
    for i = 1:length(stopW)
        coin = strmatch(stopW{i}, R);
        coint = strmatch(stopW{i}, all_terms);
        if ~isempty(coin)
            R{coin(1)} = '';
            coin = 0;
        end
        if ~isempty(coint)
            for j = 1:length(coint)
                all_terms{coint(j)} = '';
            end
            coint = 0;
        end
    end  
%% Here we counted the total number of ocurrences of each term of all word except the stopwords in
%% all documents, independetly on class that each of they belong.
    coint = 0;
    for i = 1:length(all_terms)
        if ~isempty(all_terms{i});
            coint = coint + 1;
        end
    end
%% Finaly, we obtanied the vocaulary (Voc):
    t = 1;
    for i = 1:length(R)
        if ~strcmpi('',R{i})
            aux{t} = '';
            if length(R{i})<3
                aux{t} = [R{i}, ' '];
            else
                aux{t} = R{i};
            end
            t = t + 1;
        end
    end
    Voc = aux(1:t-1);
    
    %clear file;
    clear stopW;
    clear terminos;
    clear terms;
    clear R;
    clear aux;
    
    