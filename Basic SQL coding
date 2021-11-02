Database.sql
Kdo má přístup

Vlastnosti systému
Typ
SQL
Velikost
3 kB
Využití úložiště
3 kB
Umístění
Lekce 2
Vlastník
Vojtech Flidr
Změněno
Vojtech Flidr: 28. 7. 2021
Otevřeno
18:16 mnou
Vytvořeno
28. 7. 2021
Bez popisu
Čtenáři mohou stahovat
#Order by - Ukol cislo 1
SELECT
	`date` datum,
	`country` stat,
	`confirmed` AS potvrzeni
FROM covid19_basic
WHERE country = 'Austria'
ORDER BY date;

SELECT date
FROM covid19_basic
WHERE country = 'Rakousko';

SELECT
        cb.deaths 
FROM covid19_basic cb 
WHERE country = 'Czechia'
ORDER BY date DESC;

#Order by - Ukol cislo 2
SELECT 
	sum(confirmed)
FROM covid19_basic
WHERE `date` = CAST('2020-08-30' AS date);

SELECT 
	sum(confirmed)
FROM covid19_basic
WHERE date = "2020-08-30";

SELECT 
	CAST("1" AS UNSIGNED INTEGER) AS cislo,
	"1" AS retezec;

SELECT 1 AS `SELECT`;

SELECT 
	DISTINCT
	date,
	confirmed 
FROM covid19_basic 
ORDER BY date DESC;

#Creating new column - Ukol cislo 1
SELECT 
	country,
	confirmed,
	CASE WHEN confirmed > 10000 THEN TRUE
         ELSE FALSE END AS flag_vic_nez_10000
FROM covid19_basic_differences 
WHERE date = '2020-08-30'
ORDER BY confirmed DESC;

SELECT TRUE;

#Creating new column - Úkol 2
SELECT 
	*,
	CASE 
		WHEN country IN ('Germany', 'France' , 'Spain') 
		THEN 'Evropa'
	    ELSE 'Ostatni' 
    END AS flag_evropa
FROM covid19_basic_differences
WHERE confirmed >= 1;

#Creating new column -  Úkol 3 ---
SELECT 
	*,
	CASE 
		WHEN country LIKE '%a'
		THEN '-A zeme'
	    ELSE 'Ostatni' 
    END AS flag_ge
FROM covid19_basic_differences;

#Creating new column -  Úkol 4 ---
SELECT 
	*,
	CASE WHEN country like '%a' THEN 'A zeme'
         ELSE 'neA zeme' END AS flag_end_a
FROM covid19_basic;

CREATE VIEW v_vojta_my_view AS
	SELECT
		* 
	FROM covid19_basic 
	WHERE country IN ('US','China','India');

CREATE VIEW v_vojta2_my_view_continue AS
	SELECT 
		vm.date 
	FROM v_vojta_my_view AS vm
	WHERE confirmed > 0
	LIMIT 10;

#Výběr z pohledu
SELECT * FROM v_vojta2_my_view_continue;

#Smazání pohledů
DROP VIEW IF EXISTS v_vojta2_my_view_continue;
DROP VIEW IF EXISTS v_vojta_my_view;

#Where, in + like - Úkol 1 
SELECT 
	*
FROM covid19_basic    
WHERE country IN
	(SELECT DISTINCT country 
	 FROM lookup_table 
	 WHERE population >= 100000000
	);

SELECT country 
	 FROM lookup_table 
	 WHERE population >= 100000000
	 
#Where, in + like - Úkol 2  PERFORMANCE ISSUE
SELECT 
	DISTINCT country
FROM covid19_basic    
WHERE country IN
	(SELECT 
		DISTINCT country 
	 FROM covid19_basic_differences 
	 WHERE confirmed > 10000
	);

#Tvorba indexu --- Nejsou oprávnění
CREATE INDEX IF NOT EXISTS 
covid19_basic__country__search_index ON covid19_basic (country);
#Smazání indexu --- Nejsou oprávnění
DROP INDEX IF EXISTS
covid19_basic__country__search_index ON covid19_basic;





