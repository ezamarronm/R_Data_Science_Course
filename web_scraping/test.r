library(xml2)
library(rvest)

url <- "https://www.amazon.com/s?k=vacuums&ref=nb_sb_noss_1"
web_page <- read_html(url)
#selector <-"div.s-result-item:nth-child(2) > div:nth-child(1) > span:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > h2:nth-child(2) > a:nth-child(1)"
#web_page <- read_html(url)
#node = html_node(web_page, selector)
#node_link <-html_attr(node, "href")
#node_link
#full_link <- paste0("www.amazon.com",node_link)
#full_link

#https://www.amazon.com/s?k=vacuums&page=2&qid=1590792710&ref=sr_pg_2
#https://www.amazon.com/s?k=vacuums&page=3&qid=1590792710&ref=sr_pg_3
library(stringr)
next_page <- "https://www.amazon.com/s?k=vacuums&page=2&qid=1590792710&ref=sr_pg_2"
list_pages <- c(2:5)
next_page <- str_replace(next_page, "page=2", paste0("page=",list_pages))
next_page <- str_replace(next_page, "sr_pg_2", paste0("sr_pg_",list_pages))
#next_page

url = next_page[1]
#selector = "div.sg-col-20-of-24:nth-child(4) > div:nth-child(1) > span:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > h2:nth-child(1) > a:nth-child(1)"
selector = " a:nth-child(1)"
web_page = read_html(url)
web_page
node = html_nodes(web_page,selector)
node

getLinksPage <- function(url_page){
  web_page = read_html(url_page)
  #selector <- "div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > h2:nth-child(1) > a:nth-child(1)"
  selector <- "div.sg-col-20-of-24:nth-child(12) > div:nth-child(1) > span:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > h2:nth-child(1) > a:nth-child(1)"
  #web_page = read_html(next_page)
  node = html_nodes(web_page, selector)
  node_links <-html_attr(node, "href")
  print(node_links)
}
test <- getLinksPage(next_page[3])
test

linksAsp <- sapply(next_page, getLinksPage)
vlink <- paste0("https://www.amazon.com",as.vector(linksAsp))
#vlink

url_element <- vlink[1]
#url_element
#web_page_element <- read_html(url_element)
