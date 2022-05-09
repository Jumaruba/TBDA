DROP INDEX TIPOSAULA_IDX; 
DROP INDEX UCS_IDX;
CREATE INDEX TIPOSAULA_IDX ON ZTIPOSAULA(CODIGO, TIPO);
CREATE INDEX UCS_IDX ON ZUCS(CODIGO, CURSO);


-- Calculates the number of types.
SELECT UNIQUE(tipo) FROM xtiposaula;

-- Get's the elements that have all the types. 

--
SELECT COUNT(UNIQUE(t.tipo)) AS cursos,u.curso
FROM xucs u
JOIN xocorrencias o ON u.codigo=o.codigo
JOIN xtiposaula t ON o.codigo=t.codigo AND t.periodo=o.periodo AND o.ano_letivo=t.ano_letivo
GROUP BY u.curso
HAVING COUNT(UNIQUE(t.tipo))=5; 
