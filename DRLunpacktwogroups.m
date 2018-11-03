

%DRLunpack
%
%This program will unpack DRL behavioral (raw) and store data in a
%usable/analyzable format in matlab.m file
%
%written by Abigail G. Schindler 1.5.17 with lots of help from Lauren
%Burgeno and her LgAVoltDataUnpack.m, getEventsTimes.m, and UnpackNumber.m
%codes (thanks Lauren!)

%updated from DRLunpack to DRLunpacktwogroups on 1.12.17
%this update split the strucutre into control and ethanol groups

%updated to Octave on personal PC laptop on 6.4.17
%complete folder path is: D:\Schindler_Lab\Data\ClarkDRL\TreatmentGroup\Animal#\Behavior\DRL

%%

close all
clear all
tic

%add folders and subfolders for root data pathname to octavepath
%folder path is: D:\Schindler_Lab\Data\ClarkDRL\
addpath(genpath('E:\Clark Lab\DATA\ClarkDRL'))

%defining directory for path name where DRL folders/files are located. 
%pathname1 is the directory in which all folders with treatment groups is found
pathname1='E:\Clark Lab\DATA\ClarkDRL';

%defining listing as a structure containing all infromation about files... 
%in the data directory located in pathname1 
%dir fuction creates a nfolder x 1 size structure.
%Structure contains 5 variables, one of which is the filename (group).
listing1=dir(pathname1);

%BEWARE that there are usually hidden folders with names like '..' or '.' 
%that will need to be erased.

%group all filenames for each treatment group into a single variable (i.e.
%an array for each group, containng foldernames for each animal).

%create an empty array to put treatment groups into
group = {}; 

%populate the array with the treatment groups
%errasing '..' or '.' from the list of names
for i=1:length(listing1);
    
    if strmatch('Control', listing1(i).name); %1 if true, 0 if false
        group=[group; listing1(i).name];%if filename starts with...
        %a number add the filename to the list of filenames
        %group; listing1(i).name says horizontal cat
        %(this gets rie of the hidden '..' or '.' files you don't want)
    end 
    
    if strmatch('Ethanol', listing1(i).name); %1 if true, 0 if false
        group=[group; listing1(i).name];%if filename starts with...
        %a number add the filename to the list of filenames
        %(this gets rie of the hidden '..' or '.' files you don't want)
    end
    
end

%Create and populate structure DRL with all treatment groups found within 
%...the path 
for i=1:length(group);
    DRL(i).group = group(i);
end

%folder path is: D:\Schindler_Lab\Data\ClarkDRL\TreatmentGroup\Animal#\Behavior\DRL
%Populate the structure DRL with all of the animal ID folders
for i=1:length(group);
    %generate list of sessions for each animal ID
    listing2=dir(char(strcat(pathname1, '/', DRL(i).group, '/')));
    %strcat cocatenates strings (because elements of ratID list are...
    %strings you need to tell it to take all char of a string
    %there are multiple folders within each ratID folder so also...
    %need to direct to correct DRL folder where data is
    
    %create an empty array to put filenames (sessions) into
    %needs to be cell array b/c all session names...
    %aren't same dimensions
    ratIDlist = {};
    
    for j=1:length(listing2);
        
        if isstrprop(listing2(j).name(1), 'digit'); %1 if true, 0 if false
            %.name(1) is indexing into first value in string only
            ratIDlist=[ratIDlist; listing2(j).name];%if filename starts with...
            %a number add the filename to the list of filenames
            %(this gets rie of the hidden '..' or '.' files you don't want)
        end
    end
    
    %put the info into a structure (i.e. each animal ID into appropriate 
    %...treatment group)
    DRL(i).ratIDlist = ratIDlist;
end

%folder path is: D:\Schindler_Lab\Data\ClarkDRL\TreatmentGroup\Animal#\Behavior\DRL
%Create and populate structure Group with each animal ID's sessionlist
%need to be a nested structure because want DRL and Group to each be 
%strucutres 
for i=1:length(DRL);
    for j=1:length(DRL(i).ratIDlist);
        %generate list of sessions for each animal ID
        %need '\' after group(i) to add a forward slash between folders for
        %group and rat number
        listing3=dir(char(strcat(pathname1, '/', group(i), '/', DRL(i).ratIDlist(j), '\Behavior\DRL\')));
        
        %strcat cocatenates strings (because elements of ratID list are...
        %strings you need to tell it to take all char of a string
        %there are multiple folders within each ratID folder so also...
        %need to direct to correct DRL folder where data is
        
        %pathname1='D:\Schindler_Lab\Data\ClarkDRL'
        %group(i) adds either 'control' or 'ethanol' folder
        %'\' adds a forward slash after group (ie saying the next thing is a
        %new folder)
        %DRL(i).ratIDlist(j) adds the rat number
        %example: D:\Schindler_Lab\Data\ClarkDRL\Control\26\Behavior\DRL\
        
        sessionlist = {};
        
        %create an empty array to put filenames (sessions) into
        %needs to be cell array b/c all session names...
        %aren't same dimensions
        
        
        for k=1:length(listing3);
            if isstrprop(listing3(k).name(1), 'digit'); %1 if true, 0 if false
                %name(1) tells to just look at first item in name
                sessionlist=[sessionlist; listing3(k).name];%if filename...
                %starts with a number add the filename to the list of filenames
                %this gets ride of the hidden files you don't want
            end
        end
        
        %put the info into a structure (i.e. sessionlist for each animal ID)
        Animal(j).behavsessionlist= sessionlist;
        DRL(i).Animal(j).behavsessionlist = Animal(j).behavsessionlist;
    end
   
end

%Will use function[eventVector, timeVector] = getEventsTimes(fileName)

%this function will output the event and time vector from MedPC data..
%from DRL file. It uses the unpackNumber function.
%Written by Andy Hart

for i=1:length(DRL);
    for j=1:length(DRL(i).ratIDlist)
    disp (num2str(i));
    DRL(i).Animal(j).behavior=nan(3000,2,length(DRL(i).Animal(j).behavsessionlist));
        for k=1:length(DRL(i).Animal(j).behavsessionlist); %telling to look at sessionlist
        %fileName= char(strcat(pathname1, group(i), '\', DRL(i).ratIDlist(j), '\Behavior\DRL\', DRL(i).Animal(j).sessionlist{k})); %filename input will be sessionlist(n=1:lenght(sessionlist))
        fileName= DRL(i).Animal(j).behavsessionlist{k}; %filename input will be sessionlist(n=1:lenght(sessionlist))
        [eventVector, timeVector] = getEventsTimes(fileName);
        DRL(i).Animal(j).behavior(1:length(eventVector),:,k)= [double(eventVector) double(timeVector)];
        clear eventVector timeVector
    end
    end
end

%% Save all data in populated structure in .mat file
save ('drlstructure.mat', 'DRL', '-mat')

toc