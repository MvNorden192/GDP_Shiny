library(shiny)

shinyUI(fluidPage(

  titlePanel("The Effect of Government Spending and the Interest Rate on GDP"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("G",
                  "Level of Government Spending for upcoming 14 years:",
                  min = -50,
                  max = 100,
                  value = 30,
                  step = 10),
      radioButtons("choice", "Interest Rate", choices = c("High", "Medium", "Low"),selected = "Medium"),
      sliderInput("iets", "Iets invullen", min = 0, max =50, value = 25)

    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("plot")
    )
  )
))
