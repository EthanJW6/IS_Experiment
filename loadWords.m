
    clc
    clear

    % Reading the positive words
    fidPositive = fopen(fullfile('positive-words.txt'));

    %skip the comments
    C = textscan(fidPositive,'%s','CommentStyle',';');
    %convert to string
    wordsPositive = string(C{1});

    fclose all;

    % read the negative words
    fidNegative = fopen(fullfile('negative-words.txt'));
    C = textscan(fidNegative, '%s', 'CommentStyle',';');
    wordsNegative = string(C{1});

    fclose all;

    wordsHash = java.util.Hashtable;

    [possize,~] = size(wordsPositive);
    [negsize,~] = size(wordsNegative);
    %move the positve and negative words in the hash-table
    for ii =1:possize
        wordsHash.put(wordsPositive(ii,1),1);
    end

    for ii =1:negsize
        wordsHash.put(wordsNegative(ii,1),-1);
    end
