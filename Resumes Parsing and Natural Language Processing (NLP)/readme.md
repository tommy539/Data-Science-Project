# Resumes Parsing and Natural Language Processing (NLP)
- Aurthor: Tommy Lam
- Date: 15 Mar 2020

PDF, one of the famous formats of documents, at the same time it is also a nightmare to us while we want to convert them into text format. They look like usual documents when we read them. However, they feel like pictures when we need to edit or convert them into text.

## Objective
This project firstly provides a way to parse read these notorious pdf files and convert them into text format. Around 850 resumes are used to illustrate the pdf parsing. After the conversion, basic NLP (natural language processing) is used to investigate what is the most common topics/skills are included among the resumes.

## Data
Data for this study is one of the resources from my master degree at Monash University. The data is a huge set of resume in pdf format, same as those we have seen in our daily live or online. Therefore, any resumes can also be used in this project.
This project is useful for those who need to handle a huge amount of text information such as HR handling more than 200 resumes, researchers studying linguistics, artificial intelligence to learn languages and so on.

## Result

#### [Read the full report here](https://nbviewer.jupyter.org/github/tommy539/Data-Science-Project/blob/master/Resumes%20Parsing%20and%20Natural%20Language%20Processing%20%28NLP%29/Resumes%20Parsing%20and%20Natural%20Language%20Processing%20%28NLP%29.ipynb)
### Monograms
* After parsing the resumes in pdf format, the result of top monograms mentioned:
![text](https://github.com/tommy539/Data-Science-Project/blob/master/Resumes%20Parsing%20and%20Natural%20Language%20Processing%20(NLP)/graphs/Monogram_chart.png "Top monogram mentioned")

Among the top mentions,'university','experience' and 'skiils' are expected since they are the categories that we usually put in a resume.

* Stemming the monograms will give better result to understand the text content:
![text](https://github.com/tommy539/Data-Science-Project/blob/master/Resumes%20Parsing%20and%20Natural%20Language%20Processing%20(NLP)/graphs/stemmed_monogram.png "Stemmed monogram mentioned")

After stemming, we can observe that 95% of the resumes include the keywords related to manage and finance (excluding experience/university/education).

### Bigrams
Bigram is a sequence of words with adjacent elements from sentences or tokens. For example, a sequence of 'extensive financial experience' will become 'extensive financial' and 'financial experience'. We believe the combination of words such as bigram or more (we called n-gram) gives more insights than just tokens (unigram).

From the following bar chart showing the occurance of bigrams, it gives much more information of the documents than the monogram chart.
We can observe that these 850 resumes are highly related to Hong Kong and they are mostly related to financial business as those in the top mentions are financial terms.
![text](https://github.com/tommy539/Data-Science-Project/blob/master/Resumes%20Parsing%20and%20Natural%20Language%20Processing%20(NLP)/graphs/bigram_chart.png "Bigram chart")

### Word Cloud
Word cloud visualises the text with larger size with high occurances and locates the words with similar pattern together such as the 'hong'+'kong' and 'financial'+'statement' in the following word cloud.
![text](https://github.com/tommy539/Data-Science-Project/blob/master/Resumes%20Parsing%20and%20Natural%20Language%20Processing%20(NLP)/graphs/wordcloud.png "wordcloud")

## Summary
* By using PDFminer, we can parse the pdf file into text contents. 
* With the basic Natural Language Processing, the text contents are further tokenised and formed bigrams.
* Word cloud can be used to visualise the text pattern effectively.

## Further
1. We can perform feature selection based on the tokenised documents by filtering the keywords we want and filter the documents we want.
2. Based on the tokens in each document, we can perform unsupervised classification to divide the documents into different clusters.
