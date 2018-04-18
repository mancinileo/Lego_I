##################################
##
##    AULA 7 - PROBABILIDADE
##
#################################


# criar base que simule as faces de uma moedda 

moeda <- c("cara", "caroa")


## jogar moeda para o alto uma vez (reparem no "size = 1"). 

sample(dado, size = 1, replace = T)

## simular uma amostra pequena, com 4 observações diferentes.

amostra_pequena <- sample(dado, size = 4, replace = T)

## tabular a porcentagem dos casos dessa amostra pequena. 

prop.table(table(amostra_pequena))

## simular uma amostra média (N = 40). 

amostra_media <- sample(dado, size = 40, replace = T)

## tabular a porcentagem de casos dessa amostra média. 

prop.table(table(amostra_media))

## simular uma amostra grande (N = 100).

amostra_grande <- sample(dado, size = 100, replace = T)

## tabular os casos da amostra grande.

prop.table(table(amostra_grande))

## simular uma amostra ainda maior (N = 1000000)

amostra_enorme <- sample(dado, size = 1000000, replace = T)

## tabular os casos da maior amostra

prop.table(table(amostra_enorme))




