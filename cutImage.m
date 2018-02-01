% Title : Jigsaw Puzzle Solver
% Author : VENKATACHALAPATHI Vigneshwar
% Email: haivicky@gmail.com
% Technical Paper/doc: https://www.dropbox.com/s/6tnes1h34q8azv3/Automated%20Solver%20for%20the%20JigSaw%20Puzzles.pdf?dl=0
% Video Demo: https://youtu.be/9E3sHeETj9Q

function[A,B,C,D] = cutImage(direction,x,y,I)
    % Function to cut the given image I in the requested direction. 
    if (strcmp(direction,'vertical') == 1)        
        A=I(:,1:y/4);
        B=I(:,(y/4+1):(y/2));
        C=I(:,(y/2+1):(y/2+y/4));
        D=I(:,(y/2+y/4+1):y);
    else
        if (strcmp(direction,'horizontal') == 1)
        A=I(1:x/4 , :);
        B=I((x/4+1):(x/2) , :);
        C=I((x/2+1):(x/2+x/4) , :);
        D=I((x/2+x/4+1):x , :);
        
        end
    end 
 end