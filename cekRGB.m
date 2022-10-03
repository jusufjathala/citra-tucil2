% Memeriksa citra RGB atau grayscale
% citra berupa RGB jika dimensi 3
function boole = cekRGB(imgRead)
    if ndims(imgRead)==3
        boole = 1;
    else
        boole = 0;
    end
end 