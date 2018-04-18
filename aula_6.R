##==================================
##
##            Aula 6
##
##==================================

## comando para tirar notação científica ===========

options(scipen = 9999)

## abrir pacotes ===================================

library(tidyverse) # mexer nos dados
library(janitor) # tabulacao dos dados

## abrir base iris =================================

iris <- data.frame(iris)


## 3 passos iniciais ===============================

# a) saber os nomes

names(iris)

# b) saber o tipo das variáveis

glimpse(iris)

# c) tirar um sumário das variáveis 

summary(iris)

## análise de duas variáveis contínuas ============

# Exemplo 1:

# a) plotar o gráfico antes, para verificar se relação
# entre as variáveis é linear. Nome das variáveis: 
# "Sepal.Length" e "Sepal.Width".

iris %>% 
  ggplot(aes(x = Sepal.Length, y =  Sepal.Width)) +
  geom_point()

# b) tirar um índice de correlação das variáveis

iris %>% 
  select(Sepal.Length, Sepal.Width) %>% 
  cor(., method = "pearson")

# Resultado: nível da correlação é fraco (-0.11). 

# Exemplo 2: 

# a) plotar o gráfico de pontos:

iris %>% 
  ggplot(aes(x = Petal.Width , y = Petal.Length)) +
  geom_point()

# b) tirar correlação:

iris %>% 
  select(Petal.Width, Petal.Length) %>% 
  cor(., method = "pearson")

## Resultado: correlação forte (0.96)

## Exemplo 3: crime ========================================

# abrir base 
crime <- read.csv("http://datasets.flowingdata.com/crimeRatesByState2005.tsv", header=TRUE, sep="\t")

# nome das variáveis

names(crime)

# tipo das variáveis

glimpse(crime)

# sumário das variáveis

summary(crime)

## plotar gráfico com a correlação entre "murder" e 
## "burglary"

crime %>% 
  ggplot(aes(x = murder, y = burglary)) + 
  geom_point()

## calcular a correlação entre ambas

crime %>% 
  select(murder, burglary) %>% 
  cor()


## grafico customizado 

crime %>% 
  ggplot(aes(x=murder, y=burglary, size=population, label=state),guide=FALSE)+
  geom_point(color="white", fill="red", shape=21)+ 
  scale_size_area(max_size = 15)+
  scale_x_continuous(name="Murders per 1,000 population", limits=c(0,12))+
  scale_y_continuous(name="Burglaries per 1,000 population", limits=c(0,1250))+
  geom_text(size=2.5)+ theme_bw()









