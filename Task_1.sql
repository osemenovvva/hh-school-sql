--Задание 1
--Проектирование базы данных hh

--Словари
create type experience_level as enum ('noExperience', 'between1And3', 'between3And6', 'moreThan6');
create type employment_type as enum ('part', 'project', 'volunteer', 'probation');
create type schedule_type as enum ('fullday', 'shift', 'flexible', 'remote', 'flyInFlyOut');
create type gender as enum ('female', 'male');
create type response_status as enum ('response', 'invitation', 'discard');

--Регион
create table areas (
	area_id 	serial primary key,
	area_name 	varchar(100) not null
);

--Специализации
create table specializations (
	specialization_id 	serial primary key,
	specialization_name	varchar(100) not null
);

--Навыки
create table skills (
	skill_id 	serial primary key,
	skill_name	varchar(100) not null
);

--Работодатели
create table employers (
	employer_id 			serial primary key,
	employer_name 			varchar(100) not null,
	description 			text,
	is_trusted 			boolean,
	is_accredited_it_employer 	boolean,
	logo 				uuid
);

--Вакансии
create table vacancies (
	vacancy_id		serial primary key,
	employer_id 		integer not null references employers (employer_id),
	area_id 		integer not null references areas (area_id),
	specialization_id 	integer not null references specializations (specialization_id),
	position_name 		text not null,
	creation_date		timestamp not null,
	experience_level 	experience_level not null,
	employment_type		employment_type not null,
	schedule_type  		schedule_type not null,
	compensation_from 	integer,
	compensation_to 	integer,
	is_compensation_gross 	boolean
);

--Навыки в вакансии
create table vacancy_skills (
	vacancy_id integer not null references vacancies (vacancy_id),
	skill_id   integer not null references skills (skill_id),
	primary key (vacancy_id, skill_id)
);

--Соискатели
create table applicants (
	applicant_id 		serial primary key,
	first_name		text not null,
	last_name		text not null,
	middle_name		text,
	date_of_birth 		date not null,
	gender 			gender not null,
	email			text,
	telephone_number	text
);

--Резюме
create table resumes (
	resume_id 			serial primary key,
	position_name			varchar(200) not null,	
	area_id				integer not null references areas (area_id),
	applicant_id			integer not null references applicants (applicant_id),
	specialization_id		integer not null references specializations (specialization_id),
	creation_date			timestamp not null,
    	experience_level 		experience_level not null,
    	employment_type			employment_type not null,
    	schedule_type  			schedule_type not null,
    	compensation			integer,
    	is_ready_to_relocate		boolean,
    	is_ready_to_business_trips	boolean,
    	description			text,
    	photo				uuid
);


--Опыт
create table experience (
	experience_id 		serial primary key,
	resume_id		integer not null references resumes (resume_id),
	area_id			integer not null references areas (area_id),
	specialization_id	integer not null references specializations (specialization_id),
	employer_id		integer not null references employers (employer_id),
	position_name		text not null,
	description		text,
	start_date		date not null,
	end_date		date not null

);


--Навыки в резюме
create table resume_skills (
	resume_id	integer not null references resumes (resume_id),
	skill_id	integer not null references skills (skill_id),
	primary key (resume_id, skill_id)
);


--Отклики
create table responses (
	response_id		serial primary key,
	resume_id		integer not null references resumes (resume_id),
	vacancy_id		integer not null references vacancies (vacancy_id),
	creation_date		timestamp not null,
	response_status		response_status not null
);

