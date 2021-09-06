CREATE OR REPLACE PROCEDURE sp_tl_th_metrics()

BEGIN


/*
Unicamente se corre en el desarrollo para crear la tabla
CREATE OR REPLACE TABLE gluky_datamart.th_metrics(
id_reg VARCHAR(100),
p_identity VARCHAR(100),
id_source VARCHAR(100),
device_dpi INT,
device_dw INT,
device_dh INT,
fecha_transformacion DATE,
PRIMARY KEY (id_reg)
);
*/

INSERT INTO gluky_datamart.th_metrics(id_reg,p_identity, id_source, device_dpi, device_dw, device_dh, fecha_transformacion)
SELECT 
    s.id_reg,
    s.p_identity,
    s.id_source,
    s.device_dpi,
    s.device_dw,
    s.device_dh,
    s.fecha_transformacion 
FROM gluky_test.vw_tl_th_metrics S 
LEFT JOIN gluky_datamart.th_metrics D ON S.id_reg = D.id_reg
WHERE D.id_reg IS NULL;

END




