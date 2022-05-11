clear; close all; clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%入力(準備)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

row = randperm(5,1); % 適当な非負値乱数行列の行数(Maxで5までとした)
col = randperm(5,1); % 適当な非負値乱数行列の列数(Maxで5までとした)
inMat = randi(10,row,col) % 適当な非負値乱数行列(各要素はMaxで10までの整数とした)

k = randperm(10,1); % W行列の列数かつH行列の行数(Maxで10までとした)
wMat = randi(10,row,k); 
hMat = randi(10,k,col);

oneMat = ones(row,col); % 要素が全て1の行列

update = 100; % 更新回数
x_bar = 1:update; % 更新回数ベクトル(誤差関数のプロット用)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Eu_NMF(inMat,wMat,hMat,update,x_bar); %Eu_NMF関数
%KL_NMF(inMat,wMat,hMat,oneMat,update,x_bar); %KL_NMF関数
%IS_NMF(inMat,wMat,hMat,oneMat,update,x_bar); %IS_NMF関数



