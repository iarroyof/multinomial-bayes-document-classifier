%% This function gets score for each term contained in Voc. Each term score is delivered at score(t)

function score = termScoreByClass(textCk, Voc)

score = zeros (1, length(Voc));
    coin = 0;
   
    for t = 1:length(Voc)
        coin = strfind(textCk, char(Voc{t}));    
        for i = 1:length(coin)
            score(t) = score(t) + length (coin{i});
        end
        coin = 0;
    end