-- 1.hustota zalidnění - ve státech s vyšší hustotou zalidnění se nákaza může šířit rychleji

CREATE TABLE countries_updated_v001 AS 
SELECT e.country, e2.date,
   		round( ( e.confirmed - e2.confirmed ), 2 ) as confirmed_per_day,
	CASE WHEN e2.country = 'Montenegro' THEN 'chybi data'
		WHEN e2.country = 'Timor-Leste' THEN 'chybi data'
		WHEN e2.country = 'Burma' THEN 'nenachazi se v tabulce'
		WHEN e2.country = 'Cabo Verde' THEN 'nenachazi se v tabulce'
		WHEN e2.country = 'Congo (Brazzaville)' THEN 'Congo'
		WHEN e2.country = 'Congo (Kinshasa)' THEN 'Congo'
		WHEN e2.country = 'Cote d Ivoire' THEN 'nenachazi se v tabulce'
		WHEN e2.country = 'Czechia' THEN 'Czech Republic'
		WHEN e2.country = 'Diamond Princess' THEN 'nenachazi se v tabulce'
		WHEN e2.country = 'Eswatini' THEN 'nenachazi se v tabulce'
		WHEN e2.country = 'Fiji' THEN 'Fiji Islands'
		WHEN e2.country = 'Holy See' THEN 'Holy See (Vatican City State)'
		WHEN e2.country = 'Korea, South' THEN 'nenachazi se v tabulce'
		WHEN e2.country = 'Kosovo' THEN 'nenachazi se v tabulce'
		WHEN e2.country = 'Libya' THEN 'Libyan Arab Jamahiriya'
		WHEN e2.country = 'MS Zaandam' THEN 'nenachazi se v tabulce'
		WHEN e2.country = 'Micronesia' THEN 'Micronesia, Federated States of'
		WHEN e2.country = 'Russia' THEN 'Russian Federation'
		WHEN e2.country = 'Taiwan*' THEN 'nenachazi se v tabulce'
		WHEN e2.country = 'US' THEN 'United States'
		WHEN e2.country = 'West Bank and Gaza' THEN 'nenachazi se v tabulce'
		ELSE e2.country END AS coun
FROM covid19_basic e 
JOIN covid19_basic e2 
 	ON e.country = e2.country
	AND e.date = e2.date - 1
;
    	

UPDATE countries_updated_v001 c
     SET c.confirmed_per_day = REPLACE (c.confirmed_per_day, '-', '')
     WHERE c.confirmed_per_day LIKE '%-%'
;

WITH confirmed_cases AS (
	SELECT 
		country,
		population_density,
		population
	FROM countries 
	WHERE 1=1
),
joinment AS 
(
SELECT cu.coun, cu.date, cc.population, cc.population_density, cu.confirmed_per_day
FROM confirmed_cases cc
LEFT JOIN countries_updated_v001 cu
	ON cc.country = cu.coun
)
SELECT jm.coun, jm.date, jm.confirmed_per_day, jm.population, jm.population_density, ct.tests_performed
FROM joinment jm
LEFT JOIN covid19_tests ct
ON jm.coun = ct.country
AND jm.date = ct.date
WHERE tests_performed IS NOT NULL AND tests_performed != 0 

-- Vyreseni kumulativniho poctu v confirmed
SELECT e.country, e.date, 
    round( ( e.confirmed - e2.confirmed ), 2 ) as confirmed_per_day
FROM covid19_basic e 
JOIN covid19_basic e2 
    ON e.country = e2.country
    AND e.date = e2.date + 1
WHERE e.country = 'Italy' AND e2.date = '2020-11-04'

-- 2.HDP na obyvatele - použijeme jako indikátor ekonomické vyspělosti státu - hotovo

