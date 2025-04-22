// Get the original image title and directory
originalTitle = getTitle();
originalDir = getDirectory("current");

// Convert the stack to a hyperstack
run("Stack to Hyperstack...", "order=xyzct channels=2 slices=9 frames=10 display=Grayscale");
run("Split Channels");

// Create window names based on the original title
highSNRWindow = "C1-" + originalTitle;
lowSNRWindow = "C2-" + originalTitle;

// Function to reduce dimensionality and save
function reduceAndSave(channelWindow, savePath) {
    selectWindow(channelWindow);

    // Reduce dimensionality to average over time
    run("Reduce Dimensionality...", "channels slices keep");

    // Save the result
    saveAs("Tiff", savePath);
    close();
}

// Process High SNR Channel
reduceAndSave(highSNRWindow, originalDir + originalTitle + "_High_SNR_Averaged_Stack.tif");

// Process Low SNR Channel
reduceAndSave(lowSNRWindow, originalDir + originalTitle + "_Low_SNR_Averaged_Stack.tif");

close("*");
