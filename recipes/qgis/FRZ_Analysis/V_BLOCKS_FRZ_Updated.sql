--------------------------------------------------------------------------------------
--SQL Code to summarize FRZ Zones by Cutblocks intersection product from QGIS. 
--This query can be run in the DB Manager of QGIS and load the result into the map view
--As presented on Community of Practice call on December 08, 2020
--Mike Fowler
--GIS Analyst
--December 08, 2020
--------------------------------------------------------------------------------------
CREATE VIEW V_BLOCKS_FRZ AS
SELECT 
B.CUT_BLOCK_SKEY, 
B.CUT_BLOCK_ID, B.TIMBER_MARK, 
B.CENTROID_X_ALBERS, B.CENTROID_Y_ALBERS,
B.CENTROID_X_LON, B.CENTROID_Y_LAT,
BLOCK_HA,
GEOMETRY,
Round((ifnull(VER1_MAT_HA, 0)/BLOCK_HA), 2) AS VER1_MAT_PCT,
Round((ifnull(VER1_IMM_HA, 0)/BLOCK_HA), 2) AS VER1_IMM_PCT,
Round((ifnull(VER1_MATIMM_HA, 0)/BLOCK_HA), 2) AS VER1_MATIMM_PCT,
Round((ifnull(VER2_MAT_HA, 0)/BLOCK_HA), 2) AS VER2_MAT_PCT,
Round((ifnull(VER2_IMM_HA, 0)/BLOCK_HA), 2) AS VER2_IMM_PCT,
Round((ifnull(VER2_MATIMM_HA, 0)/BLOCK_HA), 2) AS VER2_MATIMM_PCT
FROM 
(
SELECT DISTINCT CUT_BLOCK_SKEY, 
(
SELECT DISTINCT
---------------------------------------------------------------------------------------------------------------------------------------





