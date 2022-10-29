
shinyUI(fluidPage(
    fluidPage(
        textAreaInput("fun",
                      "Die zu minimierende R-Funktion mit x und y Koordinate:",
                      value="-20 * exp(-0.2 * sqrt(0.5 *((x-1)^2 + (y-1)^2))) -
          exp(0.5*(cos(2*pi*x) + cos(2*pi*y))) +
          exp(1) + 20", width=600, height=100),
        actionButton("render", "Render"),
        progressBar(
            id = "progress",
            value = 0,
            total = 100,
            title = "",
            display_pct = TRUE
        ),
        plotlyOutput("plot_fitness_test")
    )
))
