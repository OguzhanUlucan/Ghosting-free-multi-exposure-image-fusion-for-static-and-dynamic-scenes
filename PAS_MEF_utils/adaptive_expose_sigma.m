%%  Adaptive well-exposedness
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


function expose = adaptive_expose_sigma(img_seq_lum)
img_seq_lum = img_seq_lum/255;

[row,col,num] = size(img_seq_lum);
weight = zeros(row,col,num);

% compute mean value of non-exposed intensity region
means = mean(mean(img_seq_lum));
means = reshape(means, num,1);

% compute sigma value of non-exposed intensity region
sigmas = zeros(num,1);
for i = 1 : num
    a = img_seq_lum(:,:,i);
    x = std(a(:));
    sigmas(i) = x;
end


% compute weight map of each image in luminance image sequence
for i = 1 : num
    weight(:,:,i) = exp(-0.5*((img_seq_lum(:,:,i) - (1-means(i))).^2)/(2*sigmas(i)^2));
end

expose = weight + 1e-12;
expose = expose./repmat(sum(expose,3),[1 1 num]);


end
