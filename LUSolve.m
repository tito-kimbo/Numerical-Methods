% Solves a set of Lower Upper systems of the form Ax=b.
% Allows pointers to indicate row permutations.
function [sol] = LUSolve(A,B,ptr)
    if(size(A,1) ~= size(A,2) || size(B,1) ~= size(A,1))
        error('Invalid dimensions.');
    end
    sol = zeros(size(A,1), size(B,2));
    for i=1:size(B,2)
        sol(:,i) = trinf1(A,B(:,i),ptr);  
        sol(:,i) = trsup(A,sol(:,i),ptr);
    end
end