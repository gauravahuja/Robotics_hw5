function [median, area] = medianObstacle2(img, hsv)
    img_hsv= rgb2hsv(img);
    
    s = hsv(2);
    v = hsv(3);
    
    h_t1 = hsv(1) - 0.15;
    if h_t1 < 0
        h_t1 = 1 + h_t1;
    end
    
    h_t2 = hsv(1) + 0.15;
    
    if h_t2 > 1
        h_t2 = h_t2 - 1;
    end
       
    if h_t2 > h_t1
        bw = img_hsv(:, :, 1) > h_t1 & img_hsv(:, :, 1) < h_t2 & img_hsv(:, :, 2) > 0.25 & img_hsv(:, :, 3) > 0.25; 
    else
        
        bw = (img_hsv(:, :, 1) > h_t1 | img_hsv(:, :, 1) < h_t2) & img_hsv(:, :, 2) > 0.25 & img_hsv(:, :, 3) > 0.25; 
    end
    bw = bwmorph(bw, 'erode', 4);
    bw = bwmorph(bw, 'dilate', 2);
    bw = bwmorph(bw, 'clean', 2);
    
    p = regionprops(bw);
    
    if length(p) == 0
        area = 0;
        median = size(img)/2;
    else
        max_area = 0;
        max_centroid = size(img)/2;
        max_b = [0 0 0 0];
        for i = 1:length(p)
            if p(i).Area > max_area
                max_area = p(i).Area;
                max_centroid = p(i).Centroid;
                max_b = p(i).BoundingBox;
            end
        end
        hold on;
        rectangle('Position', max_b);
        plot(max_centroid(1), max_centroid(2), 'r*');
        area = max_area;
        median = fliplr(max_centroid);        
    end   
end

