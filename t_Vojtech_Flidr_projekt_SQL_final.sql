-- Dobrý den,

-- snažím se určit faktory, které ovlivňují rychlost šíření koronaviru na úrovni jednotlivých států. Chtěl bych Vás, coby datového analytika, požádat o pomoc s přípravou dat, která potom 
-- budu statisticky zpracovávat. Prosím Vás o dodání dat podle požadavků sepsaných níže.

-- Výsledná data budou panelová, klíče budou stát (country) a den (date). Budu vyhodnocovat model, který bude vysvětlovat denní nárůsty nakažených v jednotlivých zemích. 
-- Samotné počty nakažených mi nicméně nejsou nic platné - je potřeba vzít v úvahu také počty provedených testů a počet obyvatel daného státu. Z těchto tří proměnných je potom možné vytvořit 
-- vhodnou vysvětlovanou proměnnou. Denní počty nakažených chci vysvětlovat pomocí proměnných několika typů. Každý sloupec v tabulce bude představovat jednu proměnnou. Chceme získat následující sloupce:

-- Task_01 (T1) - Časové proměnné
-- T1_Ukol_01 - binární proměnná pro víkend / pracovní den
-- T1_Ukol_02 - roční období daného dne (zakódujte prosím jako 0 až 3)

-- Task_02 (T2) - Proměnné specifické pro daný stát
-- T2_Ukol_01 - hustota zalidnění - ve státech s vyšší hustotou zalidnění se nákaza může šířit rychleji
-- T2_Ukol_02 - HDP na obyvatele - použijeme jako indikátor ekonomické vyspělosti státu
-- T2_Ukol_03 - GINI koeficient - má majetková nerovnost vliv na šíření koronaviru?
-- T2_Ukol_04 - dětská úmrtnost - použijeme jako indikátor kvality zdravotnictví
-- T2_Ukol_05 - medián věku obyvatel v roce 2018 - státy se starším obyvatelstvem mohou být postiženy více
-- T2_Ukol_06 - podíly jednotlivých náboženství - použijeme jako proxy proměnnou pro kulturní specifika. Pro každé náboženství v daném státě bych chtěl procentní podíl jeho příslušníků na celkovém obyvatelstvu
-- T2_Ukol_07 - rozdíl mezi očekávanou dobou dožití v roce 1965 a v roce 2015 - státy, ve kterých proběhl rychlý rozvoj mohou reagovat jinak než země, které jsou vyspělé už delší dobu

-- Task_03 (T3) - Počasí (ovlivňuje chování lidí a také schopnost šíření viru)
-- T3_Ukol_01 - průměrná denní (nikoli noční!) teplota
-- T3_Ukol_02 - počet hodin v daném dni, kdy byly srážky nenulové
-- T3_Ukol_03 - maximální síla větru v nárazech během dne

-- Napadají Vás ještě nějaké další proměnné, které bychom mohli použít? Pokud vím, měl(a) byste si vystačit s daty z následujících tabulek: countries, economies, life_expectancy, religions, covid19_basic_differences, covid19_testing, weather, lookup_table.

-- V případě nejasností se mě určitě zeptejte.

-- S pozdravem, Student (a.k.a. William Gosset)

