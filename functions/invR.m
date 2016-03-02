function [R10] = invR(R01)
%% Auteur :                 BEGON Mickael
%% Organisation :           Laboratoire de M�canique des Solides, Poitiers
%% Cr�ation :               

% simple fonction pour passer de la matrice de passage R01 � son inverse R10

% % R = R01(1:3,1:3);
% % T = R01(1:3,4);
% % 
% % R10 = [R'; 0 0 0];
% % R10 = [R10 [-R10*T;1]];

[n,p,q] = size(R01);
R10 = zeros(n,p,q);

switch n,
    case 4,
    for k=1:q
        R = R01(1:3,1:3,k);
        T = R01(1:3,4,k);
        R10(:,:,k) = [R', -R'*T; 0 0 0 1]; 
    end
    
    case 3, for k=1:q, R10(:,:,k) = R01(:,:,k)'; end
end