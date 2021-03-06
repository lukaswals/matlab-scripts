function imagesToVideo(working_dir, output_dir, video_name, images_format)
%% Convert one Image Sequence to Video
%
% Script to make a video filesfrom a folder that contains many images
%
% Author: Lucas German Wals Ochoa
% Last Update: 2018/09/17
%
%% Setup
% Change all this variables accordingly.
%%
workingDir = working_dir;
outputDir = output_dir;
videoName = video_name;
imageFormat = ['*.' images_format];
showProcessedImage = false; % Show the percentage of video processed

%% Find Image File Names
% Find all the JPEG file names in the |images| folder. Convert the set of image 
% names to a cell array.
%%
imageNames = dir(fullfile(workingDir, imageFormat));
imageNames = {imageNames.name}';
%% Create New Video with the Image Sequence
% Construct a VideoWriter object, which creates a Motion-JPEG AVI file by default.
%%
disp('Creating new video file...');
outputVideo = VideoWriter(fullfile(outputDir, videoName), 'MPEG-4');
% Default Frame Rate is set to 30. Uncomment following line to change it
%outputVideo.FrameRate = 10;  
open(outputVideo)
%% 
% Loop through the image sequence, load each image, and then write it to 
% the video.
%%
disp('Writing images to video file...');
for ii = 1:length(imageNames)
%    disp('Image ' + ii + ' of ' + length(imageNames));
%    line = sprintf('Image %d of %d', ii, length(imageNames) );
%    disp(line);
    if (showProcessedImage)
        fprintf('Image %d of %d\n', ii, length(imageNames) );
    end
    img = imread(fullfile(workingDir, imageNames{ii}));
    writeVideo(outputVideo,img)
end
disp('Writen all images.');
%% 
% Close the video file.
%%
close(outputVideo)

end