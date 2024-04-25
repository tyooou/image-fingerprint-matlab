function RankSimilarity(fingerprint, listNames, collection, numberRanks)
% RankSimilarity displays n image files ranked by descending similarity
% (i.e the image most similar ao the seach imagpe will be at the top of the
% list).
%
%   Inputs:
%   fingerprint = A 1-by-64 logical row vector representing the image
%                 fingerprint to search.
%   listNames = A m-by-1 string array representing a list of image file
%               names.
%   collection = A m-by-1 cell array containing a collection of image
%                fingerprints.
%   numberRanks = An integer n denoting how many image fingerprint maches
%                 to display.
%
%   Output:
%   None. (The ranking is displayed.)
%
% Author: Tyler Young (tyou333)

    % Pre-establish the fingerprint list.
    listHamming = zeros(1, numberRanks);
    
    % Calculate hamming distances.
    for i = 1:numberRanks
        listHamming(i) = HammingDistance(fingerprint, ...
            collection{i});
    end

    % Order hamming distances by magnitude.
    [rankOrder, order] = sort(listHamming);

    % Order listNames such that the names align with their respesctive 
    % hamming distances.
    listNames = listNames(order);

    % Display ranking.
    for i = 1:numberRanks

        % If the number of ranks shown is less than two digits, display
        % with no spacing between rank number and left border.
        if numberRanks < 10
            fprintf("%i. %2i - %s\n", i, rankOrder(i), listNames(i));

        % Display with spacing between rank number and left border.
        else
            fprintf("%2i. %2i - %s\n", i, rankOrder(i), listNames(i));
        end
    end
end