%Active contour working code
[I1,map] = imread('puzzle4.jpg');
I = rgb2gray(I1); 

mask = zeros(size(I));
mask(25:end-25,25:end-25) = 1;
%imshow(mask)
bw = activecontour(I,mask,5800,'Chan-Vese');



%Getting the binary pieces.
bw = imfill(bw,'holes');
comp = uint8(bw);
comp2 = comp.* I; %gray pieces
comp3 = comp .* I1; %colored pieces

CC = bwconncomp(bw,8);

L = regionprops(CC, 'BoundingBox');

imshow(bw)
hold on;
[a,b] = size(L)
for i = 1:a
    rectangle('Position',L(i).BoundingBox,'EdgeColor','g');
    imgName = strcat('piece', num2str(i), '.png');
    imwrite(imcrop(bw,L(i).BoundingBox),imgName)
end












