function [out] = unpackNumber(searchStr, stringArray)

% unpackNumber by Andrew S. Hart 5/3/2010

% Returns the Numerical Informatiom associated with a given Variable Name
% from a MedPC text file.


ind = strmatch(searchStr, stringArray); % Locate line that starts with searchStr

if strmatch((searchStr), stringArray(ind,:),'exact')
    
    %% Variable is a Vector. Find out where it stops
    allind = find(isletter(stringArray(:,1)));
    nextind = allind(find(allind>ind,1));
    
    start = ind+1;
    if isempty(nextind)    
        stop = length(stringArray(:,1));
    else
        stop = nextind-1;
    end
    
    %% Read in Strings and Numbers from each row
    array = textscan((stringArray(start:stop,:))', '%s%f%f%f%f%f');
    
    %% Concatenate Numbers into vector
    concat = [array{2};array{3};array{4};array{5};array{6}];
    
    %% Make a Matrix for indexing
    
    for i = 1:ceil(length(concat)/5)
       
        M(i,:) = [1:5]+repmat((i-1)*5, 1,5);
    end
    
    indexVector = vertcat(M(:,1), M(:,2), M(:,3), M(:,4), M(:,5));
    indexVector(indexVector>length(concat)) = 0;
    indexVector = nonzeros(indexVector);
    clear M;
    
    %% Construct Reordering Matrix
    
    M = zeros(length(concat));
    
    for i = 1:length(concat)
        M(indexVector(i),i) = 1;
    end
    
    % Reorder Data
    out = (M*concat);

else
    %% Variable is a Scalar. Read Scalar Value
    out = textscan(stringArray(ind,:), [searchStr '%f']);
    out = out{:};
    
end

    