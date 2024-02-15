--01--
select vacancy.job_role , project from vacancy join project_vacancy on vacancy.vacancy_id = project_vacancy.vacancy_id join project on project.project_id = project_vacancy.project_id;
--02--
select * from candidate;
--03--
select * from project;
--04--

--05--
select p.project_name , count(v.vacancy_id) as No_of_vacancies from vacancy v join project_vacancy pv on v.vacancy_id = pv.vacancy_id join project p on pv.project_id = p.project_id group by p.project_name ;
--06--
select concat(c.fname,c.lname) ,count(v.vacancy_id) as No_of_application from  vacancy v join candidate_vacancy cv ON v.vacancy_id = cv.vacancy_id join candidate c on cv.candidate_id = c.candidate_id group by concat(c.fname,c.lname)  having count(v.vacancy_id)>1;
--07--
select p.project_name, count(c.candidate_id) as number_of_applications from project p join project_vacancy pv on p.project_id = pv.project_id join vacancy v on pv.vacancy_id  = v.vacancy_id join candidate_vacancy cv on v.vacancy_id = cv.vacancy_id join candidate c on cv.candidate_id = c.candidate_id group by p.project_name;
--08--
select * from interview i join vacancy v on i.vacancy_id = v.vacancy_id where(i.project_id = 2);
--09--
SELECT i.project_id , count(*) from interview i where(i.interview_date< current_date) group by(i.project_id)
--10--
SELECT i.*, f.*
FROM interview i
JOIN interview_feedback f ON i.interview_id = f.interview_id
WHERE i.interview_date < current_date;
--11--
SELECT
    i.candidate_id,
    i.vacancy_id,
    AVG(f.overall_rating) AS average_rating
FROM
    interview i
JOIN
    interview_feedback f ON i.interview_id = f.interview_id
GROUP BY
    i.candidate_id,
    i.vacancy_id;
   
--12--
select i.interview_id ,i.candidate_id, i.vacancy_id from interview i join interview_feedback f on i.interview_id = f.interview_id where(f.overall_rating=5);

--13--
SELECT
   CONCAT(ir.fname, ' ', ir.lname) AS interviewer_name,
    ir.interviewer_id,
    COUNT(i.interview_id) AS interview_count
FROM
    interviewer ir
JOIN
    interview_interviewer ii ON ir.interviewer_id = ii.interviewer_id
JOIN
    interview i ON ii.interview_id = i.interview_id
GROUP BY
   CONCAT(ir.fname, ' ', ir.lname),
    ir.interviewer_id
HAVING
    MAX(i.interview_date) < CURRENT_DATE;
   
--14--
select * from interview i where(i.interview_date = '2024-06-20');
  
--15--
select i.candidate_id, i.interview_id, f.overall_rating, f.interviewer_id from interview i join interview_feedback f on i.interview_id = f.interview_id;

--16--
select i.candidate_id, count(project_id) from interview i group by i.candidate_id having(count(project_id))>1;

--17--
select * from interview i join interview_feedback f on i.interview_id = f.interview_id where (f.verdict = 'Rejected' and i.interview_date< current_date);

--18--
select * from candidate c join interview i ON c.candidate_id = i.candidate_id join interview_feedback f on i.interview_id = f.interview_id where(f.overall_rating = 5 and i.interview_date< current_date);

--19--
select * from candidate c join interview i ON c.candidate_id = i.candidate_id join interview_feedback f on i.interview_id = f.interview_id where(f.overall_rating>3 and i.interview_date< current_date);

--20--
select * from interview_feedback f join interview i ON f.interview_id = i.interview_id where(i.candidate_id=2 and i.interview_date< current_date);

--21--
select * from interview i join interview_feedback f on i.interview_id = f.interview_id join interviewer w on f.interviewer_id = w.interviewer_id where (f.overall_rating = 4 and w.fname = 'Jane' and i.interview_date<current_date);





alter table interview_feedback add column interviewer_id int references interviewer(interviewer_id);

create type rating as enum('1','2','3','4','5');

alter table interview_feedback add column educational_background rating;
alter table interview_feedback add column relavent_experience rating;
alter table interview_feedback add column system_arc_design rating;
alter table interview_feedback add column technical_experience rating;
alter table interview_feedback add column conceptual_understanding rating;
alter table interview_feedback add column analytical_and_problem_solving rating;
alter table interview_feedback add column teamwork rating;
alter table interview_feedback add column leadership rating;
alter table interview_feedback add column growth_and_potential rating;
alter table interview_feedback add column communication_skill rating;

