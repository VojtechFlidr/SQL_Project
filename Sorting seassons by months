CREATE TABLE v_test_001 AS 
SELECT *, DATE_FORMAT(date,'%w') AS dates
FROM covid19_basic_differences 
;

SELECT *,
	CASE WHEN dates = 0 OR dates = 6 THEN 'vikend'
	ELSE 'pracovni_den'
	END AS dny
FROM v_test_001
ORDER BY date desc 
;


SELECT date, country,
	CASE WHEN date < 0 THEN 'jaro'
        WHEN date >= 0 AND date < 10 THEN 'leto'
        WHEN date >= 10 AND date < 20  THEN 'podzim'
        WHEN date >= 20 AND date < 30  THEN 'zima'
	ELSE 'nesmysl'
	END AS climate
FROM covid19_basic_differences
ORDER by date DESC 
;
