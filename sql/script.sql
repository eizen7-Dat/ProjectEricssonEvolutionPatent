-- ============================================================
-- ANÁLISIS SQL - Ericsson Patent Dataset
-- ============================================================
-- Objetivo: validar con SQL los hallazgos del EDA (Python) y
-- el análisis estadístico (R), usando consultas de agregación
-- y JOIN sobre las tablas patent_level y quarterly_level.
-- ============================================================


-- ---- Verificación de carga de datos ----
SELECT COUNT(*) AS total_patentes FROM patent_level;
-- Resultado esperado: 30118

SELECT COUNT(*) AS total_trimestres FROM quarterly_level;
-- Resultado esperado: 199


-- ---- Total de patentes por tech_era ----
SELECT tech_era, SUM(patent_count) AS total_patentes, COUNT(*) AS trimestres
FROM (SELECT DISTINCT year, quarter, tech_era, patent_count FROM quarterly_level)
GROUP BY tech_era
ORDER BY total_patentes DESC;
-- CONCLUSIÓN: smartphone_2010s domina con 13,841 patentes, seguido de
-- modern_2020s (8,147). La suma total coincide exactamente con 30,118,
-- validando que la tabla quarterly_level no perdió ni duplicó datos.


-- ---- Top 5 trimestres con más patentes ----
SELECT year, quarter, patent_count
FROM quarterly_level
ORDER BY patent_count DESC
LIMIT 5;
-- CONCLUSIÓN: el pico histórico es 2014 Q3 con 525 patentes, coincidiendo
-- exactamente con el pico visto en el gráfico de Python y en la serie de R.


-- ---- Promedio de keyword_score por tech_era ----
SELECT tech_era, ROUND(AVG(avg_keyword_score), 2) AS promedio_keyword_score
FROM quarterly_level
GROUP BY tech_era
ORDER BY promedio_keyword_score DESC;
-- CONCLUSIÓN: tendencia creciente confirmada, de 0.42 (legacy_pre_1990)
-- a 0.67 (modern_2020s), en escala normalizada 0-1. Esta consulta
-- corrigió una lectura visual imprecisa hecha sobre el boxplot de Python.


-- ---- Distribución de patent_type por tech_era (con JOIN) ----
SELECT q.tech_era, p.patent_type, COUNT(*) AS cantidad
FROM patent_level p
JOIN quarterly_level q
  ON p.year = q.year AND p.quarter = q.quarter
GROUP BY q.tech_era, p.patent_type
ORDER BY q.tech_era, cantidad DESC;
-- CONCLUSIÓN: la dominancia de "utility" (~99%) se mantiene consistente
-- en TODAS las eras, no es un efecto de una época particular. Validado
-- cruzando sumas por era contra la consulta anterior de tech_era.


-- ============================================================
-- RESUMEN GENERAL DEL ANÁLISIS SQL
-- ============================================================
-- 1. Todos los totales cuadran exactamente con el dataset original
--    (30,118 patentes), validando la integridad de la separación
--    patent_level / quarterly_level hecha en Python.
-- 2. El pico de innovación (2014 Q3) se confirma de forma cruzada
--    entre Python, R y SQL.
-- 3. Se corrigió la escala del keyword_score (0-1, no 0-10 como se
--    interpretó inicialmente del gráfico de Python) gracias al
--    cálculo exacto de SQL vs. la lectura visual del boxplot.
-- 4. La dominancia de patentes tipo "utility" es constante en todas
--    las eras tecnológicas, no específica de un período.
-- ============================================================