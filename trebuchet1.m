function res = trebuchet1()
	L = 10; % meters length of arm
    R1 = 2;% meters string attached to counterweight
    R2 = 2;% meters string attached to m
    M = 5; % kg mass of counterweight
    m = 1; % kg mass of thrown thing
    g = 9.8; % m/s^2 gravity
    
    %initial conditions
    itheta = pi/4;
    ithetav = 0;
    iphi1 = -pi/2;
    iphi1v = 0;
    iphi2 = -pi/2;
    iphi1v = 0;
    
    initials = [itheta, ithetav, iphi1, iphi1v iphi2, iphi2v];
    
    [time, output] = ode45(@acceleration,[0,10],initials); %inputs theta into accelerationfunc, and calculates v
    
    beamangle = output(:,1);
    cwangle = output(:,2);
    massangle = output (:,3);   
    
    function athetas = acceleration(t,thetas) %takes thetas(theta,vtheta, phi1, phi1v, phi2, phi2v) and returns athetas(vtheta,atheta)
        theta = thetas(1);
        vtheta = thetas(2);
        phi1 = thetas(3);
        phi1v = thetas(4);
        phi2 = thetas(5);
        phi2v = thetas(6);
        
        a = M*L^2/4 + m*L^2/4 
        b = M*L*R1/2 * cos(theta-phi1)
        c = m*L*R1/2 * cos(theta-phi2)
        d = .5*L*cos(theta - phi1)
        e = 1
        f = 0;
        G = 0.5 * L + 0.5 * L*vtheta * sin(theta - phi2);
        h = 0;
        j = 1 - 0.5 * L * vtheta * sin(theta - phi2);
        
        k = 0.5 * M * L * R1 * vtheta * vphi1 * sin(theta - phi1) - 0.5 * m * L * R2 * vtheta * vphi1 * sin(theta - phi2) + 0.5 * M * L * R1 * vtheta1 * sin(theta - phi1) * (vtheta - vphi1) + 0.5 * m * L * R2 * sin(theta - phi2) * (vtheta - vphi2);
        l = 0.5*L*vtheta*phi1*sin(theta - phi1) - g*cos(phi1) + 0.5*L*vtheta*sin(theta - phi1)* (vtheta - vphi1);
        n = 0.5*L*vtheta*phi2*sin(theta-phi2) + g*cos(phi2);
        coeffs = [a, b, c; d, e, f; G, h, j];
        otherside = [k; l; n];
        [atheta, aphi1, aphi2] = inv(coeffs)*otherside;
        
        athetas = [vtheta, atheta, vphi1, aphi1, vphi1, aphi2]; 
    end

% animation code
    for i = 1:length(output)
        x1(i)= 0.5 * L * cos(beamangle(i));
        y1(i)= 0.5 * L * sin(beamangle(i));
        x2(i)= -0.5 * L * cos(beamangle(i));
        y2(i)= -0.5 * L * sin(beamangle(i));    
        xM(i) = x1(i) + R1 * cos(cwangle(i));
        yM(i) = y1(i) + R1 * sin(cwangle(i));
        xm(i) = x2(i) + R2 * cos(massangle(i));
        ym(i) = y2(i) + R2 * sin(massangle(i));
        
        % draw beam
        line((x1(i), y1(i)), (x2(i), y2(i)));
        % draw cw and string
        line((x1(i), y1(i)), (xM(i), yM(i)));
        plot (xM(i), yM(i), 'o');
        % draw mass and string
        line((x1(i), y1(i)), (xm(i), ym(i)));
        plot (xm(i),ym(i),'o')
        
        hold on        
        
        axis([-15 15 -15 15])
        drawnow
        
        pause(0.05)
        hold off
    end
    
end

