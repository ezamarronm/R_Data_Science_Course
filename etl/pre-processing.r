vacuums<- read.csv("./vacuums.csv")
View(vacuums)

#Processing weight
vacuums$Weight <- as.character(vacuums$Weight)
vacuums$Weight <- gsub(" pounds", "", vacuums$Weight)
vacuums$Weight <- gsub("-1", NA, vacuums$Weight)
vacuums$Weight <- as.numeric(vacuums$Weight)
mean_weight <- mean(vacuums$Weight, na.rm = TRUE)
vacuums$Weight[is.na(vacuums$Weight)] <- mean_weight
hist(vacuums$Weight)
summary(vacuums$Weight)
#vacuums$Weight
#class(vacuums$Weight)