# AddressBase-Plus-to-postgres
This project has code for loading AddressBase Plus data into a postgres database.
It also includes some additional code for loading the Office of National Statistics (ONS) National Postocode Lookup (NSPL) and the Ordnance Survey Building Height Data.  If you don't have the NSPL or Building Height data you can just run the code in files 1 to 4.  

The addressbase table has also had some additional columns added to allow it to be used to search for addresses in AddressBase in QGIS.
This is based on the example in the blog below.  I have adapted it to work with the AddressBase Plus and Address Plus islands data (i believe their example uses just the AddressBase Premium data).

This code assuems you already have a postgres database setup 

This blog explains how to setup the Discovery Tool in QGIS to be able to access and search for the AddressBase data that you load into your Postgres SQL database.

https://www.lutraconsulting.co.uk/blog/2016/05/27/using-os-addressbase-for-address-search-in-qgis/?fbclid=IwAR38x5SG0srzRhv449Umn4FODWPzd5GC7gCXHiOlXpb_2ppSklhtte5tXrY
