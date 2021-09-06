CREATE OR REPLACE VIEW vw_tl_dim_source
AS
SELECT 
    DISTINCT MD5(CONCAT(COALESCE(`eventProps.wzrk_pid`,'_Sin_info_pid'),COALESCE(`eventProps.wzrk_cid`,'_Sin_info_cdi'),COALESCE(`eventProps.wzrk_dt`,'_Sin_info_dt'))) as id_source,
    COALESCE(`eventProps.wzrk_pid`,'_Sin_info_pid') as event_pid,
    COALESCE(`eventProps.wzrk_cid`,'_Sin_info_cdi') as event_cid,
    COALESCE(`eventProps.wzrk_dt`,'_Sin_info_dt') as event_dt,
    NOW() AS fecha_transformacion
FROM gluky_test.stg_mkt_info
