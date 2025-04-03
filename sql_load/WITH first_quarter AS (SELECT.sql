WITH first_quarter AS (
    SELECT jan.job_title_short,
        jan.job_id,
        jan.salary_year_avg
    FROM january_jobs jan
    UNION ALL
    SELECT feb.job_title_short,
        feb.job_id,
        feb.salary_year_avg
    FROM february_jobs feb
    UNION ALL
    SELECT mar.job_title_short,
        mar.job_id,
        mar.salary_year_avg
    FROM march_jobs mar
)
SELECT first_quarter.job_title_short,
    skills.skills,
    first_quarter.salary_year_avg,
    skills.type
FROM first_quarter
    INNER JOIN skills_job_dim AS skills_jobs ON first_quarter.job_id = skills_jobs.job_id
    INNER JOIN skills_dim AS skills ON skills_jobs.skill_id = skills.skill_id
WHERE first_quarter.salary_year_avg > 70000
    AND first_quarter.job_title_short = 'Data Analyst'
ORDER BY first_quarter.salary_year_avg DESC