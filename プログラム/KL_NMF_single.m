function [wMat] = KL_NMF_single(amp_X,wMat,hMat,oneMat,update)

% 反復更新 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:update
    wMat_Num = (amp_X./(wMat*hMat))*hMat.'; % 分子を先に計算(ややこしいから)
    hMat_Num = wMat.'*(amp_X./(wMat*hMat));

    wMat = wMat.*(wMat_Num./(oneMat*hMat.'));
    hMat = hMat.*(hMat_Num./(wMat.'*oneMat));
end


