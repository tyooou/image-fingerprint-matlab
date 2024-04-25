function differentialHash = DiffHash(imageArray)
% DiffHash converts a m-by-(n + 1) greyscale image into a hash containing 
% m*n bits using the differential hashing algorithm. Differential Hashing 
% is an algorithm that reduces fingerprint size by comparing each pixel 
% value to the pixel value to the right of itself in the greyscale image.
%
%   Input:
%   imageArray = A 1-by-(n + 1) uint8 array representing a greyscale image.
%
%   Output:
%   differentialHash = A 1-by-(m*n) logical row vector representing the
%                      differential hash of the greyscale image.
%
% Author: Tyler Young (tyou333)

    % Establish row and column variables.
    imageRows = size(imageArray, 1);
    imageColumns = size(imageArray, 2);

    % Pre-allocate differential hash array.
    differentialHash = zeros(imageRows, imageColumns - 1);

    % For every element in the image array,
    for m = 1:imageRows % For every row,
        for n = 1:(imageColumns - 1) % For every column,

            % If the value of the pixel is greater than the right pixel,
            if imageArray(m, n) >= imageArray(m, n + 1)  
                differentialHash(m, n) = true;
            else
                differentialHash(m, n) = false;
            end
        end
    end
    
    % Reshape into a row vector, and convert to a logical array.
    differentialHash = logical(reshape(differentialHash.', 1, []));

end