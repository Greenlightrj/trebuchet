function res = grapher()

    V = [];
    M_m = [];
    counter = 1;
    for i = 1:.2:90
        V(counter) = -lever_arm_calculation(5, 5, i, 100-i)*5;
        M_m(counter) = i/(100-i);
        counter = counter + 1;
    end
    
    display('You should be seing a graph right about now.')
    plot(M_m, V, 'Linewidth', 3)
    set(gca, 'FontSize', 18)
    xlabel('Mass Ratio (M/m)', 'FontSize', 16)
    ylabel('Launch Velocity (m/s)', 'fontsize', 16)
    title('Mass Ratio vs. Launch Velocity', 'FontSize', 24)
    display('Yep. Right now.')
end