function [psnr, mse] = psnr_mse(image, image_ref)

[m, n] = size(image);
r=max (image, [],'all');
mse = 0;
for i = 1:m
    for j = 1:n
        mse = mse + (double(image(i, j)) - double(image_ref(i, j))) ^ 2;
    end
end
mse = mse / (m*n);
psnr = 10 * log10(double(r) / double(mse));
end