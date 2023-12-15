--Задание 2
--Заполнение базы данных тестовыми данными

--Регионы
insert into areas (area_name) 
select 'Area_' || md5(random()::text)
from generate_series(1, 100);


--Специализации
insert into specializations (specialization_name)
values 	('Автомобильный бизнес'),
	('Административный персонал'),
	('Безопасность'),
	('Высший и средний менеджмент'),
	('Добыча сырья'),
	('Домашний, обслуживающий персонал'),
	('Закупки'),
	('Информационные технологии'),
	('Искусство, развлечения, массмедиа'),
	('Маркетинг, реклама, PR'),
	('Медицина, фармацевтика'),
	('Наука, образование'),
	('Продажи, обслуживание клиентов'),
	('Производство, сервисное обслуживание'),
	('Рабочий персонал'),
	('Розничная торговля'),
	('Сельское хозяйство'),
	('Спортивные клубы, фитнес, салоны красоты'),
	('Стратегия, инвестиции, консалтинг'),
	('Страхование'),
	('Строительство, недвижимость'),
	('Транспорт, логистика, перевозки'),
	('Туризм, гостиницы, рестораны'),
	('Управление персоналом, тренинги'),
	('Финансы, бухгалтерия'),
	('Юристы'),
	('Другое');

	
--Навыки
insert into skills (skill_name)
select 'Skill_' || md5(random()::text)
from generate_series(1, 500);


--Работодатели
insert into employers (employer_name, description, is_trusted, is_accredited_it_employer, logo)
select	'Employer_' || md5(random()::text),
	md5(random()::text),
	random() < 0.5,
	random() < 0.3,
	uuid_in(md5(random()::text || random()::text)::cstring) 
from generate_series(1, 1000);


--Вакансии
insert into vacancies (employer_id, area_id, specialization_id, position_name, creation_date, experience_level,
					 employment_type, schedule_type, compensation_from, compensation_to, is_compensation_gross)
 select	floor(random() * (select max(employer_id) from employers) + 1),
	floor(random() * (select max(area_id) from areas) + 1),
	floor(random() * (select max(specialization_id) from specializations) + 1),
	'Vacancy_' || md5(random()::text),
	current_timestamp - floor(random() * 365) * '1 day'::interval,
	(select unnest(enum_range(NULL::experience_level)) as experience_level ORDER BY random() LIMIT 1),
	(select unnest(enum_range(NULL::employment_type)) as employment_type ORDER BY random() LIMIT 1),
	(select unnest(enum_range(NULL::schedule_type)) as schedule_type ORDER BY random() LIMIT 1),
	floor(random() * 100000),
	floor(random() * 500000),
	random() < 0.5
from generate_series(1, 10000);


--Необходимые навыки в вакансии
insert into vacancy_skills (vacancy_id, skill_id)
select 	floor(random() * (select max(vacancy_id) from vacancies) + 1),
	floor(random() * (select max(skill_id) from skills) + 1)
from generate_series(1, 5000);


--Соискатели
insert into applicants (first_name, last_name, middle_name, date_of_birth, gender, email)
select 	'FirstName_' || md5(random()::text),
	'LastName_' || md5(random()::text),
	'MiddleName_' || md5(random()::text),
	current_timestamp - floor(random() * 365 * 25) * '1 day'::interval,
	(select unnest(enum_range(NULL::gender)) as gender ORDER BY random() LIMIT 1),
	'email' || md5(random()::text) || '@mycompany.com'
from generate_series(1, 50000);


--Резюме
insert into resumes (position_name, area_id, applicant_id, specialization_id, creation_date, experience_level,
    				employment_type, schedule_type, compensation, is_ready_to_relocate, is_ready_to_business_trips, description, photo)
select 'Position_' || md5(random()::text),
	floor(random() * (select max(area_id) from areas) + 1),
	floor(random() * (select max(applicant_id) from applicants) + 1),
	floor(random() * (select max(specialization_id) from specializations) + 1),
	current_timestamp - floor(random() * 365 * 25) * '1 day'::interval,
	(select unnest(enum_range(NULL::experience_level)) as experience_level ORDER BY random() LIMIT 1),
	(select unnest(enum_range(NULL::employment_type)) as employment_type ORDER BY random() LIMIT 1),
	(select unnest(enum_range(NULL::schedule_type)) as schedule_type ORDER BY random() LIMIT 1),
	floor(random() * 500000),
	random() < 0.2,
	random() < 0.6,
	md5(random()::text),
	uuid_in(md5(random()::text || random()::text)::cstring) 
from generate_series(1, 100000);


--Опыт
insert into experience (resume_id, area_id, specialization_id, employer_id, position_name, description, start_date, end_date)
select 	floor(random() * (select max(resume_id) from resumes) + 1),
	floor(random() * (select max(area_id) from areas) + 1),
	floor(random() * (select max(specialization_id) from specializations) + 1),
	floor(random() * (select max(employer_id) from employers) + 1),
	'Position_' || md5(random()::text),
	md5(random()::text),
	current_date - floor(random() * 365) * '1 day'::interval,
	current_date
from generate_series(1, 100000);	


--Навыки в резюме
insert into resume_skills (resume_id, skill_id)
select 	floor(random() * (select max(resume_id) from resumes) + 1),
  	floor(random() * (select max(skill_id) from skills) + 1)
from generate_series(1, 50000);


--Отклики
insert into responses (resume_id, vacancy_id, creation_date, response_status)
select	floor(random() * (SELECT max(resume_id) FROM resumes) + 1),
	floor(random() * (SELECT max(vacancy_id) FROM vacancies) + 1),
	current_timestamp - floor(random() * 365) * '1 day'::interval, 
	(select unnest(enum_range(NULL::response_status)) as response_status ORDER BY random() LIMIT 1)
from generate_series(1, 50000);

