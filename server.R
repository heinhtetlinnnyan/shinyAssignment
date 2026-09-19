library(shiny)

cars <- mtcars
cars$am <- factor(cars$am, labels = c("Automatic", "Manual"))
fit <- lm(mpg ~ wt + am, data = cars)

shinyServer(function(input, output) {
        
        pred <- reactive({
                newcar <- data.frame(wt = input$wt,
                                     am = factor(input$am, levels = c("Automatic", "Manual")))
                predict(fit, newdata = newcar)
        })
        
        output$pred <- renderText(paste(round(pred(), 1), "MPG"))
        
        output$cost <- renderText({
                cost <- input$miles / pred() * input$price
                paste0("Estimated yearly fuel cost: $", format(round(cost), big.mark = ","))
        })
        
        output$plot <- renderPlot({
                cols <- ifelse(cars$am == "Manual", "orange", "steelblue")
                plot(cars$wt, cars$mpg, pch = 16, col = cols,
                     xlim = c(1.5, 5.5), ylim = c(5, 40),
                     xlab = "Weight (1000 lbs)", ylab = "Miles per gallon")
                if (input$showLine) {
                        b <- coef(fit)
                        abline(b[1], b[2], col = "steelblue", lwd = 2)
                        abline(b[1] + b[3], b[2], col = "orange", lwd = 2)
                }
                points(input$wt, pred(), pch = 4, cex = 3, lwd = 3, col = "red")
                legend("topright", c("Automatic", "Manual", "Your car"),
                       col = c("steelblue", "orange", "red"), pch = c(16, 16, 4))
        })
})