// input_dir is a folder containing stacks that will be sheer corrected.

first_x = 0;
last_x = 108;
output_dir = "C:\\Users\\phsiao\\Desktop\\sheer_corrected\\";
input_dir  = "Y:\\research_news\\2018_04_11\\";

function to_sequence(stack, tmp_dir)
{
	File.makeDirectory(tmp_dir);
	if (!File.exists(tmp_dir))
		exit("Unable to create directory "+tmp_dir);
	open(stack);
    run("Image Sequence... ", "format=TIFF save="+tmp_dir+"00010000.tif");
    close();
}

function trim_then_pad(in_dir, num_img)
{
	setBatchMode("hide");
	img_list = getFileList(tmp_dir);
	
	for (i = 0; i < img_list.length; i++) {
  		open(in_dir+img_list[i]);
		getDimensions(w, h, channels, slices, frames);	
		start_x = first_x + round((last_x - first_x) * i / (num_img-1));
		makeRectangle(start_x, 0, w - start_x, h);
		run("Crop");
		run("Canvas Size...", "width="+w+" height="+h+" position=Center-Left zero"); 
		saveAs("Tiff", in_dir+img_list[i]+"_corrected.tif");
  		close();
  	}
  	setBatchMode("exit and display");
}

function to_stack(tmp_dir, out_file, keyword)
{
	run("Image Sequence...", "open="+tmp_dir+"00010000.tif_corrected.tif file="+keyword+" sort");
	saveAs("Tiff", out_file);
	close();
}

function clear_dir(dir)
{
	img_list = getFileList(dir);
	for (i = 0; i < img_list.length; i++) {
		File.delete(dir + img_list[i])
	}
}
function do_correction(stack_file, stack_size, tmp_dir, out_file)
{
	to_sequence(stack_file, tmp_dir);
	trim_then_pad(tmp_dir, 50);
	to_stack(tmp_dir, out_file, "corrected");
	
}

function sheer_correct(stacks_folder, out_dir)
{
	File.makeDirectory(out_dir);
	if (!File.exists(out_dir))
		exit("Unable to create directory "+out_dir);
		
	img_list = getFileList(stacks_folder);
	for (i = 0; i < img_list.length; i++) {
		if (endsWith(img_list[i], ".tif")) {
			do_correction(stacks_folder + img_list[i],
			 	     50,
			    	 "C:\\Users\\phsiao\\Desktop\\fiji_tmp\\",
			      	 out_dir+img_list[i]);
			clear_dir("C:\\Users\\phsiao\\Desktop\\fiji_tmp\\");
			print("image " + i);
		}
	}
}

sheer_correct(input_dir, output_dir);
