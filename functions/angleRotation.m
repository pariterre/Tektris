function [psi, theta, phi] = angleRotation(matrice, sequence)
%Cette fonction retourne les angles psi, thêta et phi d'une matrice de rotation en fonction 
%de la séquence d'angle souhaitée. 
%Écrite par pariterre le 15 février 2011
%Il est à noté que le tout a été trouvé à la main. J'ai contrôlé au maximum pour les erreurs, mais 
%il est toujours possible qu'il en reste
% [psi, theta, phi] : DOUBLE, contenant les angles. Si 1 seul argument de sorti : tout est placé dans psi
% matrice : MATRICE DOUBLE, 3*3 
% sequence : STRING, de la séquence d'angle


    %Controle du nombre d'argument
    if nargin ~= 2 
        error('Arguments manquants dans la fonction angleRotation')
    end %if

    psi = [];
    theta = [];
    phi = [];
    switch sequence
        case 'x', 
            psi = asin(matrice(3,2,:));
        case 'y', 
            psi = asin(matrice(1,3,:));
        case 'z',
            psi = asin(matrice(2,1,:));
        case 'xy',
            psi = asin(matrice(3,2,:));
            theta = asin(matrice(1,3,:));
        case 'xz',
            psi = -asin(matrice(2,3,:));
            theta = -asin(matrice(1,2,:));
        case 'yx'
            psi = -asin(matrice(3,1,:));
            theta = -asin(matrice(2,3,:));
        case 'yz'
            psi = asin(matrice(1,3,:));
            theta = asin(matrice(2,1,:));
        case 'zx'
            psi = asin(matrice(2,1,:));
            theta = asin(matrice(3,2,:));
        case 'zy'
            psi = -asin(matrice(1,2,:));
            theta = -asin(matrice(3,1,:));
        case 'xyz',  
			psi   = atan2(-matrice(2,3,:), matrice(3,3,:)); 	
			theta = asin(matrice(1,3,:)); 				
			phi   = atan2(-matrice(1,2,:), matrice(1,1,:));
        case 'xzy'   
			psi   = atan2(matrice(3,2,:),matrice(2,2,:));       
			phi = atan2(matrice(1,3,:), matrice(1,1,:));   
			theta   = asin(-matrice(1,2,:));
        case 'yxz'
            theta   = asin(-matrice(2,3,:));
            psi = atan2(matrice(1,3,:), matrice(3,3,:));
            phi   = atan2(matrice(2,1,:), matrice(2,2,:));
        case 'yzx'
            phi   = atan2(-matrice(2,3,:), matrice(2,2,:));
            psi = atan2(-matrice(3,1,:), matrice(1,1,:));
            theta   = asin(matrice(2,1,:));        
        case 'zxy'
            theta   = asin(matrice(3,2,:));
            phi = atan2(-matrice(3,1,:), matrice(3,3,:));
            psi   = atan2(-matrice(1,2,:), matrice(2,2,:));
        case 'zyx'
            phi   = atan2(matrice(3,2,:), matrice(3,3,:));
            theta = asin(-matrice(3,1,:));
            psi   = atan2(matrice(2,1,:), matrice(1,1,:));
        case 'zyz'
			psi   = atan2(matrice(2,3,:), matrice(1,3,:));
			theta = acos(matrice(3,3,:));
			phi   = atan2(matrice(3,2,:), -matrice(3,1,:));
        case 'zyzz'
			psi   = atan2(matrice(2,3,:), matrice(1,3,:));
			theta = acos(matrice(3,3,:));
			phi   = atan2(matrice(3,2,:), -matrice(3,1,:)) + psi;

        		
        otherwise
        	error('Séquence d''angle incorrecte dans angleRotation')
        
    end
    psi = real(psi);
    theta = real(theta);
    phi = real(phi);
	if nargout == 1			%Si un seul argument a été envoyé, mettre tous les angles dans une seule variable
		psi = [psi theta phi];
	end


end %function