vacuums<- read.csv("./vacuums_backup.csv")
View(vacuums)

#Processing weight
vacuums$Weight <- as.character(vacuums$Weight)
vacuums$Weight <- gsub(" pounds", "", vacuums$Weight)
vacuums$Weight <- gsub("-1", NA, vacuums$Weight)
vacuums$Weight <- as.numeric(vacuums$Weight)
mean_weight <- mean(vacuums$Weight, na.rm = TRUE)
vacuums$Weight[is.na(vacuums$Weight)] <- mean_weight
#hist(vacuums$Weight)
#summary(vacuums$Weight)

#Processing Batteries Required
vacuums$Batteries.Required <-as.character(vacuums$Batteries.Required)
vacuums$Batteries.Required <- gsub("No", "0", vacuums$Batteries.Required)
vacuums$Batteries.Required <- gsub("Yes", "1", vacuums$Batteries.Required)
#vacuums$Batteries.Required <- gsub("-1", NA, vacuums$Batteries.Required)
vacuums$Batteries.Required <- as.numeric(vacuums$Batteries.Required)
vacuums$Batteries.Required
#length(vacuums$Batteries.Required[is.na(vacuums$Batteries.Required)])

#Processing Price
vacuums$Price 
vacuums$Price <- as.character(vacuums$Price)
vacuums$Price <- gsub("\\$", "", vacuums$Price)
vacuums$Price <- gsub("-1", NA, vacuums$Price)
vacuums$Price <- as.numeric(vacuums$Price)
mean_price <- mean(vacuums$Price, na.rm = TRUE)
vacuums$Price[is.na(vacuums$Price)] <- mean_price

#Processing Ratings
vacuums$Opinions 
vacuums$Opinions <- as.character(vacuums$Opinions)
vacuums$Opinions <- gsub(" ratings", "", vacuums$Opinions)
vacuums$Opinions <- gsub(",", "", vacuums$Opinions)
vacuums$Opinions <- gsub("-1", NA, vacuums$Opinions)
vacuums$Opinions <- as.numeric(vacuums$Opinions)
mean_opinions <- mean(vacuums$Opinions, na.rm = TRUE)
vacuums$Opinions[is.na(vacuums$Opinions)] <- mean_opinions

#Processing Dimensions
library(stringr)
vacuums$Dimensions
vacuums$Dimensions <- as.character(vacuums$Dimensions)
vacuums$Dimensions <- gsub(" inches", "", vacuums$Dimensions)
vacuums$Dimensions <- gsub(" ", "", vacuums$Dimensions)
dimen <- data.frame(str_split_fixed(vacuums$Dimensions, "x", n=3))
colnames(dimen) <- c("length", "width", "height")
#View(dimen)

##NAs
dimen
dimen$length <- gsub("-1", NA, dimen[,1])
dimen$width[is.na(dimen$length)] <- dimen$length[is.na(dimen$length)]
dimen$height[is.na(dimen$length)] <- dimen$length[is.na(dimen$length)]

##To number
dimen$length <- as.numeric(dimen$length)
dimen$width <- as.numeric(dimen$width)
dimen$height <- as.numeric(dimen$height)

##Mean
mean_ <- mean(dimen$length, na.rm = TRUE)
dimen$length[is.na(dimen$length)] <- mean_

mean_ <- mean(dimen$width, na.rm = TRUE)
dimen$width[is.na(dimen$width)] <- mean_

mean_ <- mean(dimen$height, na.rm = TRUE)
dimen$height[is.na(dimen$height)] <- mean_

vacuums <- cbind(vacuums, dimen)
rownames(vacuums) <- vacuums[,1]
vacuums<- vacuums[,-1]
vacuums <-vacuums[,-5]
vacuums <-vacuums[,-6]

View(vacuums)
write.csv(vacuums,"clean_vacuums.csv", row.names = TRUE)

