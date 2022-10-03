% get image from filename

function imgOri = getImg(fileName)
    currentFolder = pwd;
    chosenImage = strcat(currentFolder,'\',fileName);
    imgOri = imread(chosenImage);
end