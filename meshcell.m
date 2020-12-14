classdef meshcell
    %CONSTITUENT MESH ELEMENT.  
    % Must be made of one type of material. Class holds material 
    %properties as well as location in space. This version is for 1D 2-group analytic method 
    
    properties
        sig_t = 0; %TOTAL CROSS-SECTION
        sig_s = 0; %SCATTERING CROSS-SECTION (0TH MOMENT)                   
        Q = 0; %SOURCE TERM (0TH MOMENT)
        
        
        center = 0; %LOCATION OF CENTER OF SQUARE ELEMENT
        sidelength = 1; %LENGTH OF SQUARE ELEMENT
        group_edge; %edges of energy groups. For this particular problem we'll use just two groups. Methods are optimized with this in mind
        
        material = 'source'; %TYPE OF MATERIAL. Helpful for debugging
        
        Qg  %Group source term 
    end
    
    methods
        function obj = meshcell(material,center, sidelength, group_edge)
            %Specify type of material and location in space.
            if nargin == 1
                obj.material = material;
            elseif nargin == 4
                obj.material = material;
                obj.center = center;
                obj.sidelength = sidelength;
                obj.group_edge = group_edge;
            else
                error("Incorrect number of arguments")
            end

            if strcmpi(obj.material, 'source') == 1
                obj.sig_t = 0.1;
                obj.Q = 1;
                obj.Qg = obj.Q * abs(diff(group_edge));
            elseif strcmpi(obj.material, 'scatterer') == 1
                obj.sig_t = 2;
                obj.sig_s = 1.99;
                obj.Qg = zeros(length(group_edge) - 1, 1);
            elseif strcmpi(obj.material, 'reflector') == 1
                obj.sig_t = 2;
                obj.sig_s = 1.8;
                obj.Qg = zeros(length(group_edge) - 1, 1);
            elseif strcmpi(obj.material, 'absorber') == 1
                obj.sig_t = 10;
                obj.sig_s = 2;
                obj.Qg = zeros(length(group_edge) - 1, 1);
            elseif strcmpi(obj.material, 'air') == 1
                obj.sig_t = 0.01;
                obj.sig_s = 0.006;
                obj.Qg = zeros(length(group_edge) - 1, 1);
            elseif strcmpi(obj.material, 'test') == 1
                obj.sig_t = 10;
                obj.sig_s = 0;
                obj.Qg = zeros(length(group_edge) - 1, 1);
            else
                error('material type not available')
            end
            
        end
        
        function [psibar_contrb, psi_out ] = psi_ave(obj, psi_in, phi_old, Oz, w_z)
            %calculates average psi contribution and outgoing psi through
            %the cell for each group at angle Oz.
            
            Qnew = obj.Qg +  0.5 * obj.sig_s .* phi_old + ...                I can use flipud because I have just two groups
                0.5 * obj.sig_s .* flipud(phi_old);
            S = Qnew / obj.sig_t;
            
            h = obj.sidelength;
            tau = obj.sig_t * h ./ Oz;
            
            psi_z = psi_in .* obj.f(tau) + S * (1 - obj.f(tau));
            
            psibar_contrb = psi_z * w_z;
            
            psi_out = psi_in .* exp(-tau) + S .* (1 - exp(- tau)); 
        end
        
        
    end
    
   methods(Static)
       
       function y = f(tau)
            if abs(tau) < 0.05
                y = 1 - tau ./ 2;
            else
                y = (1 - exp(- tau) ) ./ tau ;   
            end
            
            
        end
        
       
       
   end
    
  
    
        
        
end

