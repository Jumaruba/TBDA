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
