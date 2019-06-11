% Solves an upper triangular system
function [sol] = trsup(A,b,ptr)
n = size(b,1);
b(ptr(n),1)=b(ptr(n),1)/A(ptr(n),n);
for i=n-1:-1:1
    b(ptr(i),1)= (b(ptr(i),1)-dot(A(ptr(i),i+1:n),b(ptr(i+1:n),1)))/A(ptr(i),i);
end
sol = b;
end
