function [ppv] = PPV(vec)
ppv = zeros(3,3);
ppv(1,2)= -vec(3);
ppv(1,3)=  vec(2);
ppv(2,1)=  vec(3);
ppv(2,3)= -vec(1);
ppv(3,1)= -vec(2);
ppv(3,2)=  vec(1);