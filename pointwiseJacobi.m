% Solves a linear system using pointwise Jacobi method
% Assumes the matrices A and b, the threshold and maxIt are already in memory
[n,u,r,it,D] = initializeIterative(A,b);
x_vals = [0];
norm_b = norm(b);
y_vals = [norm(r)];
error = norm(r)/norm_b;

while it<maxIt &&  error>=threshold
    r = b-A*u;
    u = u + r./D;
    it = it+1;
    
    error = norm(r)/norm_b;
    x_vals = [x_vals, it];
    y_vals = [y_vals, norm(r)];
end

if(error<threshold)
    disp('Estimated solution is ')
    disp(u);
    fprintf('Convergence reached in %d iterations.\n', it);
else
    disp('Iterations completed without reaching convergence.');
end
plot(x_vals,y_vals);
title('Evolution of error')
xlabel('Iteration');
ylabel('Estimated error');