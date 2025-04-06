--Finding the data analyst skills that are most required in jobs data analyst roles available to West Africa
SELECT COUNT (*) AS skill_count,
    skills.skills
FROM skills_job_dim
    INNER JOIN job_postings_fact AS job_postings ON skills_job_dim.job_id = job_postings.job_id
    INNER JOIN skills_dim AS skills ON skills_job_dim.skill_id = skills.skill_id
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
ORDER BY skill_count DESC
LIMIT 50