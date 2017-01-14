% LG, Lausanne, october 2015
clear all, close all, clc;

%% constants

global PLOT_XY PLOT_XZ PLOT_YZ PLOT_XYZ;

PLOT_XY = 0;
PLOT_XZ = 0;
PLOT_YZ = 0;
PLOT_XYZ = 1;

SURVEY_FILENAME = './data/survey.xlsx';
DTM_FILENAME = './data/mnt.tif';
DTM_METADATA_FILENAME = './data/mnt.tfw';
HS_FILENAME = './data/hs.tif';

EXCLUDE_DEEP_SURVEYS = 0;
DEEP_SURVEYS = [42,41,39,37,36,35,27,18,10];
%deep_surveys = [2:44];

%% initialisation

% import dtm and hs files
dtm = importdata(DTM_FILENAME);
hs = importdata(HS_FILENAME);
%dtm = imread(DTM_FILENAME);

% import metadata
data = load(DTM_METADATA_FILENAME);
dtm_d = data(1);
dtm_x = data(5);
dtm_y = data(6);

% import excel file
[num,txt,raw] = xlsread(SURVEY_FILENAME);

% initialise variables
survey_i = find( isnan(num(:,2)) );
survey_n = length(survey_i);

% trim dtm
%dtm = trim_dtm(dtm, num);

% convert absolute depth in relative depth
num(:,5) = num(:,5)-max(num(:,5));

%%
figure(5);
%imagesc(dtm);
%surface(dtm);

[X,Y] = meshgrid( ...
    dtm_x:dtm_d:dtm_x+dtm_d*(size(dtm,2)-1), ...
    dtm_y:dtm_d:dtm_y+dtm_d*(size(dtm,1)-1) ...
    );


%% iterate trought all the surveys
for i= 1:survey_n
   
   % check if this survey is member of the deep_surveys array
   if(EXCLUDE_DEEP_SURVEYS == 1 &&  any(num(survey_i(i))  == DEEP_SURVEYS) )
       % skip this iteration
       continue;
   end

   survey_begin = survey_i(i)+1;
   
   % get the indices of this survey
   if(i < survey_n)
       survey_end = survey_i(i+1)-1;
   else
       % handle last survey
       survey_end = length(num);
   end
   
   % get survey data
   survey_data = num(survey_begin:survey_end,:);
   survey_title = txt(survey_i(i),1);
   
   % draw survey data
   draw_survey(survey_data,survey_title);
end

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

if(PLOT_XZ)
    figure(2);
    title('plan xz');
    colorbar();
    xlabel('x [m]');
    ylabel('\Deltaz [m]');
    axis equal;
end

if(PLOT_YZ)
    figure(3);
    title('plan yz');
    colorbar();
    xlabel('y [m]');
    ylabel('\Deltaz [m]');
    axis equal;
end

if(PLOT_XYZ)
    figure(4);

    %surf(dtm);
    %hold on;
    %surf(X,Y,dtm);
    %axis equal;
    
    view(40,35);
    title('3D view');
    colorbar();
    xlabel('x [m]');
    ylabel('y [m]');
    zlabel('\Deltaz [m]');
    axis equal;
    grid on;
end
