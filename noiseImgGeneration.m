function noiseImg = noiseImgGeneration(screenSize)    
    a = 0;
    b = 255;
    noiseImg = uint8((b-a).*rand(screenSize(2), screenSize(1), 3)+ a); 
end