%% main function of ENSC474_assignment8
function ENSC474_assignment8_main()
clear;
close all;
%% 1)Clean the Noisy Image

% input the noisy image
noise_img=imread('SRN.PNG');

% remove the noises from the input image
removal_img=medfilt2(noise_img,[3 3]);

% display the results
subplot(2,2,1);
imshow(noise_img);title('Noisy Image','fontsize',18);

subplot(2,2,2);
imshow(removal_img);title('Clear Image','fontsize',18);
%-----------------------------------------------------


%% 2) Image Registration

% read images
orimg=imread('img1.jpg');
orimg=rgb2gray(orimg);
regimg=imread('img2.jpg');
regimg=rgb2gray(regimg);

% select control points 
[fixed_point,movin_point]=cpselect(orimg,regimg,'wait',true);

% estimate transform
mytform=fitgeotrans(movin_point,fixed_point,'nonreflectivesimilarity');

% recover original image
Roriginal=imref2d(size(orimg));
registered=imwarp(regimg,mytform,'Outputview',Roriginal);

% create overlap image
C=imfuse(orimg, registered, 'falsecolor',...
    'Scaling','joint','ColorChannels',[1 2 0]);

% display output images
subplot(2,2,3);
imshow(orimg);title('Standard Image','fontsize',18);
subplot(2,2,4);
imshow(registered);title('Registered Image','fontsize',18);
figure,imshow(C);title('Overlaped Image','fontsize',18);

end

