%%This function separates CDs for each class...
function partitionedCds = concatenateCDs (Docs, Ck)

Nclases = max (Ck);
elements = zeros(1, Nclases);
 for class = 1:Nclases
    for i = 1:length(Ck)
        if class == Ck(i)
            elements(class) = elements(class) + 1;
        end
    end
end

clusters = zeros(Nclases, max(elements));
for class = 1:Nclases
    j=1;
    for i = 1:length(Ck)
       if class == Ck(i)
          clusters(class,j) = i;
          j = j + 1;
       end
    end
end
i = 1;
%dims = zeros(1, Nclases);
partitionedCds = {'',''};
for class = 1:Nclases
    for j = 1:elements(class)
        partitionedCds{i,class} = lower(Docs{clusters(class,j)});
        i = i + 1;
    end
    %dims(class) = i - 1;
    i = 1;
end