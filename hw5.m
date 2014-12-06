function hw5(serPort)

i = input('Press enter to capture image\n');
url = 'http://192.168.1.102:81/snapshot.cgi?user=admin&pwd=';
img = imread(url);
f = figure();
imshow(img);

frameRate = 20;

[x,y] = ginput(1);
rotatedhsv = rgb2hsv(img);
rgb = img(floor(y), floor(x));
hsv = rotatedhsv(floor(y), floor(x),:);

[median, initialArea] = medianObstacle(img, hsv);

maxRun = 12000000000000000;
time = tic;

while tic - time < maxRun
     rotateToAlign(serPort, url, initialArea, hsv);
     %end
end
fprintf('Time up');
end