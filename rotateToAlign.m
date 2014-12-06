function rotateToAlign(serPort, url, initialArea, hsv)
    img = imread(url);
    imshow(img);
    [median, area] = medianObstacle(img, hsv);

    angVelocity = 0.1;
    fwdVelocity = 0.2;
    
    areaThreshold = 0.25*size(img,1)*size(img,2);
    
    if abs(area-initialArea) < areaThreshold
    SetFwdVelAngVelCreate(serPort, 0, angVelocity);
    
    
    pause(0.1);
    ang = median(2)-size(img,2)/2;
    AngleSensorRoomba(serPort);
    while abs(ang)>5

        SetFwdVelAngVelCreate(serPort, 0, angVelocity*sign(ang));
        ang = ang - AngleSensorRoomba(serPort);
%         % capture new image
%         img = imread(url);
%         [median, area] = medianObstacle(img, hsv);
%         ang = median(2)-size(img,2)/2;
        pause(0.01);
    end
    img = imread(url);
    imshow(img);
    [median, area] = medianObstacle(img, hsv);
    
    fprintf('Rotating %d\n',median(2)-size(img,2)/2); 
    SetFwdVelAngVelCreate(serPort, 0, 0);
    pause(0.1);
    
    else
    
        
    fprintf('Object moved forward');    
    
    area
    initialArea
    
    if area > initialArea
        
    fprintf('Area doesnt match.. moving backward\n');
    SetFwdVelAngVelCreate(serPort, -fwdVelocity, 0);
    pause(0.1);
    while abs(area-initialArea)< areaThreshold
        
        SetFwdVelAngVelCreate(serPort, -fwdVelocity, 0);

        % capture new image
        img = image(url);
        imshow(img);
        [~, area] = medianObstacle(img, hsv);

        pause(0.01);
    end
    
    SetFwdVelAngVelCreate(serPort, 0, 0);
    pause(0.1);
    else
        
    fprintf('Area doesnt match.. moving forward\n');
    SetFwdVelAngVelCreate(serPort, fwdVelocity, 0);
    pause(0.1);
    while abs(area-initialArea)< areaThreshold
        
        SetFwdVelAngVelCreate(serPort, fwdVelocity, 0);

        % capture new image
        img = image(url);
        imshow(img);
        [~, area] = medianObstacle(img, hsv);

        pause(0.01);
    end
    
    SetFwdVelAngVelCreate(serPort, 0, 0);
    pause(0.1);
    end
    end
end