#### Comentários #
#https://www.kaggle.com/AnalyzeBoston/crimes-in-boston
# Removendo memória
rm(list = ls())
# Limpando histórico
gc()



#### Seções  ----

### Comando "ctrl + Enter"

### Comentário ctrl + Enter + "c"


### baixando pacotes (apenas 1 vez)
install.packages("tidyverse")
install.packages("data.table")


## Pacotes (todas vez que for utilizar)
library(tidyverse)
library(data.table)

## Leitura ----
base <- fread("~/Development/estatistica/Crimes/crime.csv",
              dec=".")


## Colunas

names(base)


## Tratamento ----
### Selecionando variáveis (colunas)  

base <- base %>% select(OFFENSE_CODE,OFFENSE_CODE_GROUP,YEAR,MONTH,HOUR,DAY_OF_WEEK,Lat,Long)




### Selecionando linhas

base_filtrada <- base %>%
  filter(YEAR == 2015 & MONTH==12)

### Tabela de frequência simples (objeto tabela)
table(base$YEAR)

## Duas entradas
table(base$YEAR,base$MONTH)


table(base$OFFENSE_CODE_GROUP)

### Tabela de frequência simples (objeto base de dados)

tabela_freq <- base %>% 
  group_by(OFFENSE_CODE,OFFENSE_CODE_GROUP) %>%
  summarise(N = length(MONTH))



## Gráficos básicos (gráfico de colunas)

# Gráfico básico
ggplot(tabela_freq) +
geom_bar(aes(x = OFFENSE_CODE_GROUP,y = N),
         stat="identity", width=.5, 
         position = "dodge") 

# Filtrando espécies mais recorrentes
ggplot(tabela_freq %>% filter(N>5000),
       aes(x = OFFENSE_CODE_GROUP,y = N)) +
  geom_bar(stat="identity", width=.5, 
           position = "dodge")


# Gráfico de barras (horizontal)
ggplot(tabela_freq %>% filter(N>5000),
       aes(x = OFFENSE_CODE_GROUP,y = N) )+
  geom_bar(stat="identity", width=.5, 
           position = "dodge") +
  coord_flip()


# Gráfico de barras (horizontal)
ggplot(tabela_freq %>% filter(N>5000),
       aes(x = OFFENSE_CODE_GROUP,y = N,fill=OFFENSE_CODE_GROUP)) +
  geom_bar(stat="identity", width=.5, 
           position = "dodge") +
  coord_flip() 


# Gráfico de barras (horizontal ajustado)
ggplot(tabela_freq %>% filter(N>5000),
       aes(x = OFFENSE_CODE_GROUP,y = N,fill=OFFENSE_CODE_GROUP)) +
  geom_bar(stat="identity", width=.5, 
           position = "dodge") +
  coord_flip() +
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) 

  



## Editando legendas 
ggplot(tabela_freq %>% filter(N>5000),aes(x = OFFENSE_CODE_GROUP,y = N)) +
  geom_bar(stat="identity", width=.5, 
           position = "dodge") +
  coord_flip() +
  xlab("Crime") +
  ylab("Quantidade") 

## Gráfico de setor (pizza)

ggplot(tabela_freq %>% filter(N>5000),
       aes(x = "",y = N,fill = OFFENSE_CODE_GROUP)) +
  geom_bar(stat="identity", width=.5, 
           position = "stack") +
  coord_polar("y") +
  xlab("Crime") +
  ylab("Quantidade") +
    geom_text(aes(label = paste0(round(N/sum(N),4)*100, "%")),
            position = position_stack(vjust = 0.5))+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) 



### Ajustando conteúdo (vendo os 10 primeiros registros da coluna crime)
base$OFFENSE_CODE_GROUP[1:10]


## filtrando crimes que tenham vehicle
base_filtrada <- base %>% 
  filter(grepl("vehic",OFFENSE_CODE_GROUP,ignore.case = T))
  
table(base_filtrada$OFFENSE_CODE_GROUP)

###  Salvando tabela de frequência
write.csv2(tabela_freq,"tabela_freq.csv",row.names = F)

## Base de dados tradicional ----
#https://archive.ics.uci.edu/ml/datasets/iris
#https://www.kaggle.com/rtatman/iris-dataset-json-version

# 1. comprimento da sépala em cm
# 2. largura da sépala em cm
# 3. comprimento da pétala em cm
# 4. largura da pétala em cm
# 5. classe:
#   - Iris Setosa
# - Iris Versicolour
# - Iris Virginica

iris

ggplot(iris,aes(x = Petal.Length)) +
  geom_histogram(color="black",
                 fill="white",
                 stat = "bin",
                 bins = 15) +
  ylab("Frequência")

## Número de linhas
nrow(iris)

# Intervalos iguais
# Regra de sturges determina o número de classes
1+3.3*log(150)


ggplot(iris,aes(x = Petal.Length)) +
  geom_histogram(color="black",
                 fill="white",
                 stat = "bin",
                 bins = 15) +
  ylab("Frequência") +
  facet_grid(Species ~.)










## Qual o padrão das espécies de acordo com o tamanho da pétala?
## Qual espécie tem os indivíduos mais parecidos(similares) entre si?
## Quais espécies os indivíduos são mais parecidos(similares)?
## Quais espécies os indivíduos são mais diferentes (dissimilares)?

## medida de centralidade e variabilidade
iris %>% 
  group_by(Species) %>%
  summarise(Media = mean(Petal.Length),
            Minimo = min(Petal.Length),
            Maximo = max(Petal.Length),
            Desvio = sd(Petal.Length))




## Como está o crescimento da criança?
#https://www.sbp.com.br/departamentos-cientificos/endocrinologia/graficos-de-crescimento/
  
## Primeira observação
iris[1,]



ggplot(iris %>% filter(Species == "setosa"),
       aes(x = Petal.Length)) +
  geom_histogram(color="black",
                 fill="white",
                 stat = "bin",
                 bins = 6) +
  ylab("Frequência") +
  geom_vline(xintercept = iris$Petal.Length[1],col = "red")

## Isso é muito ou pouco??
iris$Petal.Length[1]

## vetor só com tamanho da pétala das setosas
petala.setosa <- (iris %>% filter(Species == "setosa"))$Petal.Length

quantile(petala.setosa)
quantile(petala.setosa,
         p = c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9))

## Teste lógico
petala.setosa<petala.setosa[1]


table(petala.setosa<petala.setosa[1])

## Apenas 22% dos indivíduos da espécie setosa tem valor inferior a 1.4 
prop.table(table(petala.setosa<petala.setosa[1]))



## Boxplot


iris %>% group_by(Species) %>%
  summarise(media = mean(Petal.Length),
            mediana = median(Petal.Length),
            minimo = min(Petal.Length),
            maximo = max(Petal.Length),
            variancia = var(Petal.Length),
            desvio = sd(Petal.Length))




ggplot(iris,
       aes(x =Species, y = Petal.Length)) +
  geom_boxplot(color="black",
                 fill="white") +
  ylab("Tamanho da pétala")


ggplot(iris) +
  geom_point(aes(color = Species,
                   x =Sepal.Length, 
                   y = Petal.Length)) +
  ylab("Tamanho da pétala") +
  xlab("Tamanho da sépala")
