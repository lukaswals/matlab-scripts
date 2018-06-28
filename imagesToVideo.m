function imagesToVideo(working_dir, output_dir, video_name, format)
%% Convert Image Sequences to Video
%% Setup
% Change all this variables accordingly.
%%
%workingDir = 'C:\Users\lukas\Documents\MATLAB\videoresults';
workingDir = working_dir;
%imageDir = 'GOG-MVI_39931';
%videoName = 'GOG_CompACT_0.0_MVI_39931';
%videoName = 'FERN-sindoh0905_s3-15fps';
%imageFormat = '*.jpg';
outputDir = output_dir;
videoName = video_name;
imageFormat = ['*.' format];
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
%outputVideo.FrameRate = 15;  
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
% Finalize the video file.
%%
close(outputVideo)

end