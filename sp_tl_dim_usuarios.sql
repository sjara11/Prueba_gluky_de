CREATE OR REPLACE PROCEDURE sp_tl_dim_usuarios()

BEGIN

/*
Crear el dummy para los registros huerfanos
*/
INSERT INTO gluky_datamart.dim_personas (p_identity, all_identities, platform, phone, email, device_make, fecha_transformacion)
SELECT * FROM (SELECT '-99','_Sin_identities','_Sin_platform','_Sin_telefono','_Sin_email','_Sin_device_make',NOW()) as t
WHERE NOT EXISTS (
    SELECT p_identity from gluky_datamart.dim_personas WHERE p_identity = '-99'
);

/*
Actualizar los datos que cambian entre la vista y la dim
*/
UPDATE gluky_datamart.dim_personas D 
INNER JOIN gluky_test.vw_tl_dim_usuarios S ON D.p_identity = S.p_identity
SET
    D.all_identities = S.all_identities
    ,D.platform = S.platform
    ,D.phone = S.phone
    ,D.email = S.email
    ,D.device_make = S.device_make
    ,D.fecha_transformacion = S.fecha_transformacion;

/*
Unicamente se corre en el desarrollo para crear la tabla
CREATE OR REPLACE TABLE gluky_datamart.dim_personas(
p_identity VARCHAR(100),
all_identities VARCHAR(200),
platform VARCHAR(100),
phone VARCHAR(100),
email VARCHAR(100),
device_make VARCHAR(100),
fecha_transformacion DATE,
PRIMARY KEY (p_identity)
);
*/

INSERT INTO gluky_datamart.dim_personas(p_identity, all_identities, platform, phone, email, device_make, fecha_transformacion)
SELECT 
    s.p_identity,
    s.all_identities,
    s.platform,
    s.phone,
    s.email,
    s.device_make,
    s.fecha_transformacion 
FROM gluky_test.vw_tl_dim_usuarios S 
LEFT JOIN gluky_datamart.dim_personas D ON S.p_identity = D.p_identity
WHERE D.p_identity IS NULL;

END
