%This is a workaround for the images which are not segmented correctly dut
%to mounting issues

clearvars
clc

% dataDir = 'D:\Projects\ALMC Tickets\T17128-Holling\data\Tif files';
% outputBaseDir = 'D:\Projects\ALMC Tickets\T17128-Holling\processed\2022-11-14\masks';

dataDir = 'D:\Projects\ALMC Tickets\T17128-Holling\processed\2023-02-06\TIFs';
outputBaseDir = 'D:\Projects\ALMC Tickets\T17128-Holling\processed\2023-02-06\TIFs\masks';

subfolders = dir(dataDir);
subfolders(1:2) = [];

subfolders(~[subfolders.isdir]) = [];

subfolders = {subfolders.name};

%{'NC PEG10 + MAP2', 'Rb IgG + Chk IgG', 'Sigma PEG10 + MAP2'};

for ii = 1:numel(subfolders)

    files = dir(fullfile(dataDir, subfolders{ii}, '*_1.tif'));

    if ~exist(fullfile(outputBaseDir, subfolders{ii}), 'dir')
        mkdir(fullfile(outputBaseDir, subfolders{ii}));
    end

    for iFile = 1:numel(files)

        [~, outputFn] = fileparts(files(iFile).name);

        if exist(fullfile(outputBaseDir, subfolders{ii},  ...
            [outputFn, '.tif']), 'file')
            continue
        end

        currDAPIimg = imread(fullfile(files(iFile).folder, ...
            files(iFile).name));

        currDAPIimg = imgaussfilt(currDAPIimg, 10);

        %mask = segmentObjects(currDAPIimg, 150);
        mask = segmentObjects(currDAPIimg, 500);

        imwrite(mask, fullfile(outputBaseDir, subfolders{ii},  ...
            [outputFn, '.tif']), 'COmpression', 'none');

    end


end