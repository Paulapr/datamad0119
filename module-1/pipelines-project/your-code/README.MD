
# PIPELINE PROJECT --> DATASET : Avocado Prices

    1.ACQUISITION

dataset = 'avocado.csv'

    2.WRANGLING

El data set no presentaba nulos ni duplicados. Tamaño:18248 rows x 14 cols

He realizado alguna transformación: convertir la columna fecha en mes; convertir el tipo de la columna año en objeto; dividir el volumen total entre 1000; borrar alguna columna, recolocar otras y cambiarlas de nombre.
Tambien he filtrado el registro, quitando los registros del año 2018 ya que solo habia hasta marzo.
Por último he dividido el dataset en 3, uno con ciudades, que no lo utilizo, otro con regiones de US, y otro con registros de todo US.

    3.ANALYSIS

-Son objeto de análisis: el precio medio por kilo y el volumen total vendido.
-Estos datos pueden calcularse en función de la variedad de aguacate, la zona y periodo.ç
-Volumen total = Size S-M + Size L + Size XL + Bags; Bags = S + L + XL

HIPÓTESIS:
-La variedad de aguacate convencional tendrá un precio medio inferior al aguacate orgánico.
-El precio medio se incrementará por año y variará según el mes (relacionado con producción)
-Las regiones donde el precio medio sea más alto presentarán un volument total de venta menor
-El % de cada tamaño y bolsas tendrán relación con el precio medio.

ANALISIS:
1.VARIEDAD vs AVG PRICE (df_totalUS)
2.VARIEDAD vs AVG PRICE (df_region)
3.VARIEDAD vs. TOTAL VOLUMEN
    Todo US por periodo: def period_vol(df_totalUS, Month)
    Regiones y año: def period_vol(df_region, Region)
4.BENEFICIOS TOTALES (K) - df_region
5.CORRELACIÓN entre el precio medio y el volumen total - df_region
6.PORCENTAJE DE APORTE AL VOLUMEN TOTAL - df_region

VISUALIZE
-Grafico boxplot del precio medio respecto a la variedad de aguacate
    Boxplot del precio medio de ambas variedades (dfa)
-Dos barplot, en un el precio medio y en otro el volumen total durante los meses del año.
    Barplot del volumen de venta por mes - title = 'Total volumen de venta por mes (2015, 2016 y 2017)' col = Total Volume-k
    Barplot del precio medio por mes - title = 'Precio medio de venta'; col = Avg Price
-Guardado de los gráficos en formato png

CONCLUSIONES:

-Efectivamente el aguacate orgánico es más caro que el convencional.
-Por año se observa que se ha incrementado el precio medio en 2017.
-Incremento precio medio no es lineal, en 2016 disminuyó.
-Hay una correlacion lineal negativa entre el precio medio y el volumen total de venta, aunque menos de lo que cabria esperar.
-El precio medio no depende solo del volumen de venta, intervienen mas factores.
-Se observa por años aumenta la venta de bolsas de aguacates, mientras que disminuye la venta de unidades individuales de todos los tamaños.
-La región con un volumen mayor de venta es California, también presenta el precio medio mas alto.
-Los meses con el precio medio mas alto (media todo US) son septiembre, octubre y noviembre. También son los que tienen un volumen de venta menor.