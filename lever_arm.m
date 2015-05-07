function res = lever_arm()
	L1 = 5; % meters length of counterweight arm
    L2 = 0; % meters length of other arm
    M = 10; % kg mass of counterweight
    m = 1; % kg mass of thrown thing
    g = 9.8; % m/s^2 gravity
    
    %Initial Conditions
    theta0 = 0;
    dtheta0 = 0;
    initial = [theta0; dtheta0];
    
    [t, M] = ode45(@derivatives,[0,100],initial);
    animate(t, M)
    
    
    function res = derivatives(t, V)
        theta = V(1);
        dtheta = V(2);
        
        ddtheta = ddtheta_calc(theta, dtheta);
        res = [dtheta;ddtheta];
    end

    function res = ddtheta_calc(theta, dtheta)
        numerator = -M*g*L1*cos(theta) - m*g*L2*sin(theta);
        denominator = M*L1^2 + m*L2^2;
        res = numerator/denominator;
    end

    function res = animate(t, M)
        thetas = M(:,1);
        M_locations = [L1.*cos(thetas), L1.*sin(thetas)];
        m_locations = [-L2.*cos(thetas), -L2.*sin(thetas)];
        
        for i = 1:length(t)
            clf
            hold on

            %line plots ([x1, x2], [y1, y2]) for whatever reason 
            % draw beam

            plot([0,M_locations(i,1)],[0, M_locations(i,2)])
            plot([0,m_locations(i,1)],[0, m_locations(i,2)])
            plot(M_locations(i,1), M_locations(i,2), 'go')
            plot(m_locations(i,1), m_locations(i,2), 'ro')
        

            axis([-15 15 -15 15])
            drawnow

            pause(0.05)
            hold off
        end
    end
end