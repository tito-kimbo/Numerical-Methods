% Console progrqam that allows to solve linear systems through direct
% methods (Gauss, LU, CHolesky and Tridiagonal system solving).
finish = false;
while(~finish)
    clc;
    disp('Welcome to the linear system solver. Which method do you wish to apply?');
    disp('1. Gaussian Elimination');
    disp('2. LU Factorization');
    disp('3. Cholesky BB^T factorization');
    disp('4. Tridiagonal system solving');
    opt = -1;
    while(opt ~= 1 && opt ~= 2 && opt ~= 3 && opt ~= 4)
        opt = input('Select a valid option: '); 
    end
    
    if(opt == 1 || opt == 2 || opt == 3)
        if(opt ~= 3) 
            A = input('Please introduce the square matrix A: ');
        else
           n = input('Please introduce the number of columns of A: ');
           A = zeros(n,n);
           for i=1:n
               for j=i:n
                   fprintf('Element (%d,%d): ',i,j);
                   A(i,j) = input('');
                   A(j,i) = A(i,j);
               end 
           end
        end
        clc
        disp('The matrix A is')
        disp(A);
        n = size(A,1);
        if size(A,1) ~= size(A,2)
            disp('Invalid dimensions.');
            finish = true; % We abort the operation if not square matrix
        elseif opt == 1
            gaussianElimination;
        elseif opt == 2
            LUFactor;
        else
            cholesky;
        end
        
        while(~finish)
            b = input('Please introduce the elements of the independent term (as column): ');
            
            if size(b,1) ~= n
                disp('Invalid dimensions');
            elseif opt == 3
               choleskySolve(A,b) 
            else
               sol = LUSolve(A,b,ptr);
               sol(ptr(1:n),1)
            end
            finish = ~keepGoing('Do you wish to solve another system? [y/n] ');
        end
    else
        c = input('Please introduce the elements of the upper diagonal (as array): ');
        b = input('Please introduce the elements of the main diagonal (as array): ');
        a = input('Please introduce the elements of the upper diagonal (as array): ');
        d = input('Please introduce the elements of the independent term (as column): ');

        if (size(c,2)==size(a,2) && size(c,2)==(size(b,2)-1) && size(b,2) == size(d,1) ...
            && size(c,1) == 1 && size(b,1) == 1 && size(a,1) == 1 && size(d,2) == 1)
            tridiagSolve(a,b,c,d)
        else
            disp('Invalid dimensions.');
        end
        %Else we abort the operation
    end
    finish = ~keepGoing('Do you wish to continue solving systems? [y/n] ');
end

function [ans] = keepGoing(msg)
    opt = '';
    while(~strcmp(opt, 'y') && ~(strcmp(opt,'n')))
    opt = input(msg, 's');
    disp(opt);
    end
    ans = strcmp(opt,'y');
end