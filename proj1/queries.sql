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
JOIN xocorrencias o ON u.codigo=o.codigo AND o.ano_letivo='2003/2004'
WHERE u.codigo NOT IN (
    SELECT UNIQUE(codigo) FROM xtiposaula JOIN xdsd ON xdsd.id=xtiposaula.id WHERE ano_letivo='2003/2004'
); --we need the join with the table xdsd because it is responsible for the teaching service distribution

-- b) Use external join and is null.
CREATE VIEW has_service AS
SELECT UNIQUE(t.codigo)
FROM xtiposaula t
JOIN xdsd d ON d.id=t.id
WHERE t.ano_letivo='2003/2004'; 

SELECT UNIQUE(u.codigo)
FROM xucs u
JOIN xocorrencias o ON o.codigo=u.codigo
LEFT OUTER JOIN has_service hs ON u.codigo=hs.codigo
WHERE hs.codigo IS NULL AND o.ano_letivo='2003/2004';

DROP VIEW has_service;

-- QUESTION 4
CREATE VIEW docente_horas AS 
SELECT doc.nr, SUM(d.horas*d.fator) as sum_horas, t.tipo, doc.nome
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

-- Calculates the number of types.
SELECT UNIQUE(tipo) FROM xtiposaula;

-- Get's the elements that have all the types. 
SELECT COUNT(UNIQUE(t.tipo)) AS cursos,u.curso
FROM xucs u
JOIN xocorrencias o on u.codigo=o.codigo
JOIN xtiposaula t on o.codigo=t.codigo and t.periodo= o.periodo and o.ano_letivo=t.ano_letivo
GROUP BY u.curso
HAVING COUNT(UNIQUE(t.tipo))=5;

-- Checking the result.
SELECT UNIQUE(t.tipo)
FROM xucs u
JOIN xocorrencias o on u.codigo=o.codigo
JOIN xtiposaula t on o.codigo=t.codigo and t.periodo= o.periodo and o.ano_letivo=t.ano_letivo
WHERE u.curso=433;
