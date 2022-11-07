function mask = segmentObjects(inputImg, thLvl, varargin)

mask = inputImg > thLvl;

mask = bwareaopen(mask, 10000);
mask = imfill(mask, 'holes');
mask = imerode(mask, strel('disk', 2));

mask = bwareaopen(mask, 100000);

if ~isempty(varargin)

    %Save the mask file
    imwrite(mask, varargin{1});

end


end