function apce = average_peak_correlation_energy(responseMap)
%%
% Calculates the APCE (Average Peak-to-Correlation Energy) of the response map
% in order to obtain a measure of peak strength 
%
% Measurement proposed by the paper "Large margin object tracking with circulant
% feature maps" by M. Wang et al.
%
% Author: Lucas German Wals Ochoa
% Last Update: 2018/09/11
%%

%load('sample_data/correlation_mat');
%corrmat = response;
% Response Map size
[rows, cols] = size(responseMap);

% Get location of the max and min peak
[xmax, ymax] = ind2sub(size(responseMap),find(responseMap == max(responseMap(:)), 1));
[xmin, ymin] = ind2sub(size(responseMap),find(responseMap == min(responseMap(:)), 1));
% Get max and min peak value
max_peak = responseMap(xmax,ymax);
min_peak = responseMap(xmin,ymin);

% Calculate the "denominator" of apce
difference = responseMap - min_peak;
square_diff = difference .^ 2;
square_diff = square_diff(:);   % Unrolled matrix into a Vector
denominator = mean(square_diff);

apce = ((max_peak - min_peak)^2) / denominator;

end
