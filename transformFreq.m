%jenisFilter
%I = Ideal Low Pass Filter (ILPF)
%G = Gaussian Low Pass Filter (GLPF)
%B = Butterworth Pass Filter (BLPF)

% Penapisan dalam ranah frekuensi dengan Ideal Lowpass Filter (ILPF)
function mtxOut = transformFreq(chosenImage, D0, n,  jenisFilter ,jenisPassing)
% f=imread('cameraman.tif');
% imshow(f);
f= chosenImage;
[M,N] = size(f);
%Step 1: Tentukan parameter padding, biasanya untuk citra f(x,y)
% berukuran M x N, parameter padding P dan Q adalah P = 2M and Q = 2N.
P = 2*M;
Q = 2*N;
%Step 2: Bentuklah citra padding fp(x,y) berukuran P X Q dengan
% menambahkan pixel-pixel bernilai nol pada f(x, y).
f = im2double(f);
for i = 1:P
    for j = 1:Q
        if i <= M && j<= N
            fp(i,j) = f(i,j);
        else
            fp(i,j) = 0;
        end
    end
end
% imshow(f);title('original image');
% figure; imshow(fp);title('padded image');
% 15% Display the Fourier Spectrum
Fc=fftshift(fft2(fp)); % move the origin of the transform to the center of
% the frequency rectangle
S2=log(1+abs(Fc)); % use abs to compute the magnitude (handling imaginary)
% and use log to brighten display
% figure, imshow(S2,[]); title('Fourier spectrum'); GAMBAR fourier spectrum
%Step 3: Lakukan transformasi Fourier pada fpad(x, y)
F = fft2(double(fp));
%Step 4: Bangkitkan fungsi penapis H berukuran P x Q, misalkan penapis
%yang digunakan adalah Ideal Lowpass Filter (ILPF)

if D0<1
    D0 = 50; % cut-off frequency
end
% Set up range of variables.
u = 0:(P-1);
v = 0:(Q-1);
% Compute the indices for use in meshgrid
idx = find(u > P/2);
u(idx) = u(idx) - P;
idy = find(v > Q/2);
v(idy) = v(idy) - Q;
% 16% Compute the meshgrid arrays
[V, U] = meshgrid(v, u);
D = sqrt(U.^2 + V.^2);

H = 0.0;
% title_name = "";
if n<1
    n = 2; % default untuk Butterworth Low Pass Filter
end
if jenisFilter == "I"
    H = double(D <=D0);
%     title_name='LPF Ideal Mask';
elseif jenisFilter == "G"
    H = exp(-(D.^2)./(2*(D0^2)));
%     title_name='Gaussian Low Pass Filter';
elseif jenisFilter == "B"
    H = 1./(1 + (D./D0).^(2*n));
%     title_name='Butterworth Low Pass Filter';
end

if jenisPassing=="H" %L = low pass, H = high pass
    H = 1 -H ;
end 

H = fftshift(H); 
% figure;imshow(H);title(title_name);
% figure, mesh(H);
%Step 5: Kalikan F dengan H
H = ifftshift(H);
LPF_f = H.*F;
%Step 6: Ambil bagian real dari inverse FFT of G:
LPF_f2=real(ifft2(LPF_f)); % apply the inverse, discrete Fourier transform
% figure; imshow(LPF_f2);title('output image after inverse 2D DFT');
%Step 7: Potong bagian kiri atas sehingga menjadi berukuran citra semula
LPF_f2=LPF_f2(1:M, 1:N); % Resize the image to undo padding
% figure, imshow(LPF_f2); title('output image'); GAMBAR output
mtxOut = LPF_f2;
end