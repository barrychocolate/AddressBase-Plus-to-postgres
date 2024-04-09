--This query joins on the address Base plus data we loaded with a polygon shape stored in the myshapes table
--This isn't necessary for the discovery tool to work.  It is just an example of how to do a spatial join using the Addressbase data

SELECT pt.*, py.*
FROM os_address.addressbase pt
JOIN os_address.myshapes py
ON ST_Intersects(py.geom, pt.geom)
WHERE py.objectid = 1;
