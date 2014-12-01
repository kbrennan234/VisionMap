function[class] = classify(r, ratio)
global classes;
% 1 = car
% 2 = van
% 3 = bike
% 4 = person

testR = repmat(r, size(classes,1), 1);
testL = testR;
errorR = sum((testR - classes).^2, 2);
errorL = errorR;

n = length(r);

right = true;
left = true;

for i = 1:n/2
    if (right)
        testR = [testR(:,end),testR(:,1:n-1)];
        err = sum((testR - classes).^2, 2);
        
        errI = err < errorR;
        
        % Check that atleast one error is less than
        if (sum(errI) == 0)
            right = false;
        else
            errorR(errI) = err(errI);
        end
    end
    
    if (left)
        testL = [testL(:,2:end),testL(:,1)];
        err = sum((testL - classes).^2, 2);
        
        errI = err < errorL;
        
        if (sum(errI) == 0)
            left = false;
        else
            errorL(errI) = err(errI);
        end
    end
    
    if (~right && ~left)
        break
    end
end

errI = errorL < errorR;
errorR(errI) = errorL(errI)
ratio

% Default to invalid class
class = -1;

if (errorR(1) < 50 && ratio > 0.25 && ratio < 0.6)
    class = 1; % Car

if (errorR(5) < 50 && ratio > 0.5 && ratio < 1.25)
    class = 3; % Bike
end
if (errorR(2) < 40 && ratio > 0.25 && ratio < 1)
    class = 2; % Van
end
if (errorR(6) < 50 && ratio > 1.5)
    class = 4; % Person
end
end