function outputImg = reduceImage(inputImg, reductionFactor, varargin)
%REDUCEIMAGE  Reduce an image dimension
%
%  O = REDUCEIMAGE(I, RF) reduces the input image by averaging the image
%  over 2x2 pixel blocks.

rowIdx = 1:reductionFactor:size(inputImg, 1);
colIdx = 1:reductionFactor:size(inputImg, 2);

outputImg = zeros(numel(rowIdx) - 1, numel(colIdx) - 1, class(inputImg));

for iRow = 1:(numel(rowIdx) - 1)
    for iCol = 1:(numel(colIdx) - 1)

        currRowIdxs = rowIdx(iRow):(rowIdx(iRow + 1) - 1);
        currColIdxs = colIdx(iCol):(colIdx(iCol + 1) - 1);

        try
        outputImg(iRow, iCol) = mean(inputImg(currRowIdxs, currColIdxs), 'all');
        catch
            keyboard
        end

    end
end
