library(shiny)
library(data.table)
library(tidyverse)

getwd()
setwd("~/Development/git-estatistica-R/Projeto Final")

accidents <- data.table::fread("accidents.csv",
                               nrows = 1000,
                               skip = 0)

base_ocorrencia_tipo <- accidents %>%
            group_by(ocorrencia_tipo) %>%
            summarise()
