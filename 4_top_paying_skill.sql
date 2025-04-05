-- Finding the top skills based on salary
--Average salary associated with each skill for data analyst positions
SELECT ROUND (AVG (job_postings_fact.salary_year_avg), 0) AS avg_yr_sal,
    skills.skills
FROM job_postings_fact
    INNER JOIN skills_job_dim AS skill_to_job ON job_postings_fact.job_id = skill_to_job.job_id
    INNER JOIN skills_dim AS skills ON skill_to_job.skill_id = skills.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND (
        (
            job_country IN (
                'Ghana',
                'Nigeria',
                'Togo',
                'Niger',
                'Cameroon',
                'Mali',
                'Senegal',
                'Burkina Faso',
                'Benin',
                'Mauritania',
                'Guinea',
                'Guinea-Bissau',
                'Gambia',
                'Cape Verde',
                'Liberia',
                'Sierra Leone'
            )
            OR job_location = 'Anywhere'
            OR job_country LIKE '%Ivoire%'
        )
    )
GROUP BY skills.skills
ORDER BY avg_yr_sal DESC
LIMIT 50