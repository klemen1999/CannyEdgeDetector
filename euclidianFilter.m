function [outImg] = euclidianFilter(image)
    f_xy = [0,2,0;2,-1,2;0,2,0];
    f_45 = [2,0,2;0,0,0;2,0,2];
    im_xy = imfilter(image, f_xy);
    im_45 = imfilter(image, f_45);
    outImg = sqrt(im_xy.^2 + im_45.^2);
end