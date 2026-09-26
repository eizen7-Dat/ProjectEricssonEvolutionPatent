# ==============================================================
# ANÁLISIS ESTADÍSTICO DE SERIES DE TIEMPO - Ericsson Patent Dataset
# ==============================================================
# Objetivo: complementar el EDA de Python con un análisis formal
# de series de tiempo: descomposición estacional, tests de
# estacionariedad y modelo ARIMA como forecasting clásico.
#
# Dataset: quarterly_level_clean.csv (199 trimestres, 1976-2025)
# ==============================================================
library(tidyverse)
library(tseries)
library(forecast)
library(lubridate)

quarterly <- read_csv("data/processed/quarterly_level_clean.csv")
glimpse(quarterly)


patentes_ts <- ts(quarterly$patent_count, start = c(1976, 1), frequency = 4)
plot(patentes_ts, main = "Serie de tiempo: Patentes trimestrales de Ericsson",
     ylab = "Cantidad de patentes", xlab = "Año")


# ---- Descomposición estacional (STL) ----
# Separa la serie en tendencia, estacionalidad y residuo.
descomposicion <- stl(patentes_ts, s.window = "periodic")
plot(descomposicion)
# CONCLUSIÓN: la componente 'seasonal' tiene una amplitud pequeña
# (~-8 a +4) comparada con el rango total de la serie (0-500+),
# confirmando que la estacionalidad es un efecto menor frente a
# la tendencia de largo plazo. La componente 'trend' muestra
# claramente los dos ciclos de boom (2000 y 2012+) identificados
# en el EDA de Python.





# Test de Dickey-Fuller Aumentado (ADF)
# H0: la serie NO es estacionaria (tiene raíz unitaria)
adf.test(patentes_ts)

# Test KPSS
# H0: la serie SÍ es estacionaria (al contrario del ADF)
kpss.test(patentes_ts)
# CONCLUSIÓN: ADF p-value=0.47 (no estacionaria) y KPSS p-value<0.05
# (no estacionaria) COINCIDEN en el mismo diagnóstico: la serie
# tiene tendencia y no es estacionaria en su forma original.






patentes_diff <- diff(patentes_ts)
plot(patentes_diff, main = "Serie diferenciada (1er orden)")

adf.test(patentes_diff)
# CONCLUSIÓN: con d=1 (una diferenciación), el ADF da p-value=0.01,
# es decir, la serie diferenciada SÍ es estacionaria.
# d=1 es el orden de diferenciación correcto para el ARIMA.




# ---- Modelo ARIMA automático ----
modelo_arima <- auto.arima(patentes_ts, seasonal = TRUE)
summary(modelo_arima)
# CONCLUSIÓN: el modelo seleccionado es ARIMA(0,1,1) con drift.
# - d=1 confirma la diferenciación necesaria (ya validada arriba)
# - "with drift" indica una tendencia de crecimiento constante
#   (~1.98 patentes/trimestre), consistente con el crecimiento
#   sostenido observado en la era moderna del dataset
# - auto.arima() NO incluyó componente estacional (P,D,Q) pese a
#   seasonal=TRUE, confirmando que la estacionalidad trimestral
#   es demasiado débil para ser relevante en el modelo
# - RMSE=29.05, MAE=18.76: error moderado dado el rango de la
#   serie (5 a 500+ patentes/trimestre)







# ---- Forecast: próximos 8 trimestres (2 años) ----
pronostico <- forecast(modelo_arima, h = 8)  # 8 trimestres = 2 años a futuro
plot(pronostico, main = "Pronóstico ARIMA: Patentes de Ericsson (próximos 8 trimestres)")
print(pronostico)
# CONCLUSIÓN: el modelo proyecta continuidad de la tendencia
# reciente (~400-415 patentes/trimestre), sin estacionalidad
# visible en la predicción. Los intervalos de confianza se
# amplían con el horizonte (de ±57 a ±112 en 95%), como es
# esperado en cualquier forecast.
#
# LIMITACIÓN: el modelo asume que el futuro se parece al pasado
# reciente. No puede anticipar disrupciones tecnológicas nuevas
# (un tercer "boom" no vendría reflejado hasta que ya esté
# ocurriendo en los datos).





# ==============================================================
# RESUMEN GENERAL DEL ANÁLISIS EN R
# ==============================================================
# 1. La serie de patentes NO es estacionaria (confirmado por
#    ADF y KPSS) debido a su tendencia de largo plazo.
# 2. La estacionalidad trimestral es débil/irrelevante, tanto
#    en la descomposición STL como en la selección automática
#    del modelo ARIMA.
# 3. El mejor modelo encontrado es ARIMA(0,1,1) con drift,
#    reflejando crecimiento sostenido sin ciclos estacionales.
# 4. El forecast proyecta un ritmo estable de ~400-415
#    patentes/trimestre para los próximos 2 años.
#
# Estas conclusiones son consistentes con el EDA realizado en
# Python: dos ciclos de boom en lugar de estacionalidad anual.
# ==============================================================


