% Title : Jigsaw Puzzle Solver
% Author : VENKATACHALAPATHI Vigneshwar
% Email: haivicky@gmail.com
% Technical Paper/doc: https://www.dropbox.com/s/6tnes1h34q8azv3/Automated%20Solver%20for%20the%20JigSaw%20Puzzles.pdf?dl=0
% Video Demo: https://youtu.be/9E3sHeETj9Q


function [img] = StitchFuse( p1, p2 , id )
% This module fuses two already fused segments that fit together

p1n = p1;p2n = p2;
p1 = imread(p1);
p2 = imread(p2);

[x1,y1,z1]= size(p1);
[x2,y2,z2] = size(p2);

% Preprocessing of the fused segments before further fusing
if id == 12
    b = zeros(x2,y1-60,3); 
else
    b = zeros(x2,y1-87,3); 
end    
    b = cat(2,b,p2);

img = imfuse(p1,b,'blend','Scaling','joint');

name = strcat('fuse', num2str(id), '.png');
imwrite(img,name);

end