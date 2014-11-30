function [u,v] = LucasKanade(It,It1,rect)
    % Initialising u,v for motion estimate. 
    u = 0;
    v = 0;
    count = 0;
    
    % Calculating the values of the template using interpolation
    template = It(rect(2):rect(4),rect(1):rect(3));

    % Calculating the X and Y derivaties for the templates
    [dX, dY] = gradient(double(template));

    while((count < 50))
        p=[u v];
        count = count + 1;

        % Map pixels in template to pixels in It1
        % step 1
    %     Xq1 = (X1)+p(1);
    %     Yq1 = (Y1)+p(2);
    %     [Xq, Yq] = meshgrid(Xq1,Yq1);
    %     ItWarp = interp2(It1,Xq,Yq);
         
        ItWarp = warpImg(It1, rect, p);

        % Find the difference between the warped image and the template. 
        % step 2
        deltaI = double(template-ItWarp);
        deltaI = deltaI(:);

        % Warp the gradients. step 3
    %     dxWarp = interp2(dX,Xq,Yq); 
    %     dyWarp = interp2(dY,Xq,Yq);
%         dxWarp = warpImg(dX, rect, p);
%         dyWarp = warpImg(dY, rect, p);
%         dxWarp = dxWarp(:);
%         dyWarp = dyWarp(:);

        % Steepest descent images. step 5
        warpedGrad = double([dX(:), dY(:)]);

        % Compute the optimized solution for the minimization.
        % step 6, 7, 8
        deltaP = (warpedGrad'*warpedGrad)\(warpedGrad'*deltaI);

        % step 9
        u = p(1) + deltaP(1);
        v = p(2) + deltaP(2);

        if (norm(deltaP) < 0.01)
            continue
        end

    end
end

function [warpedImg] = warpImg(img, rect, p)  
    y=(rect(2)+p(2)):(rect(4)+p(2));
    x=(rect(1)+p(1)):(rect(3)+p(1));
    [X,Y]=meshgrid(x,y);

%     [Xq, Yq] = meshgrid(X2,Y2);
%     img = double(img);
    warpedImg = interp2(img,X,Y);
end