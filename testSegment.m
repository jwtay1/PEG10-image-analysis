clearvars
clc

reader = BioformatsImage('NC peg 10 + map2.nd2');
%I = getPlane(reader, 1, 1, 1, 'ROI', [10000 10000 2500 2500]);
I = getPlane(reader, 1, 'Cy5', 1);
%%
%I = imadjust(I);
%%
mask = I > 1000;
mask = imopen(mask, strel('disk', 5));

mask = bwareaopen(mask, 10000);
mask = imfill(mask, 'holes');
mask = imerode(mask, strel('disk', 2));

mask = bwareaopen(mask, 100000);

data = regionprops(mask, I, 'MeanIntensity');

imshowpair(I, bwperim(mask))

%% Downsize image
Ids = imresize(I, 0.5, 'nearest');
Ids = imgaussfilt(Ids, 10);
imshow(imadjust(Ids), [])

%%
maskds = imbinarize(Ids, 'adaptive', 'sensitivity', 0.7);

maskds = imopen(maskds, strel('disk', 3));
maskds = imclearborder(maskds);
maskds = imfill(maskds, 'holes');
maskds = imopen(maskds, strel('disk', 8));

imshow(maskds)

%%
showoverlay(Ids, maskds, 'Opacity', 0.3)


%%

mask = imresize(maskds, size(I), 'nearest');

imshowpair(I, bwperim(mask))