-- Výstup: Pomozte Vašemu kolegovi s daným úkolem. Výstupem by měla být tabulka na databázi, ze které se požadovaná data dají získat jedním selectem. Tabulku pojmenujte t_{jméno}_{příjmení}_projekt_SQL_final. 

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- UPRAVA TABULEK
CREATE TABLE life_expectancy_edited AS (
SELECT *,
	CASE WHEN country = 'British Virgin Islands' THEN 'Virgin Islands, British'
		WHEN country = 'Faeroe Islands' THEN 'Faroe Islands'
		WHEN country = 'Fiji' THEN 'Fiji Islands'
		WHEN country = 'Micronesia (country)' THEN 'Micronesia, Federated States of'
		WHEN country = 'Timor' THEN 'Timor-Leste'
		WHEN country = 'United States Virgin Islands' THEN 'Virgin Islands, U.S.'
		ELSE country END AS coun
FROM life_expectancy 
)
;
CREATE TABLE economies_edited AS (
SELECT *,
	CASE WHEN country = 'Bahamas, The' THEN 'Bahamas'
		WHEN country = 'British Virgin Islands' THEN 'Virgin Islands, British'
		WHEN country = 'Brunei Darussalam' THEN 'Brunei'
		WHEN country = 'Cabo Verde' THEN 'Cape Verde'
		WHEN country = 'Fiji' THEN 'Fiji Islands'
		WHEN country = 'Korea, Dem. Peoples Rep.' THEN 'North Korea'
		WHEN country = 'Libya' THEN 'Libyan Arab Jamahiriya'
		WHEN country = 'Macao SAR, China' THEN 'Macao'
		WHEN country = 'Micronesia, Fed. Sts.' THEN 'Micronesia, Federated States of'
		WHEN country = 'St. Kitts and Nevis' THEN 'Saint Kitts and Nevis'
		WHEN country = 'St. Lucia' THEN 'Saint Lucia'
		WHEN country = 'St. Vincent and the Grenadines' THEN 'Saint Vincent and the Grenadines'
		WHEN country = 'Virgin Islands (U.S.)' THEN 'Virgin Islands, U.S.'
		ELSE country END AS coun
FROM economies 
)
;
CREATE TABLE covid19_tests_edited AS (
SELECT *,
	CASE WHEN country = 'Democratic Republic of Congo' THEN 'Congo'
		WHEN country = 'Fiji' THEN 'Fiji Islands'
		WHEN country = 'Libya' THEN 'Libyan Arab Jamahiriya'
		WHEN country = 'Russia' THEN 'Russian Federation'
		ELSE country END AS coun
FROM covid19_tests
)
;
CREATE TABLE covid19_basic_differences_edited AS (
SELECT *,
	CASE WHEN country = 'Cabo Verde' THEN 'Cape Verde'
		WHEN country = 'Czechia' THEN 'Czech Republic'
		WHEN country = 'Fiji' THEN 'Fiji Islands'
		WHEN country = 'Holy See' THEN 'Holy See (Vatican City State)'
		WHEN country = 'Korea, South' THEN 'Kiribati'
		WHEN country = 'Libya' THEN 'Libyan Arab Jamahiriya'
		WHEN country = 'Micronesia' THEN 'Micronesia, Federated States of'
		WHEN country = 'Russia' THEN 'Russian Federation'
		WHEN country = 'Taiwan*' THEN 'Taiwan'
		WHEN country = 'West Bank and Gaza' THEN 'Wallis and Futuna'
		ELSE country END AS coun
FROM covid19_basic_differences
)
;
CREATE TABLE covid19_basic_edited AS (
SELECT *,
	CASE WHEN country = 'Cabo Verde' THEN 'Cape Verde'
		WHEN country = 'Czechia' THEN 'Czech Republic'
		WHEN country = 'Fiji' THEN 'Fiji Islands'
		WHEN country = 'Holy See' THEN 'Holy See (Vatican City State)'
		WHEN country = 'Korea, South' THEN 'Kiribati'
		WHEN country = 'Libya' THEN 'Libyan Arab Jamahiriya'
		WHEN country = 'Micronesia' THEN 'Micronesia, Federated States of'
		WHEN country = 'Russia' THEN 'Russian Federation'
		WHEN country = 'Taiwan*' THEN 'Taiwan'
		WHEN country = 'US' THEN 'United States'
		WHEN country = 'West Bank and Gaza' THEN 'Wallis and Futuna'
		ELSE country END AS coun
FROM covid19_basic
)
;
CREATE TABLE religions_edited AS (
SELECT *,
	CASE WHEN country = 'British Virgin Islands' THEN 'Virgin Islands, British'
		WHEN country = 'Faeroe Islands' THEN 'Faroe Islands'
		WHEN country = 'Federated States of Micronesia' THEN 'Micronesia, Federated States of'
		WHEN country = 'Fiji' THEN 'Fiji Islands'
		WHEN country = 'Macau' THEN 'Macao'
		WHEN country = 'Sint Maarten' THEN 'Saint Martin (French part)'
		WHEN country = 'St. Kitts and Nevis' THEN 'Saint Kitts and Nevis'
		WHEN country = 'St. Lucia' THEN 'Saint Lucia'
		WHEN country = 'St. Vincent and the Grenadines' THEN 'Saint Vincent and the Grenadines'
		WHEN country = 'U.S. Virgin Islands' THEN 'United States Virgin Islands'
		ELSE country END AS coun
FROM religions
)
;
UPDATE weather c
	SET c.rain = REPLACE(c.rain, ' mm', '')
	WHERE c.rain LIKE '% mm%';
