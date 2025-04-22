// Input directory
inputDir = "C:/Users/ASARKER/Desktop/final_results/CARE-RESULTS/F-actin_08_best_model/input_image/";
outputDir = "C:/Users/ASARKER/Desktop/final_results/CARE-RESULTS/F-actin_08_best_model/input_image/";
// C:/Users/ASARKER/Desktop/final_results/CARE-RESULTS/f-actin-04/input_image/

// C:/Users/ASARKER/Desktop/final_results/MT-02/DN_VAL/gt/

// File extensions to process (now includes .tif and .tiff)
extensions = newArray(".tif", ".tiff");

// Get a list of all files in the input directory
fileList = getFileList(inputDir);

// Print the list of files in the directory
for (i = 0; i < fileList.length; i++) {
    print("File " + i + ": " + fileList[i]);
}

// Loop over each file in the directory
for (i = 0; i < fileList.length; i++) {
    currentFile = fileList[i];
    for (e = 0; e < extensions.length; e++) {
        if (endsWith(currentFile, extensions[e])) {
            // Construct full path for each file
            filePath = inputDir + currentFile;

            // Open the input image
            open(filePath);

            print("Processing: " + currentFile);

            // Extract base name without extension
            originalTitleWithExtension = getTitle();
            dotIndex = lastIndexOf(originalTitleWithExtension, ".");
            originalBaseName = substring(originalTitleWithExtension, 0, dotIndex);

            // Run the macro
            // this is for read data
            // runMacro("Y:/data_UOS_Bio/ImageJ-reconstruction_FAIR_SIM_patch.bsh");

            // this is for data generated from AI model
            runMacro("Y:/data_UOS_Bio/ImageJ-reconstruction_FAIR_SIM_AI_DATA_patch.bsh");


           // wait(500); // Ensure macro completes

            // Set image properties
            Stack.setXUnit("µ");
            run("Properties...", "channels=1 slices=1 frames=1 pixel_width=31.3 pixel_height=31.3 voxel_depth=1");

            // Save the processed image
            newFileName = "SIM_" + originalBaseName + "_.tif";
            saveAs("Tiff", outputDir + newFileName);
            print("Saved: " + newFileName);

            // Close all images
            close("*");
           // wait(500); // Ensure closure
            break; // Exit extensions loop once processed
        }
    }
}
