Web scraping package - rvest
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
search_list = list("opioid", "heroin", "hydrocodone", "vicodin", "codeine", "morphine",
                   "fentanyl", "methadone", "pethidine", "tramadol", "carfentanil",
                   "cocaine", "pain medication", "pain killer", "pain reliever","dilaudid",
                   "demerol", "oxycontin", "Tylenol", "Percocet")</code></pre>

Create the search list
----------------
<pre class="r"><code>for (item in search_list)
{dict[[item]] = get_reddit(search_terms = item)}</code></pre>

Scrape text from the html code
----------------
<p>First, let’s create a function to scrape text from The Hill</p>
<pre class="r"><code>textScraper <- function(x) {
  as.character(html_text(html_nodes (x, ".content-wrapper") %>% html_nodes("p"))) %>%
    str_replace_all("[\n]", "") %>%
    str_replace_all("    ", "") %>%
    str_replace_all("[\t]", "") %>%
    paste(collapse = '')}</code></pre>
    
Apply this function to our html content
----------------
<pre class="r"><code>articleText <- lapply(xml, textScraper) #list of article text
articleText[[1]] # Or use head(articleText)</code></pre>

Scrape time
----------------
<p>Use similar methods to scrape the time for all the articles. We create another function timeScraper, and apply it to the html content.</p>
<pre class="r"><code>timeScraper <- function(x) {
  timestampHold <- as.character(html_text(html_nodes(x, ".submitted-date"))) %>% str_replace_all("[\n]", "")
  matrix(unlist(timestampHold))
  timestampHold[1]} 
timestamp <- lapply(xml, timeScraper) #list of timestamps
head(timestamp)</code></pre>

Output as a dataframe
----------------
<p>Create a dataframe for the text and time we scraped above</p>
<pre class="r"><code>articleDF <- data.frame(storyID = as.character(storyURL[,1]), 
                        headline = as.character(storyURL[,3]), 
                        matrix(unlist(articleText), nrow = num), 
                        matrix(unlist(timestamp), nrow = num), 
                        themes = as.character(storyURL[,7]))
names(articleDF)[3] <- 'text'
names(articleDF)[4] <- 'time'
#review the output
#articleDF[1: 2, ]
write.csv(articleDF, file = "TheHill_TrumpCovid_text.csv")</code></pre>

Further readings
----------------
The official documentation for the package [`rvest`](https://cran.r-project.org/web/packages/rvest/rvest.pdf)

[Simple web scraping for R in Github](https://github.com/tidyverse/rvest);

[RStudio Blog: rvest: easy web scraping with R] (https://blog.rstudio.com/2014/11/24/rvest-easy-web-scraping-with-r/);

Real-world applications: [Most popular films](https://www.analyticsvidhya.com/blog/2017/03/beginners-guide-on-web-scraping-in-r-using-rvest-with-hands-on-knowledge/), [Trip Advisor Reviews](https://www.johnlittle.info/project/custom/rfun-scrape/rvest_demo.nb.html), [IMDb pages](https://stat4701.github.io/edav/2015/04/02/rvest_tutorial/).

