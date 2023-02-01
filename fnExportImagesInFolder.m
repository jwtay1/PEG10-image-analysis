function fnExportImagesInFolder(inputFolder, outputFolder)
%FNEXPORTIMAGESINFOLDER  Export images in folder
%
%  FNEXPORTIMAGESINFOLDER(inputDir, outputDir) will export ND2 files in
%  folders and sub-folders of the input path to TIFF files. The exported
%  files will be saved with the same directory structure as the output dir.
%
%  Due to the large sizes of the images, and 

files = dir(inputFolder);
files(1:2) = [];        %Remove . and ..

if isempty(files)
    disp('empty')
    return
end

%Create output folder
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

%Process files
for iFile = 1:numel(files)

    %If directory, export images
    if files(iFile).isdir

        fnExportImagesInFolder(fullfile(files(iFile).folder, files(iFile).name), ...
            fullfile(outputFolder, files(iFile).name));

    else

        [~,fname,fext] = fileparts(files(iFile).name);

        %If ND2 file, export as TIF. Do nothing if other file types.
        if strcmpi(fext, '.nd2')            

            reader = BioformatsImage(fullfile(files(iFile).folder, files(iFile).name));

            for iC = 1:reader.sizeC

                %There is a known issue that the image file is too large to
                %read in all at once due to limitations of Java. So split
                %the image into two halves and combine them in MATLAB.

                Iout = zeros(reader.height, reader.width, 'uint16');

                w = round(reader.width/2);

                Iout(:, 1:w) = ...
                    getPlane(reader, 1, iC, 1, 'ROI', [1 1 w reader.height]);

                Iout(:, (w+1):end) = ...
                    getPlane(reader, 1, iC, 1, 'ROI', [w+1 1 (reader.width - w) reader.height]);

                Iout = reduceImage(Iout, 4);

                imwrite(Iout, fullfile(outputFolder, [fname, '_', int2str(iC), '.tif']), ...
                    'Compression', 'none');

            end

        end


    end

end





end