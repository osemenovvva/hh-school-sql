--Задание 4
--Запрос для получения месяца с наибольшим количеством вакансий и месяца с наибольшим количеством резюме

(
select 'Vacancies' as title, 
    date_part('month', creation_date) as max_count_month, 
    date_part('year',creation_date) as max_count_year
from vacancies
group by max_count_year, max_count_month
order by count(*) desc
limit 1
)

union

(
select 'Resumes' as title, 
    date_part('month', creation_date) AS max_count_month,  
    date_part('year',creation_date) as max_count_year
from resumes
group by max_count_year, max_count_month
order by count(*) desc
limit 1
);
