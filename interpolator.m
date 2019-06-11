% Console program that does functionwise or pointwise polynomic and spline
% interpolation
finish = false;
while(~finish)
    clc;
    disp('Welcome to the interpolator system. Which method do you wish to apply?');
    disp('1. Polynomic Interpolation');
    disp('2. Spline Interpolation');
    opt = -1;
    while(opt ~= 1 && opt ~= 2)
        opt = input('Select a valid option: '); 
    end
    
    clc;
    disp('What do you wish to interpolate');
    disp('1. A set of points');
    disp('2. A function');
    type = -1;
    while(type ~= 1 && type ~= 2)
        type = input('Select a valid option: ');
    end
    
    clc;
    x_vals = input('Please introduce the vector of X coordinates: ');
    if(type == 1)
        y_vals = input('Please introduce the vector of Y coordinates: ');
    else
        fun = input('Please introduce the function to interpolate: ');
        y_vals = arrayfun(fun, x_vals);
        fplot(fun,[min(x_vals), max(x_vals)], '--r');
    end
    
    if(opt == 1) % We apply polynomic interpolation
        [poly, aux, dd] = newtonLagrangeInterpolation(x_vals, y_vals, 1);
        opt = keepGoing('Do you wish to add a point? [y/n]: ');
        while(opt)
            if(opt)
                
                if(type == 2) 
                    pt = input('Please introduce the new X-coordinate: ');
                    pt = [pt fun(pt)];
                else
                    pt = input('Please introduce the new point (1x2 matrix): ');
                end
                x_vals = [x_vals pt(1)];
                y_vals = [y_vals pt(2)];
                [poly, aux, dd] = addPoint(poly,aux,dd,x_vals,y_vals);
                
                % Graph again
                uniform_x = linspace(min(x_vals), max(x_vals));
                plot(x_vals,y_vals,'o');
                hold on;
                if(type == 2)
                    fplot(fun,[min(x_vals), max(x_vals)],'--r');
                end
                plot(uniform_x, polyval(poly, uniform_x));
                hold off;
            end
            opt = keepGoing('Do you wish to add a point? [y/n]: ');
        end  
    else % We apply spline interpolation
        opt = -1;
        clc;
        disp('Select the type of spline');
        disp('1. Type 1');
        disp('2. Type 2');
        disp('3. Type 3');
        while(opt ~= 1 && opt ~= 2 && opt ~= 3)
           opt = input('Select a valid option: '); 
        end
        if(opt == 2)
           fixed = input('Please introduce the fixed derivative values (1x2 matrix): '); 
           spline = cubicSplineInterpolation(x_vals, y_vals, opt, fixed(1), fixed(2));
        else
           spline = cubicSplineInterpolation(x_vals, y_vals, opt);
        end
        disp('The polynomials are ');
        for i=1:size(spline,1)
            pretty(poly2sym(spline(i,:)));
            fprintf('on interval [%d, %d]\n', x_vals(i), x_vals(i+1));
        end
    end
    
    finish = ~keepGoing('Do you wish to continue doing interpolation? [y/n]: ');
end

function [inter_poly, p_n1, div_dif] = addPoint(poly, p_n, dd, x_vals, y_vals)
    n = size(x_vals,2)-1;
    
    div_dif = [dd y_vals(n+1)];
    for j=n:-1:1
        div_dif(j) = (div_dif(j)-div_dif(j+1))/(x_vals(j)-x_vals(n+1));
    end
    
    inter_poly = [0 poly] + div_dif(1)*p_n;
    p_n1 = conv([1, -x_vals(n+1)],p_n);
end
 
function [ans] = keepGoing(msg)
    opt = '';
    while(~strcmp(opt, 'y') && ~(strcmp(opt,'n')))
    opt = input(msg, 's');
    disp(opt);
    end
    ans = strcmp(opt,'y');
end