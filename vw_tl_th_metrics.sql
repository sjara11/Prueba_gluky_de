CREATE OR REPLACE VIEW vw_tl_th_metrics
AS
SELECT 
    `index` as id_reg,
    MD5(CONCAT(COALESCE(`eventProps.wzrk_pid`,'_Sin_info'),COALESCE(`eventProps.wzrk_cid`,'_Sin_info'),COALESCE(`eventProps.wzrk_dt`,'_Sin_info'))) as id_source,
    COALESCE(`profile.identity`,'-99') as p_identity,
    COALESCE(`deviceInfo.dpi`,0) as device_dpi,
    COALESCE(`deviceInfo.dimensions.width`,0) as device_dw,
    COALESCE(`deviceInfo.dimensions.height`,0) as device_dh,
    NOW() AS fecha_transformacion
FROM gluky_test.stg_mkt_info
