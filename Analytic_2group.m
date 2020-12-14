function Analytic_2group(meshnum, angle_flag, n_z)
% Our domain consists of the unit interval with a source of length 0.2
% units in the middle. Surrounding the source is a material we can
% specify. We use vacuum boundary conditions

outerbox = 1;
innerbox = 0.2;
material = 'test'; %material surrounding source

group_edge = [0 0.5 1]';


h = outerbox / meshnum;
edges = 0: h : outerbox;
cent = edges(1:meshnum) + diff(edges)/2; %center of mesh elements

%CREATE MESHCELL ELEMENTS
mesh = cell(1, meshnum);

for i = 1: meshnum
    center = cent(i);
    dist = abs(center - outerbox/2);
    if dist < innerbox/2
        mat = 'source';
    else
        mat = material;
    end
    
    mesh{i} = meshcell(mat, center, h, group_edge);   
end

[Oz, w] = angles(angle_flag, n_z);

lenz =  length(Oz);
phi = zeros(2, meshnum); %solution for each group goes here

psil = zeros(lenz, meshnum + 1); %for forward sweeps
psir = zeros(lenz, meshnum + 1); %for backward sweeps

err = 50  ; %error in calculated phis
max_iter = 3e03; %break while loop after max_iter iterations 
iter = 0; %iteration count
tol = 1e-5;

while iter <= max_iter && err > tol 
    phi_ang = zeros(lenz, 2, meshnum);
    
    
    
    
end




end