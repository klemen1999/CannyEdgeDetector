function [imgMag, imgDir] = gradientMagnitude(image)
    % x axis from (0,0) to (n,0), y axis (0,0) to (0,n)    
    sobelX = [-1, -2, -1; 0, 0, 0; 1, 2, 1];
    sobelY = sobelX.';
    
    dirX = imfilter(image, sobelX);
    dirY = imfilter(image, sobelY);

    imgMag = sqrt(dirX.^2 + dirY.^2);
    imgDir = atan2(dirY, dirX);
end

