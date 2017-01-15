% LG, Lausanne, october 2015
clear all, close all, clc;

%% constants

global PLOT_XY PLOT_XZ PLOT_YZ PLOT_XYZ;

PLOT_XY = 0;
PLOT_XZ = 1;
PLOT_YZ = 0;
PLOT_XYZ = 1;

SURVEY_FILENAME = './data/survey.xlsx';
DTM_FILENAME = './data/mnt.tif';
DTM_METADATA_FILENAME = './data/mnt.tfw';
HS_FILENAME = './data/hs.tif';

ENABLE_EXCLUDE_DEEP_SURVEYS = 0;
ENABLE_RELATIVE_DEPTH = 0;
ENABLE_TEXT_LABELS = 0;

DEEP_SURVEYS = [42,41,39,37,36,35,27,18,10];

%% initialisation

% import dtm and hs files
dtm = importdata(DTM_FILENAME);
hs = importdata(HS_FILENAME);

% import metadata
data = load(DTM_METADATA_FILENAME);
dtm_d = data(1);
dtm_x = data(5);
dtm_y = data(6);

% import cave survey (excel file)
[num,txt,raw] = xlsread(SURVEY_FILENAME);

% initialise variables
survey_i = find( isnan(num(:,2)) ); % survey index
survey_n = length(survey_i);    % number of surveys

% trim dtm
%dtm = trim_dtm(dtm, num);

% convert absolute depth in relative depth
if (ENABLE_RELATIVE_DEPTH )
    num(:,5) = num(:,5)-max(num(:,5));
end

% debug
%figure(5);
%imagesc(dtm);
%surface(dtm);

[X,Y] = meshgrid( ...
    dtm_x:dtm_d:dtm_x+dtm_d*(size(dtm,2)-1), ...
    dtm_y:dtm_d:dtm_y+dtm_d*(size(dtm,1)-1) ...
    );


%% iterate trought all the surveys
for i= 1:survey_n
   
   % check if this survey is member of the deep_surveys array
   if(ENABLE_EXCLUDE_DEEP_SURVEYS == 1 &&  any(num(survey_i(i))  == DEEP_SURVEYS) )
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
   if(ENABLE_TEXT_LABELS)
       survey_title = txt(survey_i(i),1);
   else
       survey_title = num2str(i);
   end
   
   % draw survey data
   draw_survey(survey_data,survey_title);
end

draw_legend();
