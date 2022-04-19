clear all;clc;
addpath( '10s');
load n01.mat;load n02.mat;load n03.mat;load n04.mat;load n05.mat;
load n06.mat;load n07.mat;load n08.mat;load n09.mat;load n10.mat;
load n11.mat;load n12.mat;load n13.mat;load n14.mat;load n15.mat;
load n16.mat;load n17.mat;load n18.mat;load n19.mat;load n20.mat;
load n21.mat;load n22.mat;load n23.mat;load n24.mat;load n25.mat;
load n26.mat;load n27.mat;load n28.mat;load n29.mat;load n30.mat;
load n31.mat;load n32.mat;load n33.mat;load n34.mat;load n35.mat;
load n36.mat;load n37.mat;load n38.mat;load n39.mat;load n40.mat;
load n41.mat;load n42.mat;load n43.mat;load n44.mat;load n45.mat;
load n46.mat;load n47.mat;load n48.mat;load n49.mat;load n50.mat;
load p01.mat;load p02.mat;load p03.mat;load p04.mat;load p05.mat;
load p06.mat;load p07.mat;load p08.mat;load p09.mat;load p10.mat;
load p11.mat;load p12.mat;load p13.mat;load p14.mat;load p15.mat;
load p16.mat;load p17.mat;load p18.mat;load p19.mat;load p20.mat;
load p21.mat;load p22.mat;load p23.mat;load p24.mat;load p25.mat;
load p26.mat;load p27.mat;load p28.mat;load p29.mat;load p30.mat;
load p31.mat;load p32.mat;load p33.mat;load p34.mat;load p35.mat;
load p36.mat;load p37.mat;load p38.mat;load p39.mat;load p40.mat;
load p41.mat;load p42.mat;load p43.mat;load p44.mat;load p45.mat;
load p46.mat;load p47.mat;load p48.mat;load p49.mat;load p50.mat;

data_n=cat(2,n01,n02,n03,n04,n05,n06,n07,n08,n09,n10,...
             n11,n12,n13,n14,n15,n16,n17,n18,n19,n20,...
             n21,n22,n23,n24,n25,n26,n27,n28,n29,n30,...
             n31,n32,n33,n34,n35,n36,n37,n38,n39,n40,...
             n41,n42,n43,n44,n45,n46,n47,n48,n49,n50);
data_pafn=cat(2,p01,p03,p05,p07,p09,p11,p13,p15,p17,p19,...
             p21,p23,p25,p27,p29,p31,p33,p35,p37,p39,...
             p41,p43,p45,p47,p49);
data_pafo=cat(2,p02,p04,p06,p08,p10,p12,p14,p16,p18,p20,...
             p22,p24,p26,p28,p30,p32,p34,p36,p38,p40,...
             p42,p44,p46,p48,p50);

save('10s\data_n.mat','data_n');
save('10s\data_pafn.mat','data_pafn');
save('10s\data_pafo.mat','data_pafo');