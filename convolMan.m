function mtxOut = convolMan(chosenImage, nMask, jenisFilter )

% testImg = '\flower.png';
% %flower.png
% %cameraman.tif
% % Lena.bmp
% currentFolder = pwd;
% chosenImage = strcat(currentFolder,testImg);
% chosenImage = imread(chosenImage);
% nMask = 5;
% jenisFilter = 3;

imrOri = chosenImage;
% figure; imshow(imrOri,[]);
%gambar dijadikan matrix double (2D jika greyscale
% 3D jika berwarna) agar dapat menerima value negatif
mtxIn = double(imrOri);

%membuat matrix mask
mtxMask = zeros(nMask,nMask);
if jenisFilter=="M" %M = mean filter, G = gaussian filter, Md = median filter
    mtxMask = mtxMask +1;
elseif jenisFilter =="G" % untuk gaussian filter dipaksa n = 7 dan gaussian mask sudah dibuat, karena tidak sempat mengerjakan
    mtxMask = [1 1 2 2 2 1 1; 1 2 2 4 2 2 1; 2 2 4 8 4 2 2; 2 4 8 16 8 4 2;
1 1 2 2 2 1 1; 1 2 2 4 2 2 1; 2 2 4 8 4 2 2];
    nMask = 7;
end

sumMask = sum(mtxMask,"all"); %sum mask
if (sumMask==0)
    sumMask = 1;
end
mtxMask = (1/sumMask) * mtxMask;
[nRow,nColumn,nChannel]= size(imrOri);
mtxOut = mtxIn;

for channel=1:nChannel
    mtxOut(:,:,channel)= mtxConvolution(mtxIn(:,:,channel),mtxMask,jenisFilter);
end

mtxOut = uint8(mtxOut);
% figure; imshow(mtxOut,[]);
end

function num = convolu(mtxCut,mask)
if (ndims(mtxCut)==ndims(mask))
    num = 0;
    nMask = length(mask);
    for i=1:nMask
        for j=1:nMask
            num = num + mtxCut(i,j)*mask(i,j);
        end
    end
end
end


function mtxOut = mtxConvolution(mtxIn, maskIn,jenisFilter)
%mtxOut = mtxIn; mtxOut perlu diinisialisasi dahulu
mtxOut = mtxIn;
[nRow, nCol] = size(mtxIn);

nMask = length(maskIn); %n mask

maskCenter = int32(nMask / 2); % center dari mask
nRowCenter= nRow-(maskCenter);
nColCenter= nCol-(maskCenter);
const = (nMask - 3)/2;
%pixel pinggir tidak akan dikonvolusi
for i=1:(nRowCenter-const)
    for j=1:(nColCenter-const)
        mtxTemp = mtxIn(i:i+nMask-1, j:j+nMask-1);
        if jenisFilter=="Md" %jenis filter median;
            num = median(mtxTemp,'all');
        else %jenis filter mean atau gaussian
            num = convolu(mtxTemp,maskIn);
        end
        
        %clip jika hasil <0 atau >255
        if (num<0)
            num = 0;
        end
        if (num>255)
            num =255;
        end
        mtxOut(i+maskCenter,j+maskCenter)= num;
    end
end
end

