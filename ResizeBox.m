function resizedImage = ResizeBox(imageArray, scaleArray)
% ResizeBox usese the Box Sampling Algorithm to resize an image to the
% specified direction. 
% 
% Box Sampling is an algorithm that resizes an image by calculating the 
% average pixel value in a group of pixels in the original image. It 
% calculates bounding boxes that divide the original image into the same 
% number of boxes as pixels in the resized image. Then, it calculates the 
% average pixel value in the box to determine the pixel value of the 
% resized image.
%
%   Inputs:
%   imageArray = An m-by-n-by-3 uint8 array representing a greyscale 
%                (p = 1) image or an RGB colour (p = 3) image.
%   scaleArray = A 1-by-2 double array containing two values (i, j) 
%                representing the desired height i (i.e., i rows) and width 
%                j (i.e., j columns) to resize the image to.
%
%   Output:
%   resizedImage = An i-by-j-by-p uint8 array representing a greyscale 
%                  (p = 1) image or an RGB colour (p = 3) image.
%
% Author: Tyler Young (tyou333)

    % Establish row and column variables.   
    imageRows = size(imageArray, 1);
    imageColumns = size(imageArray, 2);
    imageDepth = size(imageArray, 3);

    % Establish resized row and column variables.   
    resizedRows = scaleArray(1);
    resizedColumns = scaleArray(2);

    % Pre-allocate the resized image uint8 array.  
    resizedImage = zeros(resizedRows, resizedColumns, "uint8");

    % Determine the locations of horizontal and vertical lines that form
    % the box grid.
    horizBoxes = linspace(0, imageColumns, resizedColumns + 1);
    vertiBoxes = linspace(0, imageRows, resizedRows + 1);
    
    % Split the image array into subarrays using four methods (alternating
    % tiebreakers rounds towards and away from zero) that resemble the 
    % box grid.
    
    % Method where row tiebreakers rounds towards zero and column 
    % tiebreakers rounds away from zero.
    subArray1 = mat2cell(imageArray, ...
        diff(round(vertiBoxes, TieBreaker="tozero")), ...
        diff(round(horizBoxes, TieBreaker="fromzero")), imageDepth);

    % Method where row tiebreakers rounds towards zero and column 
    % tiebreakers rounds towards zero.
    subArray2 = mat2cell(imageArray, ...
        diff(round(vertiBoxes, TieBreaker="tozero")), ...
        diff(round(horizBoxes, TieBreaker="tozero")), imageDepth);

    % Method where row tiebreakers rounds away from zero and column
    % tiebreakers rounds towards zero.
    subArray3 = mat2cell(imageArray, ...
        diff(round(vertiBoxes, TieBreaker="fromzero")), ...
         diff(round(horizBoxes, TieBreaker="tozero")), imageDepth);

    % Method where row tiebreakers round away from zero and column
    % tiebreakers rounds away from zero.
    subArray4 = mat2cell(imageArray, ...
        diff(round(vertiBoxes, TieBreaker="fromzero")), ...
        diff(round(horizBoxes, TieBreaker="fromzero")), imageDepth);

    % Pre-allocate the main sub-cell-array.
    subArrayMain = cell(resizedRows, resizedColumns, imageDepth);

    % For every cell of each different subarrays using the four methods,
    for r = 1:resizedRows % For every row,
        for c = 1:resizedColumns % For every column,
            
            % Establish a list of all possible cell item.
            subArrayList = {subArray1{r, c, :}, subArray2{r, c, :}, ...
                subArray3{r, c, :}, subArray4{r, c, :}};

            % Pre-allocate a numel list and attain list of the number of 
            % elements in each respective cell item.
            subArrayNumel = zeros(1, 4);
            for cellNo = 1:4
                subArrayNumel(cellNo) = numel(subArrayList{cellNo});
            end

            % Insert the biggest possible cell item into the main 
            % sub-array.
            [~, largest] = max(subArrayNumel);
            subArrayMain(r, c, :) = subArrayList(largest);
        end
    end

    % For every element of the main sub-array,
    for i = 1:resizedRows % For every row,
        for j = 1:resizedColumns % For every column,

            % Select the sub element.
            subElement = subArrayMain{i, j}; 

            % If the image is in greyscale,
            if (imageDepth == 1)

                % Mean pixel values.
                resizedImage(i, j) = mean(subElement, "all");

            % Else, if the image is in RGB colour,
            elseif (imageDepth == 3)

                % Mean RGB values individually.
                resizedImage(i, j, 1) = mean(subElement(:,:,1), "all");
                resizedImage(i, j, 2) = mean(subElement(:,:,2), "all");
                resizedImage(i, j, 3) = mean(subElement(:,:,3), "all");

            end
        end
    end
end
