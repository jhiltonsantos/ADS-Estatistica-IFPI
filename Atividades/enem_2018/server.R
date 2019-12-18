#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(data.table)
library(tidyverse)
#install.packages("sos")
#library(sos)
#install.packages("sos")

getwd()
setwd("/home/hilton/Development/git-estatistica-R/enem_2018")

enem_2018 <- data.table::fread("enem_2018.csv",
                               nrows = 1000,
                               skip = 0)
                               #na.strings = "",
                               #select = ,
                               #showProgress = TRUE)

base_tp_escola <- enem_2018 %>%
  group_by(TP_ESCOLA) %>%
  summarise(media_nota_LC = mean(NU_NOTA_LC %>% as.numeric(),
                                 na.rm = TRUE),
            media_nota_MT = mean(NU_NOTA_MT %>% as.numeric(),
                                 na.rm =  T),
            media_nota_CH = mean(NU_NOTA_CH %>% as.numeric(),
                                 na.rm =  T),
            media_nota_CN = mean(NU_NOTA_CN %>% as.numeric(),
                                 na.rm =  T),
            media_nota_REDACAO = mean(NU_NOTA_REDACAO %>% as.numeric(),
                                 na.rm =  T))

base_analise_t <- base_tp_escola %>%
  gather(key = "prova_estatistica", value = "nota", -TP_ESCOLA)

#base_analise_s <- base_tp_escola %>%
#  spread(key = "prova_estatistica", value = "nota", -TP_ESCOLA)
#  (key = "prova_estatistica", value = "nota", -TP_ESCOLA)



# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    base_analise_t %>%
      ggplot(mapping = aes(x = TP_ESCOLA %>% as.character(),
                           y = nota,
                           fill = prova_estatistica)) + 
      geom_bar(stat = "summary",
               fun.y = "mean",
               width = .3,
               position = "dodge") + 
      xlab("Tipo de Instituicao") +
      ylab("Nota") +
      scale_y_continuous(breaks = c(0, 250, 500, 750)) + 
      scale_x_discrete(breaks = c("1", "2", "3", "4"),
                         labels = c("Nao declarada", "Publica", "Privada",
                                   "Exterior"))

    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
})
