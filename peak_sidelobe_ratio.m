function psr = peak_sidelobe_ratio(corrmat)
%% 
% Calculates the PSR (Peak-to-Sidelobe Ratio) of the Correlation result in 
% order to detect oclussion / tracking is lost
%
% Author: Lucas German Wals Ochoa
% Last Update: 2018/08/27
%

peakWH = 11;  % Width and Height of the Window around the Peak

%load('sample_data/correlation_mat');
%corrmat = response;
[rows, cols] = size(corrmat);
%sidelobe_Mask = ones(rows, cols);   % 1 for the sidelobe area, 0 for peak area

% Get location of the peak
[x, y] = ind2sub(size(corrmat),find(corrmat == max(corrmat(:)), 1));
% Get peak value
peak_val = corrmat(x,y);

% Handle patch boundaries
peak_Xtop = max(1, x - floor(peakWH/2) );
peak_Ytop = max(1, y - floor(peakWH/2) );
peak_Xbottom = min(rows, x + floor(peakWH/2) );
peak_Ybottom = min(cols, y + floor(peakWH/2) );

% Set values from Peak area to zero, in order to remove them later
corrmat([peak_Xtop:peak_Xbottom], [peak_Ytop:peak_Ybottom]) = 0;
% Flatten the correlation matrix into a vector for easier handling
sidelobe = corrmat(:);
% Remove the Peak area elements and leave only the values of the Sidelobe
sidelobe( sidelobe(:) == 0 ) = [];

% Calculate Mean and Standard Deviation
mu_sl = mean(sidelobe);
sigma_sl = std(sidelobe);

% Calculate the Peak-to-Sidelobe ratio;
psr = (peak_val - mu_sl) / sigma_sl;

end
