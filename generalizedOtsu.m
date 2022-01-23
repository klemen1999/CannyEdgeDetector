function [threshold] = generalizedOtsu(image)
    [n, x] = im2hist(image);
    threshold = GHT(n,x);
    thresholdOtsu = graythresh(image);
    disp(threshold);
    disp(thresholdOtsu*255);
    %{
    disp(threshold)
    thresholdOtsu = graythresh(image);
    disp(thresholdOtsu*255)
    subplot(1,3,1);
    imshow(image);
    subplot(1,3,2);
    imshow(image > threshold);
    subplot(1,3,3);
    imshow(imgDouble > thresholdOtsu);
    %}
    threshold = threshold / 255;
end

function [n, x] = im2hist(im)
    histogram(im);
    max_val = 255;
    x = 0:max_val+1;
    e = -0.5 : max_val+1.5;
    n = histcounts(im(:), e);
    x = x(:);
    n = n(:);
end

function [out] = csum(x)
    out = cumsum(x);
    out = out(1:end-2);
end

function [out] = dsum(x)
    flippedX = flip(x(1:end-1));
    out = cumsum(flippedX);
    out = flip(out);
    out = out(2:end);
end

function [out] = argmax(x, f)
    out = mean(x(f==max(f)));
end

function [out] = clip(x)
    temp = ones(size(x))*1e-30;
    mat = cat(2, x, temp);
    out = max(mat, [], 2);
end

function [w0, w1, p0, p1, mu0, mu1, d0, d1] = preliminaries(n, x)
    w0 = clip(csum(n));
    w1 = clip(dsum(n));
    p0 = w0 ./ (w0+w1);
    p1 = w1 ./ (w0+w1);
    mu0 = csum(n.*x) ./ w0;
    mu1 = dsum(n.*x) ./ w1;
    d0 = csum(n.*(x.^2)) - w0 .* (mu0.^2);
    d1 = dsum(n.*(x.^2)) - w1 .* (mu1.^2);
end

function [t] = GHT(n, x)
    nu = sum(n);
    tau = sqrt(1/12);
    kappa = sum(n);
    omega = 0.5;
    [w0, w1, p0, p1, mu0, mu1, d0, d1] = preliminaries(n, x);
    v0 = clip((p0*nu * tau.^2 + d0) / (p0*nu + w0));
    v1 = clip((p1*nu * tau.^2 + d1) / (p1*nu + w1));
    f0 = -d0 ./ v0 - w0 .* log(v0) + 2*(w0+kappa*omega) .* log(w0);
    f1 = -d1 ./ v1 - w1 .* log(v1) + 2*(w1+kappa* (1-omega)) .* log(w1);
    t = argmax(x, f0+f1);
end