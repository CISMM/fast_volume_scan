outputDir = "D:/Joe/data/volume_scan/5_split_channels/";
subDir1 = "liveCell_with_bead00147_488";
subDir2 = "liveCell_with_bead00147_561_primary";
substackfull = 200;
substackToTake = 170;
start = 31;
getDimensions(w, h, channels, slices, frames);  // Nrrd uses slices as # of frames
stackInd = 1;
File.makeDirectory(outputDir+subDir1);
if (!File.exists(outputDir+subDir1))
      exit("Unable to create directory "+outputDir+subDir1);
File.makeDirectory(outputDir+subDir2);
if (!File.exists(outputDir+subDir2))
      exit("Unable to create directory "+outputDir+subDir2);

setBatchMode("hide");
while (start < slices)
{
	print("aaa");
	make_substack_and_save(start,   start+(substackToTake-1), 2, outputDir+subDir1+"/"+IJ.pad(stackInd, 4));
	make_substack_and_save(start+1, start+(substackToTake-1), 2, outputDir+subDir2+"/"+IJ.pad(stackInd, 4));
	stackInd++;
	start += substackfull;
	print(start);
}
setBatchMode("exit and display");

function make_substack_and_save(startInd, endInd, increment, savePath)
{
	run("Make Substack...", "slices="+parseInt(startInd) + "-" + 
							 parseInt(endInd) + "-" +
							 parseInt(increment));
	//run("Nrrd ... ", "nrrd=" + savePath + ".nrrd");
	saveAs("tiff", savePath);
	print("Save " + savePath);
	close();
}