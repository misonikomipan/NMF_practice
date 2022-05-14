function [col,k,oneMat,update,wMat] = get_wMat(x)

% スペクトログラム計算 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F = DGTtool(windowshift = 1024,windowLength = 2048,FFTnum =2048,windowName="Hann"); % stftやってくれる神!!

X = F(x); % 複素スペクトログラムの計算
amp_X = abs(X); % 振幅スペクトログラムを計算

% 再現行列の用意等の準備 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[row,col] = size(amp_X); % 近似したい行列のサイズ測定
k = 10; % W行列の列数かつH行列の行数(今回は適当に10に設定, 基底が小さすぎたら近似音声は綺麗にならないため注意)

wMat = randi(10,row,k); % W行列とH行列の初期設定(各要素の初期値は乱数で設定)
hMat = randi(10,k,col);

oneMat = ones(row,col); % 1行列

update = 100; % 最適化するための行列の更新回数
[wMat] = KL_NMF_single(amp_X,wMat,hMat,oneMat,update); % KL-NMFよりW行列を入手
