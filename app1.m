%app 1

%grab image
testImg = '\testImg.jpg';
currentFolder = pwd;
chosenImage = strcat(currentFolder,testImg);
imrOri = imread(chosenImage);

%create grayscale image
imrGrayOri = imrOri;
if ndims(imrGrayOri)==3  % RGB true if dimension ==3
    imrGrayOri = rgb2gray(imrOri);
end

% sumbu y, array 0,1,2,3,..,255
arr256 = 0:255;

%greyscale
if (cekRGB(imrGrayOri)==false)
    arrCount = countPixel(imrGrayOri);
    subplot(2,2,4);
    plotbar = bar(arr256,arrCount);
    plotbar = title('grayscale');
end


% color 3 dims
if (cekRGB(imrOri))
    for channel = 1:ndims(imrOri)
        arrCount = countPixel(imrOri(:,:,channel));
        subplot(2,2,channel); %make 2x2 subplots for each channel
        plotbar = bar(arr256,arrCount);
        if (channel==1)
            plotbar = title("red");
        elseif (channel==2)
            plotbar = title("green");
        elseif (channel==3)
            plotbar = title("blue");   
        end        
    end
end



function arrCount = countPixel(imgRead)
arrCount = zeros (1,256);
for i = 1: length(imgRead(:,:))
    for j = 1:length(imgRead(i,:))
        num = imgRead(i,j);
        arrCount(num+1) = arrCount(num+1) +1;
    end
end
end

