function [result,ths] = getOutline(cluster)
    mR = mean(cluster(:,1));
    mC = mean(cluster(:,2));
    
    acc = 100;
    
    dR = cluster(:,1) - mR;
    dC = cluster(:,2) - mC;
    th = atan2(dR,dC);
    r = sqrt(dR.^2 + dC.^2);
    
    th = round(th*acc)/acc;
    
    ths = -pi:(1/acc):pi;
    ths = round(ths*acc)/acc;
    result = zeros(size(ths));
    
    %filt = [0.003, 0.1065, 0.7866, 0.1605, 0.003];
    
    % Find max radius for each theta
    for i = 1:length(ths)
        radii = r(th == ths(i));
        
        if (~isempty(radii))
            result(i) = max(radii);
        end
    end
    
    % Smooth out data
    %result = conv(result,filt,'same');

    % Normalize data
    result = result / max(abs(result));
end