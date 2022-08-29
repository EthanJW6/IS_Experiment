%wordEmbSetUp();
%get the number of words
numWords = size(data,1);
%splitting the data into training and testing 90/10%
cvp = cvpartition(numWords,'HoldOut',0.01);
dataTrain = data(training(cvp),:);
dataTest = data(test(cvp),:); 

%Convert the words into word vectors using word2vec
wordsTrain = dataTrain.Word; 
XTrain = word2vec(emb,wordsTrain);
YTrain = dataTrain.Label;

%Train a support vector machine classifier for binary classification
model = fitcsvm(XTrain,YTrain);

%Test trained model
wordsTest = dataTest.Word;
XTest = word2vec(emb,wordsTest);
YTest = dataTest.Label;
%Predict the sentiment labels of the test word vectors
[YPred,scores] = predict(model,XTest);
%Visualise the confusion matrix
figure
confusionchart(YTest,YPred);