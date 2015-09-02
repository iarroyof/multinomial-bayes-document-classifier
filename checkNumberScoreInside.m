function Nn = checkNumberScoreInside (A, n)
Nn = 0;
for i = 1:length (A)
    if n == A(i)
        Nn = Nn + 1;
    end
end