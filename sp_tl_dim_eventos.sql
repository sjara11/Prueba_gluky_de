CREATE OR REPLACE PROCEDURE `sp_tl_dim_eventos`( )

BEGIN

/*
Crear el dummy para los registros huerfanos
*/
INSERT INTO gluky_datamart.dim_source(id_source, event_pid, event_cid, event_dt,fecha_transformacion)
SELECT * FROM (SELECT '-99','_Sin_info_pid','_Sin_info_cid','_Sin_info_dt',NOW()) as t
WHERE NOT EXISTS (
    SELECT id_source from gluky_datamart.dim_source WHERE id_source = '-99'
);


/*
No se necesita Actualizar los datos que cambian entre la vista y la dim por el Checksum crea un nuevo codigo si algo nuevo se crea en el origen 
*/

/*
Unicamente se corre en el desarrollo para crear la tabla
CREATE OR REPLACE TABLE gluky_datamart.dim_source(
id_source VARCHAR(100),
event_pid VARCHAR(200),
event_cid VARCHAR(100),
event_dt VARCHAR(100),
fecha_transformacion DATE,
PRIMARY KEY (id_source)
);
*/



INSERT INTO gluky_datamart.dim_source(id_source, event_pid, event_cid, event_dt,fecha_transformacion)
SELECT 
    s.id_source,
    s.event_pid,
    s.event_cid,
    s.event_dt,
    s.fecha_transformacion 
FROM gluky_test.vw_tl_dim_source S 
LEFT JOIN gluky_datamart.dim_source D ON S.id_source = D.id_source
WHERE D.id_source IS NULL;

END
