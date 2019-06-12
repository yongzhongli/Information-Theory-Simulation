a = imread('lena.bmp');
b = dec2bin(a,8);
[h,w] = size(a);
pe = 1e-5;


for i = 1:262144
    for j = 1:8
        if rand < pe
            if b(i,j) == '1'
                b(i,j) = '0';
            elseif b(i,j) == '0'
                b(i,j) = '1';
            end
        end
    end
end

c = bin2dec(b);
d = reshape(c,512,512);
e = uint8(d);
error = sum(sum(e - a));
imshow(uint8(d));

