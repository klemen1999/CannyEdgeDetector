function [outImg] = gaussFilter(image)
    sigma = min(size(image))*0.005;
    kernelSize = ceil(6*sigma);
    if rem(kernelSize,2) == 0
        kernelSize = kernelSize+1;
    end
    gaussianKernel = fspecial('gaussian',[kernelSize, kernelSize],sigma);
    outImg = imfilter(image, gaussianKernel);
end

