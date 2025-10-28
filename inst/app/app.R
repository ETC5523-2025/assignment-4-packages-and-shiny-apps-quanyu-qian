library(shiny)

ui <- fluidPage(
  titlePanel("Bushfire Explorer (demo)"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("minFWI", "Min FWI", min = 0, max = 70, value = 20)
    ),
    mainPanel(
      plotOutput("p"),
      tableOutput("t")
    )
  )
)

server <- function(input, output, session){
  dat <- get("se_fire_monthly", envir = asNamespace("quanyu"))

  output$p <- renderPlot({
    d <- subset(dat, FWI >= input$minFWI)
    plot(d$FWI, log10(d$burned_area),
         xlab = "FWI", ylab = "log10(burned area)")
    abline(lm(log10(burned_area) ~ FWI, data = d))
  })

  output$t <- renderTable(head(dat, 10))
}

shinyApp(ui, server)
