library(shiny)

shinyUI(fluidPage(
  titlePanel("Прогноз споживання пального"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("cylinders", "Кількість циліндрів", value = ""),
      textInput("horsepower", "Кількість кінських сил", value = ""),
      actionButton("predictButton", "Зробити прогноз", class = "btn-primary btn-block"),
      actionButton("showDocumentation", "Показати документацію")
    ),
    
    mainPanel(
      h4("Результат прогнозу:", class = "text-info"),
      verbatimTextOutput("predictionOutput")
    )
  )
))
