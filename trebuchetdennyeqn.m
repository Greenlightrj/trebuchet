function res = trebuchetdennyeqn()
	L = 10; % meters length of arm
    R1 = 2;% meters string attached to counterweight
    R2 = 2;% meters string attached to m
    M = 5; % kg mass of counterweight
    m = 1; % kg mass of thrown thing
    g = 9.8; % m/s^2 gravity
    I = (M + m)*(L/2)^2;
    V = (M - m) * g * L * 0.5;
    %initial conditions
    itheta = -pi/4;
    ithetav = 0;
    iphi1 = 0;
    iphi1v = 0;
    iphi2 = pi/2;
    iphi2v = 0;
    
    initials = [itheta, ithetav, iphi1, iphi1v, iphi2, iphi2v];
    
    [time, output] = ode45(@acceleration,[0,10],initials) %inputs theta into accelerationfunc, and calculates v
    
    beamangle = output(:,1);
    cwangle = output(:,3);
    massangle = output (:,5);   
    
    function athetas = acceleration(t,thetas) %takes thetas(theta,vtheta, phi1, phi1v, phi2, phi2v) and returns athetas(vtheta,atheta)
        theta = thetas(1);
        vtheta = thetas(2);
        phi1 = thetas(3);
        vphi1 = thetas(4);
        phi2 = thetas(5);
        vphi2 = thetas(6);

        a = I;
        b = -M * 0.5 * L * R1 * sin(theta-phi1);
        c = -m * 0.5 * L * R2 * cos(theta-phi2);
        d = -.5 * L* sin(theta + phi1);
        e = R1;
        f = 0;
        G = -0.5 * L *cos(theta - phi2);
        h = 0;
        j = R2;
        
        k = -0.5 * M * L * R1 * vphi1^2 * cos(theta - phi1) - 0.5 * m * L * R2 * vphi2^2 * sin(phi2 - theta) + V * cos(theta);
        l = 0.5 * L * vtheta^2 * cos(theta + phi1) - g * sin(phi1);
        n = 0.5 * L * vtheta^2 * sin(phi2 - theta) + g * cos(phi2);
        coeffs = [a, b, c; d, e, f; G, h, j];
        otherside = [k; l; n];
        accelerations = inv(coeffs)*otherside;
        atheta = accelerations(1);
        aphi1 = accelerations(2);
        aphi2 = accelerations(3);
        
        athetas = [vtheta; atheta; vphi1; aphi1; vphi2; aphi2];
    end

% animation code
    for i = 1:length(output)
        clf
        hold on
        x1(i)= 0.5 * L * cos(-beamangle(i));
        y1(i)= 0.5 * L * sin(-beamangle(i));
        x2(i)= -0.5 * L * cos(-beamangle(i));
        y2(i)= -0.5 * L * sin(-beamangle(i));
        xM(i) = x1(i) + R1 * cos(cwangle(i)- pi/2);
        yM(i) = y1(i) + R1 * sin(cwangle(i)- pi/2);
        xm(i) = x2(i) + R2 * cos(-massangle(i));
        ym(i) = y2(i) + R2 * sin(-massangle(i));

        %line plots ([x1, x2], [y1, y2]) for whatever reason 
        % draw beam
        
        plot([x1(i), x2(i)], [y1(i), y2(i)]);
        plot(x1(i), y1(i),'rx')
        plot(x2(i), y2(i),'gx');

        % draw cw and string
        plot([x1(i), xM(i)], [y1(i), yM(i)]);
        plot (xM(i), yM(i), 'o');
        
        % draw mass and string
        plot([x2(i), xm(i)], [y2(i), ym(i)]);
        plot (xm(i), ym(i),'o')
        
        hold on        
        
        axis([-15 15 -15 15])
        drawnow
        
        pause(0.05)
        hold off
    end
    clf
end

