// Input directory and output file name
inputDir = "C:/Users/ASARKER/Desktop/final_results/this_will_be_in_paper/SIm_recon/FA/with_kernal_7_5_5/prediction_normalized/";
// C:/Users/ASARKER/Desktop/final_results/sr_patch_results/F_actin_from_SR_FINAL/F-actin_06/input/
// C:/Users/ASARKER/Desktop/final_results/MT_FINAL_works/MT-04/output/patch_results/pred/
// C:/Users/ASARKER/Desktop/final_results/sr_patch_results/Uni-Data_mid_SNR
// C:/Users/ASARKER/Desktop/final_results/SR_training_output/MT_full_train_finished_04/SR_VAL/gt

//C:/Users/ASARKER/Desktop/final_results/Uni_data_Final_works/mid_SNR/output/patch_results/input/
//C:/Users/ASARKER/Desktop/final_results/low_SNR_FIX/output/patch_result/gt/

// C:/Users/ASARKER/Desktop/final_results/F-actin_Final_works/F-A-12/output/patch_results/gt/
outputStackName = "All_image_stack.tif";

// Define valid file extensions (in lowercase)
ext1 = ".tif";
ext2 = ".tiff";

// Get a list of all files in the input directory
fileList = getFileList(inputDir);

// Print the list of files to be stacked
print("List of files to be stacked:");
for (i = 0; i < fileList.length; i++) {
    print("File " + i + ": " + fileList[i]);
}

// Open each image whose file name ends with the valid extensions (case-insensitive)
for (i = 0; i < fileList.length; i++) {
    fileName = fileList[i];
    fileNameLower = toLowerCase(fileName);
    if (endsWith(fileNameLower, ext1) || endsWith(fileNameLower, ext2)) {
        filePath = inputDir + fileName;
        open(filePath);
        print("Adding to stack: " + getTitle());
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
