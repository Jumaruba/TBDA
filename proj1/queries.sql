-- QUESTIONS 1 

SELECT u.codigo, u.designacao, o.ano_letivo, o.inscritos, t.tipo, t.turnos
FROM xucs u 
JOIN xocorrencias o on u.codigo=o.codigo
JOIN xtiposaula t on o.codigo=t.codigo and t.periodo= o.periodo and o.ano_letivo=t.ano_letivo
WHERE u.designacao='Bases de Dados' and u.curso=275;



-- QUESTIONS 2

SELECT t.tipo, SUM(d.horas)
FROM xucs u 
JOIN xocorrencias o on u.codigo=o.codigo
JOIN xtiposaula t on o.codigo=t.codigo and t.periodo= o.periodo and o.ano_letivo=t.ano_letivo
JOIN xdsd d on d.id=t.id
WHERE u.curso=233 and o.ano_letivo='2004/2005'
GROUP BY t.tipo;



-- QUESTIONS 3: Which courses (show the code) did have occurrences planned but did 
-- not get service assigned in year 2003/2004?
-- a) Use not in.
SELECT UNIQUE(u.codigo)
FROM xucs u 
JOIN xocorrencias o ON u.codigo=o.codigo
WHERE u.codigo NOT IN (
    SELECT o.codigo 
    FROM xocorrencias o 
    WHERE o.ano_letivo='2003/2004'
); 

-- b) Use external join and is null.

CREATE VIEW occurrences AS 
SELECT o.codigo 
FROM xocorrencias o 
WHERE o.ano_letivo='2003/2004'; 

SELECT UNIQUE(o.codigo)
FROM xocorrencias ox
FULL OUTER JOIN occurrences o ON o.codigo=ox.codigo;


DROP VIEW occurrences;

-- QUESTION 4
CREATE VIEW docente_horas AS 
SELECT doc.nr, SUM(d.horas) as sum_horas, t.tipo, doc.nome
FROM xdocentes doc
JOIN xdsd d ON doc.nr=d.nr
JOIN xtiposaula t ON d.id=t.id
WHERE t.ano_letivo='2003/2004'
GROUP BY doc.nome,doc.nr,t.tipo;


CREATE VIEW max_horas_tipo AS
SELECT MAX(sum_horas) as sum_horas, dh.tipo
FROM docente_horas dh 
GROUP BY dh.tipo;

SELECT dh.nr,dh.nome,dh.tipo,mht.sum_horas
FROM max_horas_tipo mht 
JOIN docente_horas dh ON dh.sum_horas=mht.sum_horas AND dh.tipo=mht.tipo;

DROP VIEW docente_horas;
DROP VIEW max_horas_tipo;


-- QUESTION 5 

SELECT u.curso, o.ano_letivo, o.periodo, SUM(d.horas)
FROM xucs u 
JOIN xocorrencias o on u.codigo=o.codigo
JOIN xtiposaula t on o.codigo=t.codigo and t.periodo= o.periodo and o.ano_letivo=t.ano_letivo
JOIN xdsd d on d.id=t.id
WHERE t.tipo='OT' AND (t.ano_letivo='2002/2003' OR t.ano_letivo='2003/2004')
GROUP BY u.curso, o.ano_letivo, o.periodo;

-- QUESTION 6

SELECT COUNT(UNIQUE(t.tipo)) AS cursos,u.curso
FROM xucs u
JOIN xocorrencias o on u.codigo=o.codigo
JOIN xtiposaula t on o.codigo=t.codigo and t.periodo= o.periodo and o.ano_letivo=t.ano_letivo
GROUP BY u.curso
HAVING COUNT(UNIQUE(t.tipo))=4;