function [imgGray, imgSuppressed, outImg] = canny(filename)
    originalImg = imread(filename);
    img = im2double(originalImg);
    if size(img,3) > 1
        imgGray = rgb2gray(img); % convert to grayscale
    else
        imgGray = img;
    end
    dispImages = {imgGray}; % list of images to display
    titles = ["Input image"];
    
    % smooth image with Gauss Filter
    imgFiltered = gaussFilter(imgGray); 
    %dispImages{end+1} = imgFiltered;
    
    % calc magnitude and direction/angle
    [imgMag, imgDir] = gradientMagnitude(imgFiltered); 
    %dispImages{end+1} = imgMag;
    %dispImages{end+1} = imgDir;

    % perform non-maxima supression
    imgSuppressed = nonmaximaSuppression(imgMag, imgDir);
    dispImages{end+1} = imgSuppressed;
    titles = [titles, "After non-maxima suppression"];

    % perform hysteresis thresholding
    %threshLow = 0.05;
    %threshHigh = threshLow*2;

    % using Otsu for defining threshHigh
    threshHigh = graythresh(imgGray);
    threshLow = threshHigh * 0.5;
    
    outImg = hysteresisThresholding(imgSuppressed, threshLow, threshHigh);
    dispImages{end+1} = outImg;
    titles = [titles, "Final image"];
    
    outName = extractBetween(filename, 1, strlength(filename)-4);
    outName = append(outName, "-out.png");
    imwrite(outImg, outName);

    viz=1;
    if viz
        figure(1);
        n = length(dispImages);
        for i=1:n
            subplot(1,n,i);
            imshow(dispImages{i});
            title(titles(i));
        end
        
        figure(2);
        rgbImage = cat(3, imgGray, imgGray, imgGray);
        [h, w] = size(outImg);
        for i=1:h
            for j=1:w
                if outImg(i,j)
                    rgbImage(i,j,1) = 1;
                end
            end
        end
        imshow(rgbImage,[0,1]); 
    end
end

