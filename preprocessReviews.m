function [documents] = preprocessReviews(textData)
% converts text to lowercase
    cleanTextData = lower(textData);
    % tokenize the text
    documents = tokenizedDocument(cleanTextData);
    % get rid of the punctuation
    documents = erasePunctuation(documents);
    % remove a list of stop words
    documents = removeStopWords(documents); 
end