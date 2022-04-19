clear all;clc;

%addpath( 'data_n');addpath( 'data_pafn');
load('data_n_afswt.mat');load('data_pafn_afswt.mat');load('label_n.mat');load('label_pafn.mat');
%把数据集划分成训练集和测试集

%trainingNumFiles = 750;
train_n=[];train_pafo=[];test_n=[];test_pafo=[];

trainImages=cat(1,data_n_afswt,data_pafn_afswt);
trainlabel=cat(2,label_n,label_pafn);trainlabel=categorical(trainlabel)';
rng(1);
idx = randperm(size(trainImages,1),1350);
testImages = trainImages(idx,1);
trainImages(idx,:) = [];
testlabel = trainlabel(idx);
trainlabel(idx) = [];


idx1 = randperm(size(trainImages,1),2700);
valImages = trainImages(idx1,1);
trainImages(idx1,:) = [];
vallabel = trainlabel(idx1);
trainlabel(idx1) = [];


%设置参数
inputSize = 35;         %35个输入节点
numHiddenUnits = 128;   %128个隐藏节点
numClasses = 2;        %10种分类结果

layers = [ ...
    sequenceInputLayer(inputSize)                   %sequence输入
    lstmLayer(numHiddenUnits,'OutputMode','last')   %lstm
    fullyConnectedLayer(numClasses)                 %全连接
    softmaxLayer                                    %softmax
    classificationLayer];  


options = trainingOptions('adam', ...
    'ExecutionEnvironment','cpu', ...
    'MaxEpochs',20, ...
    'GradientThreshold',1, ...
    'ValidationData',{valImages,vallabel},...% 显示验证集误差
    'ValidationFrequency',36,...
    'MiniBatchSize',256, ...
    'Verbose',true, ...                % 命令窗口显示训练过程的各种指标
    'Shuffle','every-epoch', ...
    'InitialLearnRate',0.001,...
    'LearnRateSchedule','piecewise', ...
   'LearnRateDropFactor',0.5, ...
    'LearnRateDropPeriod',5, ...
    'Plots','training-progress');

%
    
net=trainNetwork(trainImages,trainlabel,layers, options);    %训练

Y_train = classify(net, trainImages);                      %测试
accy1 = sum(Y_train == trainlabel) / length(trainlabel);        %计算准确度
disp(accy1);%confusionmat(Y_train,trainlabel);

Y_pred = classify(net, testImages);                      %测试
accy = sum(Y_pred == testlabel) / length(testlabel);        %计算准确度
