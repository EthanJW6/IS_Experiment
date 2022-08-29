
    %loadWords();
    %filename = "yelp_labelled.txt";
    dataReviews = readtable(filename,'TextType','string');
    textData = dataReviews.review;
    actualScore = dataReviews.score;
    sents = preprocessReviews(textData);
    fprintf('\n')
    fprintf('%s\n', chartTitle);
    fprintf('File: %s, Sentences: %d \n', filename,size(sents));
    fprintf('Word Based Sentiment Classifier\n');

    sentimentScore = zeros(size(sents));

    %looping through the sentences calculating the sentiment scores of each
    %of them
    for ii = 1 : sents.length
        docwords = sents(ii).Vocabulary;
        for jj = 1 : length(docwords)
            if wordsHash.containsKey(docwords(jj))
                sentimentScore(ii) = sentimentScore(ii) + wordsHash.get(docwords(jj));
            end
        end
        %normalising the sent score (neg = -1, pos = 1)
        if (sentimentScore(ii)>=1)
            sentimentScore(ii)=1;
        elseif (sentimentScore(ii)<=-1)
            sentimentScore(ii)=-1;
        end

    end
    % Find how many sentiment scores are equal to 0
    ZeroVal = sum(sentimentScore == 0);
    % Find all the distinct values (1 or -1)
    wordBasedCovered = numel(sentimentScore) - ZeroVal;
    
    fprintf("total of positive and negative classes (coverage): %2.2f%%, Distinct %d, Not Found or Neutral: %d\n", (wordBasedCovered*100)/numel(sentimentScore), wordBasedCovered, ZeroVal);

    %calculate tp and tn
    tp = sentimentScore((sentimentScore == 1) & (actualScore == 1));
    tn = sentimentScore((sentimentScore == -1)& (actualScore == 0));

    %calculate accuracy
    wordBasedAcc = (numel(tp) + numel(tn))*100/wordBasedCovered;
    fprintf("Accuracy: %2.2f%%, TP: %d, TN: %d\n", wordBasedAcc, numel(tp), numel(tn)); figure
    %confusion matrix
    confusionchart(actualScore, sentimentScore);

