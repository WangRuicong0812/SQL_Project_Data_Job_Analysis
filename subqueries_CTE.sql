SELECT *
FROM ( -- SubQuery starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;
-- SubQuery ends here

-- Common Table Expression (CTEs): define a temporary result set that you can reference
-- Can reference within a SELECT, INSERT, UPDATE, or DELETE statement
-- Defined with WITH

WITH january_jobs AS ( -- CTE definition starts here  WITH new table name AS (CTE definition)
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) -- CTE definition ends here

SELECT *
    FROM january_jobs; -- CTE reference

-- Subqueries Notes
-- It can be used in several places in the main query such as SELECT, FROM, WHERE or HAVING clauses
-- It's executed first, and the results are passed to the outer query
-- It is used when you want to perform a calculation before the main query can complete its calculation

-- I wante to get a list of companies that are offering jobs don't have any requirements for degree

SELECT 
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT 
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = true
    ORDER BY 
        company_id
);

-- CTEs - Common Table Expressions
-- Exists only during the execution of a query
-- It's defined query that can be referenced in the main query or other CTEs
-- WITH - used to define a CTE at the beginning of a query

/*
Find the companies that have the most job openings.
- Get the total number of job postings per company id (job_postings_fact)
- Return the total number of jobs with the company name (company_dim)
*/
WITH company_job_count AS(
SELECT
    company_id,
    COUNT(*) AS total_jobs
FROM 
    job_postings_fact
GROUP BY 
    company_id)
SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM 
    company_dim
LEFT JOIN company_job_count ON company_dim.company_id = company_job_count.company_id
ORDER BY 
    total_jobs DESC;