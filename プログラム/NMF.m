clear; close all; clc;

%音声の入力とスペクトログラム計算%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[x,fs] = audioread('piano.wav'); %入力音声ファイル(今回はピアノいれた)

F = DGTtool(windowshift = 1024,windowLength = 2048,FFTnum =2048,windowName="Hann"); %stftやってくれる神!!

X = F(x); %スペクトログラムの計算

amp_X = abs(X); %振幅スペクトログラムを計算
arg_X = angle(X); %位相スペクトログラムを計算
exp_i = exp(1i*arg_X); %位相のための極形式

%F.plot(x,fs) %スペクトログラムの表示(以下2つも同様)
%F.plotPhase(x,fs)
%F.plotReassign(x,fs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%再現行列の用意等の準備%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[row,col] = size(amp_X); % スペクトログラムと同サイズの行列生成

k = randperm(10,1); % W行列の列数かつH行列の行数(Maxで10までとした)
wMat = randi(10,row,k); 
hMat = randi(10,k,col);

oneMat = ones(row,col); % 要素が全て1の行列

update = 100; % 更新回数
x_axis = 1:update; % 更新回数ベクトル(誤差関数のプロット用)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Eu_NMF(inMat,wMat,hMat,update,x_axis); %Eu_NMF関数
[KLMat] = KL_NMF(amp_X,wMat,hMat,oneMat,update,x_axis); %KL_NMF関数
%IS_NMF(inMat,wMat,hMat,oneMat,update,x_axis); %IS_NMF関数

app_x = F.pinv(KLMat.*exp_i); %スペクトログラムから信号を復元する逆変換(振幅は近似, 位相は保存したものを使用)

app_x = app_x/max(abs(app_x),[],"all"); %1以下調整
filename = 'approximate.wav';
audiowrite(filename,app_x,fs); % 近似再現した音声