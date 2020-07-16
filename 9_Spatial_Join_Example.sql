--This query joins on the address Base plus data we loaded with a polygon shape stored in the myshapes table
--This isn't necessary for the discovery tool to work.  It is just an example of how to do a spatial join using the Addressbase data

SELECT pt.*, py.*
FROM os_address.addressbase pt
JOIN os_address.myshapes py
ON ST_Intersects(py.geom, pt.geom)
WHERE py.objectid = 1;

--This query identifies the max UPRN in the first 10M rows of data to allow the data to be extracted in batches of 10M
select max(subquery.uprn) from (select uprn from os_address.addressbase order by UPRN limit 10000000) as subquery;

--Use the result of that to adjust the where query
COPY (select * from os_address.addressbase where uprn > 100070163174) TO 'C:\OS\AddressBase\20200715_ABFLGB_p4.CSV' DELIMITER ',' CSV HEADER;
