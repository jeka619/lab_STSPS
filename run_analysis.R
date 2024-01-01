# Завантаження необхідних бібліотек
library(dplyr)

# Зчитування даних для тесту та тренування
subject_test <- read.table("/home/osboxes/Desktop/5791/UCI HAR Dataset/test/subject_test.txt", col.names = "subject_train")
y_test <- read.table("/home/osboxes/Desktop/5791/UCI HAR Dataset/test/y_test.txt", col.names = "test_labels")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject_train")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "test_labels")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")

# Об'єднання даних для тесту та тренування
all <- rbind(cbind(subject_train, y_train, X_train), cbind(subject_test, y_test, X_test))

# Зчитування назв змінних з файлу features.txt
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("index", "variable"))
feature_names <- features$variable

# Перейменування стовпців
names(all) <- c("subject_train", "test_labels", feature_names)

# Заміна символів в назвах стовпців
names(all) <- gsub("-", "_", names(all))
names(all) <- gsub("\\(\\)", "", names(all))

# Вибір тільки змінних з математичним очікуванням і середньоквадратичним відхиленням
i <- grep("mean", names(all))
j <- grep("std", names(all))
all <- all[, sort(c(1, 2, i, j))]

# Заміна значень в стовпці test_labels на назви відповідних активностей
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
all$test_labels <- as.character(activity_labels$activity[match(all$test_labels, activity_labels$code)])

# Створення незалежного набору даних з середнім значенням по кожній 
# змінній за кожним видом діяльності і по кожному предмету
result <- aggregate(. ~ test_labels + subject_train, data = all, FUN = "mean")