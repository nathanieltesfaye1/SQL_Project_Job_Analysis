/*
What are the highest paying software engineer jobs?
- Identify the top 10 highest paying software engineer roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? So we can identify the highest paying opportunities for software engineers, hence offering
    insights into employment opportunities in the field.
*/

SELECT
    job_id,
    job_title,
    company_dim.name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
    JOIN
    company_dim
    ON job_postings_fact.company_id = company_dim.company_id

WHERE
    job_title_short = 'Software Engineer' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT
    10


/*
- Top salaries cluster between $180K and $225K. The highest-paying role is a
    Senior Software Engineer at Datavant ($225K),while most other top postings sit around $185K–$205K.
- Titles are mostly senior. They are also mainly specialised with nicher focuses (e.g. security, AI,
    frontend, scalability, etc.). This suggests that specialisation adds salary leverage.
- MongoDB seems to be a skill that's paid very well at the top of the industry, given it is a skill
    desired in 2 of the top 10 highest paying roles. However, a larger sample size may be required to
    say this definitively
- Remote work is available at high pay, given that all of the top 10 postings are “Anywhere,”
    which shows that remote engineers can still command pay comparable to on-site roles.
*/