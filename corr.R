corr <- function(directory, threshold = 0) {
  # Створюємо порожній вектор для збереження кореляцій
  correlations <- numeric()
  
  # Отримуємо список файлів у каталозі
  file_list <- list.files(directory, pattern = ".csv", full.names = TRUE)
  
  # Проходимося по кожному файлу
  for (file in file_list) {
    # Зчитуємо CSV-файл
    data <- read.csv(file)
    
    # Перевіряємо, чи кількість повних спостережень перевищує поріг
    if (sum(complete.cases(data)) > threshold) {
      # Обчислюємо кореляцію між сульфатом і нітратом
      correlation <- cor(data$sulfate, data$nitrate, use = "complete.obs")
      
      # Додаємо кореляцію до вектора
      correlations <- c(correlations, correlation)
    }
  }
  
  # Повертаємо вектор кореляцій
  return(correlations)
}