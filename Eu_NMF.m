function Eu_NMF(inMat,wMat,hMat,update,x_bar)
errVec = zeros(1,update); % 誤差関数ベクトル
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%反復更新%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:update
    wMat = wMat.*((inMat*hMat.')./(wMat*(hMat)*hMat.'));
    hMat = hMat.*((wMat.'*inMat)./(wMat.'*(wMat)*hMat));

    errVec(1,i) = sum((inMat-wMat*hMat).^2,'all'); % 誤差格納

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

EuMat = wMat*hMat %再現行列
plot(x_bar,errVec); %誤差グラフの出力