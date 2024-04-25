function imageFingerprint = ImageFingerprint(imageArray, hashMethod, ...
    resizeMethod)
% ImageFingerprint creates a 64-bit image fingerprint using the specified
% hashing and resizing alorgorithnm for a given colour image.
%
%   Inputs:
%   imageArray = A m-by-n-by-3 uint8 array representing a colour image.
%   hashMethod = A character vector containing either 'AvgHash' or
%                'DiffHash'.
%   resizeMethod = A character vector containing either 'Nearest' or 'Box'.
%
%   Output:
%   imageFingerprint = A 1-by-64 logical row vector representing the image
%                      fingerprint.
%
% Author: Tyler Young (tyou333)

    % Convert from RGB colour to greyscale.
    imageFingerprint = GreyscaleLuma(imageArray);

    % Establish hashing method boolean.
    avgHash = false;
    diffHash = false;

    % Compute scale factor from specified hashing algorithm.
    if strcmpi(hashMethod, 'AvgHash') % Average Hashing.
        scaleArray = [8, 8];
        avgHash = true;

    elseif strcmpi(hashMethod, 'DiffHash') % Differential Hashing.
        scaleArray = [8, 9];
        diffHash = true;
        
    end

    % Resize image using specified resizing algorithm.
    if strcmpi(resizeMethod, 'Nearest') % Nearest Neighbour Interpolation.
        imageFingerprint = ResizeNearest(imageFingerprint, scaleArray);

    elseif strcmpi(resizeMethod, 'Box') % Box Sampling.
        imageFingerprint = ResizeBox(imageFingerprint, scaleArray);

    end
    
    % Hash image using specified hashing algorithm.
    if avgHash % Average Hashing.
        imageFingerprint = AvgHash(imageFingerprint);

    elseif diffHash % Differential Hashing.
        imageFingerprint = DiffHash(imageFingerprint);

    end
end