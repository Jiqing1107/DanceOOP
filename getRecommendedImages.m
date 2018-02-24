function rImages = getRecommendedImages(recommendedGenre, screenSize)

    %recommendedGenre = 'danceGenre1'; % if not recommendedGenre, use the manual set
    folderName = fullfile(recommendedGenre, '*.jpg');
    imglist = dir(folderName);
    totalImg = size(imglist,1);

    imgCell = cell(totalImg,1);
    for k = 1:totalImg
        fileName = fullfile(recommendedGenre, imglist(k).name);
        tempImg = imread(fileName);
        imgCell{k} = imresize(tempImg, [screenSize(2) screenSize(1)]);
    end
    rImages = imgCell;
end
