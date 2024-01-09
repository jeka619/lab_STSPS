library(shiny)
library(datasets)

shinyServer(function(input, output) {
  
  observeEvent(input$predictButton, {
    
    # Зчитування введених користувачем значень
    cylinders <- as.numeric(input$cylinders)
    horsepower <- as.numeric(input$horsepower)
    
    # Використання простого прогнозу на основі лінійної регресії
    model <- lm(mpg ~ wt + hp, data = mtcars)
    new_data <- data.frame(wt = cylinders, hp = horsepower)
    prediction <- predict(model, newdata = new_data)
    
    # Виведення результату прогнозу
    output$predictionOutput <- renderPrint({
      paste("Прогноз споживання пального:", round(prediction, 2), "mpg")
    })
  })
  
  # Відображення документації за допомогою Markdown
  observeEvent(input$showDocumentation, {
    showModal(
      modalDialog(
        HTML(markdown::markdownToHTML("documentation.md", fragment.only = TRUE)),
        footer = tagList(
          actionButton("closeDocumentation", "Закрити документацію")
        )
      )
    )
  })
  
  observeEvent(input$closeDocumentation, {
    removeModal()
  })
})
