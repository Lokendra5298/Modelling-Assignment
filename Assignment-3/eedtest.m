clc
clear all

a=imread('cameraman.tif'); % reading the image
%a=imread("tomo.jpg");
%a=imread("triangle.jpg");
a=im2double(a); % normalizing the instensity values to lie between o and 1

ref=a;
ad=imnoise(a,'gaussia',0.01); % adding Gaussian noise of mean zero and variance 0.01
%ad = imnoise(ref, 'poisson');
%ad = imnoise(ref, 'speckle');
%ad = imnoise(ref, 'salt & pepper');

Niter=20; 
%alpha=2.7; % Used in Numerical approximation
%w= exp(4*alpha/9); % Used in Numerical approximation
k=0.001;
timestep = 0.2; % timestep size used in numerical approximation

[psnr, mse]=psnr_mse(ad, ref)
variance=w
%w=0.5;
%w=1;
%w=1.5;
%w=2;

b = eed(ad, timestep, Niter, 1, w, 3, k, 5.20);
% first argument is the noisy image, 2 is the reference image, 3 is the
% lambda value, 4 is the timestep size, 5 is the no of iterations, 6 is the
% value to show the plot, 7 is the w value used in numerical approximation
% and last argument corresponding to choice of the numerical scheme. 
