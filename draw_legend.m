function [] = draw_legend()

global PLOT_XY PLOT_XZ PLOT_YZ PLOT_XYZ RELATIVE_DEPTH;


%% figure legend

step = 100;

% xmin = floor(min(num(:,3))/step)*step
% xmax = ceil(max(num(:,3))/step)*step
% xtick = xmin:step:xmax;
% 
% ymin = floor(min(num(:,4))/step)*step
% ymax = ceil(max(num(:,4))/step)*step
% ytick = ymin:step:ymax;


if(PLOT_XY)
    figure(1);
    title('plan xy');
    colorbar();
    xlabel('x [m]');
    ylabel('y [m]');
    axis equal;
end

% ax = gca;
% set(ax,'XTick',xtick);
% set(ax,'YTick',ytick);
% set(gca, 'XTickLabel', num2str(get(gca, 'XTick')))

if (RELATIVE_DEPTH)
    label_z = '\Deltaz [m]';
else
    label_z = 'z [m]';
end

if(PLOT_XZ)
    figure(2);
    title('plan xz');
    colorbar();
    xlabel('x [m]');
    ylabel(label_z);
    axis equal;
end

if(PLOT_YZ)
    figure(3);
    title('plan yz');
    colorbar();
    xlabel('y [m]');
    ylabel(label_z);
    axis equal;
end

if(PLOT_XYZ)
    figure(4);

    %hold on;
    %surf(X,Y,dtm);
    %axis equal;
    
    view(40,35);
    title('3D view');
    colorbar();
    xlabel('x [m]');
    ylabel('y [m]');
    zlabel(label_z);
    axis equal;
    grid on;
end

end
