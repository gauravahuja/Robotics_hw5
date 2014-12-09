function twoBestSlopes = alignToCorridoor(img)
close all;
halfImg  = img(size(img,1)*0.6:size(img,1),:,:);
se = strel('line',5,5);
halfImg = imdilate(halfImg,se);
%figure, imshow(halfImg)

%halfImg = imrotate(halfImg,90);
grey = rgb2gray(halfImg);
BW = edge(grey,'canny');
%figure, imshow(BW);

[H,theta,rho] = hough(BW);
P = houghpeaks(H,20,'threshold',ceil(0.2*max(H(:))));

linesAll = houghlines(BW,theta,rho,P,'FillGap',5,'MinLength',7);
slopes = [linesAll.theta];
fwdIdx = find(slopes > 0);
doorIdx = find(abs(slopes-90) > 5);
vertIdx = intersect(fwdIdx, doorIdx);

% find 2 best lines 
bestSlopes = [linesAll(vertIdx).theta];
maxElem = mode(bestSlopes);
maxElem2 = mode(bestSlopes(find(bestSlopes ~= maxElem)));


goodSlopes = union(find(slopes == maxElem), find(slopes == maxElem2));
lines = linesAll(goodSlopes);

twoBestSlopes = goodSlopes;

% figure, imshow(halfImg), hold on
% max_len = 0;
% for k = 1:length(lines)
%    xy = [lines(k).point1; lines(k).point2];
%    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
% 
%    % Plot beginnings and ends of lines
%    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
% 
%    % Determine the endpoints of the longest line segment
%    len = norm(lines(k).point1 - lines(k).point2);
%    if ( len > max_len)
%       max_len = len;
%       xy_long = xy;
%    end
% end
end