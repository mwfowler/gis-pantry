--------------------------------------------------------------------------------------
--SQL Code to query data from BCGW and load into QGIS in the DB Manager
--Mike Fowler
--GIS Analyst
--December 08, 2020
--------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW V_FRZ_HARVAUTH_BLOCKS
AS
SELECT 
ROWNUM AS BLOCK_ID, 
HARVEST_AUTH_SKEY, TIMBER_MARK, CUT_BLOCK_SKEY, CUT_BLOCK_FOREST_FILE_ID AS FOREST_FILE_ID, HARVEST_AUTH_CUTTING_PERMIT_ID AS CUTTING_PERMIT_ID, CUT_BLOCK_ID, 
DISTURBANCE_START_DATE, DISTURBANCE_END_DATE, OPENING_ID, CLIENT_NAME, BLOCK_STATUS_DATE,
FOR_REGION_CODE,
SDO_CS.TRANSFORM(GEOMETRY, 3005) AS GEOMETRY,
SDO_GEOM.SDO_CENTROID(SDO_CS.TRANSFORM(GEOMETRY, 3005), 2).sdo_point.x CENTROID_X_ALBERS, 
SDO_GEOM.SDO_CENTROID(SDO_CS.TRANSFORM(GEOMETRY, 3005), 2).sdo_point.y CENTROID_Y_ALBERS,
SDO_GEOM.SDO_CENTROID(SDO_CS.TRANSFORM(GEOMETRY, 4326), 2).sdo_point.x CENTROID_X_LON, 
SDO_GEOM.SDO_CENTROID(SDO_CS.TRANSFORM(GEOMETRY, 4326), 2).sdo_point.y CENTROID_Y_LAT
FROM WHSE_FOREST_TENURE.FTEN_CUT_BLOCK_POLY_SVW CB
LEFT JOIN WHSE_CORP.REG_DIST_ORGN CD ON CD.FOR_DISTRICT_CODE = CB.ADMIN_DISTRICT_CODE
--WHERE FOR_REGION_CODE = 'RCO'
WHERE CUT_BLOCK_SKEY IN (
345521,205997,193222,19186,193024,698794,698795,219755,425566,510526,510527,517826,205963,219768,609188,192896,
659066,205961,314761,4787,4789,4788,314762,313421,851,551667,551666,441726,407021,382101,314003,314002,314001,
454286,710256,305211,369465,579406,458246,669727,669728,748730,706473,728978,770687,736797,684843)
--------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW V_FRZ_ZONES
AS
SELECT * FROM 
(
SELECT ROWNUM AS FRZ_ID, 
VERSION, FIBRE_RECOVERY_ZONE_TYPE, VERSION_EFFECTIVE_DATE, VERSION_DESCRIPTION, 
SDO_CS.TRANSFORM(SHAPE, 3005) AS SHAPE
--SDO_UTIL.TO_WKTGEOMETRY(SHAPE) AS GEOM_TEXT
FROM WHSE_ADMIN_BOUNDARIES.FADM_FIBRE_RECOVERY_ZONES_SP
)
WHERE FRZ_ID IN (150,218,219,350,402)
--------------------------------------------------------------------------------------
