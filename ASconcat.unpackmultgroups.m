

%ASconcat.unpackmultgroups
%
%This program will unpack acoustic startle data from the csv formed by San Diego
%instruments via concatenate function and store in a usable/analyzable format in matlab.m file
%
%written by Abigail G. Schindler 10.20.17

%complete folder path is: E:\Schindler_Lab\Data\Behavior\Excel_files\AcousticStartle\cleaned

%%

close all
clear all
tic

%add folders and subfolders for root data pathname to octavepath
%folder path is: E:\Schindler_Lab\Data\Behavior\Excel_files\AcousticStartle
addpath(genpath('E:\Schindler_Lab\Data\Behavior\Excel_files\AcousticStartle\cleaned'))

%defining directory for path name where Anesth folders/files are located. 
%pathname1 is the directory in which all folders with animal numbers are found
pathname1='E:\Schindler_Lab\Data\Behavior\Excel_files\AcousticStartle\cleaned';

%defining listing as a structure containing all infromation about files... 
%in the data directory located in pathname1 
%dir fuction creates a nfolder x 1 size structure.
%Structure contains 5 variables, one of which is the filename (animal number).
listing1=dir(pathname1);

%BEWARE that there are usually hidden folders with names like '..' or '.' 
%that will need to be erased.


%populate the array with the data files
%errasing '..' or '.' from the list of names
q=1
for p=1:length(listing1);
    if strmatch('AS', listing1(p).name); %1 if true, 0 if false
      %gets rid of the hidden '..' or '.' files you don't want
      fileName=listing1(p).name;
      %C = cell(10,15);
      fid = fopen(fileName,'r');
      C = importdata(fileName, '%f%f%s%f%f%f%f%f%f%s');
      fclose(fid);
      %read data into a matrix
      %C = cell(10,15);
      %C = csvread(fileName, "%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s");
      %A(q) = cell2struct ({listing1(p).name;C}, {"session","data"});
      %q +=1
    end
end


%Each AS file contains all the animals from that date with columns indexes:
%exposure number = 5
%timepoint = 6
%treatment group = 15
%We need to extract the data from each file in order to create the data structure
%and analysis

