
% Menghitung jumlah pixel untuk tiap tingkat keabuan
% Input imgRead berupa array hasil imread 
% Output berupa arrCount berupa array berukuran 256, index berupa tingkat
% keabuan dan elemen berupa jumlah pixel
function arrCount = countPixel(imgRead)
    arrCount = zeros (1,256);
    for i = 1: length(imgRead(:,:))
        for j = 1:length(imgRead(i,:))
            num = imgRead(i,j);
            arrCount(num+1) = arrCount(num+1) +1;
        end
    end
end

