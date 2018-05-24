##============================================
##    Aula 12 - Regressões e Correlações
##============================================

## comando para limpar a memória do R ==========================

rm(list = ls())

## abrir pacotes ===============================================

library(tidyverse) # pacote para lidar com os dados
library(car) # pacote com a base "Duncan"

## abrir base contida no pacote "car" ==========================

duncan <- as.data.frame(Duncan)

## saber nomes da base, tipo e sumário das variáveis ===========

names(duncan)

glimpse(duncan)

summary(duncan)

##===============================================================
## Problema:
## A ideia central é fazer uma predição do salário, segundo o 
## nível de escolaridade.
##===============================================================

## investigar possíveis outliers ================================

boxplot(duncan$income)

# outra forma de fazer o boxplot (ggplot)

duncan %>% 
  ggplot(aes(x = "", y =income)) + 
  geom_boxplot()

# faça vc o mesmo com educação

boxplot(duncan$education)

## dar uma olhada na correlação das variáveis =========================

duncan %>% 
  select(income, education) %>% 
  cor(.)

## olhar a curva de regressão =========================================

duncan %>% 
  ggplot(aes(x = income, y = education)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = F)

## rodar a regressão ==================================================

modelo1 <- lm(income ~ education, data = duncan)

summary(modelo1)

##=====================================================================
## Problema 2: 
## Saber se o número de habitantes afeta o número de homicídios.
##=====================================================================

library(dslabs) # pacote com a base "murders"

data("murders")

## saber nomes da base, tipo e sumário das variáveis ===========

names(murders)

glimpse(murders)

summary(murders)

## investigar possíveis outliers ================================

boxplot(murders$population)

boxplot(murders$total)

## Olhar correlação =============================================

murders %>% 
  select(population, total) %>% 
  cor(.)


## Olhar regressão =============================================

murders %>% 
  ggplot(aes(x = population, y = total)) + 
  geom_point() +
  geom_smooth(method = "lm") +
  theme_bw()


## Rodar modelo ================================================

modelo_2 <- lm(total ~ population, data = murders)
  
summary(modelo_2)
