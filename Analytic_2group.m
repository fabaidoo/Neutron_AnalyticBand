function info = Analytic_2group(meshnum, angle_flag, n_z)
% Our domain consists of the unit interval with a source of length 0.1
% units in the middle. Surrounding the source is a material we can
% specify. We use vacuum boundary conditions

outerbox = 1;
innerbox = 0.1;
material = 'reflector'; %material surrounding source

group_edge = [0 0.5 3]';


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

psil = zeros(2, meshnum + 1); %for forward sweeps
psir = zeros(2, meshnum + 1); %for backward sweeps

err = 50  ; %error in calculated phis
max_iter = 3e02; %break while loop after max_iter iterations 
iter = 0; %iteration count
tol = 1e-5;

while iter <= max_iter && err > tol 
    phi_ang = zeros(lenz, 2, meshnum);
    
    for i = 1 : lenz
       if Oz(i) > 0 %FORWARD SWEEP
           for j = 1: meshnum
               obj = mesh{j};
               [phi_ang(i, :, j), psil(:, j+1)] = obj.psi_ave(psil(:, j), phi(:, j), Oz(i), w(i) ); 
           end
 
       elseif Oz(i) < 0 %BACKWARD SWEEP
           for j = 1: meshnum
               k = meshnum + 1 - j; 
               obj = mesh{k};
               [phi_ang(i,:, k), psir(:, k)] = obj.psi_ave(psir(:, k+1), phi(:, k), Oz(i), w(i));
           end  
       end 
    end
    
    
    phi_old = phi;
    phi = reshape(sum(phi_ang), [2, meshnum] );
    
    err = norm(phi_old - phi, 'fro');
    iter = iter + 1;

    % 
   if iter == max_iter
       error('Maximum number of iterations reached before convergence. Error = %.6f', err)
   end
   
    if err > 1e06 
        disp(err)
        error('Solution is blowing up. iter = %i', iter) 
   end
  %}    
   
end

info = sprintf('%s | Error = %.3g  |  Iterations = %i', upper(material),...
    err, iter);

%phi


figure
str1 = sprintf('Group [%.2f %.2f]', group_edge(1), group_edge(2) );
str2 = sprintf('Group [%.2f %.2f]', group_edge(2), group_edge(3) );
plot(cent, phi(1,:), 'r', 'MarkerSize', 11,'LineWidth', 1.5,...
    'DisplayName', str1)
hold on
plot(cent, phi(2,:), 'b', 'MarkerSize', 11, 'LineWidth', 1.5, ...
    'DisplayName', str2)
legend('FontSize', 12)

str = sprintf('%s  |  %i elements  |  %s    |  %i directions', upper(material),...
     meshnum, upper(angle_flag), n_z);

title(str)
hold off

end