DROP INDEX TIPOSAULA_IDX;
DROP INDEX DSD_IDX; 

CREATE INDEX TIPOSAULA_IDX ON ZTIPOSAULA(ANO_LETIVO);
CREATE INDEX DSD_IDX ON ZDSD(ID);

DROP VIEW docente_horas;
DROP VIEW max_horas_tipo;


CREATE VIEW docente_horas AS 
SELECT doc.nr, SUM(d.horas*d.fator*COALESCE(t.n_aulas, 1)) as sum_horas, t.tipo, doc.nome
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