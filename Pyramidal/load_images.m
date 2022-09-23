% This procedure loads a sequence of images
%
% Arguments:
%   'path', refers to a directory which contains a sequence of images
%   'reduce' is an optional parameter that controls downsampling, e.g., reduce = .5
%   downsamples all images by a factor of 2.


%{
Copyright (c) 2015, Tom Mertens
All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%}

function I = load_images(path, reduce)

if ~exist('reduce')
    reduce = 1;
end

if (reduce > 1 || reduce <= 0)
    error('reduce must fulfill: 0 < reduce <= 1');
end

% find all JPEG or PPM files in directory
files = dir(path);
files(1:2)=[];
N = length(files);
if (N == 0)
    files = dir([path '/*.png']);
    N = length(files);
    if (N == 0)
        files = dir([path '/*.gif']);
        N = length(files);
        if (N == 0)
            files = dir([path '/*.bmp']);
            N = length(files);
            if (N == 0)
                files = dir([path '/*.jpg']);
                N = length(files);
                if (N == 0)
                    error('no files found');
                end
            end
        end
    end
end

% allocate memory
sz = size(imread([path '/' files(1).name]));
r = floor(sz(1)*reduce);
c = floor(sz(2)*reduce);
I = zeros(r,c,3,N);

% read all files
for i = 1:N
    
    % load image
    filename = [path '/' files(i).name];
    im = double(imread(filename));
    if (size(im,1) ~= sz(1) || size(im,2) ~= sz(2))
        error('images must all have the same size');
    end
    
    % optional downsampling step
   % optional downsampling step
    if (reduce < 1)
        im = imresize(im,[r c],'bicubic');
    end
    if size(im,3)==1
    I(:,:,:,i) = cat(3,im,im,im);
    else
    I(:,:,:,i) = im;
    end
end
