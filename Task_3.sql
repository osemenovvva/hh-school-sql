--Задание 3
--Запрос для получения средних значений по регионам (area_id) следующих величин:
--compensation_from, compensation_to, среднее_арифметическое_from_и_to

select distinct area_id, 
    round(avg(compensation_from) over (partition by area_id), 0) as avg_compensation_from,  
    round(avg(compensation_to) over (partition by area_id), 0) as avg_compensation_to,
    round(avg((compensation_from + compensation_to) / 2)  over (partition by area_id)) as  avg_compensation_from_to
from vacancies v
where v.is_compensation_gross is True
order by area_id
