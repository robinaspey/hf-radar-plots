%   plotrt4.m
%   This one has a colour bar added for the totals plot
%
% [1 1 0] y yellow
% [1 0 1] m magenta
% [0 1 1] c cyan
% [1 0 0] r red
% [0 1 0] g green
% [0 0 1] b blue
% [1 1 1] w white
% [0 0 0] k black
close all; 
clear all; 
clc;

cd 'w:\plotrtv1'
in_dir = pwd;

addpath ([in_dir '/m_map/']);
load coastline.mat

%%%---------------------------------------%%%
%%% ------------- TOTALS -----------------%%%
%%% Plot the map with the coastline

figure( 'visible','on')
set(gcf,'position',[560 80 630 612]);
m_proj( 'Mercator','lon',[38 39.2],'lat',[21.8 23])
hold on

m_usercoast('red_sea_f.mat', 'patch',[.8 .8 .8])
m_grid ('tickdir', 'in', 'ticklen',0.01, 'fancy')

%%% Plot the antenas: position with a marker and text
m_plot(39.05,22.62,'o','MarkerEdgeColor','r','MarkerFaceColor', 'r','MarkerSize',4);
m_text(39.08, 22.62, 'RABG','FontWeight','bold')
m_plot(39.08, 22.29,'o','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);
m_text(39.11, 22.29 ,'SBCH','FontWeight','bold')

%%% Add the title            

title(['TOTALS'],'Fontsize',14)

% Debug 1: the coastline only for radials is plotted.
%%% Plot TOTALS

numfich = dir([in_dir '/'  '*.tuv']);  %list all the available TUV files in this folder
nom     = numfich(1).name;  %the first TUV on this folder;
fo      = fopen([in_dir '/' nom ]);

for ii=1:31,
    fgetl(fo);
end

data  = fscanf(fo,'%f',[16 inf]);
lon   = data(1,:);
lat   = data(2,:);
u     = data(3,:);
v     = data(4,:);
stdu  = data(6,:);
stdv  = data(7,:);
covuv = data(8,:);

% PLOT TOTALS AS ARROWS

h     = m_quiver(lon,lat,u/600,v/600,0.8,'k');
colorbar;
colormap(jet);

% Debug 2: totals plot is shown only with arrows.
% return;
%%%----------------------------------------%%%
%%% ------------- RADIALS -----------------%%%
%%% Plot the map with the coastline
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('visible','on');
set(gcf,'position',[360 80 630 612]);
m_proj('Mercator','lon',[38 39.2],'lat',[21 23.5]);
hold on

m_usercoast('red_sea_f.mat', 'patch',[.8 .8 .8]);
m_grid ('tickdir', 'in', 'ticklen',0.01,'fancy');
%%%Plot the antenas: position with a marker and text
m_plot(39.08, 22.29,'o','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);
m_text(39.11, 22.29 ,   'Mid','FontWeight','bold')
%%%Add the title            
title(['RADIALS'],'Fontsize',14);
%%% Plot RADIALS
numfich = dir([in_dir '/'  '*.ruv']);  
% list all the available TUV files in this folder
nom     = numfich(1).name;  
% the first TUV on this folder;
fo      = fopen([in_dir '/' nom ]);
for ii=1:55,
    fgetl(fo);
end
% Debug 3: The quiver plot is on the totals plot
% no radials yet
% return;
data   = fscanf(fo,'%f',[18 inf]);
rlon   = data(1,:);
rlat   = data(2,:);
ru     = data(3,:);
rv     = data(4,:);
rstdu  = data(6,:);
rstdv  = data(7,:);
rcovuv = data(8,:);
% PLOT RADIALS AS ARROWS
h      = m_quiver(rlon,rlat,ru/600,rv/600,0,'r');



