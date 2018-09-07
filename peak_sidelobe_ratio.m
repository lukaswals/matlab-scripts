function psr = peak_sidelobe_ratio(corrmat)
%% 
% Calculates the PSR (Peak-to-Sidelobe Ratio) of the Correlation result in 
% order to detect oclussion / tracking is lost
%
% Author: Lucas German Wals Ochoa
% Last Update: 2018/08/27
%

peakWH = 11;  % Width and Height of the Window around the Peak
shifting = floor(peakWH/2); % How much we should shift the matrix when dealing with boundaries

%load('sample_data/correlation_mat');
%corrmat = response;
[rows, cols] = size(corrmat);
% "Synthetic Examples"
%corrmat = circshift(corrmat, [5,-1]);
%corrmat = circshift(corrmat, [-3,3]);

% Get location of the peak
[x, y] = ind2sub(size(corrmat),find(corrmat == max(corrmat(:)), 1));

% Handle patch boundaries by shifting the matrix in correspondent direction
% and also calculate the new location of the peak.
% We always shift the matrix by "shifting" value, just for ease of coding =P
if x < (shifting + 1)
    corrmat = circshift(corrmat, shifting, 1);
    x = x + shifting;
elseif x > (rows - (shifting + 1))
    corrmat = circshift(corrmat, -(shifting+1), 1);
    x = x - shifting -1;
end
if y < (shifting + 1)
    corrmat = circshift(corrmat, shifting, 2);
    y = y + shifting;
elseif y > (cols - (shifting + 1))
    corrmat = circshift(corrmat, -(shifting+1), 2);
    y = y - shifting - 1;
end

% Get peak value
peak_val = corrmat(x,y);
%disp(peak_val);

% Get Peak surrounding area
peak_Xtop = x - floor(peakWH/2);
peak_Ytop = y - floor(peakWH/2);
peak_Xbottom = x + floor(peakWH/2);
peak_Ybottom = y + floor(peakWH/2);


% Set values from Peak area to zero, in order to remove them later
corrmat([peak_Xtop:peak_Xbottom], [peak_Ytop:peak_Ybottom]) = 0;
% Flatten the correlation matrix into a vector for easier handling
sidelobe = corrmat(:);
% Remove the Peak area elements and leave only the values of the Sidelobe (in
% order for the 0 values to not interfere in the calculation of the mean)
sidelobe( sidelobe(:) == 0 ) = [];

% Calculate Mean and Standard Deviation
mu_sl = mean(sidelobe);
sigma_sl = std(sidelobe);

% Calculate the Peak-to-Sidelobe ratio;
psr = (peak_val - mu_sl) / sigma_sl;

end
