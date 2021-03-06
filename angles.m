function [Oz, w] = angles(flag, n)
%Produces the angles and corresponding weights for quadrature. Two 
%possibilities: flag = 'discrete' gives Oz = [-1 1] and flag = 'glq' 
%gives the S_n gauss-legendre quadrature points for n = 2, 4, 6, 8, 10, 
%12, 14, 16, 18, 20.
if strcmpi(flag, 'discrete') == 1
    Oz = [-1; 1];
    w = [1; 1];
    
elseif strcmpi(flag, 'glq') == 1
    [Oz, w] = glq(n);
       
else
    error('Angle option not available')   
end


    function [angle, weight] = glq(k) 
        if mod(k,2) == 1
            error("Only even discretizations are allowed.")
        end
        
       S2 = [-.5773502691896257; .5773502691896257];
       w2 = [1 1];
       
       S4 = [-.3399810435848563;  -.8611363115940526; .3399810435848563;...
           .8611363115940526];
       w4 = [0.6521451548625461 0.3478548451374538]';
       w4 = [w4; w4];
       
       S6 =[-.2386191860831969; -.6612093864662645; -.9324695142031521;...
           .2386191860831969; .6612093864662645; .9324695142031521];
       w6 = [0.4679139345726910 0.3607615730481386	 0.1713244923791704]';
       w6 = [w6; w6];
       
       S8_p = [.1834346 .5255324 .7966665 .9602899]' ;
       S8_m = - S8_p;
       S8 = [S8_m; S8_p];
       w8 = [.3626838 .3137066 .2223810 .1012285]';
       w8 = [w8; w8];
       

      S10_p = [.1488743 .4333954 .6794096 .8650634 .9739065]' ;
      S10_m = - S10_p;
      S10 = [S10_m; S10_p];
      w10 = [.2955242 .2692667 .2190864 .1494513 .0666713]';
      w10 = [w10; w10];
      
      S12p = [.1252334 .3678315 .5873180 .7699027 .9041173 .9815606]';
      S12m = - S12p;
      S12 = [S12m; S12p];
      w12 = [.2491470 .2334925 .2031674 .1600783 .1069393 .0471753]';
      w12 = [w12; w12];
      
      S14p = [.1080549 .3191124 .5152486 .6872929 .8272013 .9284349...
          .9862838]';
      S14m = -S14p;
      S14 = [S14m; S14p];
      w14 = [.2152638 .2051985 .1855384 .1572032 .1215186 .0801581...
          .0351195]';
      w14 = [w14; w14];
      
      S16p = [.0950125 .2816036 .4580168 .6178762 .7554044 .8656312...
          .9445750 .9894009]';
      S16m = - S16p;
      S16 = [S16m; S16p];
      w16 = [.1894506 .1826034 .1691565 .1495960 .1246290 .0951585...
          .0622535 .0271525]';
      w16 = [w16; w16];
      
      S18p = [.0847750 .2518862 .4117512 .5597708 .6916870 .8037050...
          .8926025 .9558239 .9915652]';
      S18m = -S18p;
      S18 = [S18m; S18p];
      w18 = [.1691424 .1642765 .1546847 .1406429 .1225552 .1009420...
          .0764257 .0497145 .0216160]';
      w18 = [w18; w18];
      
      S20p = [.0765265 .2277859 .3737061 .5108670 .6360537 .7463319...
          .8391170 .9122344 .9639719 .9931286]';
      S20m = -S20p;
      S20 = [S20m; S20p]; 
      w20 = [.1527534 .1491730 .1420961 .1316886 .1181945 .1019301...
          .0832767 .0626720 .0406014 .0176140]';
      w20 = [w20; w20];
      
      
      Sn = {S2, S4, S6, S8, S10, S12, S14, S16, S18, S20};
      wn = {w2, w4, w6, w8, w10, w12, w14, w16, w18, w20};
      
      angle = Sn{k/2};
      weight = wn{k/2};
    end




end