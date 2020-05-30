install.packages("rvest")
library(rvest)
library(xml2)
url<-"https://www.imdb.com/title/tt7126948/"
web_page <-read_html(url)
selector <- "#titleYear > a:nth-child(1)"
node <-html_node(web_page, selector)
node_text <- html_text(node)
node_text
table_selector <-".cast_list" 
table_node <- html_node(web_page, table_selector)
table_node_text <- html_table(table_node)
table_node_text
