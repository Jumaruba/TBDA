-- Create indexes for letters A and B 
CREATE INDEX TIPOSAULA_IDX ON ZTIPOSAULA(ANO_LETIVO, TIPO);  
CREATE BITMAP INDEX TIPOSAULA_IDX ON ZTIPOSAULA(ANO_LETIVO, TIPO); 

-- Drop the index
DROP INDEX TIPOSAULA_IDX; 


-- Verify if the index was allocated. 
SELECT * 
FROM user_indexes idx
WHERE idx.index_name='ANO_LETIVO'; 

-- Verify the space occupied by an index. 
SELECT SUM(bytes)/1024/1024 AS "Index Size (MB)" 
FROM user_segments 
WHERE segment_name='TIPOSAULA_IDX';


-- Y 

SELECT u.codigo, u.curso, o.ano_letivo, o.periodo, SUM(d.horas)
FROM yucs u 
JOIN yocorrencias o ON u.codigo=o.codigo
JOIN ytiposaula t ON o.codigo=t.codigo AND t.periodo= o.periodo and o.ano_letivo=t.ano_letivo
JOIN ydsd d ON d.id=t.id
WHERE t.tipo='OT' AND (t.ano_letivo='2002/2003' OR t.ano_letivo='2003/2004')
GROUP BY u.curso, o.ano_letivo, o.periodo, u.codigo; 


-- Z 


SELECT u.codigo, u.curso, o.ano_letivo, o.periodo, SUM(d.horas)
FROM zucs u 
JOIN zocorrencias o ON u.codigo=o.codigo
JOIN ztiposaula t ON o.codigo=t.codigo AND t.periodo= o.periodo and o.ano_letivo=t.ano_letivo
JOIN zdsd d ON d.id=t.id
WHERE t.tipo='OT' AND (t.ano_letivo='2002/2003' OR t.ano_letivo='2003/2004')
GROUP BY u.curso, o.ano_letivo, o.periodo, u.codigo; 

