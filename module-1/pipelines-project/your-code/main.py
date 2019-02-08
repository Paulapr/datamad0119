

import pandas as pd
import numpy as np
import re
import seaborn as sns
import matplotlib.pyplot as plt

# 1. ACQUISITION

dataset = 'avocado.csv'

def get_data(dataset):
  dfa = pd.read_csv(dataset)
  return dfa

# 2. WRANGLING

def fixeddate (dfa):
  month = []
  for e in dfa["Date"]:
    aux= e.split("-")
    month.append(aux[1])
  dfa['month'] = pd.Series(month, index=dfa.index)
  dfa['year'] = dfa['year'].astype('object')
  dfa['Total Volume']= (dfa['Total Volume']/1000)
  return dfa

def changecols (dfa):
  column_order = ['region','year','month','type','AveragePrice','Total Volume','4046','4225','4770', 'Total Bags', 'Small Bags', 'Large Bags', 'XLarge Bags']
  dfa = dfa[column_order]
  dfa.columns = ['Region','Year','Month','Variety','Avg Price','Total Volume-k','S-M size','L size','XL size','Total Bags','S bags','L bags','XL bags']
  return dfa

def filteryear (dfa):
  filteredyear = list(dfa[(dfa['Year']==2018)].index) 
  dfa = dfa.drop(filteredyear, axis=0)
  return dfa

def subdata1 (dfa):
  df_totalUS = dfa[(dfa['Region'] == 'TotalUS')]
  return df_totalUS

def subdata2 (dfa):
  df_region = dfa[(dfa['Region'] == 'Plains')|(dfa['Region'] =='West')|
              (dfa['Region'] =='California')|(dfa['Region'] =='SouthCentral')|
              (dfa['Region'] =='Northeast')|(dfa['Region'] =='Southeast')|
              (dfa['Region'] =='GreatLakes')|(dfa['Region'] =='Midsouth')]
  return df_region

def subdata3 (dfa):
  df_cities= dfa[(dfa['Region'] != 'Plains')|(dfa['Region'] !='West')|
              (dfa['Region'] !='California')|(dfa['Region'] !='SouthCentral')|
              (dfa['Region'] !='Northeast')|(dfa['Region'] !='Southeast')|
              (dfa['Region'] !='GreatLakes')|(dfa['Region'] !='Midsouth')|
              (dfa['Region'] != 'TotalUS')] 
  return df_cities
  

# 3. ANALYSIS

#3.1. VARIEDAD vs AVG PRICE (df_totalUS)

def price_type (df):
  price_typet = df.groupby(['Variety','Year'])['Avg Price'].describe()
  return ("Variedad vs. Precio medio\n{}".format(price_typet))

#3.2. VARIEDAD vs AVG PRICE (df_region)

def price_type2 (df):
  price_type2t = pd.pivot_table(df, values=['Avg Price'], index=['Region'], columns=['Year'])
  return ("Variedad vs. Precio medio por regiones\n{}".format(price_type2t))

#3.3. VARIEDAD vs. TOTAL VOLUMEN

def period_vol(df,col):
  period_volt= pd.pivot_table(df, values=['Total Volume-k'], index=[col], columns=['Year'])
  return ("Volumen por año \n{}".format(period_volt))

#3.4. BENEFICIOS TOTALES (K) - df_region
  
def profit_vol (df):
  df['Total_profit-K']= (df['Avg Price']*df['Total Volume-k'])
  profit_volt = pd.pivot_table(df, values=['Total_profit-k','Total Volume-k'], index=['Region'], columns=['Year'])
  return ("Profit and Volumen \n{}".format(profit_volt))

#3.5. CORRELACIÓN entre el precio medio y el volumen total - df_region

def correlacion (df):
  correlacion1 = df['Total Volume-k'].corr(df['Avg Price'])
  return "La correlación linea entre el volumen total y el precio medio es {}".format(correlacion1)

#3.6. PORCENTAJE DE APORTE AL VOLUMEN TOTAL - df_region

def percentage (df):
  new_columns = ['perc_S-M size','perc_L size','perc_XL size','perc_Bags','perc_S bags','perc_L bags','perc_XL bags']
  origin_columns = ['S-M size','L size','XL size','Total Bags','S bags','L bags','XL bags']
  for n, o in zip(new_columns, origin_columns): 
    df[n] = (df[o]/df['Total Volume-k'])/10
  percen_vol= df[['Region','Year','perc_S-M size','perc_L size','perc_XL size','perc_Bags']]
  percen_vol = pd.pivot_table(percen_vol, values=['perc_S-M size','perc_L size','perc_XL size','perc_Bags'], index=['Region'],columns=['Year'])
  return ("Porcentajes de aporte al volumen total \n{}".format(percen_vol))

# 4. VISUALIZE

def graf_boxplot (df):
  grafico1=sns.boxplot(y="Variety", x="Avg Price", data=df, palette = 'Purples')
  return grafico1

def graf_bar(df,col,title):
  fig, ax = plt.subplots(figsize=(15,8))
  grafico2 = sns.barplot(data= df, x=('Month'), y='Total Volume-k')
  plt.title(title + "\n", fontsize=16)
  return grafico2

def save_viz(grafico,title):
    fig = grafico.get_figure()
    fig.savefig(title + '.png')

if __name__ == '__main__':

  dataset = 'avocado.csv'

  dfa = get_data(dataset)
  dfa = fixeddate(dfa)
  dfa = changecols(dfa)
  dfa = filteryear(dfa)
  df_totalUS = subdata1(dfa)
  df_region = subdata2(dfa)
  df_cities  = subdata3(dfa)

  result1 = price_type (df_totalUS)
  result2 = price_type2 (df_region)
  col = df_totalUS['Month']
  result3 = period_vol(df_totalUS, col)
  col = df_totalUS['Region']
  result4 = period_vol(df_region, col)
  result5 = profit_vol (df_region)
  result6 = correlacion (df_region)
  result7 = percentage (df_region)
  
 
  title1 = 'Total volumen de venta por mes'
  title2 = 'Precio medio de venta'
  title3 = 'Box plot variedad-precio medio'
  col1= df_region['Total Volume-k']
  col2= df_region['Avg Price']

  grafico1 = graf_boxplot(dfa)
  grafico2 = graf_bar(df_region,col1,title1)
  grafico3 = graf_bar(df_region,col2,title2)
  save_viz(grafico1,title3)
  save_viz(grafico2,title1)
  save_viz(grafico3,title2)
  

  ## SEND EMAIL WITH REPORT:

  import subprocess

  input = "Enter your email:"

  def bash_command(cmd):
    subprocess.Popen(['/bin/bash', '-c', cmd])

  # $ echo ('README.MD') | mail -s "Report" input