;

UPDATE weather c
     SET c.temp = REPLACE (c.temp, '°c', '')
     WHERE c.temp LIKE '%°c%';
;    
    
UPDATE weather c
     SET c.temp = REPLACE (c.temp, ' ', '')
     WHERE c.temp LIKE '% %';
;    
 
ALTER TABLE weather
MODIFY temp int(11);
;
ALTER TABLE weather
MODIFY rain float(11);
;   
UPDATE weather c
     SET c.date = REPLACE (c.date, ' 00:00:00.000', '')
     WHERE c.date LIKE '% 00:00:00.000%'
     
-- T1_Ukol_01 - binární proměnná pro víkend / pracovní den
-- T1_Ukol_02 - roční období daného dne (zakódujte prosím jako 0 až 3)
;
CREATE TABLE dateformat AS 
SELECT *, DATE_FORMAT(date,'%w') AS dates
FROM covid19_basic_differences_edited 
;
CREATE TABLE task01_ukol_01_v002 AS 
SELECT coun, date, DATE_FORMAT(date,'%m') AS mesice,
	CASE WHEN dates = 0 OR dates = 6 THEN 'vikend'
	ELSE 'pracovni_den'
	END AS dny
FROM dateformat
ORDER BY date desc 
;
CREATE TABLE task01_ukol_02_v002 AS
SELECT coun, date, dny,
	CASE WHEN mesice >= 01 and mesice <= 03 THEN '0'
	WHEN mesice >= 04 AND mesice <= 07 THEN '1'
	WHEN mesice >= 08 AND mesice <= 09 THEN '2'
	WHEN mesice >= 10 AND mesice <= 12 THEN '3'
	ELSE 'chyba'
	END AS jaro_leto_podzim_zima
