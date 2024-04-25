function DispFP(imageFingerprint)
% DispFP displays the image fingerprint in a pretty format on one line.
%
%   Input:
%   imageFingerprint = A 1-by-n logical row vector representing an image
%                      fingerprint.
%
%   Output:
%   None. (The fingerprint is displayed)
%
% Author: Tyler Young (tyou333)

    % Count how many bits there are.
    numofElements = numel(imageFingerprint);

    % Find how many bytes there are and the excess bits.
    bits = mod(numofElements, 8);
    bytes = (numofElements - bits) / 8;
    
    % Determine split array by bytes first, then remaining bits.
    arraySplit = zeros(1, bytes) + 8;
    if bits > 0
        arraySplit = [arraySplit, bits];
    end

    % Split the image fingerprint by the bytes then bits into a cell array.
    subArrays = mat2cell(double(imageFingerprint), 1, arraySplit);
    
    % Pre-allocate string array.
    displayFP = "";

    % For every byte/bits,
    for i = 1:numel(subArrays)
        displayFP = displayFP + join(string(subArrays{i}), "") ...
                + " "; % Print byte/bits and a space.
    end

    % Add newline.
    displayFP = displayFP + newline;

    % Display new image fingerprint format.
    disp(strip(displayFP));

end