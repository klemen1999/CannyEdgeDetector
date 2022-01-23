function [outImg] = hysteresisThresholding(image, threshLow, threshHigh)
    [h, w] = size(image);
    outImg = zeros(size(image));
    gnH = image >= threshHigh;
    gnL = image >= threshLow;
        
    gnL = padarray(gnL,[1,1]);

    prevImg = outImg;
    while true
        for i=1:h
            for j=1:w    
                if gnH(i,j)
                    % pixel over highThreshold
                    outImg(i,j) = 1;
                    % check neighbours
                    gnL_i = i+1;
                    gnL_j = j+1;
                    for x=-1:1
                        for y=-1:1
                            % skip central element
                            if ~x && ~y
                                continue
                            end
                            if gnL(gnL_i+x,gnL_j+y)
                                outImg(i+x, j+y) = 1;
                                gnH(i+x, j+y) = 1;
                            end
                        end
                    end
                end
            end
        end
        % if nothing changed between iterations then stop
        if isequal(prevImg, outImg)
            break
        else
            prevImg = outImg;
        end
    end
end

