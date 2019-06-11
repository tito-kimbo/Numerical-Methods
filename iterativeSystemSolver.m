% Console progrqam that allows to solve linear systems through iterative
% methods (Pointwise Jacobi, Successive Over-Relaxation).
finish = false;
while(~finish)
    clc;
    disp('Welcome to the iterative linear system solver. Which method do you wish to apply?');
    disp('1. Pointwise Jacobi');
    disp('2. Successive Over-Relaxation');
    opt = -1;
    while(opt ~= 1 && opt ~= 2)
        opt = input('Select a valid option: '); 
    end
    
    A = input('Please introduce the square matrix A: ');
    threshold = input('Please introduce the convergence threshold: ');
    maxIt = input('Please introduce the maximum number of iterations: ');    
    if opt == 2
        w = input('Please introduce the relaxation factor: ');
    end
    
    clc
    disp('The matrix A is')
    disp(A);
    n = size(A,1);
    if size(A,1) ~= size(A,2)
        disp('Invalid dimensions.');
        finish = true; % We abort the operation if not square matrix
    end

    while(~finish)
        b = input('Please introduce the elements of the independent term (as column): ');

        if size(b,1) ~= n
            disp('Invalid dimensions');
        elseif opt == 1
           pointwiseJacobi;
        else %opt = 2
           pointwiseRelaxation;
        end
        finish = ~keepGoing('Do you wish to solve another system? [y/n] ');
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