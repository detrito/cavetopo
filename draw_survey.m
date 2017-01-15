function [] = draw_survey(data, title)

global PLOT_XY PLOT_XZ PLOT_YZ PLOT_XYZ;


% draw the topography of one survey

    % rename data
    data_x = data(:,3);
    data_y = data(:,4);
    data_z = data(:,5);
    
    % calculate mean position (for text label)
    mean_x = mean(data_x);
    mean_y = mean(data_y); 
    mean_z = mean(data_z);

    % plan xy
    if (PLOT_XY)
        figure(1);
        hold on;
        lab = text(mean_x, mean_y, title);
        scatter(data_x, data_y, [], data_z, 'filled');
        plot(data_x, data_y,'k');
                uistack(lab,'top')
        hold off;
    end

    % coupe xz
    if (PLOT_XZ)
        figure(2);
        hold on;
        text(mean_x, mean_z, title);
        scatter(data_x, data_z, [], data_z, 'filled');
        plot(data_x, data_z,'k');
        hold off;
    end

    % coupe yz
    if (PLOT_YZ)
        figure(3);
        hold on;
        text(mean_y, mean_z, title);
        scatter(data_y, data_z, [], data_z, 'filled');
        plot(data_y, data_z,'k');
        hold off;
    end

    if (PLOT_XYZ)
        % 3D
        figure (4);
        hold on;
        text(mean_x, mean_y, mean_z, title);
        scatter3(data_x, data_y, data_z, [], data_z, 'filled');
        plot3(data_x, data_y, data_z, 'k');
        hold off;
    end
end

