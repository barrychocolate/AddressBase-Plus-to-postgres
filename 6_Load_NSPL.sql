-- Download the National Statistics Postcode Lookup from
-- https://geoportal.statistics.gov.uk/search?collection=Dataset&sort=name&tags=PRD_NSPL

--Load csv into the table
copy os_address.nspl (
	pcd,
	pcd2,
	pcds,
	dointr,
	doterm,
	usertype,
	oseast1m,
	osnrth1m,
	osgrdind,
	oa21,
	cty,
	ced,
	laua,
	ward,
	nhser,
	ctry,
	rgn,
	pcon,
	ttwa,
	itl,
	npark,
	lsoa21,
	msoa21,
	wz11,
	sicbl,
	bua22,
	ru11ind,
	oac11,
	lat,
	"long",
	lep1,
	lep2,
	pfa,
	imd,
	icb

) from 'C:\temp\OS\NSPL_2021_FEB_2024_UK\Data\NSPL21_FEB_2024_UK.csv' delimiter ',' quote '"' escape '"' csv HEADER;

--Create indexes
create index nspl_postcode_indx on os_address.NSPL (pcd);

create index nspl_postcode2_indx on os_address.NSPL (pcd2);

create index nspl_postcodes_indx on os_address.NSPL (pcds);

create index nspl_OA21_indx on os_address.NSPL (OA21);

create index nspl_LSOA21_indx on os_address.NSPL (LSOA21);

create index nspl_MSOA21_indx on os_address.NSPL (MSOA21);

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
