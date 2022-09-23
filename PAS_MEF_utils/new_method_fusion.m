% Oguzhan Ulucan & Diclehan Ulucan, M.Sc.
% ========================================================================
%
% Corresponding Author
% =========> M.Sc. Oguzhan Ulucan, Izmir, Turkey.
% ============ oguzhan.ulucan.iz@gmail.com
%
% ========================================================================
%
% Ghosting-free multi-exposure image fusion for static and dynamic scenes
%
% Copyright(c) 2022 Oguzhan Ulucan, Diclehan Ulucan and Mehmet Turkan
%
% All Rights Reserved.
%
% ----------------------------------------------------------------------
% Permission to use, copy, or modify this software and its documentation
% for educational and research purposes only and without fee is hereby
% granted, provided that this copyright notice and the original authors'
% names appear on all copies and supporting documentation. This program
% shall not be used, rewritten, or adapted as the basis of a commercial
% software or hardware product without first obtaining permission of the
% authors. The authors make no representations about the suitability of
% this software for any purpose. It is provided "as is" without express
% or implied warranty.
%----------------------------------------------------------------------
%
% If you use this work, please cite as follows;
%
% @article{ulucan2022ghosting,
%  title={Ghosting-Free Multi-Exposure Image Fusion for Static and Dynamic Scenes},
%  author={Ulucan, Oguzhan and Ulucan, Diclehan and Turkan, Mehmet},
%  journal={Signal Processing},
%  pages={108774},
%  year={2022},
%  publisher={Elsevier}
% }
%
%----------------------------------------------------------------------

function [fused,w_all] = PAS_fusion(PCA,expose,sal,I)

I = (I)/255;
[~,~,~,num] = size(I);

Weights_all = PCA .* expose .* sal;

for i=1:num
  Weights_all(:,:,i) = fastGF( Weights_all(:,:,i),12,0.25,2.5);
end

w_all =  Weights_all + 1e-12;
w_all =  w_all./repmat(sum(w_all,3),[1 1 num]);


fused = Fusion(I,w_all);
fused = uint8(fused*255);

end

