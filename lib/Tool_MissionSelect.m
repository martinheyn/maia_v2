%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This script asks the user which mission is the source of data         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% script: It just sets the missionselect variable     
% 
% Output data:
%   missionselect variable
%   1. Frej OATRC 2015
%   2. Oden OATRC 2015
%   3. Oden Arctic Ocean 2016
%	4. Oden Arctic OCean 2016 after Day 10
%	5. SKT 2017
%
%    Copyright:     NTNU
%    Project:	    SAMCoT, AMOS
%    Author:        Hans-Martin Heyn
%    Date created:  2016-08-10  Hans-Martin Heyn (NTNU)
%    Change Log: 

%---------------------------------------------------------------------%

missions = [{'Frej OATRC 2015'},{'Oden OATRC 2015'},{'Oden Arctic Ocean 2016'},{'Oden Arctic Ocean 2016 >D10'},{'SKT 2017'},{'Other'}];

missionselect = listdlg('PromptString','Select a mission',...
    'SelectionMode','single',...
    'ListString',missions,...
    'OKString','Go!','CancelString','Do not press here');

clear missions