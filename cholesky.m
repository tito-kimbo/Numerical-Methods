% Cholesky BB^T factorization.
% It is assumed A already exists in memory.
if(~issymmetric(A))
   % Nótese que esta comprobación no es necesaria pues en ejecución el 
   % método indicaría que no es posible factorizar esta matriz.
   error('A must be symmetric.')
end
rows = size(A,1);
cols = size(A,2);
ptr = [1:size(A,1)]; 
if(cols ~= rows)
   error('Invalid dimensions.'); 
end
for i=1:rows
    A(i,i)=A(i,i)-dot(A(i,1:i-1), A(i,1:i-1));
    if(A(i,i)<=0)
        error("A can't be factored.");
    else
        A(i,i) = sqrt(A(i,i));
    end
    for j=i+1:cols
        A(j,i)= (A(i,j)-dot(A(i,1:i-1),A(j,1:i-1)))/A(i,i);
        A(i,j)= 0;
    end
end