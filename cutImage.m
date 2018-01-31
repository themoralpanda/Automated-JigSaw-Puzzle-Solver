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