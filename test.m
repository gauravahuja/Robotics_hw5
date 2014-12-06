close all;

i = input('Press enter to capture image\n');
url = 'http://192.168.1.102:81/snapshot.cgi?user=admin&pwd=';
img = imread(url);
f1 = figure();
imshow(img);

frameRate = 20;

[x,y] = ginput(1);
hsv_img = rgb2hsv(img);
rgb_thresh = img(floor(y), floor(x), :);
hsv_thresh = hsv_img(floor(y), floor(x),:);

x_mid = size(img, 2)/2;
x_max = x_mid;

max_area = size(img, 1)*size(img, 2);

fwd_vel = 0.1;
ang_vel = 0.3;


[median, initial_area] = medianObstacle(img, hsv_thresh); 


while(1)
    url = 'http://192.168.1.102:81/snapshot.cgi?user=admin&pwd=';
    img = imread(url);
    imshow(img);
    [median, area] = medianObstacle(img, hsv_thresh); 
    fwdVel = 0;
    angVel = 0;
    
    if (area < 10)
        fwdVel = 0;
        angVel = 0;
    elseif(area > initial_area)
        fwdVel = -fwd_vel;        
    else
        fwdVel = fwd_vel;
    end
    
    diff_x = median(2) - x_mid;
    
    if((abs(diff_x)) < x_max*0.1)
        angVel = 0;
    else
        angVel = sign(-diff_x)*ang_vel*abs(diff_x)/x_max;
    end
    
    fprintf('Intial Area: %f, Area: %f, fwdVel = %f, angVel = %f, diff_x = %f\n', initial_area, area, fwdVel, angVel, diff_x);
    
    SetFwdVelAngVelCreate(serPort, fwdVel, angVel);
    
    pause(1/frameRate);
end
