/*
What skills are required for the top-paying software engineer jobs?
- Use the top 10 highest-paying software engineer jobs from the first query
- Find the specific skills required for these roles.
- Why? It provides a detailed look at which high-paying jobs demand certain skills, helping job
    seekers to understand which skills to develop that align with the highest salaries in the field.
*/


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

/*
Out of the 10 highest paying roles for software engineers, the most common skills required are:
    - JavaScript & Python appear in half of the top jobs (5/10).
    - React, TypeScript, AWS appear in 40% of jobs (4/10)
    - MongoDB appear in 30% (3/10)
Most other skills are niche, only covering 1–2 jobs.

In other words, a candidate with Python, JavaScript, React, TypeScript, AWS and MongoDB
would cover the majority of the skills required for these top paying roles (at least 70%).


Results as JSON (for future reference):
[
  {
    "job_id": 562251,
    "job_title": "Senior Software Engineer",
    "company_name": "Datavant",
    "salary_year_avg": "225000.0",
    "skills": "python"
  },
  {
    "job_id": 562251,
    "job_title": "Senior Software Engineer",
    "company_name": "Datavant",
    "salary_year_avg": "225000.0",
    "skills": "javascript"
  },
  {
    "job_id": 562251,
    "job_title": "Senior Software Engineer",
    "company_name": "Datavant",
    "salary_year_avg": "225000.0",
    "skills": "typescript"
  },
  {
    "job_id": 562251,
    "job_title": "Senior Software Engineer",
    "company_name": "Datavant",
    "salary_year_avg": "225000.0",
    "skills": "azure"
  },
  {
    "job_id": 562251,
    "job_title": "Senior Software Engineer",
    "company_name": "Datavant",
    "salary_year_avg": "225000.0",
    "skills": "aws"
  },
  {
    "job_id": 562251,
    "job_title": "Senior Software Engineer",
    "company_name": "Datavant",
    "salary_year_avg": "225000.0",
    "skills": "snowflake"
  },
  {
    "job_id": 562251,
    "job_title": "Senior Software Engineer",
    "company_name": "Datavant",
    "salary_year_avg": "225000.0",
    "skills": "spark"
  },
  {
    "job_id": 562251,
    "job_title": "Senior Software Engineer",
    "company_name": "Datavant",
    "salary_year_avg": "225000.0",
    "skills": "react"
  },
  {
    "job_id": 365528,
    "job_title": "Engineering",
    "company_name": "Huckleberry Labs",
    "salary_year_avg": "205000.0",
    "skills": "python"
  },
  {
    "job_id": 365528,
    "job_title": "Engineering",
    "company_name": "Huckleberry Labs",
    "salary_year_avg": "205000.0",
    "skills": "aws"
  },
  {
    "job_id": 365528,
    "job_title": "Engineering",
    "company_name": "Huckleberry Labs",
    "salary_year_avg": "205000.0",
    "skills": "gcp"
  },
  {
    "job_id": 1356375,
    "job_title": "Senior Software Engineer, Full Stack",
    "company_name": "SmarterDx",
    "salary_year_avg": "205000.0",
    "skills": "python"
  },
  {
    "job_id": 1356375,
    "job_title": "Senior Software Engineer, Full Stack",
    "company_name": "SmarterDx",
    "salary_year_avg": "205000.0",
    "skills": "elasticsearch"
  },
  {
    "job_id": 1356375,
    "job_title": "Senior Software Engineer, Full Stack",
    "company_name": "SmarterDx",
    "salary_year_avg": "205000.0",
    "skills": "dynamodb"
  },
  {
    "job_id": 1356375,
    "job_title": "Senior Software Engineer, Full Stack",
    "company_name": "SmarterDx",
    "salary_year_avg": "205000.0",
    "skills": "aws"
  },
  {
    "job_id": 1356375,
    "job_title": "Senior Software Engineer, Full Stack",
    "company_name": "SmarterDx",
    "salary_year_avg": "205000.0",
    "skills": "snowflake"
  },
  {
    "job_id": 1356375,
    "job_title": "Senior Software Engineer, Full Stack",
    "company_name": "SmarterDx",
    "salary_year_avg": "205000.0",
    "skills": "pandas"
  },
  {
    "job_id": 1356375,
    "job_title": "Senior Software Engineer, Full Stack",
    "company_name": "SmarterDx",
    "salary_year_avg": "205000.0",
    "skills": "airflow"
  },
  {
    "job_id": 1356375,
    "job_title": "Senior Software Engineer, Full Stack",
    "company_name": "SmarterDx",
    "salary_year_avg": "205000.0",
    "skills": "react"
  },
  {
    "job_id": 1356375,
    "job_title": "Senior Software Engineer, Full Stack",
    "company_name": "SmarterDx",
    "salary_year_avg": "205000.0",
    "skills": "graphql"
  },
  {
    "job_id": 1356375,
    "job_title": "Senior Software Engineer, Full Stack",
    "company_name": "SmarterDx",
    "salary_year_avg": "205000.0",
    "skills": "node.js"
  },
  {
    "job_id": 1231528,
    "job_title": "Senior Software Engineer, Server Security",
    "company_name": "MongoDB",
    "salary_year_avg": "200000.0",
    "skills": "mongodb"
  },
  {
    "job_id": 1231528,
    "job_title": "Senior Software Engineer, Server Security",
    "company_name": "MongoDB",
    "salary_year_avg": "200000.0",
    "skills": "mongodb"
  },
  {
    "job_id": 64759,
    "job_title": "Senior Ruby Engineer - Analytics Platform - $190-210k+",
    "company_name": "Orbis",
    "salary_year_avg": "200000.0",
    "skills": "typescript"
  },
  {
    "job_id": 64759,
    "job_title": "Senior Ruby Engineer - Analytics Platform - $190-210k+",
    "company_name": "Orbis",
    "salary_year_avg": "200000.0",
    "skills": "ruby"
  },
  {
    "job_id": 64759,
    "job_title": "Senior Ruby Engineer - Analytics Platform - $190-210k+",
    "company_name": "Orbis",
    "salary_year_avg": "200000.0",
    "skills": "ruby"
  },
  {
    "job_id": 1398776,
    "job_title": "Senior Software Engineer, Cluster Scalability",
    "company_name": "MongoDB",
    "salary_year_avg": "200000.0",
    "skills": "mongodb"
  },
  {
    "job_id": 1398776,
    "job_title": "Senior Software Engineer, Cluster Scalability",
    "company_name": "MongoDB",
    "salary_year_avg": "200000.0",
    "skills": "mongodb"
  },
  {
    "job_id": 946351,
    "job_title": "Staff Frontend Engineer",
    "company_name": "Webflow",
    "salary_year_avg": "191000.0",
    "skills": "javascript"
  },
  {
    "job_id": 946351,
    "job_title": "Staff Frontend Engineer",
    "company_name": "Webflow",
    "salary_year_avg": "191000.0",
    "skills": "css"
  },
  {
    "job_id": 946351,
    "job_title": "Staff Frontend Engineer",
    "company_name": "Webflow",
    "salary_year_avg": "191000.0",
    "skills": "react"
  },
  {
    "job_id": 946351,
    "job_title": "Staff Frontend Engineer",
    "company_name": "Webflow",
    "salary_year_avg": "191000.0",
    "skills": "graphql"
  },
  {
    "job_id": 946351,
    "job_title": "Staff Frontend Engineer",
    "company_name": "Webflow",
    "salary_year_avg": "191000.0",
    "skills": "node.js"
  },
  {
    "job_id": 946351,
    "job_title": "Staff Frontend Engineer",
    "company_name": "Webflow",
    "salary_year_avg": "191000.0",
    "skills": "react.js"
  },
  {
    "job_id": 1054268,
    "job_title": "Staff Software Engineer, AI",
    "company_name": "Pulley",
    "salary_year_avg": "185000.0",
    "skills": "python"
  },
  {
    "job_id": 1054268,
    "job_title": "Staff Software Engineer, AI",
    "company_name": "Pulley",
    "salary_year_avg": "185000.0",
    "skills": "javascript"
  },
  {
    "job_id": 1054268,
    "job_title": "Staff Software Engineer, AI",
    "company_name": "Pulley",
    "salary_year_avg": "185000.0",
    "skills": "typescript"
  },
  {
    "job_id": 1054268,
    "job_title": "Staff Software Engineer, AI",
    "company_name": "Pulley",
    "salary_year_avg": "185000.0",
    "skills": "golang"
  },
  {
    "job_id": 182858,
    "job_title": "Senior Software Engineer (Confirmations - System)",
    "company_name": "ConsenSys",
    "salary_year_avg": "184500.0",
    "skills": "javascript"
  },
  {
    "job_id": 182858,
    "job_title": "Senior Software Engineer (Confirmations - System)",
    "company_name": "ConsenSys",
    "salary_year_avg": "184500.0",
    "skills": "typescript"
  },
  {
    "job_id": 182858,
    "job_title": "Senior Software Engineer (Confirmations - System)",
    "company_name": "ConsenSys",
    "salary_year_avg": "184500.0",
    "skills": "react"
  },
  {
    "job_id": 117409,
    "job_title": "Director of Software Engineer",
    "company_name": "Robert Half",
    "salary_year_avg": "182500.0",
    "skills": "python"
  },
  {
    "job_id": 117409,
    "job_title": "Director of Software Engineer",
    "company_name": "Robert Half",
    "salary_year_avg": "182500.0",
    "skills": "javascript"
  },
  {
    "job_id": 117409,
    "job_title": "Director of Software Engineer",
    "company_name": "Robert Half",
    "salary_year_avg": "182500.0",
    "skills": "html"
  },
  {
    "job_id": 117409,
    "job_title": "Director of Software Engineer",
    "company_name": "Robert Half",
    "salary_year_avg": "182500.0",
    "skills": "css"
  },
  {
    "job_id": 117409,
    "job_title": "Director of Software Engineer",
    "company_name": "Robert Half",
    "salary_year_avg": "182500.0",
    "skills": "c#"
  },
  {
    "job_id": 117409,
    "job_title": "Director of Software Engineer",
    "company_name": "Robert Half",
    "salary_year_avg": "182500.0",
    "skills": "mongodb"
  },
  {
    "job_id": 117409,
    "job_title": "Director of Software Engineer",
    "company_name": "Robert Half",
    "salary_year_avg": "182500.0",
    "skills": "redis"
  },
  {
    "job_id": 117409,
    "job_title": "Director of Software Engineer",
    "company_name": "Robert Half",
    "salary_year_avg": "182500.0",
    "skills": "mysql"
  },
  {
    "job_id": 117409,
    "job_title": "Director of Software Engineer",
    "company_name": "Robert Half",
    "salary_year_avg": "182500.0",
    "skills": "elasticsearch"
  },
  {
    "job_id": 117409,
    "job_title": "Director of Software Engineer",
    "company_name": "Robert Half",
    "salary_year_avg": "182500.0",
    "skills": "mongodb"
  },
  {
    "job_id": 117409,
    "job_title": "Director of Software Engineer",
    "company_name": "Robert Half",
    "salary_year_avg": "182500.0",
    "skills": "dynamodb"
  },
  {
    "job_id": 117409,
    "job_title": "Director of Software Engineer",
    "company_name": "Robert Half",
    "salary_year_avg": "182500.0",
    "skills": "couchbase"
  },
  {
    "job_id": 117409,
    "job_title": "Director of Software Engineer",
    "company_name": "Robert Half",
    "salary_year_avg": "182500.0",
    "skills": "azure"
  },
  {
    "job_id": 117409,
    "job_title": "Director of Software Engineer",
    "company_name": "Robert Half",
    "salary_year_avg": "182500.0",
    "skills": "aws"
  },
  {
    "job_id": 117409,
    "job_title": "Director of Software Engineer",
    "company_name": "Robert Half",
    "salary_year_avg": "182500.0",
    "skills": "asp.net"
  }
]
*/