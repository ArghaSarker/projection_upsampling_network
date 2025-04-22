#@ File (label = "Input directory", style = "directory") input
#@ String (label = "File suffix", value = ".tif") suffix

processFolder(input);

// Function to scan folders/subfolders/files to find files with the correct suffix
function processFolder(input) {
    list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if (File.isDirectory(input + File.separator + list[i])) {
			processFolder(input + File.separator + list[i]);
		}
		if (endsWith(list[i], suffix)) {
			processFile(input, list[i]);
		}
	}
}

function processFile(input, file) {
	print("Processing: " + input + File.separator + file);

    open(input + File.separator + file);
    originalTitle = getTitle();

    // Convert the stack to a hyperstack
    run("Stack to Hyperstack...", "order=xyzct channels=2 slices=9 frames=10 display=Grayscale");
    run("Split Channels");

    // Create window names based on the original title
    highSNRWindow = "C1-" + originalTitle;
    lowSNRWindow = "C2-" + originalTitle;

    // Function to reduce dimensionality and save
    function reduceAndSave(channelWindow, suffix) {
        selectWindow(channelWindow);
        // Reorder the hyperstack
	    run("Re-order Hyperstack ...", "channels=[Channels (c)] slices=[Frames (t)] frames=[Slices (z)]");

	    // Perform Z projection with average intensity
	    run("Z Project...", "projection=[Average Intensity] all");

        // Reduce dimensionality to average over time
//        run("Reduce Dimensionality...", "channels slices keep");

        // Save the result in the same directory as the input file
        saveAs("Tiff", input + File.separator  + suffix + ".tif");
        close();
    }

    // Process High SNR Channel
    reduceAndSave(highSNRWindow, "highSNR");

    // Process Low SNR Channel
    reduceAndSave(lowSNRWindow, "lowSNR");

    close();
}

close("*");
