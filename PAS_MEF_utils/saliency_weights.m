function sal_map_norm = saliency_weights(imgs)

for i = 1:size(imgs,4)
    
labMap = signatureSal(imgs(:,:,:,i));
paramRGB = default_signature_param;
paramRGB.colorChannels = 'RGB';
rgbMap = signatureSal( imgs(:,:,:,i) , paramRGB );
sal_map(:,:,i) = imresize(rgbMap, [size(imgs,1) size(imgs,2)]);

end

for i = 1:size(imgs,4)
    sal_map_norm(:,:,i) = sal_map(:,:,i)./sum(sal_map,3);
end

end
