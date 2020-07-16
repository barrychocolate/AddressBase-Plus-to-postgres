-- Create the indexes using the following code.  
-- It is more efficient to do this after the data has been loaded into the table

-- Create a pg_trgm index on the full_address column
-- This will allow super-fast, case-insensitive search on the column
CREATE EXTENSION
IF NOT EXISTS pg_trgm;
        CREATE INDEX
                addressbase_full_address_gin_trgm
        ON
                os_address.addressbase
        USING
                gin
                (
                        "full_address" gin_trgm_ops
                );
-- Spatial index for the geometry column 
CREATE INDEX
        addressbase_geom_gist
ON
        os_address.addressbase
USING
        gist
        (
                geom
        );

-- Create index on postcode 
CREATE INDEX
        addressbase_postcode_indx
ON
        os_address.addressbase(postcode);
        
        -- Create index on uprn 
CREATE INDEX
        addressbase_uprn_indx
ON
        os_address.addressbase(uprn);
