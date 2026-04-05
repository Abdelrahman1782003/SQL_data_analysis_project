/*
 displaying the top-paying Business Analyst jobs (top 10 on-site and full-time)
 */
SELECT job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    company_dim.name AS company_name
FROM job_postings_fact
    LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE job_title_short = 'Business Analyst'
    AND job_location <> 'Anywhere'
    AND job_schedule_type = 'Full-time'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;