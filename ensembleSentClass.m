%loadWords();
    dataReviews = readtable(filename,'TextType','string');
    textData = dataReviews.review;
    actualScore = dataReviews.score;
    sents = preprocessReviews(textData);

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
        %word embedding sentiment classifier if sent score was 0
        if sentimentScore(ii) == 0
            vec = word2vec(emb,docwords);
            [~,scores] = predict(model,vec);
            sentimentScore(ii) = mean(scores(:,1));
            %normalising the sent score (neg = -1, pos = 1)
            if (isnan(sentimentScore(ii)))
                sentimentScore(ii)=0;
            end
        end

        %normalising the sent score (neg = -1, pos = 1)
        if (sentimentScore(ii)>0)
            sentimentScore(ii)=1;
        elseif (sentimentScore(ii)<0)
            sentimentScore(ii)=-1;
        end

    end
    % Find how many sentiment scores are equal to 0
    ZeroVal = sum(sentimentScore == 0);
    % Find all the distinct values (1 or -1)
    ensembCovered = numel(sentimentScore) - ZeroVal;

    fprintf('Ensemble Sentiment Classifier\n');
    fprintf("total of positive and negative classes (coverage): %2.2f%%, Distinct %d, Not Found or Neutral: %d\n", (ensembCovered*100)/numel(sentimentScore), ensembCovered, ZeroVal);

    %calculate tp and tn
    tp = sentimentScore((sentimentScore > 0) & (actualScore == 1));
    tn = sentimentScore((sentimentScore < 0)& (actualScore == 0));

    %calculate accuracy
    ensembAcc = (numel(tp) + numel(tn))*100/ensembCovered;
    fprintf("Accuracy: %2.2f%%, TP: %d, TN: %d\n", ensembAcc, numel(tp), numel(tn));
    %visualise using a confusion chart
    figure
    confusionchart(actualScore, sentimentScore)