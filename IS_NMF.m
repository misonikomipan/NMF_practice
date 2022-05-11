function IS_NMF(inMat,wMat,hMat,oneMat,update,x_bar)
errVec = zeros(1,update); % 誤差関数ベクトル
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%反復更新%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:update
    wMat_Num = (inMat./((wMat*hMat).^2))*hMat.'; % 分子
    wMat_Den = (oneMat./(wMat*hMat))*hMat.'; % 分母
    hMat_Num = wMat.'*(inMat./((wMat*hMat).^2));
    hMat_Den = wMat.'*(oneMat./(wMat*hMat));

    wMat = wMat.*(wMat_Num./wMat_Den).^(0.5);
    hMat = hMat.*(hMat_Num./hMat_Den).^(0.5);

    whMat = wMat*hMat;
    errVec(1,i) = sum(inMat./whMat-log(inMat./whMat)-oneMat,'all'); % 誤差格納
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ISMat = wMat*hMat %再現行列
plot(x_bar,errVec); %誤差グラフの出力