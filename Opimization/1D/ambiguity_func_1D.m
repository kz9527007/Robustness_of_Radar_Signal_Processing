function [ambi_func] = ambiguity_func_1D(ux, uy, P, radarParameter, objectParameter)
% AMBIGUITY_FUNC
% use ambiguity function to set constraint during optimization
% constrain SLL lower than 1/2 main lobe
tpn = (0 : radarParameter.N_Tx - 1) * radarParameter.T_pn;
E = -2*pi /radarParameter.c0 * [2 * kron(radarParameter.f0', ones([radarParameter.N_Rx,1])),...
                               + 2 * kron(radarParameter.f0' .* tpn', ones([radarParameter.N_Rx,1])),...
                               + kron(radarParameter.f0', ones([radarParameter.N_Rx,1])) .* P];

ambi_func = abs((exp(1j*(E * [objectParameter.r0;...
                             objectParameter.vr;...
                             0;0;0])))'...
              * exp(1j*(E * [objectParameter.r0;...
                             objectParameter.vr;...
                             ux;uy;sqrt(1 - ux^2 + uy ^2)]))).^2;
end

