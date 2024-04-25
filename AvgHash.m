function averageHash = AvgHash(imageArray)
% AvgHash uses the Average Hashing algorithm to convert a m-by-n greyscale
% image into a hash containing m*n bits. Average Hashing is an algorithm 
% that reduces fingerprint size by comparing each pixel value to the 
% average pixel value of the greyscale image.
%
%   Input:
%   imageArray = An m-by-n-by-3 uint8 array representing a greyscale image.
%
%   Output:
%   averageHash = A 1-by-(m*n) logical row vector representing the average
%                 hash of the greyscale image.
%
% Author: Tyler Young (tyou333)

    % Reshape the image array into a row vector.
    reshapedArr = reshape(imageArray.', 1, []);

    % Find the average pixel value rounded to the nearest whole integer.
    avgPixelValue = round(mean(double(imageArray), "all"));

    % Determine the logical row vector representing the average hash by
    % comparing whether elements of the row vector are greater or equal to
    % the average pixel value.
    averageHash = logical(ge(reshapedArr, avgPixelValue));
    
end