--This creates a table and loads in the Ordnance Survey Master Map Building Heights data

-- Create the destination schema if required
CREATE SCHEMA IF NOT EXISTS os_address;

--Drop table if it already exists
DROP TABLE
        IF EXISTS os_address.building_heights

--Create the table
CREATE TABLE
        os_address.building_heights
        (
                OS_TOPO_TOID         VARCHAR(20) NOT NULL ,
                OS_TOPO_TOID_VERSION SMALLINT NULL        ,
                BHA_ProcessDate      DATE NULL            ,
                TileRef              VARCHAR(6) NULL      ,
                AbsHMin              REAL NULL            ,
                AbsH2                REAL NULL            ,
                AbsHMax              REAL NULL            ,
                RelH2                REAL NULL            ,
                RelHMax              REAL NULL            ,
                BHA_Conf             SMALLINT NULL
        );

--Combine the Building Heights data into one file
--I used the command line copy function to combine all of the csvs into one file
--This example would copy all of the csvs in the C:\OS\OS Building Heights\bldhgb_csv\Data directory
--into a single csv called all_building_heights.csv


--Load the building Heights data
copy os_address.building_heights ( os_topo_toid, os_topo_toid_version, bha_processdate, tileref, abshmin, absh2, abshmax, relh2, relhmax, bha_conf ) 
FROM 'C:\temp\OS\bldhgb_csv\combine.csv' WITH delimiter ',' quote '"' ESCAPE '"' csv;

CREATE INDEX idx_os_topo_toid ON os_address.building_heights (OS_TOPO_TOID);