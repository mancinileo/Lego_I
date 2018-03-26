##===============================================
##
##    Laboratório 1: Apresentação do Rstudio
##
##===============================================


## Comandos básicos ========================================

# Ctrl(Command) + Enter para rodar comandos no script

1 + 1

# Detalhe: hashtag para comentar

### Criar bases 

x <- c(1, 2, 3, 4, 5, 6, 7)

y <- c("Sim", "Nao", "Sim", "Nao", "Sim", "Nao", "Sim")

dados <- data.frame(x, y)

# Detalhe: "c" de "combine", usado para se referir a mais de um valor. 

# Detalhe 2: palavras devem ser envoltas por aspas. 


### Saber o nome das variáveis ==================================

names(dados)

### Saber a categoria das variáveis (numéricas ou categóricas) ==

str(dados)

### Sumarizar os dados (melhor para contínuas) ==================

summary(dados)

# Outra forma: 

mean(dados$x)
median(dados$x)
sd(dados$x)
quantile(dados$x)

# Pergunta: alguém sabe o que é desvio-padrão?


### Tabular os dados (usado para categóricas) ================

# números absolutos
table(dados$y)

# porcentagens
prop.table(table(dados$y))


### Pacotes ===================================================

# install.packages("nome_do_pacote")

# library(nome_do_pacote)

# Exemplo 

install.packages("car", dependencies = TRUE) # basta instalar uma vez. 

library(car) # tem que rodar o pacote toda vez

update.packages() # atualizar pacotes (fazer de vez em quando)


### Atalhos importantes ========================================

# ctrl(cmd) + shift + C = comentários

# alt + - = criar objeto

# ctrl(cmd) + shift + H = setwd() = acertar o diretório

# ctrl(cmd) + D = apaga a linha

# ctrl(cmd) + shift + m = pipe (importante para tidyverse)


### Exemplos de análise ======================================

# Como o R performa

getwd() # saber o diretório de trabalho

dir() # para saber o que tem no diretório 

setwd() # ou ctrl + shift + H


## Mãos à obra ================================================

library(tidyverse) # pacote para mexer nos dados
library(janitor) # pacote para sumarizar dados
library(formattable) # mudar valores para porcentagens
library(rio) # pacote para importar dados

## ou .....

install.packages(c("tidyverse", "haven", "janitor",
                   "formattable"))


## Abrir base do World Values Survey (2014) ========================

# download em http://www.worldvaluessurvey.org/WVSDocumentationWV6.jsp,
# baixar o arquivo SPSS no final do site.

# saber qual é o diretório 

getwd()

# mudar diretório para achar base

setwd("C:/Users/thiagomoreira/Documents") # primeira forma

# ctrl(também no mac) + shift + H 

# dir() # saber como está o nome do arquivo no diretório
dir()

wvs_2014 <- import("wvs2014.sav")

names(wvs_2014) # saber nomes das variáveis


## Analisar os dados =========================================

# processo de seleção das variáveis 

# Variáveis de interesse: V203 (homossexualidade), 
# V240 (sexo)
base_nova <- wvs_2014 %>%
  select(V203, V240)


# Mudar nome das variáveis
base_nova <- base_nova %>% 
  rename(homo = V203, 
         sexo = V240)


# Organizar pelo maior número de casos
base_nova %>% 
  tabyl(homo) %>% 
  arrange(-n)


# Tirar médias e desvio-padrão 
base_nova %>% 
  summarise(media = mean(homo))

base_nova %>% 
  summarise(media = mean(homo, na.rm = TRUE))

base_nova %>% 
  summarise(desvio_padrao = sd(homo, na.rm = TRUE))


# Tabular quantidade de mulheres e homens
base_nova %>% 
  tabyl(sexo)


# Ver se existe diferença entre mulheres e homens
base_nova %>% 
  group_by(sexo) %>% 
  summarise(media = mean(homo, na.rm = T))


# Filtrar somente as mulheres
base_mulheres <- base_nova %>% 
  filter(sexo == 2) # ATENCAO AO IGUAL IGUAL


# Filtrar os missings (NA)
base_sem_missing <- base_nova %>% 
  filter(!is.na(homo))


# modificar variável homo 

base_sem_missing <- base_sem_missing %>% 
  mutate(homo = case_when(homo <= 4 ~ "direita", 
                          homo == 5 | homo == 6 ~ "centro",
                          homo >= 7 ~ "esquerda")) 


base_sem_missing %>% 
  tabyl(homo)


# base_nova %>% 
#   mutate(homo = case_when(homo %in% c(1,2,3,4) ~ "direita", 
#                           homo %in% c(5,6) ~ "centro",
#                           homo %in% c(7,8,9,10) ~ "esquerda")) %>% 
#   tabyl(homo)


# modificar variável sexo (binária)
# melhor como o comando "ifelse"
base_sem_missing <- base_sem_missing %>% 
  mutate(sexo = ifelse(sexo == 1, "homem", "mulher")) 

base_sem_missing %>% 
  tabyl(sexo)

# Melhor forma: usar o comando "percent" do pacote
# "formattable"

base_sem_missing %>% 
  tabyl(sexo) %>% 
  mutate(percent = percent(percent))


# comparar homens e mulheres em relacao homossexualidade
base_sem_missing %>% 
  crosstab(sexo, homo)


# melhor forma: 
base_sem_missing %>% 
  crosstab(sexo, homo) %>% 
  adorn_crosstab()

# salvar analise em csv
base_csv <- base_sem_missing %>% 
  crosstab(sexo, homo) %>% 
  adorn_crosstab()

write_csv(base_csv, "predilecoes_homossexualidade.csv")  














