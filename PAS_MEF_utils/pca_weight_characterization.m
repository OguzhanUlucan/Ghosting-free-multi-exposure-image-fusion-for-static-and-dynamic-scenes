%% PCA Weights
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

function PCA_Weights_norm = pca_weight_characterization(imgs)
[row,col,~,nImgs] = size(imgs);
imgs = uint8(imgs);


for i = 1:nImgs
    I = rgb2gray(imgs(:,:,:,i));
    x{i} = double(I(:));
end
   y = zeros(row .* col, nImgs);
   
for l = 1 : nImgs
    y(:,l) = x{1,l};
end
    
[~,Weights] = pca(y,'Algorithm','eig','Centered',false,'Rows','all');

PCA_Weights = zeros(row,col,nImgs);
for i = 1:nImgs
    p = reshape(Weights(:,i),[row, col]); 
    PCA_Weights(:,:,i) = mat2gray(p);
end

for i = 1:nImgs
    PCA_Weights(:,:,i) = imgaussfilt(PCA_Weights(:,:,i), 5);
end

PCA_Weights_norm = PCA_Weights + 1e-12;
PCA_Weights_norm = PCA_Weights_norm./repmat(sum(PCA_Weights_norm,3),[1 1 nImgs]);


end

