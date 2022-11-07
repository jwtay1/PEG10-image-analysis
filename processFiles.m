clearvars
clc

dataDir = 'D:\Projects\ALMC Tickets\T17128-Holling\data\ND2 files\Rb IgG + Chk IgG\export';

imageFiles = dir(fullfile(dataDir, '*.tif'));

%Strip the extension and the last three characters off the filenames (these
%are the channel numbers)
storeFilenames = cell(1, numel(imageFiles));
for iFN = 1:numel(imageFiles)
    
    [~, currFN] = fileparts(imageFiles(iFN).name);
    storeFilenames{iFN} = currFN(1:(end - 2));

end

storeFilenames = unique(storeFilenames);

%Create a struct
storeData = struct('Filename', [], 'GFPIntensity', [], 'TRITCIntensity', []);

%Process each file
for iFile = 1:numel(storeFilenames)

    %Read in images
    I_dapi = imread(fullfile(dataDir, [storeFilenames{iFile}, '_1', '.tif']));
    I_gfp = imread(fullfile(dataDir, [storeFilenames{iFile}, '_2', '.tif']));
    I_tritc = imread(fullfile(dataDir, [storeFilenames{iFile}, '_3', '.tif']));

    %Blur the DAPI image to smooth it out
    I_dapi = imgaussfilt(I_dapi, 10);

    %Segment the spinal cord
    mask = segmentObjects(I_dapi, 150);

    %Measure intensity in other channels
    data_gfp = regionprops(mask, I_gfp, 'MeanIntensity');
    data_tritc = regionprops(mask, I_tritc, 'MeanIntensity');

    storeData(iFile).Filename = storeFilenames{iFile};
    storeData(iFile).GFPIntensity = mean([data_gfp.MeanIntensity]);
    storeData(iFile).TRITCIntensity = mean([data_tritc.MeanIntensity]);

    %Write an image of the mask out
    Iout = showoverlay(I_dapi, imdilate(bwperim(mask), strel('disk', 2)));
    imwrite(Iout, fullfile(dataDir, [storeFilenames{iFile}, '_mask.png']));

end

save(fullfile(dataDir, 'processedData.mat'), 'storeData')