clear;
close all;
clc;

%% Dataset and noise level

noise_level = 50;
dataset_folder_image = 'Path/To/Validation/Dataset/CBSDS68';
label_path = 'Path/To/Validation/Dataset/cbsd68_label_gray.mat';
data_savepath = 'Path/To/Validation/Dataset/noisy_cbsd68_50_gray.mat';

data = {}; label = {};

count = 0;
list_image = dir(dataset_folder_image);
n = length(list_image);

for i = 3 : n
    file_image = strcat(dataset_folder_image, '/', list_image(i).name);    
    
    image = imread(file_image);
    image = single(image) / 255;
    image = rgb2gray(image);
    noisy = imnoise(image, 'gaussian', 0, (noise_level/255)^2);
    noisy(noisy<0)=0;
    noisy(noisy>1)=1;
    
    count = count + 1;
    data{count} = noisy;
    label{count} = image;
    
    
    display(100 * (i - 2) / (n - 2));
    display('Percent complete(val)');
end    

save(label_path, 'label');
save(data_savepath, 'data');