# Resumes Parsing and Natural Language Processing (NLP)
- Aurthor: Tommy Lam
- Date: 15 Mar 2020

PDF, one of the famous formats of documents, at the same time it is also a nightmare to us while we want to convert them into text format. They look like usual documents when we read them. However, they feel like pictures when we need to edit or convert them into text.
#### [Read the full report here](https://nbviewer.jupyter.org/github/tommy539/Data-Science-Project/blob/master/Resumes%20Parsing%20and%20Natural%20Language%20Processing%20%28NLP%29/Resumes%20Parsing%20and%20Natural%20Language%20Processing%20%28NLP%29.ipynb)

## Objective
This project firstly provides a way to parse read these notorious pdf files and convert them into text format. Around 850 resumes are used to illustrate the pdf parsing. After the conversion, basic NLP (natural language processing) is used to investigate what is the most common topics/skills are included among the resumes.

## Data
Data for this study is one of the resources from my master degree at Monash University. The data is a huge set of resume in pdf format, same as those we have seen in our daily live or online. Therefore, any resumes can also be used in this project.
This project is useful for those who need to handle a huge amount of text information such as HR handling more than 200 resumes, researchers studying linguistics, artificial intelligence to learn languages and so on.

## Exploration
### Monograms
* After parsing the resumes in pdf format, the result of top monograms mentioned:
![text](https://github.com/tommy539/Data-Science-Project/blob/master/Resumes%20Parsing%20and%20Natural%20Language%20Processing%20(NLP)/graphs/Monogram_chart.png "Top monogram mentioned")

Among the top mentions,'university','experience' and 'skiils' are expected since they are the categories that we usually put in a resume.

* Stemming the monograms will give better result to understand the text content:
![text](https://github.com/tommy539/Data-Science-Project/blob/master/Resumes%20Parsing%20and%20Natural%20Language%20Processing%20(NLP)/graphs/stemmed_monogram.png "Stemmed monogram mentioned")

After stemming, we can observe that 95% of the resumes include the keywords related to manage and finance (excluding experience/university/education).

### Bigrams
Bigram is a sequence of words with adjacent elements from sentences or tokens. For example, a sequence of 'extensive financial experience' will become 'extensive financial' and 'financial experience'. We believe the combination of words such as bigram or more (we called n-gram) gives more insights than just tokens (unigram).

From the following bar chart showing the occurence of bigrams, it gives much more information of the documents than the monogram chart.
We can observe that these 850 resumes are highly related to Hong Kong and they are mostly related to financial business as those in the top mentions are financial terms.
![text](https://github.com/tommy539/Data-Science-Project/blob/master/Resumes%20Parsing%20and%20Natural%20Language%20Processing%20(NLP)/graphs/bigram_chart.png "Bigram chart")

### Word Cloud
Word cloud visualises the text with larger size with high occurences and locates the words with similar pattern together such as the 'hong'+'kong' and 'financial'+'statement' in the following word cloud.
![text](https://github.com/tommy539/Data-Science-Project/blob/master/Resumes%20Parsing%20and%20Natural%20Language%20Processing%20(NLP)/graphs/wordcloud.png "wordcloud")

## Applications
### Criteria Filtering
Since there are 850+ resumes, we can develop a filter to select some of them with the criteria we need.

For example, I would like to find out those with experience in finance and marketing in Australia, with position at least manager level and with a master's degree. We can launch a filter based on the keywords as followed:
criteria = ['finance','marketing','australia','manager','master']

In this project, I developed a function to perform this filtering process. By this function, we are able to search through the documents and return the name of documents which carry the criteria we are looking for. We can also input the percentage match of criteria before we perform the filtering such that we are able to use this function to find out for example 80% of the criteria I want. Here is the example:

Input:
```
filtering_documents(keywords,100)
filtering_documents(keywords,90)
```
Output:
```
100% match:
resume_(579).pdf
-------------------
90% match:
resume_(19).pdf
resume_(43).pdf
resume_(579).pdf
resume_(765).pdf
```
### Unsupervised classification: K-mean Clustering
K-mean clustering is one of the famous classification methods to partition the data into K clusters based on their similarities among the data. We will use the top 50 frequent stemmed tokens as the features to perform clustering. 

Before we run the K-mean algorithm, we will first create a DTM (document-term matrix) that describes the frequency of terms that occur in a collection of documents. In the DTM, the row corresponds to documents in our collection and the column corresponds to the features terms (Top 50 frequent stemmed tokens in this case).

Based on the DTM, we can create a TF-IDF (short for term frequency-Inverse document frequency) which is a weighting conversion of DTM such that it can reflect the the importance of word in a more effective way. TF-IDF is common used by search engines, stop-words filtering, text summarisation and classification.

Result
We run the K-mean clustering to partition the resumes into two groups. 

![text](https://github.com/tommy539/Data-Science-Project/blob/master/Resumes%20Parsing%20and%20Natural%20Language%20Processing%20(NLP)/graphs/cluster.png "cluster")

We can see that the candidates in Cluster 1 possess more skills and experience in accounting and audit aspect; while those in Cluster 2 are more related to business, team and management, relating to senior management position with handling teams situation.

## Summary
* By using PDFminer, we can parse the pdf file into text contents. 
* With the basic Natural Language Processing, the text contents are further tokenised and formed bigrams.
* We can further develop different types of application based on the NLP we have performed on the text data.
* K-mean clustering can partition the resumes into different clusters. Each clusters may carry different characteristics based the input we used in the model.
