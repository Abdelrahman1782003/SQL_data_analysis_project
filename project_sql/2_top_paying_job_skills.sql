WITH top_paying_jobs AS(
    SELECT job_id,
        job_title,
        job_location,
        salary_year_avg,
        company_dim.name AS company_name
    FROM job_postings_fact
        LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
    WHERE job_title_short = 'Business Analyst'
        AND job_location <> 'Anywhere'
        AND job_schedule_type = 'Full-time'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT top_paying_jobs.*,
    skills_dim.skills
FROM top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    /*
     for better sight on the number of job_postings per-skill you can use this query instead
     
     SELECT 
     count(top_paying_jobs.job_id) AS job_posting,
     skills_dim.skills AS skills
     FROM top_paying_jobs
     INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
     INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
     GROUP BY
     skills
     ORDER BY
     job_posting DESC
     */