clear; close all; clc;

% 音声信号の入力と学習ステージ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[piano,fs] = audioread('ymh_pf_scale.wav'); % ピアノの音階信号
x = piano;
[col,k,oneMat,update,wMat] = get_wMat(x);
pi_wMat = wMat;

trumpet = audioread('ymh_tp_scale.wav'); % トランペットの音階信号
x = trumpet;
[~,~,~,~,wMat] = get_wMat(x);
tr_wMat = wMat;

% 混合音声信号の生成と分離ステージ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

w1 = randi([3 10])/10; % 各信号の重みを生成(今回は0.3~1の範囲で)
w2 = randi([3 10])/10;
mixed = w1*piano + w2*trumpet; % 混合音声信号

F = DGTtool(windowshift = 1024,windowLength = 2048,FFTnum =2048,windowName="Hann"); %stftやってくれる神!!

MIXED = F(mixed);
amp_MIXED = abs(MIXED);

pi_gMat = randi(10,k,col); % G行列の初期設定(各要素の初期値は乱数で設定)
tr_gMat = randi(10,k,col);

[pi_gMat,tr_gMat] = KL_NMF_multiple(amp_MIXED,pi_wMat,tr_wMat,pi_gMat,tr_gMat,oneMat,update);

% 分離した各々の信号の復元とSDR計算 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
common = MIXED./((pi_wMat*pi_gMat).^2+(tr_wMat*tr_gMat).^2); % Wiener filter
PIANO = ((pi_wMat*pi_gMat).^2).*common; 
TRUMPET = ((tr_wMat*tr_gMat).^2).*common;

app_p = F.pinv(PIANO); % 分離音声信号
app_t = F.pinv(TRUMPET);

app_p = app_p/max(abs(app_p),[],"all"); % 1以下調整
app_t = app_t/max(abs(app_t),[],"all");

filename = 'app_p.wav'; % 分離音声書き出し
audiowrite(filename,app_p,fs); 

filename = 'app_t.wav';
audiowrite(filename,app_t,fs);

[SDR_p,~,~,~] = bss_eval_sources(app_p.',piano.') % SDR計算
[SDR_t,~,~,~] = bss_eval_sources(app_t.',trumpet.')