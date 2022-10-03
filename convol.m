%greyscale done 
%rgb pending
testImg = '\cameraman.tif';
currentFolder = pwd;
chosenImage = strcat(currentFolder,testImg);
imrOri = imread(chosenImage);

%create grayscale image
imrGrayOri = imrOri;
if ndims(imrGrayOri)==3  % RGB true if dimension ==3
    imrGrayOri = rgb2gray(imrOri);
end


%matrix berukuran m x n
mat1 = [[4 4 3 5 4], 
    [6 6 5 5 2] , 
    [5 6 6 6 2] ,
    [6 7 5 5 3] ,
    [3 5 2 4 4] ,
    [1 2 3 4 5]];

%gambar dijadikan double agar dapat menerima value negatif
mat1 = double(imrGrayOri);
[nRow, nCol] = size(mat1);

%mask berukuran n x n
mask = [ [0 -1 0], 
    [-1 4 -1] , 
    [0 -1 0] ];
nMask = length(mask);

sumMask = sum(mask,"all");
if (sumMask==0)
    sumMask = 1;
end

% center dari mask
maskCenter = int32(nMask / 2);

mx = conv2(mat1,mask,"same");

temp = mat1;
selisihMask= nMask-maskCenter;
nRowCenter= nRow-(maskCenter);
nColCenter= nCol-(maskCenter);
targetCoord = maskCenter-selisihMask;

%pixel pinggir tidak akan dikonvolusi
for i=1:(nRowCenter)
    for j=1:(nColCenter)
        matEx = mat1(i:i+maskCenter, j:j+maskCenter);
        num = convolu(matEx,mask) / sumMask;
        if (num<0)
            num = 0;
        end
        if (num>255)
            num =255;
        end
        temp(i+targetCoord,j+targetCoord)= num;
    end
end

subplot(2,2,1);
mxImg = image(mx);
mxImg = title('MX');

subplot(2,2,2);
mxImg = image(temp);
mxImg = title('TEMP');

function num = convolu(matCut,mask)
if (ndims(matCut)==ndims(mask))
    num = 0;
    nMask = length(mask);
    for i=1:nMask
        for j=1:nMask
            num = num + matCut(i,j)*mask(i,j);
        end
    end
end
end