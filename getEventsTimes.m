function[eventVector, timeVector] = getEventsTimes(fileName)

%This function will output the event and time vector from any MedPC data
%file. It uses the unpackNumber function.

%filename must have quotes around it 'filename'

%open file and read into cell array

%, 'r+'

fid = fopen(fileName);
cellArray = textscan(fid, '%s','delimiter','\n','MultipleDelimsAsOne',1);

% '%s' indicates string
% delimiter is a sequence of one or more characters used to specify...
%the boundary between separate, independent regions in plain text or...
%other data streams (exp. commas)
%'delimiter' is telling to interpret repeated delimiter characters...
%as separate delimiters, and return an empty value to the output cell
% '\n' indicates new line character
% 'MultipleDelimsAsOne' indicates If true, textscan treats consecutive...
% delimiters as a single delimiter.

%convert cell array into a character array
stringArray = char(cellArray{1});

%get event stamps
searchStr = 'E:';

eventVector = unpackNumber(searchStr, stringArray);
eventVector = uint8(eventVector);

%get time stamps
searchStr = 'T:';

timeVector = unpackNumber(searchStr, stringArray);

%close file

fclose(fid);

