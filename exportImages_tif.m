clearvars
clc

dataDir = 'D:\Projects\ALMC Tickets\T17128-Holling\data\Tif files\Sigma PEG10 + MAP2';

if ~exist(fullfile(dataDir,'export'), 'dir')
    mkdir(fullfile(dataDir,'export'));
end

files = dir(fullfile(dataDir, '*.tif'));

for iF = 1:numel(files)

    [~, outputFN] = fileparts(files(iF).name);

    outputFN = outputFN(1:(end - 2));

    if exist(fullfile(dataDir, 'export', [outputFN, '_1', '.tif']), ...
            'file')
        continue
    end
         
    for iC = 1:3

        I = imread(fullfile(dataDir, [outputFN, 'c', int2str(iC), '.tif']));

        Iout = reduceImage(I, 4);

        imwrite(Iout, fullfile(dataDir, 'export', [outputFN, '_', int2str(iC), '.tif']), ...
            'Compression', 'none');

    end

end