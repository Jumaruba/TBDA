DROP INDEX UCS_IDX; 
DROP INDEX TIPOSAULA_IDX;

CREATE INDEX TIPOSAULA_IDX ON ZTIPOSAULA(CODIGO, ANO_LETIVO, PERIODO);
CREATE INDEX UCS_IDX ON ZUCS(DESIGNACAO, CURSO);


SELECT u.codigo, u.designacao, o.ano_letivo, o.inscritos, t.tipo, t.turnos
FROM yucs u 
JOIN yocorrencias o on u.codigo=o.codigo
JOIN ytiposaula t on o.codigo=t.codigo and t.periodo= o.periodo and o.ano_letivo=t.ano_letivo
WHERE u.designacao='Bases de Dados' and u.curso=275;
