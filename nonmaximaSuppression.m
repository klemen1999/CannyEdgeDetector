function [outImg] = nonmaximaSuppression(imgMag, imgDir)
    [h, w] = size(imgMag);
    outImg = zeros(size(imgMag));

    paddedMag = padarray(imgMag,[1,1]);
    
    for i = 1:h
        for j = 1:w
            keep = false;
            magI = i+1;
            magJ = j+1;
            currMag = paddedMag(magI, magJ);
            currDir = imgDir(i,j);
            % horizontal edge
            if (currDir >= -pi/8 && currDir <= pi/8) || (currDir >= 7*pi/8 || currDir <= -7*pi/8)
                if currMag >= max(paddedMag(magI-1, magJ), paddedMag(magI+1, magJ))
                    keep = true;
                end
            % diagonal bottom left to top right
            elseif (currDir > pi/8 && currDir < 3*pi/8) || (currDir > -7*pi/8 && currDir < -5*pi/8)
                if currMag >= max(paddedMag(magI-1, magJ-1), paddedMag(magI+1, magJ+1))
                    keep = true;
                end
            % vertical edge
            elseif (currDir >= 3*pi/8 && currDir <= 5*pi/8) || (currDir >= -5*pi/8 && currDir <= -3*pi/8)
                if currMag >= max(paddedMag(magI, magJ-1), paddedMag(magI, magJ+1))
                    keep = true;
                end
            % diagonal bottom right to top left
            elseif (currDir > 5*pi/8 && currDir < 7*pi/8) || (currDir > -3*pi/8 && currDir < -pi/8)
                if currMag >= max(paddedMag(magI-1, magJ+1), paddedMag(magI+1, magJ-1))
                    keep = true;
                end
            else
                printf("Something wrong at (%d,%d)", i, j);
            end

            if keep
                outImg(i,j) = currMag;
            else
                outImg(i,j) = 0;
            end
        end
    end
end

