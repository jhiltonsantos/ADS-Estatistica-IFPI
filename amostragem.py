# python -m pip install --user numpy scipy matplotlib ipython jupyter pandas sympy nose

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from itertools import product


# Valores População

valor_populacao = np.array([1,2,4,5,7,9])

populacao = {
    'Media' :valor_populacao.mean(),
    'Variancia': valor_populacao.var(),
    'Tamanho Amostra' :3
   }

# Tabela

tabela_amostra = list(product(valor_populacao, repeat=populacao['Tamanho Amostra']))
tabela_experimento = pd.Series(tabela_amostra)
resumo = tabela_experimento.describe()
print(tabela_experimento)
print(resumo)

print("\n________População________")
print("Media: ", populacao['Media'])
print("Variancia: ", populacao['Variancia'])
print("Tamanho da Amostra: ", populacao['Tamanho Amostra'])


# Teória Estatística Média

teoria_media = {
    'Media': valor_populacao.mean(),
    #'VarianciaObservada' : ,
    'VarianciaTeoria' : populacao['Variancia'] / populacao['Tamanho Amostra'],
}

print("\n\n_Teória Estatística Média_")
print("Media: ", teoria_media['Media'])
#print("Variancia Observada: ", teoria_media['VarianciaObservada'])
print("Variância teória: ", teoria_media['VarianciaTeoria'])


# Teoria Estatística Variância

valor_amostral = []

for i in range(len(tabela_amostra)):
    valor_amostral += [np.var([tabela_amostra[i]])]

soma_valor_amostral = 0

for i in range(len(valor_amostral)):
    soma_valor_amostral += valor_amostral[i]

media_variancia_e = soma_valor_amostral/len(valor_amostral)

teoria_estatistica_variancia = {
    'Teoria Variancia' : populacao['Variancia'],
    'MediaVarianciaC': np.var(valor_amostral)/2,
    'MediaVarianciaE': media_variancia_e
}

print("\n\n_Teoria Estatística Variância_")
print("Teoria Variância: ", teoria_estatistica_variancia['Teoria Variancia'])
print("Media VariânciaC: ", teoria_estatistica_variancia['MediaVarianciaC'])
print("Media VariânciaE: ", teoria_estatistica_variancia['MediaVarianciaE'])
