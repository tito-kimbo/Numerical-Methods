% Solves an inferior triangular system
function [sol] = trinf(A,b)
n = size(b,1);
b(1,1)=b(1,1)/A(1,1);
for i=2:n
    b(i,1)= (b(i,1)-dot(A(i,1:i-1),b(1:i-1,1)))/A(i,i);
end
sol = b;
end
