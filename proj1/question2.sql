DROP INDEX UCS_IDX;
DROP INDEX TIPOSAULA_IDX;
CREATE INDEX UCS_IDX ON ZUCS(CODIGO, CURSO);  
CREATE INDEX TIPOSAULA_IDX ON ZTIPOSAULA(ANO_LETIVO);

SELECT t.tipo, SUM(t.horas_turno * COALESCE(n_aulas,1)) as horas
FROM xucs u 
JOIN xocorrencias o on u.codigo=o.codigo
JOIN xtiposaula t on o.codigo=t.codigo and t.periodo=o.periodo and o.ano_letivo=t.ano_letivo
JOIN xdsd d on d.id=t.id
WHERE u.curso=233 and o.ano_letivo='2004/2005'
GROUP BY t.tipo;