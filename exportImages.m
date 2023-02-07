clearvars
clc

dataDir = 'G:\.shortcut-targets-by-id\1v1eZdGr5J0bg_Z8wJ6IOB8eSkMuvOVyL\last 2 samples';

if ~exist(fullfile(dataDir,'export'), 'dir')
    mkdir(fullfile(dataDir,'export'));
end

files = dir(fullfile(dataDir, '*.nd2'));

for iF = 1:numel(files)

    [~, outputFN] = fileparts(files(iF).name);

    if exist(fullfile(dataDir, 'export', [outputFN, '_1', '.tif']), ...
            'file')
        continue
    end
         
    reader = BioformatsImage(fullfile(files(iF).folder, files(iF).name));

    for iC = 1:reader.sizeC

        I = getPlane(reader, 1, iC, 1);

        Iout = reduceImage(I, 4);

        imwrite(Iout, fullfile(dataDir, 'export', [outputFN, '_', int2str(iC), '.tif']), ...
            'Compression', 'none');

    end

end