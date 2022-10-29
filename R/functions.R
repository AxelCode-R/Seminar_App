test_pso_plot <- function(fn, lower, upper, test_n = 100, maxiter = 100, swarmsize = 20){
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
        showlegend=F
      )
  }

  return(fig)
}
