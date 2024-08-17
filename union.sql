/*
Combine result sets of two or more SELECT statements into a single result set.
UNION: Remove duplicate rows
UNION ALL: Includes all duplicate rows

Note: Each SELECT statement within UNION must have the same number of columns in the result sets with similar data types.
*/

-- Get jobs and companies from January
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION -- combine another table

-- Get jobs and companies from February
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION -- combine another table

-- Get jobs and companies from March
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs;

/*
UNION ALL - combine the result of two or more SELECT statements
They need to have the same amount of columns and data type must match
Returns all rows, even duplicates(unlike UNION)
*/