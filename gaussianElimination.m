% Applies Gaussian Elimination on the matrix A.
% It is assumed A already exists in memory.
% It uses a pointer to keep track of permutations.
if(size(A,1) ~= size(A,2))
   error('Las dimensiones de A no son adecuadas.'); 
end
N = size(A,1);
ptr = 1:N; % ptr
for j=1:N 
    %Find pivot using max module criterion      
    [maxVal,i] = max(abs(A(ptr(j:N),j)));
    i = i+j-1;
    if (maxVal == 0)
        error('La matriz no es inversible.');
    end
    %We permute the rows
    [ptr(j),ptr(i)] = deal(ptr(i),ptr(j));
    
    %Operate on each row and make zeroes
    A(ptr(j+1:N),j) = A(ptr(j+1:N),j)/A(ptr(j),j);%Assign multipliers
    for i=j+1:N
        A(ptr(i),j+1:N) = A(ptr(i),j+1:N)-A(ptr(i),j)*A(ptr(j),j+1:N); %Modify A
    end
end