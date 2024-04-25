function differingBits = HammingDistance(fingerprint1, fingerprint2)
% HammingDistance compares two image fingerprints, f1 and f2, and
% determines the number of positions at which the corresponding values
% differ. The number of positions that differ is known as the Hamming
% distance. A small hamming distance indicates similar images, and vice
% versa.
%
%   Inputs:
%   fingerprint1 = A 1-by-n logical row vector for fingerprint f1.
%   fingerprint2 = A 1-by-n logical row vector for fingerprint f2.
%
%   Output:
%   differingBits = A integer representing the number of differing bits 
%                   between fingerprints f1 and f2. 
%
% Author: Tyler Young (tyou333)

    % Pre-allocate variable for the number of differing bits.
    differingBits = 0;

    % For every bit in the fingerprint row vector (assuming equal n),
    for i = 1:numel(fingerprint1)

        % If bits are not equal in value,
        if fingerprint1(i) ~= fingerprint2(i)

            % Increase Hamming distance.
            differingBits = differingBits + 1;

        end
    end
end