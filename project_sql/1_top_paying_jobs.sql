/*
What are the highest paying software engineer jobs?
- Identify the top 10 highest paying software engineer roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? So we can identify the highest paying opportunities for software engineers, hence offering insights into employment opportunities in the field.
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