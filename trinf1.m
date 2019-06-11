% Solves an inferior triangular system with 1s in the diagonal
function [sol] = trinf1(A,b, ptr)
n = size(b,1);
for i=2:n
    b(ptr(i),1)= b(ptr(i),1)-dot(A(ptr(i),1:i-1),b(ptr(1:i-1),1));
end
sol = b;
end
