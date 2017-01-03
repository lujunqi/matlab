%% ´ó½òËã·¨
function level = Otsu(I)
%GRAYTHRESH Global image threshold using Otsu's method.
%   LEVEL = Mygraythresh(I) computes a global threshold (LEVEL) that can be
%   used to convert an intensity image to a binary image with IM2BW. LEVEL
%   is a normalized intensity value that lies in the range [0, 1].
%   GRAYTHRESH uses Otsu's method, which chooses the threshold to minimize
%   the intraclass variance of the thresholded black and white pixels.
%
%   Example
%   -------
%       I = imread('coins.png');
%       level = Otsu(I);
%       BW = im2bw(I,level);
%       figure, imshow(BW)
%
%   See also IM2BW.
%I=rgb2gray(I);
I=im2uint8(I(:));
depth=256;
counts=imhist(I,depth);
w=cumsum(counts);
ut=counts .* (1:depth)';
u=cumsum(ut);
MAX=0;
level=0;


for t=1:depth
    u0=u(t,1)/w(t,1);
    u1=(u(depth,1)-u(t,1))/(w(depth,1)-w(t,1));
    w0=w(t,1);
    w1=w(depth,1)-w0;
    g=w0*w1*(u1-u0)*(u1-u0);
    if g > MAX
        MAX=g;
        level = t;
    end
end
level=level/256;