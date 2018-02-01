% Title : Jigsaw Puzzle Solver
% Author : VENKATACHALAPATHI Vigneshwar
% Email: haivicky@gmail.com
% Technical Paper/doc: https://www.dropbox.com/s/6tnes1h34q8azv3/Automated%20Solver%20for%20the%20JigSaw%20Puzzles.pdf?dl=0
% Video Demo: https://youtu.be/9E3sHeETj9Q


function [img] = StitchPair( p1, p2 , id )
%This module is for stitching two puzzle pieces that fit together

p1n = p1;p2n = p2;
p1 = imread(p1);
p2 = imread(p2);

%Preprocessing of the puzzle pieces before fusing
p1 = (imrotate(p1,-90));
p2 = (imrotate(p2,-90));
[x1,y1,z1]= size(p1)
[x2,y2,z2] = size(p2)
b = zeros(x2,y1-57,3); % for right bulb
b = cat(2,b,p2);
imshow(b);

img = imrotate(imfuse(p1,b,'blend','Scaling','joint'),90);
imshow(img);
res = verify(img)

if res == 0

    %There is a mismatch in size
    diff  = abs(x1-x2)

    p1Spec = AnalyzePiece(extractAfter(p1n,'c'))
    p2Spec = AnalyzePiece(extractAfter(p2n,'c'))

    if x1>x2 %then p1 has bulb at top or bottom
        if p1Spec(1) ==1 && p2Spec(1) ~= 1
            %Add block to p2 top
            b2 = zeros(diff,y2,3);
            b2 = cat(1,b2,p2);
            [xn,yn] = size(b2);
            b = zeros(xn,y1-57,3);
            b2 = cat(2,b,b2);
            img = imrotate(imfuse(p1,b2,'blend','Scaling','joint'),90);
        else
            if p1Spec(3) ==1 && p2Spec(3) ~= 1
                %Add block to p2 bottom
            b2 = zeros(diff,y2,3);
            b2 = cat(1,p2,b2);
            [xn,yn] = size(b2);
            b = zeros(xn,y1-57,3);
            b2 = cat(2,b,b2);
            img = imrotate(imfuse(p1,b2,'blend','Scaling','joint'),90);
            end
        end
    else         
        if x1<x2 %then p2 has bulb at top or bottom

        if p2Spec(1) ==1 && p1Spec(1) ~= 1
            %Add block to p1 top
            b2 = zeros(diff,y1,3);
            b2 = cat(1,b2,p1);

            b = zeros(x2,y1-57,3);
            b = cat(2,b,p2);

            img = imrotate(imfuse(b2,b,'blend','Scaling','joint'),90);        
        else
            if p2Spec(3) ==1 && p1Spec(3) ~= 1
                %Add block to p1 bottom
            b2 = zeros(diff,y1,3);
            b2 = cat(1,p1,b2);

            b = zeros(x2,y1-57,3);
            b2 = cat(2,b,p2);
            img = imrotate(imfuse(b2,b,'blend','Scaling','joint'),90);        
            end
        end

        end
    end
end    
name = strcat('fuse', num2str(id), '.png');
imwrite(img,name);  
end
 
% Utiltiy Function % 
function res = verify(img)
    %Verifies if the built fuse is Ok to proceed with
    [x,y,z] = size(img);
    grayp1 = rgb2gray(img);
    img = logical(zeros(x,y));
    [x1,y1] = find(grayp1);
    for i=1:size(x1)
    img(x1(i),y1(i)) = 1;
    end
    
    A=img(1:x/2,:);
    B=img(x/2+1 :x,:);
    
    [x,y] = size(A);
    [p,q,r,s] = cutImage('vertical',x,y,A);
    weight1 = [sum(sum(p))  sum(sum(q)) sum(sum(r)) sum(sum(s))]
    
    [x,y] = size(B);
    [p1,q1,r1,s1] = cutImage('vertical',x,y,B);
    weight2 = [sum(sum(p1))  sum(sum(q1)) sum(sum(r1)) sum(sum(s1))]
    
    if (weight1(1) == min(weight1)  && weight2(4) == min(weight2)) || (weight1(4) == min(weight1)  && weight2(1) == min(weight2))
        res = 0;
    else
        res = 1;
    end
end

