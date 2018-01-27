function [img] = StitchFuse( p1, p2 , id )

p1n = p1;p2n = p2;
p1 = imread(p1);
p2 = imread(p2);

% p1 = (imrotate(p1,-90));
% p2 = (imrotate(p2,-90));

[x1,y1,z1]= size(p1);
[x2,y2,z2] = size(p2);
if id == 12
    b = zeros(x2,y1-60,3); % for right bulb
else
    b = zeros(x2,y1-87,3); % for right bulb
end    
    b = cat(2,b,p2);



img = imfuse(p1,b,'diff','Scaling','joint');


    
name = strcat('fuse', num2str(id), '.png');
imwrite(img,name);

end