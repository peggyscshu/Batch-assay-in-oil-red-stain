# Batch-assay-in-oil-red-stain [![DOI](https://zenodo.org/badge/315870372.svg)](https://zenodo.org/badge/latestdoi/315870372)
This Fiji macro is designed to automatically measure the oil red occupation and intensity in tissues from tif files collected in a folder.
#Examples
1.	Tissues or cells stained with oil red and hematoxylin. 

#Description
1.	“Batch assay in oil red.ijm” is used to measure the area where oil red signal occupies and the intensity that oil red stained. The corresponding measured data and file names will be collected in the table “Oil red analysis” after batch processing.
2.	The macro offers users to back check the result by opening the raw image and two zip files saved in the same folder in Fiji. These zip files contain the information of region-of-interest of oil red signal and tissue region.
3.	The parameters to segment oil red signal from the whole tissue on line 56 can be modified according to the staining result.

#Instructions Batch assay in oil red.ijm
1.	Clone this repository to your own account.
2.	Install “Fiji is just Image J“ in your PC.
3.	Collect the input image in a folder.
4.	Launch Fiji.
5.	Execute the script under Plugins\Macros\Run
6.	Define the input folder.
7.	Then the measured data will be ready for you.

#Reference
1.	Ruifrok, A.C. & Johnston, D.A. (2001), "Quantification of histochemical staining by color deconvolution", Anal. Quant. Cytol. Histol. 23: 291-299, PMID 11531144

#Feedback
1.	Made changes to the layout templates or some other part of the code? Fork this repository, make your changes, and send a pull request..
2.	Do these codes help on your research? Please cite as the follows. Wang, M.C. , Hsu, M.T., Hu, M.Y., Lin, C.C., Hsu, S.C., Chen, R.D., Lee, J. R., Chou, Y.L., Furukawa, F., Hwang, S.P.L., Hwang, P.P., and Tseng, Y.C., “Adaptive metabolic responses in a thermostabilized environment: transgenerational trade-off implications from tropical tilapia.”

![alt text](https://github.com/peggyscshu/Batch-assay-in-oil-red-stain/blob/main/Flowchart.JPG)