WITH confirmed_cases AS (
	SELECT GDP, population, year,
		CASE WHEN country = 'Africa Eastern and Southern' THEN 'null'
			WHEN country = 'Africa Western and Central' THEN 'null'
			WHEN country = 'Arab World' THEN 'null'
			WHEN country = 'Caribbean small states' THEN 'null'
			WHEN country = 'Central Europe and the Baltics' THEN 'null'
			WHEN country = 'Early-demographic dividend' THEN 'null'
			WHEN country = 'East Asia & Pacific' THEN 'null'
			WHEN country = 'East Asia & Pacific (excluding high income)' THEN 'null'
			WHEN country = 'East Asia & Pacific (IDA & IBRD countries)' THEN 'null'
			WHEN country = 'Euro area' THEN 'null'
			WHEN country = 'Europe & Central Asia' THEN 'null'
			WHEN country = 'Europe & Central Asia (excluding high income)' THEN 'null'
			WHEN country = 'Europe & Central Asia (IDA & IBRD countries)' THEN 'null'
			WHEN country = 'European Union' THEN 'null'
			WHEN country = 'Fragile and conflict affected situations' THEN 'null'
			WHEN country = 'Heavily indebted poor countries (HIPC)' THEN 'null'
			WHEN country = 'High income' THEN 'null'
			WHEN country = 'IBRD only' THEN 'null'
			WHEN country = 'IDA & IBRD total' THEN 'null'
			WHEN country = 'IDA blend' THEN 'null'
			WHEN country = 'IDA only' THEN 'null'
			WHEN country = 'IDA total' THEN 'null'
			WHEN country = 'Late-demographic dividend' THEN 'null'
			WHEN country = 'Latin America & Caribbean' THEN 'null'
			WHEN country = 'Latin America & Caribbean (excluding high income)' THEN 'null'
			WHEN country = 'Latin America & the Caribbean (IDA & IBRD countries)' THEN 'null'
			WHEN country = 'Least developed countries: UN classification' THEN 'null'
			WHEN country = 'Low & middle income' THEN 'null'
			WHEN country = 'Low income' THEN 'null'
			WHEN country = 'Lower middle income' THEN 'null'
			WHEN country = 'Middle East & North Africa' THEN 'null'
			WHEN country = 'Middle East & North Africa (excluding high income)' THEN 'null'
			WHEN country = 'Middle East & North Africa (IDA & IBRD countries)' THEN 'null'
			WHEN country = 'Middle income' THEN 'null'
			WHEN country = 'North America' THEN 'null'
			WHEN country = 'Not classified' THEN 'null'
			WHEN country = 'OECD members' THEN 'null'
			WHEN country = 'Other small states' THEN 'null'
			WHEN country = 'Pacific island small states' THEN 'null'
			WHEN country = 'Post-demographic dividend' THEN 'null'
			WHEN country = 'Pre-demographic dividend' THEN 'null'
			WHEN country = 'Small states' THEN 'null'
			WHEN country = 'South Asia' THEN 'null'
			WHEN country = 'South Asia (IDA & IBRD)' THEN 'null'
			WHEN country = 'Sub-Saharan Africa' THEN 'null'
			WHEN country = 'Sub-Saharan Africa (excluding high income)' THEN 'null'
			WHEN country = 'Sub-Saharan Africa (IDA & IBRD countries)' THEN 'null'
			WHEN country = 'Upper middle income' THEN 'null'
			WHEN country = 'World' THEN 'null'
			ELSE country END AS coun
	FROM economies
)
select distinct coun, round(GDP/population) as gdp_per_person, population
from confirmed_cases
where coun != 'null' and round(GDP/population) is not null
group by coun
; 


-- 4.dětská úmrtnost - použijeme jako indikátor kvality zdravotnictví - hotovo
SELECT b.country, a.population, a.year, round (sum (a.mortaliy_under5))
FROM economies AS a
LEFT JOIN countries AS b
ON a.country = b.country
WHERE a.mortaliy_under5 IS NOT NULL 
group BY b.country 
ORDER BY sum(a.mortaliy_under5) 

WITH confirmed_cases AS (
			select year ,mortaliy_under5,
					CASE WHEN country = 'Africa Eastern and Southern' THEN 'null'
						WHEN country = 'Africa Western and Central' THEN 'null'
						WHEN country = 'Arab World' THEN 'null'
						WHEN country = 'Caribbean small states' THEN 'null'
						WHEN country = 'Central Europe and the Baltics' THEN 'null'
						WHEN country = 'Early-demographic dividend' THEN 'null'
						WHEN country = 'East Asia & Pacific' THEN 'null'
						WHEN country = 'East Asia & Pacific (excluding high income)' THEN 'null'
						WHEN country = 'East Asia & Pacific (IDA & IBRD countries)' THEN 'null'
						WHEN country = 'Euro area' THEN 'null'
						WHEN country = 'Europe & Central Asia' THEN 'null'
						WHEN country = 'Europe & Central Asia (excluding high income)' THEN 'null'
						WHEN country = 'Europe & Central Asia (IDA & IBRD countries)' THEN 'null'
						WHEN country = 'European Union' THEN 'null'
						WHEN country = 'Fragile and conflict affected situations' THEN 'null'
						WHEN country = 'Heavily indebted poor countries (HIPC)' THEN 'null'
						WHEN country = 'High income' THEN 'null'
						WHEN country = 'IBRD only' THEN 'null'
						WHEN country = 'IDA & IBRD total' THEN 'null'
						WHEN country = 'IDA blend' THEN 'null'
						WHEN country = 'IDA only' THEN 'null'
						WHEN country = 'IDA total' THEN 'null'
						WHEN country = 'Late-demographic dividend' THEN 'null'
						WHEN country = 'Latin America & Caribbean' THEN 'null'
						WHEN country = 'Latin America & Caribbean (excluding high income)' THEN 'null'
						WHEN country = 'Latin America & the Caribbean (IDA & IBRD countries)' THEN 'null'
						WHEN country = 'Least developed countries: UN classification' THEN 'null'
						WHEN country = 'Low & middle income' THEN 'null'
						WHEN country = 'Low income' THEN 'null'
						WHEN country = 'Lower middle income' THEN 'null'
						WHEN country = 'Middle East & North Africa' THEN 'null'
						WHEN country = 'Middle East & North Africa (excluding high income)' THEN 'null'
						WHEN country = 'Middle East & North Africa (IDA & IBRD countries)' THEN 'null'
						WHEN country = 'Middle income' THEN 'null'
						WHEN country = 'North America' THEN 'null'
						WHEN country = 'OECD members' THEN 'null'
						WHEN country = 'Other small states' THEN 'null'
						WHEN country = 'Pacific island small states' THEN 'null'
						WHEN country = 'Post-demographic dividend' THEN 'null'
						WHEN country = 'Pre-demographic dividend' THEN 'null'
						WHEN country = 'Small states' THEN 'null'
						WHEN country = 'South Asia' THEN 'null'
						WHEN country = 'South Asia (IDA & IBRD)' THEN 'null'
						WHEN country = 'Sub-Saharan Africa' THEN 'null'
						WHEN country = 'Sub-Saharan Africa (excluding high income)' THEN 'null'
						WHEN country = 'Sub-Saharan Africa (IDA & IBRD countries)' THEN 'null'
						WHEN country = 'Upper middle income' THEN 'null'
						WHEN country = 'World' THEN 'null'
						ELSE country END AS coun
FROM economies
)
select coun, year, mortaliy_under5
from confirmed_cases
where mortaliy_under5 is not null and coun != 'null'
group by coun, year

