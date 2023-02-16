Welcome to the PEG10 Image Analysis project!
---

This code is for the upcoming manuscript "UBQLN2 restrains the domesticated 
retrotransposon PEG10 to maintain neuronal health in ALS" by the [Alex 
Whiteley lab](https://www.colorado.edu/lab/alex-whiteley/).

## Usage

1. First clone the Git repository to a location on your computer
   ```bash
   git clone https://github.com/jwtay1/PEG10-image-analysis.git
   ```

2. In MATLAB, add the new folder to the path (e.g., by right clicking in 
   the Current Folder panel and selecting Add to Path > Current Folder)

3. Edit the script ``exportND2asTIFs.m`` to change the paths for the input
   and output folders. The input folder should point to the folder where 
   the ND2 files are (the ND2s can be in subfolders under this).

4. Run the script. This should generate a series of TIF files which are 
   reduced in size (by calculating the mean in 2x2 blocks).

5. Edit the script ``exportMask.m`` and change the ``dataDir`` and 
   ``outputBaseDir`` paths. The ``dataDir`` variable should point to the 
   output path of the ``exportND2asTIFs`` script.

6. Run the script. This should generate a series of TIFs containing masks 
   which label each pixel in the image as being part of the region of 
   interest (``true``) or background (``false``).

7. Edit the masks if necessary, e.g. using Fiji/ImageJ. If using ImageJ,
   you will need to invert the LUT and then invert the image to get the
   final mask.

8. Edit the script ``processFilesWithMask.m`` and change the ``dataDir``,
   ``maskDir``, and ``outputDir`` as appropriate.

9. Run the script. The code should output a series of PNG images showing 
   the outline of the regions of interest in green. A MAT-file will be
   produced containing intensity of the PEG10 and Map2 channels.

10. Finally, edit the script ``export2csv.m`` to modify the ``dataDir``. 
    This should point to the locatin of the MAT-files.

11. Run the script to obtain a CSV file with a summary of all the measured
    intensities. Note that in the CSV file, ``Texas Red`` is the PEG10 and
    ``Cy5`` is the Map2 channel.

## Acknowledgements

If you use this code in a publication, please cite our paper:

Black et al. "UBQLN2 restrains the domesticated retrotransposon PEG10 to 
maintain neuronal health in ALS." bioRxiv 2022.03.25.485837; 
doi: https://doi.org/10.1101/2022.03.25.485837