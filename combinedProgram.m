%loads the positive and negative words
loadWords();
%sets up the word embeddings
wordEmbSetUp();
%trains the classifier
clasiffierTraining();

%runs the three classifiers for the first data set
filename = "yelp_labelled.txt";
chartTitle = "Data Set 1";
wordBasedSentClass();
totalWordBasedAcc = wordBasedAcc;
totalWordBasedCovered = wordBasedCovered;
wordEmbSentClass();
totalWordEmbAcc = wordEmbAcc;
totalWordEmbCovered = wordEmbCovered;
ensembleSentClass();
totalEnsembAcc = ensembAcc;
totalEnsembCovered = ensembCovered;

%runs the three classifiers for the first data set
filename = "imdb_labelled_2.txt";
chartTitle = "Data Set 2";
wordBasedSentClass();
totalWordBasedAcc =  totalWordBasedAcc + wordBasedAcc;
totalWordBasedCovered = totalWordBasedCovered + wordBasedCovered;
wordEmbSentClass();
totalWordEmbAcc =  totalWordEmbAcc + wordEmbAcc;
totalWordEmbCovered = totalWordEmbCovered + wordEmbCovered;
ensembleSentClass();
totalEnsembAcc =  totalEnsembAcc + ensembAcc;
totalEnsembCovered = totalEnsembCovered+ ensembCovered;

%runs the three classifiers for the first data set
filename = "amazon_cells_labelled.txt";
chartTitle = "Data Set 3";
wordBasedSentClass();
totalWordBasedAcc =  totalWordBasedAcc + wordBasedAcc;
totalWordBasedCovered = totalWordBasedCovered + wordBasedCovered;
wordEmbSentClass();
totalWordEmbAcc =  totalWordEmbAcc + wordEmbAcc;
totalWordEmbCovered = totalWordEmbCovered + wordEmbCovered;
ensembleSentClass();
totalEnsembAcc =  totalEnsembAcc + ensembAcc;
totalEnsembCovered = totalEnsembCovered+ ensembCovered;

%calculates average accuracy and coverage for each classifier
averageWordBasedAcc = totalWordBasedAcc/3;
averageWordEmbAcc = totalWordEmbAcc/3;
averageEnsembAcc = totalEnsembAcc/3;

averageWordBasedCovered = totalWordBasedCovered/30;
averageWordEmbCovered = totalWordEmbCovered/30;
averageEnsembCovered = totalEnsembCovered/30;

Y = [averageWordBasedAcc, averageWordBasedCovered
     averageWordEmbAcc, averageWordEmbCovered
     averageEnsembAcc, averageEnsembCovered];
X = categorical({'Word Based','Word Embeddings','Ensemble'});
X = reordercats(X,{'Word Based','Word Embeddings','Ensemble'});

figure
bar(X,Y)
title('Average Accuracy and Coverage of Classifiers')
legend({'Avg Accuracy','Avg Coverage'},'Location','northwest')
xlabel('Type of Classifier')
ylabel('Percentage')