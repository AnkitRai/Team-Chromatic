library('RPostgreSQL')
drv <- dbDriver('PostgreSQL')

con <- dbConnect(drv, 
                 host = "dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com",
                 dbname = "training_2015",
                 user = "katzsamuels",
                 password = "katzsamuels"
                 )

data <- dbGetQuery(con, "SELECT * FROM jkatzsamuels.Building_Violations_sample_50000;")

dbDisconnect(con)

#view data
head(data)
tail(data)

#obtain dimension of data
dim(data)

#type of datas
sapply(data, class)

#get rid of ssa
data <- data[, !(names(data) %in% 'SSA')]

#convert date variable to datetime
data$VIOLATION.DATE <- as.character(data$VIOLATION.DATE)
data$VIOLATION.DATE <- as.Date(data$VIOLATION.DATE, format = '%m/%d/%Y')
class(data$VIOLATION.DATE)
head(data$VIOLATION.DATE)

#remove missing values
data = data[!is.na(data$LOCATION) ,]
