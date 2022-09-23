function f = Fusion(imgs,w)
[row,col,~,num] = size(imgs);

% create empty pyramid
pyr = gaussian_pyramid(zeros(row,col,3));
nlev = length(pyr);

% multiresolution blending
for i = 1:num
%     construct pyramid from each input image
	pyrW = gaussian_pyramid(w(:,:,i));
	pyrI = laplacian_pyramid(imgs(:,:,:,i));
    
%     blend
    for l = 1:nlev
        W = repmat(pyrW{l},[1 1 3]);
        pyr{l} = pyr{l} + W.*pyrI{l};
    end
end

% reconstruct
f = reconstruct_laplacian_pyramid(pyr);

end

