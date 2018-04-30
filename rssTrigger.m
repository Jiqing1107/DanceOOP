function [toVisualize, indSet]= rssTrigger(handOrFeet, indSet, handInd, feetInd, noiseImg, targetimg)
    height = size(handInd,1);
    width = size(handInd,2);
    rowlimit = size(targetimg,1)-size(handInd,1);
    row = randi(rowlimit);
    collimit = size(targetimg,2)-size(handInd,2);
    col = randi(collimit);
    while(ismember(row, indSet(1,1)) & ismember(col, indSet(1,2)))
        row = randi(size(targetimg,1)-size(handInd,1));
        col = randi(size(targetimg,2)-size(handInd,2));
    end
    indSet(size(indSet,1)+1, :) = [row col];
    
    if(handOrFeet ==1)
        toExtract = [row:row+height-1; col:col+width-1];
        temp = noiseImg(toExtract(1,:), toExtract(2,:), :);
        tempT = targetimg(toExtract(1,:), toExtract(2,:), :);
        
        temp(handInd) = tempT(handInd);
        
    elseif(handOrFeet ==2)
        toExtract = [row:row+height-1; col:col+width-1];
        temp = noiseImg(toExtract(1,:), toExtract(2,:), :);
        tempT = targetimg(toExtract(1,:), toExtract(2,:), :);
        
        temp(feetInd) = tempT(feetInd);
        
    elseif(handOrFeet ==3)
        toExtract = [row:row+599; col:col+599];
        temp = noiseImg(toExtract(1,:), toExtract(2,:), :);
        tempT = targetimg(toExtract(1,:), toExtract(2,:), :);
    end


    noiseImg(toExtract(1,:), toExtract(2,:), :) = temp;
    toVisualize = noiseImg;
end