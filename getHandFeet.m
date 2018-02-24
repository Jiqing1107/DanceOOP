function [handInd, feetInd] = getHandFeet(hand,feet,sizing)
    
    if (sizing == 0)
        expSize = 150;
    else
        expSize = round(200*sizing);
    end
    
    screensize = getScreenSize();
    expSize = min(expSize, round(min(screensize(1), screensize(2))*0.8));
    expSize = max(5, expSize);
    fprintf('expSize: %d\n', expSize);
    
    hand = imresize(hand, [expSize expSize]);
    feet = imresize(feet, [expSize expSize]);
    handInd = hand~=0;
    feetInd = feet~=255;
end