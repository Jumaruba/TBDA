DROP INDEX TIPOSAULA_IDX; 
DROP INDEX DSD_IDX; 

CREATE INDEX TIPOSAULA_IDX ON ZTIPOSAULA(ANO_LETIVO);
CREATE INDEX DSD_IDX ON ZDSD(ID);



-- QUESTIONS 3: Which courses (show the code) did have occurrences planned but did 
-- not get service assigned in year 2003/2004?
-- a) Use not in.
SELECT UNIQUE(u.codigo)
FROM xucs u 
JOIN xocorrencias o ON u.codigo=o.codigo AND o.ano_letivo='2003/2004'
WHERE u.codigo NOT IN (
    SELECT UNIQUE(codigo) 
    FROM xtiposaula 
    JOIN xdsd ON xdsd.id=xtiposaula.id 
    WHERE ano_letivo='2003/2004'
); 
--we need the join with the table xdsd because it is responsible for the teaching service distribution

-- b) Use external join and is null. ABS(P_ /*N*/)
DROP VIEW has_service;
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
