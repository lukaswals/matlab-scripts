function sequencesToVideos(base_dir, output_dir, format)
%% Convert Image Sequences to Video
%
% Script to make many video files from a folder that contains different
% sequences of images
%
% Author: Lucas German Wals Ochoa
% Last Update: 2018/06/27
%
%% Some considerations
% The directory where the images are stored will be "splitted" in two
% variables like these 'workingDir\imageDir'
% So "workingDir" will be the directory where all the sequences are, and 
% "imageDir" will be the directory where the images are
%% Setup
% Change all this variables accordingly if you not use the function input
%%
workingDir = base_dir;
outputDir = output_dir;
imageFormat = ['*.' format];
%percentage = 'Images processed: %.2f%%\n';

%% Find all the Subdirectories 
% Find all the |imageDirs| folders in the |workingDir| folder. 
% Convert the result into a cell array.
workingDirContents = dir(workingDir);
dirsIndex = find(vertcat(workingDirContents.isdir));
imagesDirs = {workingDirContents(dirsIndex).name}';
% Avoid the first two directories, '.' and '..'
imagesDirs = imagesDirs(3:length(imagesDirs)); 

for i = 1:length(imagesDirs)
    %% Find Image File Names
    % Find all the |imageFormat| file names in the |images| folder. 
    % Convert the set of image names to a cell array.
    %%
    imageDir = imagesDirs{i};
    imageNames = dir(fullfile(workingDir, imageDir, imageFormat));
    imageNames = {imageNames.name}';
	% If no images were found, tell user and continue with other folders
    if ( isempty(imageNames) ) 
        fprintf('No images were found in folder "%s" with format "%s"\n', imageDir, imageFormat);
    else
        %% Create New Video with the Image Sequence
        % Construct a VideoWriter object. Unless specified otherwhise
        % it will create a Motion-JPEG AVI file by default.
        %%
        fprintf('Creating video named "%s" in folder "%s"...\n', imageDir, outputDir);
        outputVideo = VideoWriter(fullfile(outputDir, imageDir), 'MPEG-4');
        % Default Frame Rate is set to 30. If you want to change it, uncomment following line
        %outputVideo.FrameRate = 15;  
        open(outputVideo)
        %% 
        % Loop through the image sequence, load each image, and then write it to 
        % the video.
        %%
        disp('--> Writing images to video file.');
        for ii = 1:length(imageNames)
            %if ( mod(ii,100) == 0 )
            %    per = 100 * (ii/length(imageNames) );
            %    fprintf(percentage, per);
            %end
            img = imread(fullfile(workingDir, imageDir, imageNames{ii}));
            writeVideo(outputVideo,img)
        end
        disp('----> All images were written.');
        %% 
        % Close the video file.
        %%
        close(outputVideo)
    end
end

disp('Finish making all videos!.');

end