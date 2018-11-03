

%FSCVAnesth.unpackmultgroups
%
%This program will unpack anesthetized i/o stimulated FSCV (raw) and store data in a
%usable/analyzable format in matlab.m file
%
%written by Abigail G. Schindler 5.14.17; getEventsTimes.m and UnpackNumber.m
%codes from Andy Hart/Lauren Burgeno

%updated to Octave on personal PC laptop on 6.4.17\\

%complete folder path is: D:\Schindler_Lab\Data\2014-17\FSCVanesthetized\7daydata\...
%Animal#\iocurve\BATCH_PC\STACKED_PC\Stacked_Qcutoff
%Stacked_Qcutoff is where the FSCV data is stored

%%

close all
clear all
tic

%add folders and subfolders for root data pathname to octavepath
%folder path is: D:\Schindler_Lab\Data\2014-17\FSCVanesthetized\7daydata
addpath(genpath('D:\Schindler_Lab\Data\2014-17\FSCVanesthetized\7daydata'))

%defining directory for path name where Anesth folders/files are located. 
%pathname1 is the directory in which all folders with animal numbers are found
pathname1='D:\Schindler_Lab\Data\2014-17\FSCVanesthetized\7daydata';

%defining listing as a structure containing all infromation about files... 
%in the data directory located in pathname1 
%dir fuction creates a nfolder x 1 size structure.
%Structure contains 5 variables, one of which is the filename (animal number).
listing1=dir(pathname1);

%BEWARE that there are usually hidden folders with names like '..' or '.' 
%that will need to be erased.

%group all filenames for each treatment group into a single variable (i.e.
%an array for each group, containng foldernames for each animal).

%create an empty array to put treatment groups into
blast = {}; 
sham = {};

%populate the array with the treatment groups
%errasing '..' or '.' from the list of names
for i=1:length(listing1);
    
    if strmatch('blast', listing1(i).name); %1 if true, 0 if false
        blast=[blast; listing1(i).name];%if filename starts with...
        %a number add the filename to the list of filenames
        %group; listing1(i).name says horizontal cat
        %(this gets rie of the hidden '..' or '.' files you don't want)
    end 
    
    if strmatch('sham', listing1(i).name); %1 if true, 0 if false
        sham=[sham; listing1(i).name];%if filename starts with...
        %a number add the filename to the list of filenames
        %(this gets rie of the hidden '..' or '.' files you don't want)
    end
    
end

%Create and populate each structure Treatment with all animal numbers found within... 
%the path 
for i=1:length(blast);
    Treatment(2).group(i) = blast(i);
end

for i=1:length(sham);
    Treatment(1).group(i) = sham(i);
end

%complete folder path is: D:\Schindler_Lab\Data\2014-17\FSCVanesthetized\7daydata\...
%Animal#\iocurve\BATCH_PC\STACKED_PC\Stacked_Qcutoff
%Populate the structure Treatment.group with all of the folders for each animal ID
for i=1:length(Treatment);
  for j=1:length(Treatment(i).group);
    %generate list of sessions for each animal ID within each treatment group
    listing3=dir(char(strcat(pathname1, '/', Treatment(i).group(j), '/')));
    %strcat cocatenates strings (because elements of ratID list are...
    %strings you need to tell it to take all char of a string
    %there are multiple folders within each ratID folder so also...
        
        sessionlist = {};
        
        %create an empty array to put filenames (sessions) into
        %needs to be cell array b/c all session names...
        %aren't same dimensions
        
        
        for k=1:length(listing3);
            if strmatch('uA', listing3(k).name); %1 if true, 0 if false
                sessionlist=[sessionlist; listing3(k).name];%if filename...
                %starts with 'uA' add the filename to the list of filenames
                %this gets ride of the hidden files you don't want
            end
            if strmatch('Hz', listing3(k).name); %1 if true, 0 if false
                sessionlist=[sessionlist; listing3(k).name];%if filename...
                %starts with 'Hz' add the filename to the list of filenames
                %this gets ride of the hidden files you don't want
            end
        end
        
        %put the info into a structure (i.e. sessionlist for each animal ID)
        Animal(j).FSCVsessionlist= sessionlist;
        Treatment(i).Animal(j).FSCVsessionlist = Animal(j).FSCVsessionlist;
    end
   
end


%complete folder path is: D:\Schindler_Lab\Data\2014-17\FSCVanesthetized...
%\7daydata\blast 1x 7 day.1\uA\BATCH_PC\STACKED_PC\Stacked_Qcutoff
for i=1:length(Treatment);
  for j=1:length(Treatment(i).Animal);
    for k=1:length(Treatment(i).Animal(j).FSCVsessionlist);
    %generate list of sessions for each animal ID within each treatment group
    listing4=dir(char(strcat(pathname1, '/', Treatment(i).group(j), '/',...
    Treatment(i).Animal(j).FSCVsessionlist(k), '/', 'BATCH_PC\STACKED_PC\')));
    %strcat cocatenates strings (because elements of ratID list are...
    %strings you need to tell it to take all char of a string
    %there are multiple folders within each ratID folder so also...
        
        sessionlist = {};
        
        %create an empty array to put filenames (sessions) into
        %needs to be cell array b/c all session names...
        %aren't same dimensions
        
        
        for l=1:length(listing4);
            if strmatch('Stacked_Qcutoff', listing4(l).name); %1 if true, 0 if false
                sessionlist=[sessionlist; listing4(l).name];%if filename...
                %starts with 'uA' add the filename to the list of filenames
                %this gets ride of the hidden files you don't want
            end
        end
        
        %put the info into a structure (i.e. sessionlist for each animal ID)
        list(k).FSCV = sessionlist;
        Treatment(i).Animal(j).list(k).FSCV = list(k).FSCV;
    end
  end
end

%%
%Now we need to extract the relevant current data from the voltammetry files in...
%each behavsessionlist

%only one channel because anesthetized FSCV

%set up of anesthetized experiments: i/o curves where stim at a different parameter...
%happens every 5 min. recording is 15 sec long. stacked files are thus...
%columns represt the i/o stims and the rows represent time in ms
%uA have 6 stims
%Hz have 5 stims

%list(1) is Hz and list(2) is uA
for i=1:length(Treatment);
  for j=1:length(Treatment(i).Animal);
    for k=1:length(Treatment(i).Animal(j).list);
      fileName=(char(strcat(pathname1, '/', Treatment(i).group(j), '/',...
      Treatment(i).Animal(j).FSCVsessionlist(k), '/', 'BATCH_PC\STACKED_PC\Stacked_Qcutoff')));
        %read data into a matrix
        datastack= dlmread(fileName);
        Treatment(i).Animal(j).list(k).data=datastack;
      end
      clear datastack
    end
  end
%end

 
%% Save all data in populated structure in .mat file
save ('FSCVAnesthstructure.mat', 'Treatment', '-mat')
toc