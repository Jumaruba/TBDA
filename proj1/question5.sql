-- Create indexes for letters A and B 
CREATE INDEX TIPOS_AULA ON ztiposaula(ano_letivo, tipo);  
CREATE BITMAP INDEX TIPOS_AULA ON ztiposaula(ano_letivo, tipo); 

-- Drop the index
DROP INDEX TIPOS_AULA; 


-- Verify if the index was allocated. 
SELECT * 
FROM user_indexes idx
WHERE idx.index_name='ANO_LETIVO'; 

-- Verify the space occupied by an index. 
SELECT SUM(bytes)/1024/1024 AS "Index Size (MB)" 
FROM user_segments 
WHERE segment_name='TIPOS_AULA';


-- Y 

SELECT u.curso, o.ano_letivo, o.periodo, SUM(d.horas)
FROM yucs u 
JOIN yocorrencias o ON u.codigo=o.codigo
JOIN ytiposaula t ON o.codigo=t.codigo AND t.periodo= o.periodo and o.ano_letivo=t.ano_letivo
JOIN ydsd d ON d.id=t.id
WHERE t.tipo='OT' AND (t.ano_letivo='2002/2003' OR t.ano_letivo='2003/2004')
GROUP BY u.curso, o.ano_letivo, o.periodo; 


-- Z 


SELECT u.curso, o.ano_letivo, o.periodo, SUM(d.horas)
FROM zucs u 
JOIN zocorrencias o ON u.codigo=o.codigo
JOIN ztiposaula t ON o.codigo=t.codigo AND t.periodo= o.periodo and o.ano_letivo=t.ano_letivo
JOIN zdsd d ON d.id=t.id
WHERE t.tipo='OT' AND (t.ano_letivo='2002/2003' OR t.ano_letivo='2003/2004')
GROUP BY u.curso, o.ano_letivo, o.periodo; 

