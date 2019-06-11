% Polynomic interpolation through cubic splines.
% Assumes x_vals is ordered from lowest to highest
function [spline] = cubicSplineInterpolation(x_vals, y_vals, type, y1_prime, yn1_prime)
n = size(x_vals,2)-1;
% Check values

% Initialization
H = zeros(1,n);
Lambda = zeros(1,n);
Mu = zeros(1,n);
D = zeros(n+1,1);

% Update
H(1) = x_vals(2)-x_vals(1);
for i=1:n-1
    H(i+1) = x_vals(i+2)-x_vals(i+1);
    Lambda(i+1) = H(i+1)/(H(i)+H(i+1));
    Mu(i) = 1-Lambda(i+1);
    D(i+1) = 6/(H(i)+H(i+1))*((y_vals(i+2)-y_vals(i+1))/H(i+1) - (y_vals(i+1)- y_vals(i))/H(i));
end

% Type-dependant assignments
if(type==1)
    Lambda(1) = 0;
    D(1) = 0;
    Mu(n) = 0;
    D(n+1) = 0;
elseif(type==2)
    Lambda(1) = 1;
    Mu(n) = 1;
    D(1) = 6/H(1)*((y_vals(2)-y_vals(1))/H(1) - y1_prime);
    D(n+1) = 6/H(n)*(yn1_prime - (y_vals(n+1)-y_vals(n))/H(n));
elseif(type==3)
    Lambda(n) = H(1)/(H(1)+H(n));
    Mu(n) = 1 - Lambda(n);
    D(n+1) = 6/(H(1)+H(n))*((y_vals(1)-y_vals(n+1))/H(1) - (y_vals(n+1)-y_vals(n))/H(n));
end

% Create the spline
% Solve system
if(type == 3)
    A = zeros(n,n);
    for i=1:n
       A(i,i) = 2;
       if (i < n)
           A(i+1,i) = Mu(i+1);
           A(i,i+1) = Lambda(i);
       end
    end
    A(1,n) = Mu(1);
    A(n,1) = Lambda(n);
    LUFactor;
    M = [0; LUSolve(A,D(2:n+1),1:n)];
    M(1) = M(n+1);
else
    two = 2*ones(1,n+1);
    M = tridiagSolve(Mu, two, Lambda, D); 
end

% Creating the spline
spline = [];
for i=1:n
    p = [0,0,1,-x_vals(i)];
    p2 = conv(p,p);
    p3 = conv(p,p2);
    
    spline = [spline; ...
            [0,0,0,y_vals(i)] + ((y_vals(i+1)-y_vals(i))/H(i) ...
            - ((2*M(i)+M(i+1))/6*H(i)))*p + M(i)/2*p2(4:7) ...
            + (M(i+1)-M(i))/(6*H(i))*p3(7:10)];
end

% Plot
hold on;
plot(x_vals,y_vals,'o');
for i=1:n
  uniform_x = linspace(x_vals(i),x_vals(i+1));
  plot(uniform_x, polyval(spline(i,:), uniform_x));
end
hold off;

end