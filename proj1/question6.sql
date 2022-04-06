-- Calculates the number of types.
SELECT UNIQUE(tipo) FROM xtiposaula;

-- Get's the elements that have all the types. 
SELECT COUNT(UNIQUE(t.tipo)) AS cursos,u.curso
FROM xucs u
JOIN xocorrencias o ON u.codigo=o.codigo
JOIN xtiposaula t ON o.codigo=t.codigo AND t.periodo= o.periodo AND o.ano_letivo=t.ano_letivo
GROUP BY u.curso
HAVING COUNT(UNIQUE(t.tipo))=5; 


SELECT COUNT(UNIQUE(t.tipo)) AS cursos,u.curso
FROM yucs u
JOIN yocorrencias o ON u.codigo=o.codigo
JOIN ytiposaula t ON o.codigo=t.codigo AND t.periodo= o.periodo AND o.ano_letivo=t.ano_letivo
GROUP BY u.curso
HAVING COUNT(UNIQUE(t.tipo))=5; 



SELECT COUNT(UNIQUE(t.tipo)) AS cursos,u.curso
FROM zucs u
JOIN zocorrencias o ON u.codigo=o.codigo
JOIN ztiposaula t ON o.codigo=t.codigo AND t.periodo= o.periodo AND o.ano_letivo=t.ano_letivo
GROUP BY u.curso
HAVING COUNT(UNIQUE(t.tipo))=5;