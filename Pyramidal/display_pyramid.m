% Display the contents of a pyramid, as returned by functions
% 'laplacian_pyramid' or 'gaussian pyramid'
%
% tom.mertens@gmail.com, August 2007
%

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

function display_pyramid(pyr)

L = length(pyr);
r = size(pyr{1},1);
c = size(pyr{1},2);
k = size(pyr{1},3);
R = zeros(r,2*c,k);

offset = 1;
for l = 1:L
    I = pyr{l};
    r = size(I,1);
    c = size(I,2);
    R(1:r, offset:offset-1+c, :) = I;
    offset = offset + c;
end

if (min(R(:)) < 1e-5)
    %make negative values displayable
    a = min(R(:));
    b = max(R(:));
    R = (R - a) / (b - a);
end    

figure; imshow(R);
