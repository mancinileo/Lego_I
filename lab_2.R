##==================================
##
##   Labortatório 2 - Gráficos
##
##==================================

library(gapminder)
library(tidyverse)
library(janitor)

options(scipen = 999)


## alternativa
pacman::p_load(gapminder, tidyverse, janitor)

## base do pacote "gapminder"
gapminder

## transformar em data frame
gapminder <- data.frame(gapminder)

names(gapminder)

glimpse(gapminder)

summary(gapminder)



## nomes 
names(gapminder)

## tipo
glimpse(gapminder)




## abrir dispositivo de grafico
x11()

quartz()

window()

gapminder %>% 
  summarise(media = mean(lifeExp),
            desvio = sd(lifeExp))

gapminder %>% 
  filter(country == "Brazil") %>% 
  summarise(media = mean(lifeExp))




## sumarizar media
gapminder %>%
  summarise(media = mean(lifeExp))

## sumarizar media por país
gapminder %>%
  group_by(country) %>% 
  summarise(media = mean(lifeExp))


## sumarizar media por país e ordenar tabela
gapminder %>%
  group_by(country) %>% 
  summarise(media = mean(lifeExp)) %>% 
  arrange(-media) 

## printar mais casos
base_nova <- gapminder %>%
  group_by(country) %>% 
  summarise(media = mean(lifeExp))  
  
  
base_nova <- base_nova %>%   
  arrange(-media) %>% 
  print(n=50)

## cortar top 30
base_cortada <- gapminder %>%
  group_by(country) %>% 
  summarise(media = mean(lifeExp)) %>% 
  arrange(-media) %>% 
  top_n(n= 10)

nova_base_cortada <- gapminder %>%
  group_by(country) %>% 
  summarise(media = mean(lifeExp)) %>% 
  arrange(-media) %>% 
  print(n= 30)

## grafico de barras entre 2 variaveis
base_cortada %>% 
  ggplot(aes(x = country, y = media)) + 
  geom_bar(stat = "identity")






## girar gráfico
base_cortada %>% 
  ggplot(aes(x = country, y = media)) + 
  geom_bar(stat = "identity") + 
  coord_flip()

## ordenar grafico
base_cortada %>% 
  ggplot(aes(x = reorder(country, media), y = media)) + 
  geom_bar(stat = "identity") + 
  coord_flip() 

## mudar tema
base_cortada %>% 
  ggplot(aes(x = reorder(country, media), y = media)) + 
  geom_bar(stat = "identity") + 
  coord_flip() +
  theme_bw()

## tirar legendas laterais
base_cortada %>% 
  ggplot(aes(x = reorder(country, media), y = media)) + 
  geom_bar(stat = "identity") + 
  coord_flip() + 
  theme_bw() + 
  labs(x = "", y = "")

## grafico de pontos
base_cortada %>% 
  ggplot(aes(x = reorder(country, media), y = media)) + 
  geom_point(size = 5) + 
  coord_flip() + 
  theme_bw() +
  labs(x = "", y = "")


## 2 variacao temporal

base_al <- gapminder %>% 
  filter(country %in% c("Brasil", "Argentina",
                        "Cuba", "Bolivia", "Chile",
                        "Colombia"))



base_al %>% 
  ggplot(aes(x = year, y = lifeExp, color = country)) + 
  geom_line()


## 2 variaveis continuas

gapminder %>% 
  filter(gdpPercap != 0) %>% 
  ggplot(aes(x = gdpPercap, y = lifeExp)) + 
  geom_point()

## 1 variavel continua

gapminder %>% 
  filter(gdpPercap != 0) %>% 
  ggplot(aes(lifeExp)) + 
  geom_histogram()


## 3 variaveis

dezmais <- gapminder %>% 
  group_by(country, continent) %>% 
  summarise(media = mean(lifeExp)) %>% 
  arrange(-media) %>% 
  top_n(n= 10) %>%
  filter(media >= 74.3)
  


dezmais %>% 
  ggplot(aes(x = country, y = media, fill = continent)) + 
  geom_bar(stat = "identity") + coord_flip() 
  





