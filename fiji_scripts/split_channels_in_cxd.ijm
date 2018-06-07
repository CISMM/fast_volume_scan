outputDir = "D:/Joe/data/12_12/continuous_5min/";
subDir1 = "488";
subDir2 = "561";
substackSize = 100;

start = 1;
getDimensions(w, h, channels, slices, frames);
stackInd = 1;
File.makeDirectory(outputDir+subDir1);
if (!File.exists(outputDir+subDir1))
      exit("Unable to create directory "+outputDir+subDir1);
File.makeDirectory(outputDir+subDir2);
if (!File.exists(outputDir+subDir2))
      exit("Unable to create directory "+outputDir+subDir2);

setBatchMode("hide");
while (start < frames)
{
	make_substack_and_save(start, start+(substackSize-1), 2, outputDir+subDir1+"/"+IJ.pad(stackInd, 4));
	make_substack_and_save(start+1, start+(substackSize-1), 2, outputDir+subDir2+"/"+IJ.pad(stackInd, 4));
	stackInd++;
	start += (substackSize+1);
	print(start);
}
setBatchMode("exit and display");

function make_substack_and_save(startInd, endInd, increment, savePath)
{
	run("Make Substack...", "slices="+parseInt(startInd) + "-" + 
							 parseInt(endInd) + "-" +
							 parseInt(increment));
	saveAs("Tiff", savePath);
	print("Save "+savePath);
	close();
}