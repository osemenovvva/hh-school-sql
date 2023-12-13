--Задание 6
--Создание индексов

--Индекс по региону и дате создания вакансии
--Полезен для быстрой выдачи новых вакансий в регионе
create index vacancies_in_areas_idx on vacancies(area_id, creation_date);

--Индекс по навзанию вакансии
--Полезен для быстрой выдачи вакансий по поисковому запросу
create index vacancies_position_idx on vacancies(position_name);

--Индекс по з/п в резюме
--Полезен для быстрого поиска резюме по размеру желаемой з/п
create index resumes_compensation_idx on resumes(compensation);

--Индекс по дате создания отклика
--Полезен для фильтрации откликов и отображения статистики
create index responses_creation_date_idx on response(creation_date);

