// Get the original image title and directory
originalTitle = getTitle();
originalDir = getDirectory("current");

// Convert the stack to a hyperstack
run("Stack to Hyperstack...", "order=xyzct channels=2 slices=9 frames=10 display=Grayscale");
run("Split Channels");

// Create window names based on the original title
highSNRWindow = "C1-" + originalTitle;
lowSNRWindow = "C2-" + originalTitle;

// Function to process, reorder, project, and save
function reorderProjectAndSave(channelWindow, savePath) {
    selectWindow(channelWindow);

    // Reorder the hyperstack
    run("Re-order Hyperstack ...", "channels=[Channels (c)] slices=[Frames (t)] frames=[Slices (z)]");

    // Perform Z projection with average intensity
    run("Z Project...", "projection=[Average Intensity] all");

    // Convert the result from hyperstack to stack
    //run("HyperStack to Stack");

    // Save the result
    saveAs("Tiff", savePath);
    close();
}

// Process High SNR Channel
reorderProjectAndSave(highSNRWindow, originalDir + originalTitle + "_High_SNR_Averaged_Stack.tif");

// Process Low SNR Channel
reorderProjectAndSave(lowSNRWindow, originalDir + originalTitle + "_Low_SNR_Averaged_Stack.tif");

close("*");
