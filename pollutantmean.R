pollutantmean <- function(directory, pollutant, id = 1:332) {

  # Повний шлях
  directory <- "/home/osboxes/Desktop/5791/specdata" 
  
  # Форматує ID як текст з 3 знаками   
  id <- sprintf("%03d", id)
  
  # Читає файли даних
  files <- paste0(id, ".csv")
  datalist <- lapply(files, function(x) {
    filepath <- file.path(directory, x)
    read.csv(filepath)
  })
  
  # Вибирає стовпець забруднювача
  pollutantdata <- lapply(datalist, function(x) x[[pollutant]])
  
  # Розраховує середнє значення
  mean(unlist(pollutantdata), na.rm = TRUE)
  
}