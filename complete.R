complete <- function(directory, id = 1:332) {
  # Ініціалізуємо порожній фрейм даних для збереження результатів
  result_df <- data.frame(id = numeric(), nobs = numeric())
  
  # Проходимося по кожному ідентифікатору монітора
  for (i in id) {
    # Формуємо шлях до файлу
    file_path <- file.path(directory, paste(formatC(i, width = 3, flag = "0"), ".csv", sep = ""))
    
    # Зчитуємо CSV-файл
    data <- read.csv(file_path)
    
    # Підраховуємо кількість повних випадків
    nobs <- sum(complete.cases(data))
    
    # Додаємо результати до фрейму даних
    result_df <- rbind(result_df, data.frame(id = i, nobs = nobs))
  }
  
  # Виводимо результати
  print(result_df)
}