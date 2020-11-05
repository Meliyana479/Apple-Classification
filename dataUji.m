%Untuk Melatih Data apel 

clc; clear; close all;

image_folder = 'Data Uji';
filenames = dir(fullfile(image_folder, '*.jpg'));
total_images = numel(filenames);

for n = 1:total_images
    full_name= fullfile(image_folder, filenames(n).name);
    I = imread(full_name);

    t = statxture(I,0.1);
    grayLevel(n) = t(1);
    averageContarst(n) = t(2);
    measureSmoothnes(n) = t(3);
    thirdMoment(n) = t(4);
    measureUni(n) = t(5);
    Entropy(n) = t(6);
    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);
    sumR(n) = sum(sum(R));
    sumG(n) = sum(sum(G));
    sumB(n) = sum(sum(B));
    
     
end

input = [grayLevel;averageContarst;measureSmoothnes;thirdMoment;measureUni;Entropy;sumR;sumG;sumB];

target = zeros(1,25);
target(:,1:5)  = 1;
target(:,6:10) = 2;
target(:,11:15) = 3;
target(:,16:20) = 5;
target(:,21:25) = 4;

load net
output = round(sim(net,input));

[m,n] = find(output==target);
akurasi = sum(m)/total_images*100;
