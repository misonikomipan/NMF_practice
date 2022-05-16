function [KLMat] = KL_NMF(amp_X,wMat,hMat,oneMat,update,x_axis)
errVec = zeros(1,update); % 誤差関数ベクトル
%反復更新%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:update
    wMat_Num = (amp_X./(wMat*hMat))*hMat.'; % 分子
    hMat_Num = wMat.'*(amp_X./(wMat*hMat));

    wMat = wMat.*(wMat_Num./(oneMat*hMat.'));
    hMat = hMat.*(hMat_Num./(wMat.'*oneMat));

    whMat = wMat*hMat;
    errVec(1,i) = sum(amp_X.*log(amp_X./whMat)-(amp_X-whMat),'all'); % 誤差格納
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

KLMat = wMat*hMat %再現行列
plot(x_axis,errVec); %誤差グラフの出力

