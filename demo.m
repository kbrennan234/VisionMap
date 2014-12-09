clear all;
close all;
global classes;

% Change filename to run another file
filename = 'videos/ambassador_morning.avi';
hbfr = vision.VideoFileReader('Filename', filename);

% Store positions of found objects
% obj = [x0, y0, x, class]
objs = [];
colors = ['r','g','b','m','c'];
load('outlines.mat');
classes = outlines;

% Create background image
numSamples = 4;
for i = 1:numSamples
    frame = double(rgb2gray(step(hbfr)));
    if (i == 1)
        bkgd = frame;
    else
        bkgd = bkgd + frame;
    end
end
bkgd = bkgd / numSamples;
[m,n] = size(frame);
frameLast = frame;

% Smoothing filter
blur = double(ones(7)/49);

while ~isDone(hbfr)
    frame = double(rgb2gray(step(hbfr))); % Read input video frame
    diff = abs(frame - bkgd);
    
    % Threshold difference to get foreground
    t_diff = double(diff > 0.11);
    
    % Smooth foreground to complete objects
    c_diff = conv2(t_diff,blur,'same');
    c_diff = c_diff > 0.25 & c_diff < 0.75;
    
    % Show original versus filtered frame
    figure(1);
    subplot(1,2,1);
    imshow(frame);
    hold on;
    
    % Iterate through known objects
    for i = 1:size(objs,1);
        
        [u,v] = LucasKanade(frameLast, frame, objs(i,1:4));
        objs(i,1) = round(objs(i,1) + u);
        objs(i,2) = round(objs(i,2) + v);
        objs(i,3) = round(objs(i,3) + u);
        objs(i,4) = round(objs(i,4) + v);
        
        if (objs(i,3) > (n-40) || objs(i,4) > (m-40) || ...
                objs(i,1) < 40 || objs(i,2) < 40)
            objs(i,:) = [];
            i = i - 1;
            continue;
        end
        
        if (objs(i,end) == 0)
            % Average together current frame and attempt classification
        end
        
        rect = [objs(i,1),objs(i,2),objs(i,3)-objs(i,1),objs(i,4)-objs(i,2)];
        rectangle('Position',rect,'LineWidth',2, 'EdgeColor',colors(objs(i,end)));
        c_diff(objs(i,2):objs(i,4),objs(i,1):objs(i,3)) = 0;
    end
    
    frameLast = frame;
    subplot(1,2,2);
    imshow(c_diff);
    
    % Iterate through unkwown objects
    cc = bwconncomp(c_diff, 8);
    for i = 1:cc.NumObjects
        cluster = cc.PixelIdxList{i};
        [r,c] = ind2sub([m,n],cluster);
        x0 = min(c);
        xf = max(c);
        y0 = min(r);
        yf = max(r);
        height = yf - y0;
        width = xf - x0;
        ratio = height/width;
        
        if (length(r) < 500)
            continue;
        elseif (width < 30 || height < 30)
            continue;
        elseif (ratio > 4 || ratio < 0.25) 
            continue;
        elseif (x0 < 45 || y0 < 45 || xf > (n-45) || yf > (m-45))
            continue;
        end
        
        rectangle('Position',[x0,y0,width,height],'LineWidth',2, 'EdgeColor','y');
        
        [radii,~] = getOutline([r,c]);
        class = classify(radii, ratio);
        if (class >= 0)
            objs = [objs;[x0,y0,xf,yf,class]];
        end
    end
    
    pause(0.001);
end
release(hbfr); % release the handle hbfr
