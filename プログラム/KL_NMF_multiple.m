function [pi_gMat,tr_gMat] = KL_NMF_multiple(amp_MIXED,pi_wMat,tr_wMat,pi_gMat,tr_gMat,oneMat,update)

error = zeros(1,update); % 誤差
x_axis = 1:update;

% 反復更新 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:update
    pi_gMat_Num = pi_wMat.'*(amp_MIXED./(pi_wMat*pi_gMat)); % 分子を先に計算(ややこしいから)
    pi_gMat = pi_gMat.*(pi_gMat_Num./(pi_wMat.'*oneMat));

    tr_gMat_Num = tr_wMat.'*(amp_MIXED./(tr_wMat*tr_gMat));
    tr_gMat = tr_gMat.*(tr_gMat_Num./(tr_wMat.'*oneMat));

    pt_wgMat = pi_wMat*pi_gMat+tr_wMat*tr_gMat; % 近似した混合音声信号の振幅スペクトログラム
    error(1,i) = sum(amp_MIXED.*log(amp_MIXED./pt_wgMat)-(amp_MIXED-pt_wgMat),'all'); % 更新毎に誤差格納
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(x_axis,error); % 誤差が収束しているグラフ



