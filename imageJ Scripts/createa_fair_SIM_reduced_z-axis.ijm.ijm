// Input directory and output file name
inputDir = "C:/Users/ASARKER/Desktop/final_results/this_will_be_in_paper/SIm_recon/FA/SR/FA/input/";
outputStackName = "All_image_stack.tif";

// Define valid file extensions (in lowercase)
ext1 = ".tif";
ext2 = ".tiff";

// Get a list of all files in the input directory
fileList = getFileList(inputDir);

// Print the list of files to be processed
print("List of files to be processed:");
for (i = 0; i < fileList.length; i++) {
    print("File " + i + ": " + fileList[i]);
}

// Process each image
for (i = 0; i < fileList.length; i++) {
    fileName = fileList[i];
    fileNameLower = toLowerCase(fileName);
    if (endsWith(fileNameLower, ext1) || endsWith(fileNameLower, ext2)) {
        filePath = inputDir + fileName;
        open(filePath);
        originalTitle = getTitle();
        if (nSlices() > 1) {
            run("Duplicate...", " ");
            duplicatedTitle = getTitle();
            selectWindow(originalTitle);
            close();
            selectWindow(duplicatedTitle);
        }
        currentTitle = getTitle();
        print("Adding to stack: " + currentTitle);
    }
}

// Convert all opened images to a stack
run("Images to Stack", "name=All_image_stack use");

// Save the resulting stack to the input directory
stackFilePath = inputDir + outputStackName;
saveAs("Tiff", stackFilePath);
print("Stack saved to: " + stackFilePath);

// Close all images to free memory
close("*");
