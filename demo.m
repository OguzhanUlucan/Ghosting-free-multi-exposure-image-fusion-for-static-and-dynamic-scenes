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
[fused,~] = new_method_fusion(PCA,expose,sal,I);

%% Metrics
SSIM = SSIMscore(I, fused)
S_NiqeI = niqe(fused)
S_BrisqueI = brisque(fused) 
S_PiqeI = piqe(fused)

