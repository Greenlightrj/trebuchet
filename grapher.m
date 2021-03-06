function res = grapher()

%     V = [];
%     M_m = [];
%     counter = 1;
%     for i = 1:.2:90
%         V(counter) = -lever_arm_calculation(5, 5, i, 100-i)*5;
%         M_m(counter) = i/(100-i);
%         counter = counter + 1;
%     end
%     
%     display('You should be seing a graph right about now.')
%     plot(M_m, V, 'Linewidth', 3)
%     set(gca, 'FontSize', 18)
%     xlabel('Mass Ratio (M/m)', 'FontSize', 16)
%     ylabel('Launch Velocity (m/s)', 'fontsize', 16)
%     title('Mass Ratio vs. Launch Velocity', 'FontSize', 24)
%     display('Yep. Right now.')
    
%     V = [];
%     p_p = [];
%     counter = 1;
%     for i = 1:.1:9
%         V(counter) = -lever_arm_calculation(i, 10-i, 1, 10)*i;
%         p_p(counter) = i/(10-i);
%         counter = counter + 1;
%     end
%     
%     plot(p_p, V, 'Linewidth', 3)
%     xlabel('Beam Ratio (L1/L2)', 'FontSize', 16)
%     ylabel('Launch Velocity (m/s)', 'fontsize', 16)
%     %axis([0 1.15 0 inf])
%     title('Beam Ratio vs. Launch Velocity', 'FontSize', 24)

    display('running')
    counter1 = 1;
    for i = 1:.5:95
        counter2 = 1;
        for j = 1:.3:7.5
            V(counter2,counter1) = -lever_arm_calculation2(j, 10-j, i, 100-i)*5;
            M_m(counter1) = i/(100-i);
            p_p(counter2) = j/(10-j);
            counter2 = counter2 + 1;
        end
        counter1 = counter1 + 1;
    end
    V
    contourf(M_m,p_p, V)
    xlabel('Mass Ratio (M/m)', 'FontSize', 16)
    ylabel('Beam Ratio (L1/L2)', 'FontSize', 16)
end