-- 6.podíly jednotlivých náboženství - použijeme jako proxy proměnnou pro kulturní specifika. Pro každé náboženství v daném státě bych chtěl procentní podíl jeho příslušníků na celkovém obyvatelstvu - hotovo


SELECT r.country , r.religion , 
    round( r.population / r2.total_population_2020 * 100, 2 ) as religion_share_2020
FROM religions r 
JOIN (
        SELECT r.country , r.year,  sum(r.population) as total_population_2020
        FROM religions r 
        WHERE r.year = 2020 and r.country != 'All Countries'
        GROUP BY r.country
    ) r2
    ON r.country = r2.country
    AND r.year = r2.year
    AND r.population > 0
; 


-- UPRAVA TABULEK - ODSTRANENI SPECIALNICH ZNAKU Z TABULKY

UPDATE weather c
	SET c.rain = REPLACE(c.rain, ' mm', '')
	WHERE c.rain LIKE '% mm%';


UPDATE weather c
     SET c.temp = REPLACE (c.temp, '°c', '')
     WHERE c.temp LIKE '%°c%';
    
    
UPDATE weather c
     SET c.temp = REPLACE (c.temp, ' ', '')
     WHERE c.temp LIKE '% %';
    
 
ALTER TABLE weather
MODIFY temp int(11);

ALTER TABLE weather
MODIFY rain float(11);
     
UPDATE weather c
     SET c.date = REPLACE (c.date, ' 00:00:00.000', '')
     WHERE c.date LIKE '% 00:00:00.000%';
     
    
    
SELECT *
FROM weather w 
WHERE city = 'Amsterdam' AND date = '2020-01-04'
;
    


-- 01 průměrná denní (nikoli noční!) teplota - hotovo
SELECT date, city, avg(temp) as prumer_temp
FROM weather
WHERE time >= '06:00' AND time <= '18:00' AND city != '' 
GROUP BY date, city
ORDER BY date
;

-- 02 počet hodin v daném dni, kdy byly srážky nenulové - hotovo
SELECT date, city, (count(cast(time_to_sec(time) / (60 * 60) AS decimal(10, 1))))*3 AS pocet_hodin
FROM weather
WHERE rain >= '0.1' AND city != '' AND time >= '06:00' AND time <= '18:00' 
GROUP BY date, city
ORDER BY city, date
;


-- 03 maximální síla větru v nárazech během dne - hotovo
SELECT city, date, max(gust) as max_vitr
FROM weather
WHERE city != '' AND time >= '06:00' AND time <= '18:00'
GROUP BY date, city
ORDER BY city, date
;





-- 1.binární proměnná pro víkend / pracovní den
-- 2.roční období daného dne (zakódujte prosím jako 0 až 3)
WITH date_form AS (
SELECT *, DATE_FORMAT(date,'%w') AS dates
FROM covid19_basic_differences 
), 
promenne_pro_vikend AS (
SELECT date, DATE_FORMAT(date,'%m') AS mesice,
	CASE WHEN dates = 0 OR dates = 6 THEN 'vikend'
	ELSE 'pracovni_den'
	END AS dny
FROM date_form
ORDER BY date desc 
),
rocni_obdobi_daneho_dne AS (
SELECT date, dny,
	CASE WHEN mesice >= 01 and mesice <= 03 THEN '0'
	WHEN mesice >= 04 AND mesice <= 07 THEN '1'
	WHEN mesice >= 08 AND mesice <= 09 THEN '2'
	WHEN mesice >= 10 AND mesice <= 12 THEN '3'
	ELSE 'chyba'
	END AS jaro_leto_podzim_zima
FROM promenne_pro_vikend
ORDER BY date
)
select *
from rocni_obdobi_daneho_dne


