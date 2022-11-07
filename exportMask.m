%This is a workaround for the images which are not segmented correctly dut
%to mounting issues

clearvars
clc

dataDir = 'D:\Projects\ALMC Tickets\T17128-Holling\data\ND2 files';
outputBaseDir = 'D:\Projects\ALMC Tickets\T17128-Holling\processed\2022-11-07\masks';

subfolders = {'NC PEG10 + MAP2', 'Rb IgG + Chk IgG', 'Sigma PEG10 + MAP2'};

for ii = 1:numel(subfolders)

    files = dir(fullfile(dataDir, subfolders{ii}, 'export', '*_1.tif'));

    if ~exist(fullfile(outputBaseDir, subfolders{ii}), 'dir')
        mkdir(fullfile(outputBaseDir, subfolders{ii}));
    end

    for iFile = 1:numel(files)

        currDAPIimg = imread(fullfile(files(iFile).folder, ...
            files(iFile).name));

        currDAPIimg = imgaussfilt(currDAPIimg, 10);

        mask = segmentObjects(currDAPIimg, 150);

        [~, outputFn] = fileparts(files(iFile).name);

        imwrite(mask, fullfile(outputBaseDir, subfolders{ii},  ...
            [outputFn, '.tif']), 'COmpression', 'none');

    end


end