library(shiny)
library(data.table)
library(tidyverse)

getwd()
setwd("C:/Users/Aluno/Documents/Dados")

accidents <- data.table::fread("accidents.csv",
                               nrows = 1000,
                               skip = 0)

base_ocorrencia_tipo <- accidents.csv %>%
            group_by(ocorrencia_tipo) %>%
            summarise()