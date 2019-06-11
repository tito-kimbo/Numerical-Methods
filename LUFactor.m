% Factors the matrix A as L*U=A.
% We assume A already exists in memory.
rows = size(A,1);
cols = size(A,2);
ptr = 1:size(A,1);
if(cols ~= rows)
   error('Invalid dimensions.'); 
end
for i=1:rows
    % Upper and lower calculation
    for j=i:cols
       A(i,j)=A(i,j)-dot(A(i,1:i-1),A(1:i-1,j));
       if(abs(A(i,i)) < 1.e-6)
          error('A must be nonsingular.'); 
       end
       if (j>i)
           A(j,i) = (A(j,i)-dot(A(j,1:i-1),A(1:i-1,i)))/(A(i,i));
       end
    end
end