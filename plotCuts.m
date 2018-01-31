 function [] = plotCuts(A,B,C,D,direction)
 % Utility function to plot the cuts for image analysis 
    if(strcmp(direction, 'vertical') == 1)
        subplot(4,1,1);imshow(A);
        subplot(4,1,2);imshow(B);
        subplot(4,1,3);imshow(C);
        subplot(4,1,4);imshow(D);
    else
        if (strcmp(direction, 'horizontal') ==1)
            subplot(1,4,1);imshow(A);
            subplot(1,4,2);imshow(B);
            subplot(1,4,3);imshow(C);
            subplot(1,4,4);imshow(D);
        end
    end
    
 end
