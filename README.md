# SQL Project - Job Analysis

## Introduction
This project explores the top-paying jobs, most in-demand skills, and finally the most optimal skills to learn in order to land high-paying/in-demand jobs. It is based on a dataset for tech-related job postings in 2023.

Here are all the SQL queries used: [project_sql folder](/project_sql/). All queries have been tailored for software engineers.

## Background
This project was inspired by my desire to understand which software engineering skills are best paid, most in-demand, and potentially offer the greatest career longevity (while still aligning with my own personal passions and interests), so I could focus on developing them.

### The questions I wanted to answer with my SQL queries were:
1. What are the top paying software engineering jobs?
2. What skills are required for these top paying jobs?
3. What skills are the most in-demand for software engineers?
4. Which skills are associated with higher salaries?
5. With all of this in mind, what are the most 'optimal' (high pay + high demand) skills to learn?

## Tools Used
The tools used for this project were:
- **SQL**: Allowed me to query the database
- **PostgreSQL**: The database management system that allowed me to handle the job posting data
- **VS Code**: The code editor used for executing SQL queries and database management
- **Git/GitHub**: For version control and sharing my SQL scripts and analysis. Also opens up the potential for future collaboration.

## Analysis
Each query for this project aimed to investigate specific aspects of the software engineering job market. Here's how I approached each of the 5 questions above:

### 1. Top Paying Software Engineering Jobs
To identify the highest paying roles, I filtered software engineering positions by average yearly salary and location (focussing on remote jobs).

```sql
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
```

## What I Learned

## Conclusion

## Closing Thoughts
