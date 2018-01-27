% % %Active contour working code
[I1,map] = imread('puzzlenew.png');
I = rgb2gray(I1); 

mask = zeros(size(I));
mask(25:end-25,25:end-25) = 1;
 %imshow(mask)
bw = activecontour(I,mask,5800,'Chan-Vese');
% 
% % 
% % 
% %Getting the binary pieces.
% 
bw = imfill(bw,'holes');
comp = uint8(bw);
comp2 = comp.* I; %gray pieces
comp3 = comp .* I1; %colored pieces

CC = bwconncomp(bw,8);

L = regionprops(CC, 'BoundingBox');

imshow(bw)
hold on;
[a,b] = size(L);
pieces = []
for i = 1:a
    rectangle('Position',L(i).BoundingBox,'EdgeColor','g');
    imgName = strcat('piece', num2str(i), '.png');
    imgName2 = strcat('cpiece', num2str(i), '.png');
    img = imcrop(comp3,L(i).BoundingBox);
    imwrite(img,imgName2);
    img = imcrop(bw,L(i).BoundingBox);
    imwrite(img,imgName);
    p = AnalyzePiece(imgName)
    pieces = cat(1,pieces,p)
end

hold off;
% %Algorithm for solving the puzzles


  rejectList = [];
%Build first column
disp('fuse1');
p1 = search(pieces,2,0,0,2,2,rejectList)
p2 = search(pieces,2,2,0,0,2,rejectList)
StitchPair(getPiece(p1),getPiece(p2), 1);
rejectList = cat(1,rejectList, p1);
rejectList = cat(1,rejectList, p2);
% % 
%Build last column
disp('fuse3');
p3 = search(pieces,0,0,2,2,2,rejectList)
p4 = search(pieces,0,2,2,0,2,rejectList)
StitchPair(getPiece(p3),getPiece(p4), 3);
rejectList = cat(1,rejectList, p3);
rejectList = cat(1,rejectList, p4);
% %  
% %  
% %Build middle column
disp('fuse2');
if pieces(p3,1) == 1
    p5 = search(pieces,0,0,-1,2,2,rejectList)
else
    p5 = search(pieces,0,0,1,2,2,rejectList)
end
if pieces(p4,1) == 1
    p6 = search(pieces,0,2,-1,0,2,rejectList)
else
    p6 = search(pieces,0,2,1,0,2,rejectList)
end

StitchPair(getPiece(p5),getPiece(p6), 2);
%  %code for combining fuses % 

StitchFuse('fuse1.png','fuse2.png',12)
solvedPuzzle = StitchFuse('fuse12.png','fuse3.png',123);

imshow(solvedPuzzle);

% % 
% % 
function name = getPiece(pid)
    name = strcat('cpiece', num2str(pid), '.png');
end

function list = removeFromList(pid, pieces)
    pieces(pid) = [];
    list = pieces;
end

function result = search(pieces,left,top,right,bottom, counter, rejectList)
    [x,y] = size(pieces);
    result = [];
    for i=1:x
        if ismember(i,rejectList) == 0
            p = pieces(i,:);
            l = p(1); t = p(2); r = p(3); b = p(4);
            c = 0; %counter
            if left ~=0
                if l == left
                    c = c+1;
                end
            end

            if top ~=0
                if t == top
                    c = c+1;
                end
            end

            if right ~=0
                if r == right
                    c = c+1;
                end
            end

            if bottom ~=0
                if b == bottom
                    c = c+1;
                end
            end

            if c == counter
              result = cat(1, result, i);
            end


        end
    end
    
end

function Index = FindRow(S, s)
    nCol  = size(S, 2);
    match = S(:, 1) == s(1);
    for col = 2:nCol
       match(match) = S(match, col) == s(col);
    end
    Index = find(match);
end