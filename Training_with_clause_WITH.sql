SELECT
    cb.date,
    cb.country,
    cb.confirmed,
    c.life_expectancy 
FROM (
    SELECT 
        date,
        country,
        confirmed 
    FROM covid19_basic 
    WHERE country = 'Czechia'
      AND date = '2021-03-20'
) cb
LEFT JOIN countries c 
  ON cb.country = c.country 


  
  
WITH confirmed_cases AS (
-- asdasdasdasd
    SELECT 
        date,
        country,
        confirmed 
    FROM covid19_basic 
    WHERE 1=1
--       AND country = 'Czechia'
      AND date = '2021-03-20'
),
countries_updated AS (
-- sad asdas dasdasd asd
    SELECT 
        CASE WHEN country = 'Czech Republic' THEN 'Czechia' 
            WHEN country = 'Montenegro' THEN 'Monte negro'
            WHEN country = 'South Sudan' THEN 'south sudan'
            WHEN country = 'Sri Lanka' THEN 'sri lanka'
            WHEN country = 'Timor-Leste' THEN 'timor-leste'
            WHEN country = 'Burma' THEN 'burma'
            WHEN country = 'Cabo Verde' THEN 'cabo verde'
            WHEN country = 'Congo (Brazzaville)' THEN 'congo (brazzaville)'
            WHEN country = 'Congo (Kinshasa)' THEN 'congo (kinshasa)'
            WHEN country = 'Cote dIvoire' THEN 'cote divoire'
            WHEN country = 'Czechia' THEN 'czechia'
            WHEN country = 'Diamond Princess' THEN 'diamond princess'
            WHEN country = 'Eswatini' THEN 'eswatini'
            WHEN country = 'Fiji' THEN 'fiji'
            WHEN country = 'Holy See' THEN 'holy see'
            WHEN country = 'Korea, South' THEN 'korea, south'
            WHEN country = 'Kosovo' THEN 'kosovo'
            WHEN country = 'Libya' THEN 'libya'
            WHEN country = 'MS Zaandam' THEN 'ms zaandam'
            WHEN country = 'Micronesia' THEN 'micronesia'
            WHEN country = 'Russia' THEN 'russia'
            WHEN country = 'Taiwan*' THEN 'taiwan*'
            WHEN country = 'US' THEN 'us'
            WHEN country = 'West Bank and Gaza' THEN 'west bank and gaza'
            ELSE country END AS country,
        life_expectancy     
     FROM countries 
),
SELECT
    cb.date,
    cb.country,
    cb.confirmed,
    c.life_expectancy 
FROM confirmed_cases cb    
LEFT JOIN countries_updated c 
  ON cb.country = c.country 

  
  
  
  
WITH country AS (
    SELECT 
        count(distinct country) AS cntcountry
    FROM covid19_basic cb 
    WHERE date = '2021-03-10'  
),
overmil AS (
    SELECT 
        count(distinct country) AS cntcountry_over_mil
    FROM covid19_basic cb 
    WHERE date = '2021-03-10'     
      AND confirmed > 1000000
)
SELECT 
    cntcountry_over_mil/cntcountry*100 AS prc
FROM country base
CROSS JOIN overmil a



SELECT 
    sum(CASE WHEN confirmed>1000000 THEN 1 ELSE 0 END)/
    count(DISTINCT country)*100 AS prc
FROM covid19_basic cb 
WHERE date = '2021-03-10'


SELECT 
    count(DISTINCT CASE WHEN confirmed>1000000 THEN country END)/
    count(DISTINCT country)*100 AS prc
FROM covid19_basic cb 
WHERE date = '2021-03-10' 
  
