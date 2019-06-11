function [n,u,r,it,D] = initializeIterative(A,b)
if(size(A,1) ~= size(A,2) || size(A,1) ~= size(b,1))
    error('Invalid dimensions');
elseif(any(diag(A))==0)
    error("The matrix can't have zeroes in the main diagonal");
end

n = size(A,1);
u = zeros(n,1);
r = b; % u0 = {0}
it = 0;
D = diag(A);
end