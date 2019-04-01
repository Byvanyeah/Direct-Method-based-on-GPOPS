function[J]=dmg_jacobian_AN(x,mysetup)
%------------------------------------------------------------------%
% Compute jacobian of constraints function for IPOPT when 
% Aanalytical derivatives are provided            
%------------------------------------------------------------------%
% DMG Copyright (c) David Morante Gonz�lez                         %
% GPOPS Copyright (c) Anil V. Rao, Geoffrey T. Huntington, David   %
% Benson, Michael Patterson, Christopher Darby, & Camila Francolin %
%------------------------------------------------------------------%
% Unscale the decision variables
y   = x./mysetup.column_scales;
[~,Jac] = mysetup.constraints(y,mysetup);
J   = sparse(Jac*mysetup.invDx);
J(1:mysetup.numnonlin,:) = mysetup.DF*J(1:mysetup.numnonlin,:);
J   = sparse (J+ mysetup.Alinear_augmented);