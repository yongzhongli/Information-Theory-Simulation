[s,a,b]=image2bit(imread('lena.bmp'));
haha=bit2image(s,a,b);
subplot(1,2,1)
imshow(haha)
subplot(1,2,2)
imshow(imread('lena.bmp'))