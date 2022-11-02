clearvars
clc

dataDir = 'D:\Projects\ALMC Tickets\T17128-Holling\data\ND2 files\Sigma PEG10 + MAP2';

if ~exist(fullfile(dataDir,'export'), 'dir')
    mkdir(fullfile(dataDir,'export'));
end

files = dir(fullfile(dataDir, '*.nd2'));

for iF = 1:numel(files)

    reader = BioformatsImage(fullfile(files(iF).folder, files(iF).name));

    for iC = 1:reader.sizeC

        I = getPlane(reader, 1, iC, 1);

        Iout = reduceImage(I, 4);

        [~, outputFN] = fileparts(files(iF).name);

        imwrite(Iout, fullfile(dataDir, 'export', [outputFN, '_', int2str(iC), '.tif']), ...
            'Compression', 'none');

    end

end