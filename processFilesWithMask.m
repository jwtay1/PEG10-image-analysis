clearvars
clc

dataDir = 'D:\Projects\ALMC Tickets\T17128-Holling\data\Tif files';
maskDir = 'D:\Projects\ALMC Tickets\T17128-Holling\processed\2022-11-14\masks';
outputDir = 'D:\Projects\ALMC Tickets\T17128-Holling\processed\2022-11-14';

subfolders = {'NC PEG10 + MAP2', 'Rb IgG + Chk IgG', 'Sigma PEG10 + MAP2'};

for ii = 1:numel(subfolders)

    currOutputDir = fullfile(outputDir, subfolders{ii});

    if ~exist(currOutputDir, 'dir')
        mkdir(currOutputDir)
    end
    
    %Get list of images
    imageFiles = dir(fullfile(dataDir, subfolders{ii}, 'export', '*_1.tif'));

    %Create a struct
    storeData = struct('Filename', [], 'GFPIntensity', [], 'TRITCIntensity', []);

    %Process each file
    for iFile = 1:numel(imageFiles)

        [~, fn] = fileparts(imageFiles(iFile).name);
        fn = fn(1:end - 2);

        %Read in images
        I_dapi = imread(fullfile(imageFiles(iFile).folder, [fn, '_1', '.tif']));
        I_gfp = imread(fullfile(imageFiles(iFile).folder, [fn, '_2', '.tif']));
        I_tritc = imread(fullfile(imageFiles(iFile).folder, [fn, '_3', '.tif']));

        %Segment the spinal cord
        mask = imread(fullfile(maskDir, subfolders{ii}, [fn, '_1', '.tif']));

        if ~islogical(mask)
            mask = mask > 0;
        end

        %Measure intensity in other channels
        data_gfp = regionprops(mask, I_gfp, 'MeanIntensity');
        data_tritc = regionprops(mask, I_tritc, 'MeanIntensity');

        storeData(iFile).Filename = imageFiles(iFile).name;
        storeData(iFile).GFPIntensity = mean([data_gfp.MeanIntensity]);
        storeData(iFile).TRITCIntensity = mean([data_tritc.MeanIntensity]);

        %Write an image of the mask out
        I_dapi_norm = double(I_dapi);
        I_dapi_norm = (I_dapi_norm - min(I_dapi_norm(:)))/(max(I_dapi_norm(:)) - min(I_dapi_norm(:)));

        Iout = showoverlay(imadjust(I_dapi_norm), imdilate(bwperim(mask), strel('disk', 2)));
        imwrite(Iout, fullfile(currOutputDir, [fn, '_mask.png']));

    end

    save(fullfile(outputDir, [subfolders{ii}, '.mat']), 'storeData')

end