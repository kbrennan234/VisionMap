function [u,v] = LucasKanade(im1,im2,rect)
    % Initialize u,v to zero
    uv = [0;0];
    
    % Patch in original image for comparison
    patch = im1(rect(2):rect(4),rect(1):rect(3));

    % Calculating the spatial gradients dX and dY
    [dX, dY] = gradient(double(patch));
    dXY = double([dX(:), dY(:)]);

    % Run until minimal change in u,v
    while (true)
        x = (rect(1)+uv(1)):(rect(3)+uv(1));
        y = (rect(2)+uv(2)):(rect(4)+uv(2));
        [X,Y] = meshgrid(x, y);
        
        It = interp2(im2, X, Y);
        dIt = double(patch - It);
        
        dUV = (dXY'*dXY) \ (dXY'*dIt(:));
        uv = uv + dUV;

        if (norm(dUV) < 0.01)
            break;
        end

    end
    
    u = uv(1);
    v = uv(2);
end