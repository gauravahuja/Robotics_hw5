function [median, area] = medianObstacle(img, hsv)
    %rotated = imrotate(img, -90); 
    %imshow(rotated);
    
%     [x,y] = ginput(1);
%     rotatedhsv = rgb2hsv(rotated);
%     rgb = rotated(floor(y), floor(x));
%     hsv = rotatedhsv(floor(y), floor(x),:);
    rotatedhsv = rgb2hsv(img);
    hold on;

%     r = find(abs(double(rotated(:,:,1)) - 142) < 35);
%     g = find(abs(double(rotated(:,:,2)) - 31) < 35);
%     b = find(abs(double(rotated(:,:,3)) - 12) < 35);
    
    h = find(abs(double(rotatedhsv(:,:,1)) - hsv(1)) < hsv(:,:,1)*0.3);
    s = find(abs(double(rotatedhsv(:,:,2)) - hsv(2)) < hsv(:,:,2)*0.4);
    v = find(abs(double(rotatedhsv(:,:,3)) - hsv(3)) < hsv(:,:,3)*0.8);
    
    i = intersect(intersect(h,s),v);
    [x y] = ind2sub([size(img,1), size(img,2)], i);
    plot(y,x, 'bX');
    hold on;

    median = sum([x,y])/(size(x,1)+1); 
    plot(median(2), median(1), 'r*');
    area = size(x,1);
end

