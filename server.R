
shinyServer(function(session, input, output) {


    output$plot_fitness_test <- renderPlotly({
        temp <- input$render
        req(input$render)

        isolate({
            eval(parse(text = paste('fn <- function(pos) { \n x=pos[1] \n y=pos[2] \n return(' , input$fun , ')}', sep='')))

            lower = -20
            upper = 20
            test_n = 50
            maxiter = 100
            swarmsize = 20
        })

        fig <- plot_ly(mode = "lines", type = "scatter")
        for(k in 1:test_n){
            res <- suppressMessages(psoptim(
                par = rep(NA, 2),
                fn = fn,
                lower = lower,
                upper = upper,
                control = list(
                    maxit = maxiter,
                    s = swarmsize,
                    trace = T,
                    REPORT = 1,
                    trace.stats = T
                )
            ))
            res$history_best_fit <- data.frame("iter"=1:length(res$stats$x), "fit_iter"= unlist(lapply(res$stats$f, min))) %>%
                mutate(fit_best = fit_iter)
            for(i in 2:nrow(res$history_best_fit)){
                if(res$history_best_fit$fit_best[i] > res$history_best_fit$fit_best[i-1]){
                    res$history_best_fit$fit_best[i] <- res$history_best_fit$fit_best[i-1]
                }
            }

            fig <- fig %>%
                add_trace(
                    data = res$history_best_fi,
                    x = ~iter,
                    y = ~fit_best,
                    showlegend = F
                )

            updateProgressBar(
                session = session,
                id = "progress",
                value = k,
                total = test_n,
                title = "Render Progress:"
            )
        }

        fig
    })

})
