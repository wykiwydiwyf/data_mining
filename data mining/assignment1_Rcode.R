install.packages("rio")
library("rio")
#import data and name the col

raw_data <- read.table("breast-cancer-wisconsin.data",sep = ",",
                     col.names = c("sample_code_num","clump_thickness",
                                   "uniformity_of_cell_size","uniformity_of_cell_shape",
                                   "marginal_adhesion","single_epithelial_cell_size",
                                   "bare_nuclei","bland_chromatin","normal_nucleoli","mitoses","class"))
#examine data type and remove all missing rows
#convert factor into int
str(raw_data)
raw_data$bare_nuclei <- gsub("?",NA,raw_data$bare_nuclei, fixed = TRUE)
complete_raw_data <- raw_data[complete.cases(raw_data),]
raw_data$bare_nuclei <- as.integer(raw_data$bare_nuclei)

#remove first column
complete_raw_data <- complete_raw_data[,2:11]

#change 'class's type from integer to factor

complete_raw_data$class <- as.factor(complete_raw_data$class)
class(complete_raw_data$class)

#Save the dataframe into a file with filename bcw_processed.Rda
export(complete_raw_data,"bcw_processed.Rda")

##Task 2 - Clustering:

load("bcw_processed.Rda")

data_cluster <- x[,1:9]



