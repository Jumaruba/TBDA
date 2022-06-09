-- QUESTION A --

select f.id, f.name, r.description, a.activity 
from facilities f
inner join roomtypes r on f.roomtype = r.roomtype
inner join uses u on u.id = f.id 
inner join activities a on a.ref = u.ref 
where r.description like '%touros%' and a.activity='teatro'; 


-- QUESTION B -- 
select r.designation, count(f.name)
from facilities f 
inner join roomtypes r on r.roomtype = f.roomtype 
inner join municipalities m on m.cod = f.municipality 
inner join regions r on r.cod = m.region 
where r.description like '%touros%'
group by r.designation;


