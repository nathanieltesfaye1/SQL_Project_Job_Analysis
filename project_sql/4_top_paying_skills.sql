/*
Which skills have the highest salaries associated with them?
- Look at the average salary associated with each skill for software engineering roles.
- Focus on roles with salaries specified (i.e. not null), regardless of location.
- Why? It helps to reveal how different skills impact salary potential for
    software engineers, hence identifying the most financially rewarding skills to
    acquire and/or improve.
*/

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

/*
Succinct summary:
- Specialised databases lead software engineering salaries. For example, Cassandra ($213k) and Neo4j ($184k)
    show that more niche data systems command the highest pay.
- Legacy and enterprise tech also often outperforms 'trendier' tech stacks when it comes to pay. E.g. Assembly ($157k),
    ASP.NET Core ($155k), and Ruby on Rails ($150k) earn more than oversaturated JS frameworks like Node/NextJS
    ($136k and $138k respectively). This shows that there is often higher value in learning rarer skills.
- Also, analytics can still be lucrative. Tools like Matplotlib and Alteryx (~$137k) show high pay in specialised
    scientific/data visualisation and data engineering roles, even if these skills aren’t always in mainstream demand.

All in all, the salary spread is wide ($134k–213k), with clear premiums for skills that are both specialised and rarer. The data
shows strong earning potential across all 25 skills, but the highest returns concentrate in databases, systems engineering, legacy tech,
and less mainstream programming expertise.




For future reference:

[
  {
    "skills": "cassandra",
    "avg_salary": "213333.33"
  },
  {
    "skills": "debian",
    "avg_salary": "196500.00"
  },
  {
    "skills": "neo4j",
    "avg_salary": "183840.00"
  },
  {
    "skills": "couchbase",
    "avg_salary": "166250.00"
  },
  {
    "skills": "assembly",
    "avg_salary": "157188.25"
  },
  {
    "skills": "asp.net core",
    "avg_salary": "155000.00"
  },
  {
    "skills": "ruby on rails",
    "avg_salary": "149500.00"
  },
  {
    "skills": "dynamodb",
    "avg_salary": "148812.50"
  },
  {
    "skills": "node",
    "avg_salary": "145147.14"
  },
  {
    "skills": "aurora",
    "avg_salary": "144561.43"
  },
  {
    "skills": "express",
    "avg_salary": "143816.00"
  },
  {
    "skills": "go",
    "avg_salary": "142748.22"
  },
  {
    "skills": "julia",
    "avg_salary": "142500.00"
  },
  {
    "skills": "workfront",
    "avg_salary": "142430.00"
  },
  {
    "skills": "sharepoint",
    "avg_salary": "141454.33"
  },
  {
    "skills": "clojure",
    "avg_salary": "140000.00"
  },
  {
    "skills": "next.js",
    "avg_salary": "138433.33"
  },
  {
    "skills": "matplotlib",
    "avg_salary": "137675.00"
  },
  {
    "skills": "mongo",
    "avg_salary": "137502.00"
  },
  {
    "skills": "alteryx",
    "avg_salary": "137500.00"
  },
  {
    "skills": "golang",
    "avg_salary": "136685.29"
  },
  {
    "skills": "node.js",
    "avg_salary": "136656.82"
  },
  {
    "skills": "looker",
    "avg_salary": "134431.25"
  },
  {
    "skills": "atlassian",
    "avg_salary": "134000.00"
  },
  {
    "skills": "c",
    "avg_salary": "133721.40"
  }
]
*/