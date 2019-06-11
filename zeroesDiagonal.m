function [hasZero] = zeroesDiagonal(A)
    i = 0;
    isZero = false;
    while (~isZero) && i < size(A,1)
        isZero = (A(i,i) == 0);
        i = i+1;
    end
    hasZero = isZero;
end