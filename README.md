Reddit Scraping - RedditExtractoR
----------------
This GitHub repository contains data, code and refereces materials related to R package [`RedditExtractoR`](https://cran.r-project.org/web/packages/RedditExtractoR/RedditExtractoR.pdf)

The [`RedditExtractoR`](https://cran.r-project.org/web/packages/RedditExtractoR/RedditExtractoR.pdf) is to scrape Reddit data. We are going to exemplify how to use this package to pull out Reddit data and output a dataframe.

Preparation - Install packages
----------------
<pre class="r"><code>library(RedditExtractoR) 
library(dplyr)
library(hash)</code></pre>

Create a list of keywords for text data retrieval
----------------
<pre class="r"><code>dict = hash()
search_list = list("opioid", "heroin")</code></pre>

Create the search list
----------------
<pre class="r"><code>for (item in search_list){
  dict[[item]] = get_reddit(search_terms = item)}
  opioid = dict[["opioid"]]
  heroin = dict[["heroin"]]
</code></pre>

Combine the two dataframes and output to csv
----------------
<pre class="r"><code>df3 <- rbind(opioid, heroin)
write.csv(df, "RedditData.csv")</code></pre>
    
Further readings
----------------
The official documentation for the package [`RedditExtractoR`](https://cran.r-project.org/web/packages/RedditExtractoR/RedditExtractoR.pdf)


