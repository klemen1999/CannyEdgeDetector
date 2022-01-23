function [imgMag, imgDir] = gradientMagnitude2(image)
    imgMag = zeros(size(image));
    imgDir = zeros(size(image));
    [h, w] = size(image);
    paddedImg = padarray(image, [1,1]);
    for i=1:h
        for j=1:w
            padI = i+1; 
            padJ = j+1;
            s1 = paddedImg(padI-1, padJ-1);
            s2 = paddedImg(padI-1, padJ);
            s3 = paddedImg(padI-1, padJ+1);
            s4 = paddedImg(padI, padJ-1);
            s5 = paddedImg(padI,padJ);
            s6 = paddedImg(padI, padJ+1);
            s7 = paddedImg(padI+1, padJ-1);
            s8 = paddedImg(padI+1, padJ);
            s9 = paddedImg(padI+1, padJ+1);

            Ax = (s1+sqrt(2)*s2+s3-s4-sqrt(2)*s8-s9) / (2*sqrt(2));
            Ay = (s1-s3+sqrt(2)*s4-sqrt(2)*s6+s7-s9) / (2*sqrt(2));
            A45 = (sqrt(2)*s1-s2-s4+s6+s8-sqrt(2)*s9) / (2*sqrt(2));
            A135 = (-s2+sqrt(2)*s3+s4-s6-sqrt(2)*s7+s8) / (2*sqrt(2));

            imgMag(i, j) = sqrt(Ax.^2+Ay.^2+A45.^2+A135.^2);
            imgDir(i, j) = atan2(Ay, Ax);
        end
    end
end