FROM task01_ukol_01_v002
ORDER BY date  
-- -----------------------------------------------------------------------------------------------------------------------------
;
CREATE TABLE joinment_01 AS (
SELECT e.coun, e.date, 
   		round( ( e.confirmed - e2.confirmed ), 2 ) as confirmed_per_day
FROM covid19_basic_edited e 
LEFT JOIN covid19_basic_edited e2 
 	ON e.coun = e2.coun
	AND e.date = e2.date - 1
WHERE e.coun IS NOT NULL
ORDER BY e.coun
)
-- -----------------------------------------------------------------------------------------------------------------------------
;
-- T2_Ukol_01 - hustota zalidnění - ve státech s vyšší hustotou zalidnění se nákaza může šířit rychleji
-- T2_Ukol_05 - medián věku obyvatel v roce 2018 - státy se starším obyvatelstvem mohou být postiženy více
CREATE TABLE joinment_02 as (
WITH population_table AS (
SELECT 
		cc.country,
		cc.population_density,
		cc.population,
		cc.median_age_2018,
		cc.life_expectancy
FROM countries cc
WHERE 1=1 
),
joinment AS (
SELECT hu.coun, hu.date, ro.dny, ro.jaro_leto_podzim_zima, hu.confirmed_per_day
FROM task01_ukol_02_v002 ro
LEFT JOIN joinment_01 hu
	ON ro.coun = hu.coun
	AND ro.date = hu.date
)
SELECT jf.coun, jf.date, jf.dny, jf.jaro_leto_podzim_zima, jf.confirmed_per_day, cc.population_density, cc.population, cc.median_age_2018, cc.life_expectancy
FROM joinment jf
LEFT JOIN population_table cc
	ON cc.country = jf.coun
WHERE jf.coun IS NOT NULL AND jf.coun != ' '
ORDER BY jf.coun, jf.date
)
-- -----------------------------------------------------------------------------------------------------------------------------
;
-- T2_Ukol_02 - HDP na obyvatele - použijeme jako indikátor ekonomické vyspělosti státu
-- T2_Ukol_03 - GINI koeficient - má majetková nerovnost vliv na šíření koronaviru?
-- T2_Ukol_04 - dětská úmrtnost - použijeme jako indikátor kvality zdravotnictví
create table joinment_03 AS (
WITH GDP_per_person AS (
SELECT coun, round (GDP/population,2) as gdp_per_person, mortaliy_under5, GDP, population, YEAR, gini
FROM economies_edited
WHERE YEAR = '2018'
),
joinment AS (
SELECT jm.coun, jm.date, ct.tests_performed, jm.confirmed_per_day, jm.dny, jm.jaro_leto_podzim_zima, jm.population_density, jm.population, jm.median_age_2018, jm.life_expectancy
FROM joinment_02 jm
LEFT JOIN covid19_tests_edited ct
	ON jm.coun = ct.coun
	AND jm.date = ct.date
)
SELECT jm.coun, jm.date, jm.tests_performed, jm.confirmed_per_day, jm.dny, jm.jaro_leto_podzim_zima, jm.population_density, jm.population, jm.median_age_2018, jm.life_expectancy, gd.gdp_per_person, gd.mortaliy_under5, gd.gini
FROM joinment jm
LEFT JOIN GDP_per_person gd
	ON jm.coun = gd.coun
)
-- -----------------------------------------------------------------------------------------------------------------------------
;
-- T2_Ukol_06 - podíly jednotlivých náboženství - použijeme jako proxy proměnnou pro kulturní specifika. Pro každé náboženství v daném státě bych chtěl procentní podíl jeho příslušníků na celkovém obyvatelstvu
CREATE TABLE nabozenstvi AS (
WITH Christianity AS (
SELECT r.coun, r.religion, round( r.population / r2.total_population_2020 * 100, 2 ) AS Christianity
FROM religions_edited r 
JOIN (
        SELECT r.coun , r.year,  sum(r.population) as total_population_2020
        FROM religions_edited r 
        WHERE r.year = '2020' and r.coun != 'All Countries'
        GROUP BY r.coun
    ) r2
    ON r.coun = r2.coun
    AND r.year = r2.year
    AND r.population > 0
WHERE r.religion = 'Christianity'
),
Islam AS (
SELECT r.coun, r.religion, round( r.population / r2.total_population_2020 * 100, 2 ) AS Islam
FROM religions_edited r 
JOIN (
        SELECT r.coun , r.year,  sum(r.population) as total_population_2020
        FROM religions_edited r 
        WHERE r.year = '2020' and r.coun != 'All Countries'
        GROUP BY r.coun
    ) r2
    ON r.coun = r2.coun
    AND r.year = r2.year
    AND r.population > 0
WHERE r.religion = 'Islam'
),
Hinduism AS (
SELECT r.coun, round( r.population / r2.total_population_2020 * 100, 2 ) AS Hinduism
FROM religions_edited r 
JOIN (
        SELECT r.coun, r.year,  sum(r.population) as total_population_2020
        FROM religions_edited r 
        WHERE r.year = '2020' and r.coun != 'All Countries'
        GROUP BY r.coun
    ) r2
    ON r.coun = r2.coun
    AND r.year = r2.year
    AND r.population > 0
WHERE r.religion = 'Hinduism'
),
Judaism AS (
SELECT r.coun, r.religion, round( r.population / r2.total_population_2020 * 100, 2 ) AS Judaism
FROM religions_edited r 
JOIN (
        SELECT r.coun , r.year,  sum(r.population) as total_population_2020
        FROM religions_edited r 
        WHERE r.year = '2020' and r.coun != 'All Countries'
        GROUP BY r.coun
    ) r2
    ON r.coun = r2.coun
    AND r.year = r2.year
    AND r.population > 0
WHERE religion = 'Judaism'
),
Buddhism AS (
SELECT r.coun, r.religion, round( r.population / r2.total_population_2020 * 100, 2 ) AS Buddhism
FROM religions_edited r 
JOIN (
        SELECT r.coun , r.year,  sum(r.population) as total_population_2020
        FROM religions_edited r 
        WHERE r.year = '2020' and r.coun != 'All Countries'
        GROUP BY r.coun
    ) r2
    ON r.coun = r2.coun
    AND r.year = r2.year
    AND r.population > 0
WHERE religion = 'Buddhism'
),
Other_Religions AS (
SELECT r.coun, r.religion, round( r.population / r2.total_population_2020 * 100, 2 ) AS Other_Religions
FROM religions_edited r 
JOIN (
        SELECT r.coun , r.year,  sum(r.population) as total_population_2020
        FROM religions_edited r 
        WHERE r.year = '2020' and r.coun != 'All Countries'
        GROUP BY r.coun
    ) r2
    ON r.coun = r2.coun
    AND r.year = r2.year
    AND r.population > 0
WHERE religion = 'Other Religions'
),
Folk_Religions AS (
SELECT r.coun, r.religion, round( r.population / r2.total_population_2020 * 100, 2 ) AS Folk_Religions
FROM religions_edited r 
JOIN (
        SELECT r.coun , r.year,  sum(r.population) as total_population_2020
        FROM religions_edited r 
        WHERE r.year = '2020' and r.coun != 'All Countries'
        GROUP BY r.coun
    ) r2
    ON r.coun = r2.coun
    AND r.year = r2.year
    AND r.population > 0
WHERE religion = 'Folk Religions'
),
Unaffiliated_Religions AS (
SELECT r.coun, r.religion, round( r.population / r2.total_population_2020 * 100, 2 ) AS Unaffiliated_Religions
FROM religions_edited r 
JOIN (
        SELECT r.coun , r.year,  sum(r.population) as total_population_2020
        FROM religions_edited r 
        WHERE r.year = '2020' and r.coun != 'All Countries'
        GROUP BY r.coun
    ) r2
    ON r.coun = r2.coun
    AND r.year = r2.year
    AND r.population > 0
WHERE religion = 'Unaffiliated Religions'
)
SELECT r.coun, ch.Christianity, che.Islam, cher.Hinduism, chere.Judaism, j.Buddhism, jo.Other_Religions, jop.Folk_Religions, jopo.Unaffiliated_Religions
FROM religions_edited r 
LEFT JOIN Christianity ch
	ON r.coun = ch.coun
LEFT JOIN Islam che
	ON r.coun = che.coun
LEFT JOIN Hinduism cher
	ON r.coun = cher.coun
LEFT JOIN Judaism chere
	ON r.coun = chere.coun
LEFT JOIN Buddhism j
	ON r.coun = j.coun
LEFT JOIN Other_Religions jo
	ON r.coun = jo.coun
LEFT JOIN Folk_Religions jop
	ON r.coun = jop.coun
LEFT JOIN Unaffiliated_Religions jopo
	ON r.coun = jopo.coun
GROUP BY r.coun
)
-- -----------------------------------------------------------------------------------------------------------------------------
;
-- T3_Ukol_01 - průměrná denní (nikoli noční!) teplota
-- T3_Ukol_02 - počet hodin v daném dni, kdy byly srážky nenulové
-- T3_Ukol_03 - maximální síla větru v nárazech během dne
CREATE TABLE edited_city_countries AS (
WITH edited_city AS (
SELECT country, capital_city,
		CASE WHEN capital_city = 'Amsterdam' THEN 'Amsterdam'
			WHEN capital_city = 'Athenai' THEN 'Athens'
			WHEN capital_city = 'Belgrade' THEN 'Belgrade'
			WHEN capital_city = 'Berlin' THEN 'Berlin'
			WHEN capital_city = 'Bern' THEN 'Bern'
			WHEN capital_city = 'Bratislava' THEN 'Bratislava'
			WHEN capital_city = 'Bruxelles [Brussel]' THEN 'Brussels'
			WHEN capital_city = 'Bucuresti' THEN 'Bucharest'
			WHEN capital_city = 'Budapest' THEN 'Budapest'
			WHEN capital_city = 'Chisinau' THEN 'Chisinau'
			WHEN capital_city = 'Copenhagen' THEN 'Copenhagen'
			WHEN capital_city = 'Dublin' THEN 'Dublin'
			WHEN capital_city = 'Helsinki [Helsingfors]' THEN 'Helsinki'
			WHEN capital_city = 'Kyiv' THEN 'Kiev'
			WHEN capital_city = 'Lisboa' THEN 'Lisbon'
			WHEN capital_city = 'Ljubljana' THEN 'Ljubljana'
			WHEN capital_city = 'London' THEN 'London'
			WHEN capital_city = 'Luxembourg [Luxemburg/L' THEN 'Luxembourg'
			WHEN capital_city = 'Madrid' THEN 'Madrid'
			WHEN capital_city = 'Minsk' THEN 'Minsk'
			WHEN capital_city = 'Moscow' THEN 'Moscow'
			WHEN capital_city = 'Oslo' THEN 'Oslo'
			WHEN capital_city = 'Paris' THEN 'Paris'
			WHEN capital_city = 'Praha' THEN 'Prague'
			WHEN capital_city = 'Riga' THEN 'Riga'
			WHEN capital_city = 'Roma' THEN 'Rome'
			WHEN capital_city = 'Skopje' THEN 'Skopje'
			WHEN capital_city = 'Sofia' THEN 'Sofia'
			WHEN capital_city = 'Stockholm' THEN 'Stockholm'
			WHEN capital_city = 'Tallinn' THEN 'Tallinn'
			WHEN capital_city = 'Tirana' THEN 'Tirana'
			WHEN capital_city = 'Wien' THEN 'Vienna'
			WHEN capital_city = 'Vilnius' THEN 'Vilnius'
			WHEN capital_city = 'Warszawa' THEN 'Warsaw'
		ELSE capital_city END AS new_city
FROM countries
),
joinment AS (
SELECT cc.country, cc.new_city, we.city
FROM edited_city cc
LEFT JOIN weather we
	ON cc.new_city = we.city
GROUP BY city
)
SELECT we.date, jm.country, jm.new_city, avg(we.temp) as prumer_temp, (count(cast(time_to_sec(we.time) / (60 * 60) AS decimal(10, 1))))*3 AS pocet_hodin, max(we.gust) as max_vitr
FROM weather we
LEFT JOIN joinment jm
	ON we.city = jm.new_city
WHERE we.time >= '06:00' AND we.time <= '18:00' AND we.city != '' AND we.rain >= '0.1' AND we.city != ''
GROUP BY we.date, jm.new_city
ORDER BY jm.new_city, we.date
)
-- -----------------------------------------------------------------------------------------------------------------------------
;
CREATE TABLE joinment_04 AS (
SELECT jm.coun, jm.date, jm.tests_performed, jm.confirmed_per_day,dny, jm.jaro_leto_podzim_zima, jm.population_density, jm.population, jm.median_age_2018, jm.life_expectancy, jm.gdp_per_person, jm.mortaliy_under5, jm.gini, ec.prumer_temp, ec.pocet_hodin, ec.max_vitr, na.Christianity, na.Islam, na.Hinduism, na.Judaism, na.Buddhism, na.Other_Religions, na.Unaffiliated_Religions, na.Folk_Religions
FROM joinment_03 jm
LEFT JOIN edited_city_countries ec
	ON jm.coun = ec.country
	AND jm.date = ec.date 
LEFT JOIN nabozenstvi na
	ON jm.coun = na.coun
ORDER BY jm.date
)
-- -----------------------------------------------------------------------------------------------------------------------------
;
-- T2_Ukol_07 - rozdíl mezi očekávanou dobou dožití v roce 1965 a v roce 2015 - státy, ve kterých proběhl rychlý rozvoj mohou reagovat jinak než země, které jsou vyspělé už delší dobu
CREATE TABLE t_Vojtech_Flidr_projekt_SQL_final AS (
WITH jedna as (
SELECT coun, year, life_expectancy AS devatenacet_padesat
FROM life_expectancy_edited 
WHERE YEAR = '1950' 
),
dva AS (
SELECT coun, year, life_expectancy AS dva_tisice_patnact
FROM life_expectancy_edited 
WHERE YEAR = '2015' 
),
final_test AS (
SELECT je.coun, je.devatenacet_padesat, dv.dva_tisice_patnact, (dv.dva_tisice_patnact - je.devatenacet_padesat) AS rozdil_doziti
FROM jedna je
LEFT JOIN dva dv
	ON je.coun = dv.coun
)
SELECT jm.coun, jm.date, jm.dny, jm.jaro_leto_podzim_zima, jm.population_density, jm.population, jm.tests_performed, jm.confirmed_per_day, jm.gdp_per_person, jm.gini, jm.mortaliy_under5, jm.median_age_2018, jm.Christianity, jm.Islam, jm.Hinduism, jm.Judaism, jm.Buddhism, jm.Other_Religions, jm.Unaffiliated_Religions, jm.Folk_Religions, fi.rozdil_doziti, jm.prumer_temp, jm.pocet_hodin, jm.max_vitr
FROM joinment_04 jm
LEFT JOIN final_test fi
	ON jm.coun = fi.coun
WHERE jm.coun != ' ' AND jm.coun IS NOT NULL 
)
-- -----------------------------------------------------------------------------------------------------------------------------
;
UPDATE t_Vojtech_Flidr_projekt_SQL_final c
     SET c.confirmed_per_day = REPLACE (c.confirmed_per_day, '-', '')
     WHERE c.confirmed_per_day LIKE '%-%'


select *
from t_Vojtech_Flidr_projekt_SQL_final
ORDER BY coun






