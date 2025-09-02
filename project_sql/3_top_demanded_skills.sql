/*
What are the most in-demand skills for software engineers?
- Identify the top 5 most in-demand skills for software engineers.
- Focus on ALL job postings
- Why? Provides insights into the most valuable (and potentially highest ROI) skills
    for job seekers
*/

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