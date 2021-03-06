--This creates a cross tab count or properties by country for each postcode
--This is helpful for identifying cross border postcodes

--enable the extension to use 
CREATE extension IF NOT EXISTS tablefunc ;

--Get a count of UPRNS by country_codes by Postcode or postcode_locator
--Use postcode locator as many postcodes are empty

DROP TABLE IF EXISTS os_address.pcode_country_counts;

select 
	CASE   
    	WHEN length(postcode)<>0 
		THEN postcode
    	ELSE postcode_locator
	END	   as postcode, 
country, 
count(UPRN) as property_count
into os_address.pcode_country_counts
from os_address.addressbase
GROUP BY 	CASE   
    	WHEN length(postcode)<>0 
		THEN postcode
    	ELSE postcode_locator
		END, 
	country;

--Crosstab query that to return one row per postcode

DROP TABLE IF EXISTS os_address.country_crosstab;

SELECT * 
INTO os_address.country_crosstab
FROM crosstab( $$ select postcode, country, property_count from os_address.pcode_country_counts ORDER BY postcode $$ , 
			 $$ values ('E'), ('J'), ('L'), ('M'), ('N'), ('S'), ('W') $$) 
     AS final_result(postcode character(8), England BIGINT, No_country BIGINT, Channel_Islands BIGINT, Isle_of_Man BIGINT, Northern_Ireland BIGINT, Scotland BIGINT, Wales BIGINT);

--Remove initial 
DROP table IF EXISTS  os_address.pcode_country_counts;

--Example query to find postcodes with properties in Both England AND Wales
select * from os_address.country_crosstab WHERE England >0 AND Wales > 0;

--Example query to find postcodes with properties in Both Scotland AND England
select * from os_address.country_crosstab WHERE Scotland >0 AND England > 0;


---------------------------------------------------------

--This creates a cross tab count or properties by country for each postcode.  ***It only looks at residential properties***
--This is helpful for identifying cross border postcodes

--enable the extension to use 
CREATE extension IF NOT EXISTS tablefunc;

--Get a count of UPRNS by country_codes by Postcode or postcode_locator
--Use postcode locator as many postcodes are empty

DROP TABLE IF EXISTS os_address.res_pcode_country_counts;

select COALESCE(postcode, postcode_locator)as postcode, country, count(UPRN) as property_count
into os_address.res_pcode_country_counts
from os_address.addressbase
WHERE left(CLASS, 1)= 'R'
GROUP BY COALESCE(postcode, postcode_locator), country;

--Crosstab query that to return one row per postcode

DROP TABLE IF EXISTS os_address.res_country_crosstab;

SELECT * 
INTO os_address.res_country_crosstab
FROM crosstab( $$ select postcode, country, property_count from os_address.res_pcode_country_counts ORDER BY postcode $$ , 
			 $$ values ('E'), ('J'), ('L'), ('M'), ('N'), ('S'), ('W') $$) 
     AS final_result(postcode character(8), England BIGINT, No_country BIGINT, Channel_Islands BIGINT, Isle_of_Man BIGINT, Northern_Ireland BIGINT, Scotland BIGINT, Wales BIGINT);

--Remove initial 
DROP table IF EXISTS  os_address.pcode_country_counts;

--Example query to find postcodes with properties in Both England AND Wales
select * from os_address.res_country_crosstab WHERE England >0 AND Wales > 0;

--Example query to find postcodes with properties in Both Scotland AND England
select * from os_address.res_country_crosstab WHERE Scotland >0 AND England > 0;

--Example query to return the UPRN and address data for all residential properties 
--in postcodes that have properties in both England and Wales

SELECT
        b.UPRN              ,
        b.country           ,
        b.sub_building_name ,
        b.building_name     ,
        b.building_number   ,
        b.street_description,
        b.thoroughfare      ,
        b.town_name         ,
        b.post_town         ,
        b.postcode
FROM
        os_address.res_country_crosstab a
LEFT JOIN
        os_address.addressbase b
ON
        a.postcode = b.postcode
WHERE
        a.postcode     <> ''
AND     a.England       >0
AND     a.Wales         > 0
AND     LEFT(b.CLASS, 1)= 'R' --This ensures only residential properties are returned
