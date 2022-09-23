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

function I_new = Dynamic_Alignment(I)
[H,W,cha,num] = size(I);

for i = 1 : num
    I_x   = I(:,:,:,i); 
    I_Vec{i} = I_x(:);
end

for i = 1 : num
    I_d{i} = imhistmatch(uint8(I_Vec{1,median(int8(1:num))}),uint8(I_Vec{1,i}),'method','polynomial'); 
end

for i = 1 : num
    I_resize(:,:,:,i) = reshape(I_d{i},[H W cha]); 
end
I_new = double(I_resize);

end
