clear all;clc;

%addpath( 'data_afswt');
%load('data_n1.mat');load('data_pafn1.mat');load('label_n.mat');load('label_pafn.mat');
%addpath( 'data_n');addpath( 'data_pafn');
load('data_n_afswt_cnn.mat');load('data_pafn_afswt_cnn.mat');load('label_n.mat');load('label_pafn.mat');

%把数据集划分成训练集和测试集

%trainingNumFiles = 750;
train_n=[];train_pafo=[];test_n=[];test_pafo=[];
%rng(1) % For reproducibility
%a=randi([1 757],1,600);b=randi([1 757],1,600);
%perm_n = randperm(9000,6300);
a=[];b=[];
a(1:35,1:128,1,1:9000)=data_n_afswt_cnn(1:35,1:128,1:9000);b(1:35,1:128,1,1:4500)=data_pafn_afswt_cnn(1:35,1:128,1:4500);
trainImages=cat(4,a,b);
trainlabel=cat(2,label_n,label_pafn);trainlabel=categorical(trainlabel);
rng(1);
idx = randperm(size(trainImages,4),1350);
testImages = trainImages(:,:,:,idx);
trainImages(:,:,:,idx) = [];
testlabel = trainlabel(idx);
trainlabel(idx) = [];


idx1 = randperm(size(trainImages,4),2700);
valImages = trainImages(:,:,:,idx1);
trainImages(:,:,:,idx1) = [];
vallabel = trainlabel(idx1);
trainlabel(idx1) = [];
%valImages=cat(4,val_n,val_pafo);
%vallabel=cat(2,val_n_label,val_pafo_label);vallabel=categorical(vallabel);
%testImages=cat(4,test_n,test_pafo);
%testlabel=cat(2,test_n_label,test_pafo_label);testlabel=categorical(testlabel);
%trainDigitData=[train_n;train_af];

layers = [
    imageInputLayer([35 128 1])
    
    convolution2dLayer([3 5],8)
    %batchNormalizationLayer
    reluLayer   
    
    maxPooling2dLayer([1 2],'Stride',[1 2])
    
    convolution2dLayer([3 5],16)
    %batchNormalizationLayer
    reluLayer   
    
    maxPooling2dLayer([1 2],'Stride',[1 2])
    
    convolution2dLayer([3 5],32)
    %batchNormalizationLayer
    reluLayer 
    dropoutLayer
    
    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer];

optionsTransfer = trainingOptions('sgdm',...
    'MaxEpochs',16,...
    'ValidationData',{valImages,vallabel},...% 显示验证集误差
    'ValidationFrequency',36,...
    'Verbose',true, ...                % 命令窗口显示训练过程的各种指标
    'Shuffle','every-epoch', ...
    'InitialLearnRate',0.01,...
    'LearnRateSchedule','piecewise', ...
   'LearnRateDropFactor',0.5, ...
    'LearnRateDropPeriod',5, ...
    'MiniBatchSize',256, ...
    'ExecutionEnvironment','cpu',...
    'Plots','training-progress');

%'LearnRateSchedule', 'piecewise',...
 %'L2Regularization', 0.1,...
% 'LearnRateSchedule','piecewise', ...
 %   'LearnRateDropFactor',0.1, ...
 %   'LearnRateDropPeriod',5, ...
% 'ValidationFrequency',50,...'Padding','same'
% 训练网络

[netTransfer,traininfo] = trainNetwork(trainImages,trainlabel,layers,optionsTransfer);

%convnet = trainNetwork(trainImages,trainlabel,layers,options);

YTrain = classify(netTransfer,trainImages);

TTrain =trainlabel'; 
%testDigitData.Labels;

accuracy1 = sum(YTrain == TTrain)/numel(TTrain);

disp(accuracy1);
%测试网络


YTest = classify(netTransfer,testImages);

TTest =testlabel'; 
%testDigitData.Labels;

accuracy2 = sum(YTest == TTest)/numel(TTest);

disp(accuracy2);%confusionmat(YTest,TTest)  confusionmat(YTrain,TTrain)
%net = trainNetwork(trainImages,trainlabel,layers,options);
