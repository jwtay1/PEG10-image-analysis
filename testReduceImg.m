clearvars
clc

dataDir = 'D:\Projects\ALMC Tickets\T17128-Holling';

reader = BioformatsImage(fullfile(dataDir, 'NC peg 10 + map2.nd2'));
%I = getPlane(reader, 1, 1, 1, 'ROI', [10000 10000 2500 2500]);
I = getPlane(reader, 1, 'Cy5', 1);

%%
outputImg = reduceImage(double(I), 2);

norm = (outputImg - min(outputImg(:)))/(max(outputImg(:)) - min(outputImg(:)));

imshow(norm, [0 0.05])