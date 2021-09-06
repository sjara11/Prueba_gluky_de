
CREATE OR REPLACE VIEW vw_tl_dim_usuarios
AS
SELECT 
    DISTINCT a.`profile.identity` as p_identity,
    ts as ts_evento,
    COALESCE(a.`profile.all_identities`,'_Sin_identities') as all_identities,
    COALESCE(a.`profile.platform`,'_Sin_platform') as platform,
    COALESCE(a.`profile.phone`,'_Sin_telefono')as phone,
    COALESCE(a.`profile.email`,'_Sin_email') as email,
    COALESCE(a.`deviceInfo.make`,'_Sin_device_make') as device_make,
    NOW() AS fecha_transformacion
FROM gluky_test.stg_mkt_info a
INNER JOIN (SELECT `profile.identity`, max(ts) as fecha_max FROM gluky_test.stg_mkt_info GROUP BY `profile.identity`) b 
ON a.`profile.identity` = b.`profile.identity` and a.ts = b.fecha_max

