function res = lever_arm_calculation2(L1, L2, M, m)
%    takes length of counterweight arm, 
%    length of thrown mass arm, 
%    mass of counterweight,
%    mass of thrown object,
%    and returns angular velocity at launch in radians/sec
	L1 = L1; %5; % meters length of counterweight arm
    L2 = L2; %5; % meters length of other arm
    M = M; %10; % kg mass of counterweight
    m = m; %1; % kg mass of thrown thing
    g = 9.8; % m/s^2 gravity
    
    %Initial Conditions
    theta0 = pi/4;
    dtheta0 = 0;
    initial = [theta0; dtheta0];
    
    options = odeset('Events', @events);
    [t, M] = ode45(@derivatives,[0,10],initial, options);
    res = M(end,2);
    
    function res = derivatives(t, V)
        theta = V(1);
        dtheta = V(2);
        
        ddtheta = ddtheta_calc(theta);
        res = [dtheta;ddtheta];
    end

    function res = ddtheta_calc(theta)
        numerator = -g * cos(theta) * (M - m) * (L1 + L2);
        denominator = (M + m) * (L1^2 + L2^2);
        res = numerator/denominator;
    end

    function [value, isterminal, direction] = events(t, Y)
        value = Y(1) + pi/4;
        isterminal = 1;
        direction = -1;
    end

end