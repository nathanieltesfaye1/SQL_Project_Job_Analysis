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
My findings based on the above query and attached dataset are as follows:
- Top salaries cluster between $180K and $225K. The highest-paying role is a Senior Software Engineer at Datavant ($225K),while most other top postings sit around $185K–$205K.
- Titles are mostly senior. They are also mainly specialised with nicher focuses (e.g. security, AI, frontend, scalability, etc.). This suggests that specialisation adds salary leverage.
- MongoDB seems to be a skill that's paid very well at the top of the industry, given it is a skill desired in 2 of the top 10 highest paying roles. However, a larger sample size may be required to say this definitively
- Remote work is available at high pay, given that all of the top 10 postings are “Anywhere,” which shows that remote engineers can still command pay comparable to on-site roles.


### 2. Skills for Top Paying Job
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, to see what employers value for high-paying roles.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        company_dim.name AS company_name,
        salary_year_avg
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
)

SELECT
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
    INNER JOIN
    skills_job_dim
    ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN
    skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC
```

Out of the 10 highest paying roles for software engineers, the most common skills required are:
- JavaScript & Python appear in half of the top jobs (5/10).
- React, TypeScript, AWS appear in 40% of jobs (4/10)
- MongoDB appear in 30% (3/10)

Most other skills are niche, only covering 1–2 jobs.

In other words, a candidate with Python, JavaScript, React, TypeScript, AWS and MongoDB
would cover the majority of the skills required for these top paying roles (at least 70%).

### 3. Most In-Demand Skills

This query helped me identify the skills most frequently requested in job postings, directing focus to areas with high demand:

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS "demand_count"
FROM
    job_postings_fact
    INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Software Engineer'
GROUP BY
    skills
ORDER BY
    "demand_count" DESC
LIMIT
    5
```

My findings based on the above query and attached dataset are as follows:
- Python has over 15K postings and stands out as the single most in-demand skill. After all, it is a very versatile language, spanning over several domains like data, backend, machine learning, AI, etc.
- SQL ranks second, hence showing that data querying and database fluency are still non-negotiables for engineers.
- Cloud expertise is big as well. With AWS (10K+) and Azure (7K+) both ranking in the top 5, demand for cloud skills collectively exceeds even Python (10k + 15k = 17K, vs. 15K for Python). This suggests that engineers who build broad, cross-platform cloud expertise may be potentially better positioned for the most in-demand opportunities.
- Java is still a staple language; nearly 10K postings show that despite the rise of newer languages, Java continues to dominate development.

So, for a job seeker looking to develop skills that're in high-demand, my research implies that they should prioritise Python + SQL as foundational skills, then potentially layer in cloud expertise (AWS/Azure) to stand out. Adding Java can also offer extra leverage for enterprise roles, hence giving htem the strongest ROI across industries.

### 4. Skills based on Salary
The query below aims to identify which skills have the highest salaries associated with them on average. This is likely more representative of which skills have the potential to earn job seekers more money than Query no. 2, given that very, very small number of people will be in the top 10 highest earning software engineering roles.

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 2) AS "avg_salary"
FROM
    job_postings_fact
    INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Software Engineer'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT
    25
```

Here's a brief summary of my findings:
- Specialised databases lead software engineering salaries. For example, Cassandra ($213k) and Neo4j ($184k)
    show that more niche data systems command the highest pay.
- Legacy and enterprise tech also often outperforms 'trendier' tech stacks when it comes to pay. E.g. Assembly ($157k),
    ASP.NET Core ($155k), and Ruby on Rails ($150k) earn more than oversaturated JS frameworks like Node/NextJS
    ($136k and $138k respectively). This shows that there is often higher value in learning rarer skills.
- Also, analytics can still be lucrative. Tools like Matplotlib and Alteryx (~$137k) show high pay in specialised
    scientific/data visualisation and data engineering roles, even if these skills aren’t always in mainstream demand.

All in all, the salary spread is wide ($134k–213k), with clear premiums for skills that are both specialised and rarer. The data shows strong earning potential across all 25 skills, but the highest returns concentrate in databases, systems engineering, legacy tech, and less mainstream programming expertise.

### 5. Most Optimal Skills
Taking into account everything learned from queries 1–4, which skills are the most 'optimal' (i.e. strategically valuable) for software engineers to learn?

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS "demand_count",
    ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact
    INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Software Engineer'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT
    25

SELECT *
FROM job_postings_fact
ORDER BY job_posted_date DESC
LIMIT 100
```

## What I Learned

## Conclusion

## Closing Thoughts
