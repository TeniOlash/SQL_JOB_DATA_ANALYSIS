-- Finding the specific skills required for the highest paying jobs available to West African Data Analyst roles
WITH top_paying_jobs AS (
    SELECT job_id,
        job_title,
        job_location,
        company.name,
        salary_year_avg
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
)
SELECT top_paying_jobs.*,
    skills.skills
FROM top_paying_jobs
    INNER JOIN skills_job_dim AS skill_to_job ON top_paying_jobs.job_id = skill_to_job.job_id
    INNER JOIN skills_dim AS skills ON skill_to_job.skill_id = skills.skill_id
ORDER BY salary_year_avg DESC
    /* Key Findings from the Skills Analysis:
     Most In-Demand Skills:
     SQL (37 listings) is the most required skill, reinforcing its importance for data querying and database management.
     Python (28 listings) follows closely, highlighting its role in data analysis, machine learning, and automation.
     Tableau (23 listings) is the most in-demand data visualization tool, showing the need for dashboarding and reporting expertise.
     
     Other Notable Skills:
     Excel (14 listings) remains relevant despite newer tools.
     R (18 listings) is still in demand, particularly for statistical modeling.
     Power BI, Looker, and Snowflake (each around 9 listings) indicate a rising preference for cloud-based and business intelligence tools.
     Cloud & Big Data Technologies:
     Azure, AWS, Hadoop, Snowflake, and Oracle suggest that data analysts are expected to work with cloud data platforms.
     Less Common but Valuable Skills:
     SAS (12 listings) still appears in some roles, likely in industries like finance and healthcare.
     Go (6 listings) shows an emerging trend, possibly in roles requiring backend analytics. */