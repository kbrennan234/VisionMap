function[class] = classify(r)
global classes;
% 0 = unknown
% 1 = car
% 2 = van
% 3 = truck
% 4 = bike
% 5 = person

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
% minError = min(errorR);

% If close but still not accurate enough mark as unknown
% class = find(errorR == minError);
% if (class == 1 && minError > 12)
%     class = -1;
% elseif (class == 2 && minError > 50)
%     class = -1;
% end

if (errorR(1) < 12)
    class = 1;
elseif (errorR(1) < 210)
    class = 2;
else
    class = -1;
end
end