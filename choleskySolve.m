% Solves a system in the form Cx = b
% A is a lower triangular matrix such that A*A^t=C
function [sol] = choleskySolve(A,B)
    if(size(A,1) ~= size(A,2) || size(B,1) ~= size(A,1))
        error('Invalid dimensions.');
    end
    sol = zeros(size(A,1), size(B,2));
    for i=1:size(B,2)
        sol(:,i) = trinf(A,B(:,i));
        sol(:,i) = trsup(A',sol(:,i),1:size(A,1));
    end
end