library(rvest)
library(xml2)

url <- "https://www.amazon.com/s?k=vacuums&ref=nb_sb_noss_1"
web_page <- read_html(url)
web_page
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
list_pages <- c(1:18)
next_page <- str_replace(next_page, "page=2", paste0("page=",list_pages))
next_page <- str_replace(next_page, "sr_pg_2", paste0("sr_pg_",list_pages))
#next_page

url_page = next_page[2]
getLinksPage <- function(url_page){
  web_page = read_html(url_page)
  print(web_page)
  selector <- "div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > h2:nth-child(1) > a:nth-child(1)"
  #selector <- "div.sg-col-20-of-24:nth-child(12) > div:nth-child(1) > span:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > h2:nth-child(1) > a:nth-child(1)"
  #web_page = read_html(next_page)
  node = html_nodes(web_page, selector)
  node_links <-html_attr(node, "href")
  node_links
}
#test <- getLinksPage(next_page[3])
#test
linksAsp <- sapply(next_page, getLinksPage)
links_vector <- as.vector(linksAsp)
#View(links_vector)
vlink <- paste0("https://www.amazon.com",as.vector(linksAsp))
#url_element <- vlink[1]
#url_element
#web_page_element <- read_html(url_element)
getArticle <- function(url_element){
  web_page_element <- read_html(url_element)
  print(web_page_element)
  #NAME
  vacuum_name_selector <- "#productTitle"
  vacuum_name_node = html_node(web_page_element, vacuum_name_selector)
  vacuum_name_text <- html_text(vacuum_name_node)
  vacuum_name_text
  
  #OPINIONS_NUMBER
  vacuum_opinions_selector <- "#averageCustomerReviews_feature_div > div:nth-child(2) > span:nth-child(3) > a:nth-child(1) > span:nth-child(1)"
  vacuum_opinions_node = html_node(web_page_element, vacuum_opinions_selector)
  vacuum_opinions_text <- html_text(vacuum_opinions_node)
  vacuum_opinions_text

  #PRICE
  vacuum_price_selector <- "#priceblock_ourprice" 
  vacuum_price_node = html_node(web_page_element, vacuum_price_selector)
  if(length(vacuum_price_node) == 0){
    vacuum_price_selector <- "#priceblock_saleprice"
    vacuum_price_node = html_node(web_page_element, vacuum_price_selector)
  }
  vacuum_price_text <- html_text(vacuum_price_node)
  vacuum_price_text
  
  
  #INFORMATION TABLE
  vacuum_information_table_selector <- "#productDetails_detailBullets_sections1"  
  vacuum_information_table_node <- html_node(web_page_element,vacuum_information_table_selector)
  
  if(!is.na(vacuum_information_table_node)){
    vacuum_information_table_tab <- html_table(vacuum_information_table_node)
    vacuum_information_table_tab
    table_values <- data.frame(t(vacuum_information_table_tab$X2))
    names <-vacuum_information_table_tab$X1
    colnames(table_values) <- names
  }
  else{
    table_values <- NULL
  }
  #  vacuum_ans <- c(vacuum_name_text, vacuum_price_text, vacuum_price_text, as.character(values$'Item Weight'), as.character(values$'Product Dimensions'), as.character(values$'Batteries Required'),as.character(values$'Manufacturer') ) 

  cols <- c("Item Weight", "Product Dimensions", "Batteries Required","Manufacturer")
  if(length(table_values) == 0){
    #No values, all in -1
    mytab <- data.frame(colnames(cols))
    mytab <- rbind(mytab, c("-1", "-1", "-1","-1"))
    colnames(mytab) <- cols
  } else {
  #check every attribute
    zeros <- matrix("-1", ncol=4, nrow = 1)
    dfzeros <- as.data.frame(zeros)
    colnames(dfzeros)<- cols
    
    weight <- as.character(table_values$`Item Weight`)
    dimensions <- as.character(table_values$`Product Dimensions`)
    manufr <- as.character(table_values$Manufacturer)
    batt <- as.character(table_values$`Batteries Required`)
    
    if(length(weight) == 0) weight <- "-1"
    if(length(dimensions) == 0) dimensions <- "-1"
    if(length(manufr) == 0) manufr <- "-1"
    if(length(batt) == 0) batt <- "-1"
    
    dfzeros$`Item Weight` <- weight
    dfzeros$`Product Dimensions`<- dimensions
    dfzeros$`Batteries Required`<- batt
    dfzeros$Manufacturer <- manufr
    
    mytab <- dfzeros
    colnames(mytab) <-cols
  }
  
  article <-c(vacuum_name_text, vacuum_opinions_text, vacuum_price_text, as.character(mytab$'Item Weight'), as.character(mytab$'Product Dimensions'), as.character(mytab$'Batteries Required'),as.character(mytab$'Manufacturer') )
  article
}  
#vacuum <- getArticle(url_element)
vacuums <- sapply(vlink, getArticle)
vacuums <- t(vacuums)
colnames(vacuums) <- c("Name", "Opinions", "Price", "Weight", "Dimensions", "Batteries Required", "Manufacturer")
View(vacuums)

write.csv(vacuums,"vacuums.csv", row.names = TRUE)
