% Applies polynomial interpolation using Newton's method.
function [inter_poly, p_n, div_dif] = newtonLagrangeInterpolation(x_vals, y_vals,varargin)
n = size(x_vals,2)-1;
%Check values

%Initialization
inter_poly = [];
p_n = [1];
div_dif = y_vals;
for i=0:n
    inter_poly = [0 inter_poly] + div_dif(1)*p_n;
    p_n = conv([1, -x_vals(i+1)],p_n);
    
    if (i~=n)
        for j=1:n-i
           div_dif(j) = (div_dif(j)-div_dif(j+1))/(x_vals(j)-x_vals(j+i+1)); 
        end
    end
end

if(nargin == 3)
    uniform_x = linspace(min(x_vals), max(x_vals));
    hold on;
    plot(x_vals,y_vals,'o');
    plot(uniform_x, polyval(inter_poly, uniform_x));
    hold off;
end

end