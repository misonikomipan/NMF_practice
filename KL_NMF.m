function KL_NMF(inMat,wMat,hMat,oneMat,update,x_bar)
errVec = zeros(1,update); % 誤差関数ベクトル
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%反復更新%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:update
    wMat_Num = (inMat./(wMat*hMat))*hMat.'; % 分子
    hMat_Num = wMat.'*(inMat./(wMat*hMat));

    wMat = wMat.*(wMat_Num./(oneMat*hMat.'));
    hMat = hMat.*(hMat_Num./(wMat.'*oneMat));

    whMat = wMat*hMat;
    errVec(1,i) = sum(inMat.*log(inMat./whMat)-(inMat-whMat),'all'); % 誤差格納
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

KLMat = wMat*hMat %再現行列
plot(x_bar,errVec); %誤差グラフの出力