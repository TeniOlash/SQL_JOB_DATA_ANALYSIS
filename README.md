Pending update...

# INTRODUCTION

Introduction
As data-driven decision-making becomes increasingly essential across industries, the demand for data analysts continues to grow globally—including in West Africa. However, navigating the regional job landscape, identifying the most lucrative opportunities, and aligning one’s skill set with market demands can be a challenge for both aspiring and experienced professionals.

This project analyzes data analyst job listings and associated skills to uncover actionable insights for those seeking to build a data career within or from West Africa. It aims to highlight not only the most sought-after and highest-paying roles but also the specific technical skills that provide the best return on investment in terms of employability and earning potential.
[sql_files Folder](/sql_files/)

# BACKGROUND

The West African tech ecosystem is rapidly evolving, with many organizations adopting digital transformation strategies. As a result, the need for qualified data analysts is on the rise. Yet, the regional job market is unique—affected by factors such as remote job availability, international collaborations, infrastructure limitations, and diverse employer expectations. Data is gotten from the [sql course](https://lukebarrouse.com/sql)

This analysis explores the following core areas:

- **Highest Paying Jobs:** Identifying the roles with the most attractive compensation packages (both local and remote).

- **Job Demand:** Analyzing which job titles appear most frequently in listings to assess demand.

- **Skill Requirements:** Understanding which technical and analytical skills are consistently required for these roles.

- **Relation of Skills with Higher Salaries:** Identifying the skills which are associated with higher salaries.

- **Optimal Skill Set:** Combining insights from salary and demand data to determine the most strategic skills for data analysts in the region.

By addressing these questions, the project serves as a practical guide for individuals aiming to position themselves competitively in the West African data job market.

# TOOLS USED

This project utilized a range of industry-standard tools and technologies for data analysis, querying, and version control:

- **SQL:** Employed for querying, aggregating, and transforming structured job and skill datasets.

- **PostgreSQL:** Used as the relational database management system for storing and managing data efficiently.

- **Visual Studio Code (VS Code):** The primary integrated development environment (IDE) used for writing and managing code in a clean, modular structure.

- **Git:** Enabled version control and collaboration, ensuring reproducibility and tracking of project changes.

- **GitHub:** Served as the remote repository for code management, sharing, and documentation.

# ANALYSIS

### 1. Exploring Data Analyst Opportunities in West Africa with the Highest Pays.

Here, the focus was on quantifying and categorizing job opportunities in the region based on earning. The goal was to determine which data analyst roles are associated with the highest salaries.

```sql
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
```

Top Salary: The highest-paying data analyst role offers an annual salary of $650,000, listed by a company called Mantys.

Other High Earners: Roles like Director of Analytics (Meta, $336,500) and Associate Director – Data Insights (AT&T, $255,829) are also among the top.

Remote Opportunities: Many of these high-paying roles are marked as "Anywhere," suggesting significant remote work potential for West African analysts.

### 2. Finding the Specific Skills Required for the Highest Paying Jobs

This part of the analysis isolated the technical skills most commonly required in the highest paying roles. It helps job seekers understand which competencies are associated with top-tier salaries.

```sql
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
LIMIT 50
```

SQL and Python are non-negotiable for high-paying data analyst roles.

Data visualization tools (Tableau, Power BI) and presentation tools (PowerPoint) are highly valued.

Cloud-related and big data technologies (AWS, Azure, Databricks, PySpark, Hadoop) are common in the highest-tier roles.

Versatility matters: Top-paying roles prefer analysts who can code, analyze, visualize, and communicate results effectively.

### 3. Finding the Data Analyst Skills Most Required by Employers

Beyond just high-paying roles, this analysis looked at overall demand—identifying the skills most frequently requested by employers across all job listings targeting West African data analysts.

```sql
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
```

The most frequently requested skills in job listings:

SQL – 402 mentions

Excel – 257 mentions

Python – 236 mentions

Tableau – 232 mentions

R – 148 mentions

Insight: Mastery of these tools significantly increases a candidate’s chances of qualifying for most data analyst roles in the region.

### 4. Finding the Top Skills Based on Salary

This analysis ranked skills solely based on their associated average salary. It highlights the tools and technologies that, when listed in job requirements, correlate with higher pay.

```sql
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
```

The highest average salary is associated with:

Go – $115,320

Snowflake – $112,948

Azure – $110,862

AWS – $108,020

Looker – $103,689

These skills may not be the most common, but they command premium compensation, making them valuable differentiators.

### 5. Finding the Most Optimal Skills to Have as a Data Analyst in West Africa

To determine the most strategic skills to learn or focus on, this section combined salary and demand data. It identifies skills that strike the best balance between being in high demand and offering high compensation—making them optimal for career growth.

```sql
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
```

By balancing demand and salary, the most optimal skills include:

Python – High demand and strong salary

SQL – Highest demand with solid pay

Tableau – In-demand and well-compensated

Snowflake & Looker – Lower demand but high-paying

Azure & AWS – Valuable for cloud-based data analysis roles

These skills offer the best strategic advantage for data analysts aiming to maximize employability and earnings in West Africa.

# CONCLUSION

This project offers a comprehensive examination of the data analytics job market in West Africa, with a focus on identifying the most lucrative and in-demand opportunities for aspiring and practicing data analysts. The analysis revealed key trends that can inform strategic skill development and career positioning:

SQL and Python stand out as essential core competencies, appearing consistently across high-paying and highly demanded roles.

Data visualization tools such as Tableau and Power BI, along with foundational tools like Excel, remain highly relevant and frequently requested.

Proficiency in cloud platforms (e.g., AWS, Azure) and big data technologies (e.g., Hadoop, Databricks, PySpark) significantly boosts salary potential.

Optimal skills—those that are both in high demand and associated with high salaries—include a blend of programming, analytics, and visualization capabilities.

Overall, the findings suggest that data analysts in West Africa who invest in building a strong portfolio of modern, high-utility skills are well-positioned to access competitive opportunities both locally and globally. By strategically aligning one's skillset with market demand, it is possible to not only secure employment but also command higher compensation and career growth.
