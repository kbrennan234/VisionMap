function[] = loadClassifications() 
    global classes
    
    % Load car outline
    load 'car.mat';
    classes = radii;
    
    % Load van outline
    load 'van.mat';
    %classes = [classes; radii];
    classes = radii;
    
    % Load bike outline
    load 'bike.mat';
    classes = [classes; radii];
    
    load 'outlines.mat';
    classes = outlines;