library(shiny)
library(caret)
library(rsconnect)
shinyServer(function(input, output) {

  output$plot <- renderPlot({
    par(mfrow=c(1,1))

    #Interest and Investments
    set.seed(1234567)
    x <- c("High" = 18, "Medium" = 7, "Low" = 1)
    df <- read.csv("GDP_Shiny.csv")
    plot(df$Year, df$GDP, xlab = "Year", ylab = "GDP", xlim = c(1960, 2030), ylim = c(350, 1050))
    linmod <- lm(GDP ~ Year + Consumption + Government + Investment, data = df)
    if (input$choice == "High") {
      Investment <- rnorm(14, 250 * (100+2*x[input$choice])/100, 100)
    }

    if (input$choice == "Medium") {
      Investment <- rnorm(14, 250 * (100+2*x[input$choice])/100, 20)
    }
    if (input$choice == "Low") {
      Investment <- rnorm(14, 250 * (100+2*x[input$choice])/100, 2)
    }

    input$iets


    #Investment <- rnorm(14, 250 * (100+2*x[input$choice])/100, 8)
    Government <- rep(input$G/2, 14)
    Consumption <- seq(330, 460, by = 10)
    Year <- 2017:2030
    to_predict <- cbind(Year, Consumption, Government, Investment)
    to_predict <- data.frame(to_predict)
    to_predict$GDP <- 0
    pred <- predict(linmod, newdata = to_predict)
    pred2 <- data.frame(pred)
    pred2$Year <- 2017:2030
    points(pred2$Year, pred2$pred, pch = 18, cex = 2, lty = 3, col = "royalblue")
    abline(reg = lm(GDP ~ Year, data = df), col = "tomato3")
  })

})
