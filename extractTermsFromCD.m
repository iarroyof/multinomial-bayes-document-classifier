function ter = extractTermsFromCD (V, tl)

    terminos = lower (regexp(tl,'\w+','match'));
    ter = zeros(1,length(terminos));
    t = 1;
    for i = 1:length(V)
        coin = strmatch(V{i}, terminos);
        if ~isempty(coin)
            for j = 1:length (coin)
                %ter{t} = terminos{coin(j)};
                ter(coin(j)) = i;
            end
            coin = 0;
        end
    end 
 