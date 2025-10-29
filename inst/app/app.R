library(shiny)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
  ),
  titlePanel("Bushfire Explorer"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("minFWI", "Min FWI", min = 0, max = 59, value = 20),
      selectInput("month", "Month", choices = c("All", month.abb), selected = "All"),
      checkboxInput("showLine", "Show trend line", TRUE),

      tags$p(tags$em(
        "Goal: Explore whether higher FWI is associated with larger burned area, and how this varies by month."
      )),

      tags$hr(),
      helpText(
        tags$b("Field meanings:"),
        tags$br(), tags$b("FWI"), " – Fire Weather Index (higher = more dangerous fire weather).",
        tags$br(), tags$b("burned_area"), " – Area burned in hectares (the plot uses ", tags$code("log10"), ")."
      ),
      helpText(HTML("
<b>Goal:</b> Explore how fire risk (FWI) relates to burned area, and how this changes by month.<br><br>

<b>How to use:</b><br>
Use the <b>Min FWI</b> slider to focus on higher-risk fire conditions, or select a <b>Month</b> to zoom into specific seasonal patterns.<br><br>

<b>How to read the chart:</b><br>
Each dot shows one month’s fire event.
The <span style='color:#0066cc; font-weight:600;'>blue line</span> indicates the trend between FWI and burned area.<br>
If the line slopes upward → higher FWI corresponds to larger burned areas.
If downward → higher FWI corresponds to smaller burned areas.<br><br>

<b>How to read the summary below the plot:</b><br>
The text under the chart reports:
<ul style='margin-left:15px;'>
  <li><b>Sample size</b> – number of events after filtering</li>
  <li><b>r</b> – correlation between FWI and log(burned area)</li>
  <li><b>Line slope</b> – rate of change per +1 FWI unit</li>
</ul>
A higher <b>r</b> means a stronger relationship.
"))
),

    mainPanel(
      uiOutput("filters"),
      plotOutput("p"),
      tags$small(htmlOutput("summary")),
      tags$hr(),
      tags$h4("Top 10 rows (after filtering)"),
      tableOutput("t")
    )
  )
)

server <- function(input, output, session) {
  dat <- get("se_fire_monthly", envir = asNamespace("quanyu"))

  filtered <- reactive({
    d <- dat %>% filter(FWI >= input$minFWI)
    if (input$month != "All") d <- d %>% filter(month == input$month)
    d
  })
  output$filters <- renderUI({
    req(input$minFWI, input$month)
    month_txt <- if (input$month == "All") "All months" else paste("Month:", input$month)
    HTML(sprintf("<div class='filters-badge'>Filters: <b>Min FWI ≥ %s</b> | <b>%s</b></div>",
                 input$minFWI, month_txt))
  })


  output$p <- renderPlot({
    d <- subset(dat, FWI >= input$minFWI &
                  (input$month == "All" | month == input$month))

    if (nrow(d) < 2) {
      plot.new(); text(0.5, 0.5, "Not enough data after filtering"); return(invisible())
    }

    subtxt <- paste0("Filters: Min FWI ≥ ", input$minFWI,
                     if (input$month != "All") paste0(" | Month: ", input$month) else "")

    g <- ggplot(d, aes(FWI, log10(burned_area))) +
      geom_point(alpha = 0.75) +
      labs(
        x = "Fire Weather Index (FWI)",
        y = "log10(Burned Area)",
        title = "FWI vs log10(Burned Area)",
        subtitle = subtxt
      ) +
      theme_minimal(base_size = 13)

    if (input$showLine) g <- g + geom_smooth(method = "lm", se = FALSE)

    r     <- suppressWarnings(cor(d$FWI, log10(d$burned_area)))
    slope <- coef(lm(log10(burned_area) ~ FWI, d))[2]
    g + annotate(
      "text",
      x = max(d$FWI) - 0.05*diff(range(d$FWI)),
      y = max(log10(d$burned_area)) - 0.05*diff(range(log10(d$burned_area))),
      hjust = 1, vjust = 1, size = 3.8,
      label = sprintf("r = %.2f | slope = %.3f", r, slope)
    )
  })

  output$summary <- renderUI({
    d <- filtered()
    if (!is.data.frame(d) || NROW(d) < 2) return(HTML(""))

    n_obs <- NROW(d)
    r <- suppressWarnings(cor(d$FWI, log10(d$burned_area)))
    if (!is.finite(r)) r <- NA_real_

    first_line <- sprintf(
      "%d observations. Each dot represents one month’s fire event.",
      n_obs
    )

    second_line <- if (!is.finite(r) || n_obs < 12) {
      sprintf("Relationship is unclear with current sample (r = %s).",
              ifelse(is.finite(r), sprintf("%.2f", r), "NA"))
    } else if (abs(r) < 0.2) {
      sprintf("Little or no clear link between FWI and burned area (r = %.2f).", r)
    } else if (r > 0) {
      sprintf("As FWI rises, burned area tends to be larger (r = %.2f).", r)
    } else {
      sprintf("As FWI rises, burned area tends to be smaller (r = %.2f).", r)
    }

    html <- sprintf(
      '<div class="sum-note">%s<br><span class="sum-emph">%s</span></div>',
      first_line, second_line
    )
    HTML(html)
  })


  output$t <- renderTable({
    filtered() %>%
      arrange(desc(FWI)) %>%
      mutate(burned_area = round(burned_area, 0)) %>%
      head(10)
  }, striped = TRUE, bordered = TRUE, hover = TRUE)
}

shinyApp(ui, server)
