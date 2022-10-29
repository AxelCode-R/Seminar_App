library(dplyr)
library(tidyr)
library(pso)
library(tibble)
library(plotly)
library(shinyWidgets)

for(src in list.files("R")){
  source(paste0("R/",src))
}
