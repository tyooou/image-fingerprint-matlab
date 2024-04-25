function collection = FingerprintCollection(listNames, hashMethod, ...
    resizeMethod)
% FingerprintCollection function stores all of the image fingerprints from
% a list of image filenames so they can be quickly looked up for
% comparison.
%
%   Inputs:
%   listNames = A m-by-1 string arrray representing a list of image file
%               names.
%   hashMethod = A character vector containing either 'AvgHash' or
%                'DiffHash'.
%   resizeMethod = A character vector containing either 'Nearest' or 'Box'.
%
%   Output:
%   imageFingerprint = A m-by-1 cell array containg the fingerprint from
%                      each image file.
%
% Author: Tyler Young (tyou333)
    
    % Pre-allocate cell array for fingerprint data collection.
    collection = cell(numel(listNames), 1);

    % For every file listed in the list of filenames,
    for i = 1:numel(listNames)

        % Read specified image file.
        imageArray = imread(listNames(i)); 

        % Determine the image fingerprint.
        imageFingerprint = ImageFingerprint(imageArray, hashMethod, ...
            resizeMethod);

        % Store image fingerprint into the fingerprint data collection.
        collection{i} = imageFingerprint;

    end
end