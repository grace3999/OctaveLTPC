%FSCVAnesth.analysismultgroups
%
%This program will pull the structure and data that was created with...
%FCVAnesth.unpackmult groups and analyze in order to be put into stats program 
%
%written by Abigail G. Schindler 6.11.17

%Anesth protocol is i/o (different parameter each column). Taking max value...
%between 5sec (start of stim) and 9 sec (ie 3 sec total)
tic
clear all
close all

%load stats package to can use nanmean etc
pkg load statistics

%loading the .mat strucutre that you created with DRLunpack
load FSCVAnesthstructure.mat 

%ensure that correctly loaded
Treatment
%1x2 struct array with fields:
    %group 
    %Animal - this is a strucutre also
        %FSCVsessionlist - this is where the type of io curve is stored
        %list - this is a structure also
            %FSCV
            %data - this is where the current values are stored

%%
%determine if there is a Hz data file for each animal
%if there is then find max value from 5-7.9 sec 
for i=1:length(Treatment);
  Treatment(i).uA = []; 
  Treatment(i).Hz = [];
  for j=1:length(Treatment(i).Animal);
    for k=1:length(Treatment(i).Animal(j).list);
      %if Hz
      if strmatch('Hz',Treatment(i).Animal(j).FSCVsessionlist(k));
        %find max value Hz
        data = max(Treatment(i).Animal(j).list(k).data(50:79,2:6));
        Treatment(i).Animal(j).Hz = data;
        %add to array
        Treatment(i).Hz = [Treatment(i).Hz; Treatment(i).Animal(j).Hz];
      %if uA
      elseif strmatch('uA',Treatment(i).Animal(j).FSCVsessionlist(k));
        %find max value uA
        data = max(Treatment(i).Animal(j).list(k).data(50:79,2:7));
        Treatment(i).Animal(j).uA = data;
        %add to array 
        Treatment(i).uA = [Treatment(i).uA; Treatment(i).Animal(j).uA];
      end
    end
  end
end

    

toc     
        
       