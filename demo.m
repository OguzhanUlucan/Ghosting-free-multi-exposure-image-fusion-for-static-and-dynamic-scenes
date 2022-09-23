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
%
% This work uses several packages provided by different authors;
%
% Pyramidal -> https://mericam.github.io/exposure_fusion/index.html
%
% Guided_Filter -> Kaiming He's website: http://kaiminghe.com/eccv10/
%
% signatureSal -> "Image Signature: Highlighting sparse salient regions", 
% Xiaodi Hou, Jonathan Harel, and Christof Koch,
% IEEE Trans. Pattern Anal. Mach. Intell. 34(1): 194-201 (2012)
%
% If you see any bugs or have any ideas to improve the code 
% please contact me.

clear all, close all, clc
addpath('Pyramidal');
addpath('PAS_MEF_utils');
addpath('signatureSal');
addpath('Guided_Filter')

%% Loading the sequence (Select the input stack)
I = load_images(uigetdir);
[r,c,cha,num] = size(I);

%% Use this step for only dynamic scenes
% I_dyn = Dynamic_Alignment(I);

%% Fusion
img_seq_lum = rgb2lum(I);
expose = adaptive_expose_sigma(img_seq_lum);
sal = saliency_weights(I);
PCA = pca_weight_characterization(I);
[fused,~] = PAS_fusion(PCA,expose,sal,I);

%% Metrics
S_NiqeI = niqe(fused)
S_BrisqueI = brisque(fused) 
S_PiqeI = piqe(fused)

