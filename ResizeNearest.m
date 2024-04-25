function resizedImage = ResizeNearest(imageArray, scaleArray)
% ResizeNearest uses the Nearest Neighbour Interpolation Algorithm to
% resizn an image to the specified dimensions.
%
% Nearest-Neighbour Interpolation is an algorithm that resizes an image by 
% selecting pixel values nearest to specific pixels in the original image.
% It calculates the new pixel's relative position in theoriginal image and 
% takes the pixel value nearest to the calculated relative position
%
%   Inputs:
%   imageArray = An m-by-n-by-3 uint8 array representing a greyscale (p = 1)
%                image or an RGB colour (p = 3) image.
%   scaleArray = A i-by-j-by-p uint8 array representing the resized
%                greyscale (p = 1) or RGB colour (p = 3) image.
%
%   Output:
%   resizedImage = An m-by-n-by-1 uint8 array representing a greyscale |
%                  (p = 1) image or an RGB colour (p = 3) image.
%
% Author: Tyler Young (tyou333)

    % Establish row and column variables.   
    resizedRows = scaleArray(1);
    resizedColumns = scaleArray(2);

    % Pre-allocate the resized image uint8 array.  
    resizedImage = zeros(resizedRows, resizedColumns, "uint8"); 

    % Calculate row and column ratios.
    rowRatio = size(imageArray, 1) / resizedRows;
    columnRatio = size(imageArray, 2) / resizedColumns;

    % For every element in the image array,
    for i = 1:resizedRows % For every row,
        for j = 1:resizedColumns % For every column,

            % Calculate relative position and round upwards.
            relativeHoriPos = ceil((i - 0.5) * rowRatio);
            relativeVertPos = ceil((j - 0.5) * columnRatio);

            % If image is a greyscale image,
            if (size(imageArray, 3) == 1)

                % Copy the pixel values at the relative positions to the
                % resized image positions.
                resizedImage(i, j) = imageArray(relativeHoriPos, ...
                relativeVertPos);

            % If image is a RGB colour image,
            elseif (size(imageArray, 3) == 3)

                % For every RGB value,
                for k = 1:3

                    % Copy the pixel values at the relative positions to 
                    % the resized image positions.
                    resizedImage(i, j, k) = imageArray(relativeHoriPos, ...
                    relativeVertPos, k);

                end
            end
        end
    end
end