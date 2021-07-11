#########################################################  TEXT MINING ON PDF #####################################################
install.packages('wordcloud')
install.packages('tm') #means text mining 
install.packages('pdftools')
install.packages('RColorBrewer')
library(RColorBrewer)
library('wordcloud')
library('tm')
library('pdftools')


############################ STEP 1 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
txt=pdf_text(choose.files())

## for data mining text should be in form of corpus ---corpus means collection of text documnets
##types of corpus ---vcorpus --volatile corpus ----pcorpus-->> permanent corpus
#vectorcorpus() is a function used to create source object(main corpus)

txt_corpus=Corpus(VectorSource(txt))

t=lapply(txt_corpus,as.character)


##########################  STEP 2  @@@@@@@@@@@@@@@@@@@@@@
#DATA CLEANING

txt_corpus=tm_map(txt_corpus,removeNumbers) #remove numbers
lapply(txt_corpus,as.character)

txt_corpus=tm_map(txt_corpus,removePunctuation) #remove punctualtions
lapply(txt_corpus,as.character)

#remove white spaces
txt_corpus=tm_map(txt_corpus,stripWhitespace)
lapply(txt_corpus,as.character)


#convert to lower case
txt_corpus=tm_map(txt_corpus,tolower)
lapply(txt_corpus,as.character)

#stop words should be removed ---like---- to is the a an---

stopwords('en') ###inbuilt dictionary

txt_corpus=tm_map(txt_corpus,removeWords,stopwords('en'))
lapply(txt_corpus,as.character)

############### stemming 
#understand understood understanding,.... In stemming we convert words to their root words i.e. understand

#POS tagging-- part of speech tagging
#tokeniZation--- breaking  the sentence /document into individual elements


#******************************DATA PREPAPRATION ******************************#
#tokeniZation- split the documnet into individual components

dtm=DocumentTermMatrix(txt_corpus)

dtm=as.matrix(dtm)

dtm=t(dtm)

occ=rowSums(dtm)

numOfOcc=sort(occ,decreasing = T)


#********************************************DATA VIZUALIZATION
## PLOT WORDCLOUD
wordcloud(txt_corpus,,min.freq = 50,random.order = F)

#FOR FONT COLORING---
wordcloud(txt_corpus,,min.freq = 50,random.order = F,color=brewer.pal(8,'Dark2'),rot.per=0.30)
