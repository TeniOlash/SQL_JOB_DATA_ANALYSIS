-- Finding the highest paying data analyst jobs available to West Africans(Local and Remote)
-- Exploring data analyst opportunities in West Africa
SELECT job_id,
    job_title,
    job_location,
    company.name,
    salary_year_avg,
    job_schedule_type,
    job_posted_date
FROM job_postings_fact
    LEFT JOIN company_dim AS company ON job_postings_fact.company_id = company.company_id
WHERE (
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
    AND salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC
LIMIT 50