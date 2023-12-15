--Задание 5
--Запрос для получения id и title вакансий, которые собрали больше 5 откликов в первую неделю после публикации

select v.vacancy_id, position_name
from vacancies v 
join responses r on v.vacancy_id = r.vacancy_id 
where r.creation_date - v.creation_date <= '1 week'::interval
group by v.vacancy_id
having count(*) > 5
order by v.vacancy_id 


