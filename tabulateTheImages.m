function rImg = tabulateTheImages(dancer, music, imagesFig, checkboxes, screenSize)
    % based on the selected music to determine the danceGenre
    % and then use the dancer profile to locate the recommended images
    rImg = getRecommendedImages('danceGenre3', screenSize);
    
    Img1 = 5;
    Img2 = [4,6];
    Img3 = [1, 5, 9];
    Img4 = [1,3,7,9];
    Img5 = [1,3,5,7,9];
    Img6 = [1,2,3,7,8,9];
    Img7 = [1,2,3,4,5,6,8];
    Img8 = [1,2,3,4,6,8,9];
    Img9 = [1,2,3,4,5,6,7,8,9];
    
    noOfImg = size(rImg,1);
    if(noOfImg>9)
       noOfImg = 9;
    end
    for k = 1:noOfImg
        ind = strcat('Img',num2str(noOfImg));
        toPlot = eval(ind);
        
        % axes(imagesFig{toPlot(k)}); imshow(rImg{k});
        imshow(rImg{k}, 'Parent', imagesFig{toPlot(k)});
        set(checkboxes{k}, 'Visible', 'On');
    end
end