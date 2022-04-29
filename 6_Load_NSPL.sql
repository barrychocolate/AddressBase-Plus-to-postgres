-- Download the National Statistics Postcode Lookup from
-- https://geoportal.statistics.gov.uk/search?collection=Dataset&sort=name&tags=PRD_NSPL

--Load csv into the table
copy os_address.nspl (pcd, pcd2, pcds, dointr, doterm, usertype, oseast1m, osnrth1m, osgrdind, oa11, cty, ced, laua, ward, hlthau, nhser, ctry, rgn, pcon, eer, teclec, ttwa, pct, nuts, park, lsoa11, msoa11, wz11, ccg, bua11, buasd11, ru11ind, oac11, lat, "long", lep1, lep2, pfa, imd, calncv, stp
	) from 'INSERT PATH TO CSV HERE' delimiter ',' quote '"' escape '"' csv HEADER;

--Create indexes
create index nspl_postcode_indx on os_address.NSPL (pcd);

create index nspl_postcode2_indx on os_address.NSPL (pcd2);

create index nspl_postcodes_indx on os_address.NSPL (pcds);

create index nspl_OA11_indx on os_address.NSPL (OA11);

create index nspl_LSOA11_indx on os_address.NSPL (LSOA11);

create index nspl_MSOA11_indx on os_address.NSPL (MSOA11);

create index nspl_WZ11_indx on os_address.NSPL (WZ11);


--Check that different format postcodes can be found
--AA9A 9AA
select * from os_address.nspl WHERE pcds = 'EC1A 1BB';
--A9A 9AA
select * from os_address.nspl WHERE pcds = 'W1A 0AX';
--A9 9AA
select * from os_address.nspl WHERE pcds = 'M1 1AE';
--A99 9AA
select * from os_address.nspl WHERE pcds = 'B33 8TH';
--AA9 9AA
select * from os_address.nspl WHERE pcds = 'CR2 6XH';
--AA99 9AA
select * from os_address.nspl WHERE pcds = 'DN55 1PT';
