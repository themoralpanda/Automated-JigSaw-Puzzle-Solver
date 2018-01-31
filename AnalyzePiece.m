function piece = AnalyzePiece( test )
    % Function to analyze the puzzle pieces
    % returns : Shape vector 'piece'
    I = imread(test);
    [x,y] = size(I);    
    
    top = AnalyzeEdge('top',x,y, I); %Analyze Top edge
    left = AnalyzeEdge('left',x,y, I); %Analyze Left edge
    bottom = AnalyzeEdge('bottom',x,y, I); %Analyze bottom edge    
    right = AnalyzeEdge('right',x,y, I); %Analyze Right edge   

    piece = [left top right bottom];    
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
        
        weight = [sum(sum(A))  sum(sum(B)) sum(sum(C)) sum(sum(D))]
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
       if isscalar(j) ~= 1
           j = j(1);
       end
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
 
 function [ y ] = second_max( x )

   y = max(x(x<max(x)));

 end

 




