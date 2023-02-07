clearvars
clc

dataDir = 'D:\Projects\ALMC Tickets\T17128-Holling\processed\2023-02-06\processed';

files = dir(fullfile(dataDir, '*.mat'));

fid = fopen(fullfile(dataDir, 'results.csv'), 'w');

fprintf(fid, 'Condition, Filename, Texas Red, Cy5\n');

for iF = 1:numel(files)

    currFile = load(fullfile(dataDir, files(iF).name));

    for iD = 1:numel(currFile.storeData)

        if iD == 1

            fprintf(fid, '%s, %s, %f, %f\n', ...
                files(iF).name, currFile.storeData(iD).Filename, ...
                currFile.storeData(iD).GFPIntensity, ...
                currFile.storeData(iD).TRITCIntensity);

        else

            fprintf(fid, ', %s, %f, %f\n', ...
                currFile.storeData(iD).Filename, ...
                currFile.storeData(iD).GFPIntensity, ...
                currFile.storeData(iD).TRITCIntensity);

        end

    end


end

fclose(fid)