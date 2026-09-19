library(shiny)

shinyUI(fluidPage(
        titlePanel("MPG Predictor"),
        sidebarLayout(
                sidebarPanel(
                        sliderInput("wt", "Car weight (1000 lbs):",
                                    min = 1.5, max = 5.5, value = 3, step = 0.1),
                        radioButtons("am", "Transmission:",
                                     choices = c("Automatic", "Manual")),
                        checkboxInput("showLine", "Show regression lines", value = TRUE)
                ),
                mainPanel(
                        tabsetPanel(
                                tabPanel("Prediction",
                                         h4("Predicted fuel efficiency:"),
                                         h2(textOutput("pred")),
                                         plotOutput("plot")),
                                tabPanel("How to use",
                                         h3("What this app does"),
                                         p("It predicts how many miles per gallon (MPG) a car gets,
                   based on its weight and transmission type."),
                                         h3("How to use it"),
                                         tags$ol(
                                                 tags$li("Move the slider to set the car's weight.
                            3 means 3,000 lbs."),
                                                 tags$li("Choose Automatic or Manual transmission."),
                                                 tags$li("Read the predicted MPG on the Prediction tab.
                            It updates instantly."),
                                                 tags$li("On the plot, the red X is your car. The dots are
                            the 32 real cars the model learned from.")
                                         ),
                                         h3("How it works"),
                                         p("The prediction comes from a linear regression,
                   mpg ~ weight + transmission, fit on R's built-in
                   mtcars dataset (1974 Motor Trend road tests)."),
                                         p("Tick or untick the checkbox to show or hide the fitted
                   line for each transmission type."))
                        )
                )
        )
))
