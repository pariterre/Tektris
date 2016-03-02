function mat_out = matrice_rotation(angles,seq)
	%Cette fonction donne la matrice rotation associ�e � trois angles de rotation 
	%donn�s en radian selon la s�quence choisie
	%Pariterre, 14 f�vrier 2011, r��crite 22 mars 2011
	% out = MATRICE DOUBLE, matrice de rotation 3*3
	% angles = VECTEUR DOUBLE, angles de rotation en radian 
	% seq = STRING, s�quence choisie sous la forme : 'xyz', le nombre de lettre doit correspondre au nombre d'angle envoy�
   
	Rx = @(a)	[1,0,0;0,cos(a),-sin(a);0,sin(a),cos(a)]; 				%#ok<*NASGU> %D�finition de la rotation x
	Ry = @(b)	[cos(b),0,sin(b);0,1,0;-sin(b),0,cos(b)];					%D�finition de la rotation y
	Rz = @(c)	[cos(c),-sin(c),0;sin(c),cos(c),0;0,0,1];					%D�finition de la rotation z

	seq = lower(seq); 												% Mettre tout en minuscule
	vseq = seq;																% S�parer chacune des lettres en �l�ment de matrice
	nrot = size(vseq,2);											% D�terminer le nombre de rotations successives
	nangles = size(angles,1);									% D�terminer le nombre d'angles envoy�s
	nframe = size(angles,2);
    
    if nrot ~= nangles                                          % S'ils ne correspondent pas, il y a erreur
        if (strcmp(vseq,'zyzz') && nangles==3)			
            angles = [angles(1:2,:); angles(3,:)-angles(1,:)]; 
            vseq = 'zyz';
            nrot    = size(vseq,2);	
            nangles = length(angles);
        else
            error('Le nombre d''angles et de sequences doivent correspondre ou les vecteurs doivent �tre colonne');
        end
    end
	
    mat_out = nan(3,3,nframe);
    for j=1:nframe
        str='';																		% Initiation d'une variable str
        for i=1:nrot															% Pour toutes les rotations 
            str = [str, sprintf('R%c(angles(%d,j))*', vseq(i),i)]; 		%#ok<AGROW> % Ajouter le nom R correspondant
        end
        mat_out(:,:,j) = eval(str(1:length(str)-1));								% Enlever le signe '*' � la fin
        
    end
end %%function









