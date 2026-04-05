WITH high_salary AS(
    SELECT skills_job_dim.skill_id,
        round(avg(job_postings_fact.salary_year_avg), 2) AS avg_salary
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_postings_fact.job_title_short = 'Business Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_location <> 'Anywhere'
    GROUP BY skills_job_dim.skill_id
),
high_demand AS(
    SELECT skills_dim.skill_id,
        skills_dim.skills,
        count(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_postings_fact.job_title_short = 'Business Analyst'
        AND job_location <> 'Anywhere'
        AND salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
)
SELECT high_demand.skill_id,
    high_demand.skills,
    demand_count,
    avg_salary
FROM high_demand
    INNER JOIN high_salary ON high_demand.skill_id = high_salary.skill_id
WHERE demand_count > 10
ORDER BY avg_salary DESC,
    demand_count DESC
LIMIT 25