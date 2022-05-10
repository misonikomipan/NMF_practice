clear; close all; clc;

row = randperm(5,1); % 適当な非負値乱数行列の行数(Maxで5までとした)
col = randperm(5,1); % 適当な非負値乱数行列の列数(Maxで5までとした)
inMat = randi(10,row,col) % 適当な非負値乱数行列(各要素はMaxで10までの整数とした)

k = randperm(10,1); % W行列の列数かつH行列の行数
wMat = randi(10,row,k); 
hMat = randi(10,k,col);

update = 100;
x_bar = 1:update;

oneMat = repmat(1,row,col); % 要素が全て1の行列

%%%%%%%%%%%%%%%%%%%%%%%%%(Eu-NMF)%%%%%%%%%%%%%%%%%%%%%%%%%%

wMat_Eu = wMat;
hMat_Eu = hMat;
errVec_Eu = zeros(1,update); % コスト関数ベクトル

for i=1:update % 反復更新
    wMat_Eu = wMat_Eu.*((inMat*hMat_Eu.')./(wMat_Eu*(hMat_Eu)*hMat_Eu.'));
    hMat_Eu = hMat_Eu.*((wMat_Eu.'*inMat)./(wMat_Eu.'*(wMat_Eu)*hMat_Eu));

    errVec_Eu(1,i) = sum((inMat-wMat_Eu*hMat_Eu).^2,'all');

end

EuMat = wMat_Eu*hMat_Eu
plot(x_bar,errVec_Eu);


%%%%%%%%%%%%%%%%%%%%%%%%%(KL-NMF)%%%%%%%%%%%%%%%%%%%%%%%%%%

wMat_KL = wMat;
hMat_KL = hMat;
errVec_KL = zeros(1,update);

for i=1:update % 反復更新
    wMat_KL_Num = (inMat./(wMat_KL*hMat_KL))*hMat_KL.'; % 分子
    hMat_KL_Num = wMat_KL.'*(inMat./(wMat_KL*hMat_KL));

    wMat_KL = wMat_KL.*(wMat_KL_Num./(oneMat*hMat_KL.'));
    hMat_KL = hMat_KL.*(hMat_KL_Num./(wMat_KL.'*oneMat));

    whMat = wMat_KL*hMat_KL;
    errVec_KL(1,i) = sum(inMat.*log(inMat./whMat)-(inMat-whMat),'all');
end

KLMat = wMat_KL*hMat_KL
plot(x_bar,errVec_KL);

%%%%%%%%%%%%%%%%%%%%%%%%%%(IS-NMF)%%%%%%%%%%%%%%%%%%%%%%%%%

wMat_IS = wMat;
hMat_IS = hMat;
errVec_IS = zeros(1,update);

for i=1:update % 反復更新
    wMat_IS_Num = (inMat./((wMat_IS*hMat_IS).^2))*hMat_IS.'; % 分子
    wMat_IS_Den = (oneMat./(wMat_IS*hMat_IS))*hMat_IS.'; % 分母
    hMat_IS_Num = wMat_IS.'*(inMat./((wMat_IS*hMat_IS).^2));
    hMat_IS_Den = wMat_IS.'*(oneMat./(wMat_IS*hMat_IS));

    wMat_IS = wMat_IS.*(wMat_IS_Num./wMat_IS_Den).^(0.5);
    hMat_IS = hMat_IS.*(hMat_IS_Num./hMat_IS_Den).^(0.5);

    whMat = wMat_IS*hMat_IS;
    errVec_IS(1,i) = sum(inMat./whMat-log(inMat./whMat)-oneMat,'all');
end

ISMat = wMat_IS*hMat_IS
plot(x_bar,errVec_IS);


