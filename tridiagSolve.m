% Tridiagonal system solver. Accepts the 3 diagonals a,b,c and the
% independent term
function [sol] = tridiagSolve(a,b,c,D)
if(size(a,2) ~= size(c,2) || size(b,2) ~= (size(a,2)+1) || size(b,2) ~= size(D,1))
   error('Las dimensiones no son adecuadas.') 
end
n = size(b,2);
[m,g] = deal(zeros(n));
sol = zeros(n,size(D,2));

m(1) = b(1);
if(m(1) == 0)
 error('Invalid data.');
end
for i=2:n
   m(i) = b(i)-a(i-1)*c(i-1)/m(i-1);
   if(m(i) == 0)
     error('Invalid data.');
   end
end

% To save up on memory we use a double loop
% We could also not use this loop and keep a matrix size G with the size of D
% using matrix operations for more compact code.
for j=1:size(D,2)
    g(1) = D(1,j)/m(1);
    for i=2:n
       g(i) = (D(i,j)-g(i-1)*a(i-1))/m(i);
    end   
    sol(n,j) = g(n);
    for i=n-1:-1:1
        sol(i,j) = g(i)-sol(i+1,j)*c(i)/m(i);
    end
end
end