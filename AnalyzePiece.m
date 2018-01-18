function piece = AnalyzePiece( test )
    I = imread(test);
    [x,y] = size(I);
    disp(test);
    %if x > y;disp('vertical');else;disp('horizontal');end;
    top = AnalyzeEdge('top',x,y, I);
    left = AnalyzeEdge('left',x,y, I); 
    bottom = AnalyzeEdge('bottom',x,y, I);    
    right = AnalyzeEdge('right',x,y, I);    

    piece = [left top right bottom]
    
 
  end



 
 function type = AnalyzeEdge(pos, x, y, I)
    %type = {1 bulb , 0 line, -1 hole}
    %pos = {'top', 'bottom', 'left', 'right'}
    
    l = 0; r = 0;t = 0;b = 0;
   
    if(strcmp(pos,'top') ==1)
        [A,B,C,D] = cutImage('horizontal',x,y,I);
        [x,y] = size(A);
        
        [A,B,C,D] = cutImage('vertical',x,y,A);
        
        weight = [sum(sum(A))  sum(sum(B)) sum(sum(C)) sum(sum(D))];
        type = checkTypeOfEdge(weight);
        %plotCuts(A,B,C,D,'horizontal');        
    else
    if(strcmp(pos,'left') ==1)
        [A,B,C,D] = cutImage('vertical',x,y,I);
        [x,y] = size(A);
        [A,B,C,D] = cutImage('horizontal',x,y,A);
        
        weight = [sum(sum(A))  sum(sum(B)) sum(sum(C)) sum(sum(D))];
        type = checkTypeOfEdge(weight);
       % plotCuts(A,B,C,D,'vertical');        
    else
    if(strcmp(pos,'bottom') ==1)
        [A,B,C,D] = cutImage('horizontal',x,y,I);
        [x,y] = size(D);
        [A,B,C,D] = cutImage('vertical',x,y,D);
        
        weight = [sum(sum(A))  sum(sum(B)) sum(sum(C)) sum(sum(D))];
        type = checkTypeOfEdge(weight);
        %plotCuts(A,B,C,D,'horizontal');  
        
    else
    if(strcmp(pos,'right') ==1)
        [A,B,C,D] = cutImage('vertical',x,y,I);
        [x,y] = size(D);
        [A,B,C,D] = cutImage('horizontal',x,y,D);
        
        weight = [sum(sum(A))  sum(sum(B)) sum(sum(C)) sum(sum(D))];
        type = checkTypeOfEdge(weight);
        %plotCuts(A,B,C,D,'vertical');        
    end
    end
    end
    end
    
        

        

 end
 


 function etype = checkTypeOfEdge(weight)
     sortedWeights = sort(weight,'descend');
     peak = sortedWeights(1);
     peak2 = sortedWeights(2);
     peak3 = sortedWeights(3);
     %peak2 = second_max(weight)
     i = find(weight == peak);
     if isscalar(i) == 1
       j = find(weight == peak2);
     else
       j = i(2);
       i = i(1);
     end
       
     
     
     peakRegion = weight(i)+weight(j);

     remaining = 0;
     % check for bulb
     if abs(i-j) == 1
        for l = 1:4
            if l~=i && l~=j
                remaining = remaining + weight(l);
            end
        end 

        if( (0.3 * peakRegion) >= remaining)
            etype = 1;
            return;
        else
            etype = 0;
        end
     else
        etype = 0;
     end
     
     % check for Line
     if etype == 0
        %weight2 = weight(weight~=peak);
        %peak3 = second_max(weight2);
        k = find(weight == peak3);
        
        peaks = sort([i j k]);
        
        %Condition1 : Check if three peaks are adjacent
        if abs(peaks(1) - peaks(2)) == 1 && abs(peaks(2) - peaks(3)) == 1
            %Condition2 : check for the average pixels in the three peaks
            if peak2 >= 0.6*peak && peak3 >=0.6*peak2
                etype = 2;
            end
            
        end
            
        
     end
     
     %check for hole
     if etype == 0
         etype = -1;
     end
         
     
 
 end
 
 %Utility functions below

  function[A,B,C,D] = cutImage(direction,x,y,I)
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
 
 function [] = plotCuts(A,B,C,D,direction)
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
 
 function [ y ] = second_max( x )

   y = max(x(x<max(x)));

 end

 




