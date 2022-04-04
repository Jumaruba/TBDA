-- x

SELECT u.curso, o.ano_letivo, o.periodo, SUM(d.horas)
FROM xucs u 
JOIN xocorrencias o ON u.codigo=o.codigo
JOIN xtiposaula t ON o.codigo=t.codigo AND t.periodo= o.periodo and o.ano_letivo=t.ano_letivo
JOIN xdsd d ON d.id=t.id
WHERE t.tipo='OT' AND (t.ano_letivo='2002/2003' OR t.ano_letivo='2003/2004')
GROUP BY u.curso, o.ano_letivo, o.periodo;

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

