function greyscaleImage = GreyscaleLuma(imageArray)
% GreyscaleLuma converts the supplied RGB colour image array (NOT the image
% itself) into a greyscale version by calculating the weighted sum for each
% pixel.
%
%   Input:
%   imageArray = An m-by-n-by-3 uint8 array representing an RGB colour
%                image.
%
%   Output:
%   greyscaleImage = An m-by-n-by-1 uint8 array representing a
%                    greyscale image.
%
% Author: Tyler Young (tyou333)

    % Establish row and column variables.
    imageRows = size(imageArray, 1);
    imageColumns = size(imageArray, 2);

    % Pre-allocate the greyscale image uint8 array.
    greyscaleImage = uint8(zeros(imageRows, imageColumns, "uint8"));
    
    % For every element in the image array,
    for m = 1:imageRows % For every row,
        for n = 1:imageColumns % For every column,

            % Fetch relevent RGB values.
            red = double(imageArray(m, n, 1));
            green = double(imageArray(m, n, 2));
            blue = double(imageArray(m, n, 3));

            % Find greyscale equivalent of the RGB values.
            greyscalePixel = round((0.2126 * red) + (0.7152 * green) ...
                + (0.0722 * blue));

            % Place greyscale value in the same location of the RGB values.
            greyscaleImage(m, n) = greyscalePixel;

        end
    end
end
