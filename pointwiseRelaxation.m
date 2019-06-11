% Solves a linear system using pointwise relaxation method
% Assumes A,b,threshold,maxIt and w are already in memory
[n,u,r,it,D] = initializeIterative(A,b);
if (w<=0 || w >= 2)
   error('Relaxation parameter must be strictly between 0 and 2.'); 
end
x_vals = [0];
norm_b = norm(b);
y_vals = [norm(r)];
error = norm(r)/norm(b);

while it<maxIt && error>=threshold
    for i=1:n
       r(i) = b(i)-A(i,1:i-1)*u(1:i-1,1)-A(i,i:n)*u(i:n,1); 
       u(i) = u(i)+w*r(i)/D(i);
    end
    it = it+1;
    error = norm(r)/norm_b;
    
    x_vals = [x_vals, it];
    y_vals = [y_vals, error];
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