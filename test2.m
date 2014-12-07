close all;

img_dir = 'hallway_images';
files = dir(strcat(img_dir,'/*.png'));

f1 = figure(1);
f2 = figure(2);

t1 = 0.9;
t2 = 1.1;

for i =1:length(files)
    file_name = strcat(img_dir,'/',files(i).name);
    img = imread(file_name);
    figure(f1);
    imshow(img);   
    
    img_hsv = rgb2hsv(img);
    
    bw = img_hsv(:,:,1) > 0.5 & img_hsv(:,:,1) < 0.7 & img_hsv(:,:,3) > 0.25 & img_hsv(:,:, 2) > 0.1;    
    bw = bwmorph(bw, 'erode', 4);
    bw = bwmorph(bw, 'dilate', 2);
    bw = bwmorph(bw, 'clean', 2);
    
    p = regionprops(bw);
    

    figure(f2);
    imshow(bw); 
    hold on;
    
    for j = 1:length(p)
        if p(j).Area > 400
            rectangle('Position', p(j).BoundingBox, 'EdgeColor', 'b');
            c = p(j).Centroid;
            plot(c(1), c(2), 'b*');
        end
    end
    
    input('Press enter for next image');
end