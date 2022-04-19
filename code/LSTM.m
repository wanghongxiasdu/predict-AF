clear all;clc;

%addpath( 'data_n');addpath( 'data_pafn');
load('data_n_afswt.mat');load('data_pafn_afswt.mat');load('label_n.mat');load('label_pafn.mat');
%�����ݼ����ֳ�ѵ�����Ͳ��Լ�

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


%���ò���
inputSize = 35;         %35������ڵ�
numHiddenUnits = 128;   %128�����ؽڵ�
numClasses = 2;        %10�ַ�����

layers = [ ...
    sequenceInputLayer(inputSize)                   %sequence����
    lstmLayer(numHiddenUnits,'OutputMode','last')   %lstm
    fullyConnectedLayer(numClasses)                 %ȫ����
    softmaxLayer                                    %softmax
    classificationLayer];  


options = trainingOptions('adam', ...
    'ExecutionEnvironment','cpu', ...
    'MaxEpochs',20, ...
    'GradientThreshold',1, ...
    'ValidationData',{valImages,vallabel},...% ��ʾ��֤�����
    'ValidationFrequency',36,...
    'MiniBatchSize',256, ...
    'Verbose',true, ...                % �������ʾѵ�����̵ĸ���ָ��
    'Shuffle','every-epoch', ...
    'InitialLearnRate',0.001,...
    'LearnRateSchedule','piecewise', ...
   'LearnRateDropFactor',0.5, ...
    'LearnRateDropPeriod',5, ...
    'Plots','training-progress');

%
    
net=trainNetwork(trainImages,trainlabel,layers, options);    %ѵ��

Y_train = classify(net, trainImages);                      %����
accy1 = sum(Y_train == trainlabel) / length(trainlabel);        %����׼ȷ��
disp(accy1);%confusionmat(Y_train,trainlabel);

Y_pred = classify(net, testImages);                      %����
accy = sum(Y_pred == testlabel) / length(testlabel);        %����׼ȷ��
