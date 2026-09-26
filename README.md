#  Ericsson Patent Evolution — Análisis Multi-Herramienta

Análisis exploratorio, estadístico y predictivo del dataset **Ericsson Innovation Timeline: Patent Evolution** (30,118 patentes, 1976-2025), implementado con 6 herramientas distintas para comparar enfoques y validar hallazgos de forma cruzada.

##  Objetivo

Explorar la evolución histórica de la innovación tecnológica de Ericsson a través de sus patentes, identificar tendencias tecnológicas clave (5G, AI/ML, IoT, Cloud), y comparar distintos enfoques de forecasting (estadístico clásico vs. Machine Learning) para predecir el volumen de patentes futuras.

## 🗂️ Dataset

- **Fuente**: Ericsson Innovation Timeline: Patent Evolution (Kaggle)
- **Tamaño**: 30,118 patentes individuales | 199 trimestres (1976-2025)
- **Columnas**: 55 features originales, incluyendo metadata, keywords tecnológicos, y features de series de tiempo (lags, rolling means, growth rates)

##  Herramientas y rol de cada una

| Herramienta | Rol en el proyecto | Carpeta |
|---|---|---|
| **Python** | Limpieza de datos, EDA (6 visualizaciones), Modelado ML (Ridge + Random Forest) | `/notebooks`, `/scripts` |
| **R** | Análisis estadístico formal de series de tiempo: descomposición STL, tests de estacionariedad, modelo ARIMA | `/R` |
| **SQL** | Consultas de validación y agregación sobre los datos limpios (SQLite) | `/sql` |
| **Excel** | Tablas dinámicas para vista ejecutiva rápida | `/excel` |
| **Power BI** | Dashboard interactivo de tendencias tecnológicas | `/powerbi` |
| **Tableau** | Dashboard de forecasting con pronóstico nativo | `/tableau` |

##  Hallazgos principales

1. **Dos ciclos de innovación**: la actividad de patentamiento no fue lineal. Se identifican dos "booms" (≈2000 y ≈2012-2025) separados por un período de estancamiento (2004-2010), coincidiendo con las revoluciones de 2G/3G y 4G/5G/smartphones respectivamente.

2. **Sin estacionalidad relevante**: los 4 trimestres del año muestran actividad de patentamiento similar; no existe un patrón estacional fuerte, confirmado tanto visualmente (Python) como estadísticamente (descomposición STL en R).

3. **Explosión tecnológica reciente**: Cloud/Edge lideró la adopción temprana (~2000), mientras que 5G, AI/ML e IoT explotaron después de 2020, coincidiendo con la era `modern_2020s`.

4. **ARIMA superó a los modelos de ML genéricos**: el modelo ARIMA(0,1,1) con drift (ajustado en R) obtuvo mejor desempeño (RMSE=29.05) que Ridge y Random Forest entrenados en Python, incluso después de resolver un problema de extrapolación fuera de rango reformulando el target como "cambio" en vez de "nivel absoluto".

5. **Validación cruzada exitosa**: los totales agregados (30,118 patentes, distribución por `tech_era`, promedio de `keyword_score`) coinciden exactamente entre Python, SQL, Excel y Power BI, confirmando la integridad del pipeline de datos.

## 📁 Estructura del repositorio

```
├── data/
│   ├── raw/                        # Dataset original
│   └── processed/                  # Datasets limpios (patent_level, quarterly_level)
├── notebooks/                      # Jupyter Notebooks (limpieza, EDA, ML)
├── R/                               # Script de series de tiempo y ARIMA
├── sql/                             # Base de datos SQLite y queries documentadas
├── excel/                           # Archivo con tablas dinámicas
├── powerbi/                         # Dashboard .pbix
├── tableau/                         # Dashboard .twb
└── screenshots/                     # Capturas de resultados clave
```

##  Cómo reproducir este análisis

1. Clona este repositorio
2. Los notebooks de Python requieren: `pandas`, `numpy`, `matplotlib`, `seaborn`, `scikit-learn`
3. El script de R requiere: `tidyverse`, `tseries`, `forecast`, `lubridate`
4. Los dashboards de Power BI/Tableau se abren directamente con sus respectivos programas (Power BI Desktop / Tableau Desktop)

## 👤 Autor

[Alonso Salazar Franco]
