-- Finding the most optimal skills to have as a Data Analyst in West Africa.
-- Identifies skills in high demand and high associated salaries
SELECT skills.skill_id,
    skills.skills,
    COUNT (*) AS skill_count,
    ROUND (AVG (jp.salary_year_avg), 0) AS avg_yr_sal
FROM job_postings_fact AS jp
    INNER JOIN skills_job_dim AS skills_to_job ON jp.job_id = skills_to_job.job_id
    INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
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
GROUP BY skills.skills,
    skills.skill_id
HAVING COUNT(skills_to_job.job_id) > 25
ORDER BY avg_yr_sal DESC,
    skill_count DESC
LIMIT 25
    /*
     INSIGHTS
     Python and SQL remain foundational—widely used and well-paid.
     
     Snowflake, Looker, and Azure are less common but very lucrative, suggesting a strong edge if you're certified or experienced in them.
     
     Visualization tools like Tableau and Looker also carry weight in both salary and demand.*/