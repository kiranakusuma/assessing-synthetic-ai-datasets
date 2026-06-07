/*
Dataset Notes

combined_batches : 300,000 records (primary analysis dataset)
all_datarows     : 1,000,000 records (validation dataset)
Dataset_source   : https://www.kaggle.com/datasets/aashyur/ai-usage-vs-output-quality-dataset

Queries in this file were used to investigate and validate
findings reported in the project README.

Analysis was performed using DuckDB, SQLite, and SQLTools is VSCode.
*/

CREATE TABLE combined_batches AS
SELECT * FROM batch_0.batch_0
UNION ALL
SELECT * FROM batch_1.batch_1
UNION ALL
SELECT * FROM batch_2.batch_2;


CREATE TABLE all_datarows AS
    SELECT * FROM combined_batches
    UNION ALL
    SELECT * FROM batch_3.batch_3
    UNION ALL
    SELECT * FROM batch_4.batch_4
    UNION ALL
    SELECT * FROM batch_5.batch_5
    UNION ALL
    SELECT * FROM batch_6.batch_6
    UNION ALL
    SELECT * FROM batch_7.batch_7
    UNION ALL
    SELECT * FROM batch_8.batch_8
    UNION ALL
    SELECT * FROM batch_9.batch_9;

SELECT * FROM combined_batches;
SELECT * FROM all_datarows;

-- Finding 1: User identity instability
SELECT user_id, timestamp, profession FROM combined_batches
WHERE user_id = 23000;
SELECT user_id, timestamp, profession FROM all_datarows
WHERE user_id = 23000;

-- Finding 2: Tool-use case specialization
SELECT use_case, tool, COUNT(tool) as tool_count FROM combined_batches
WHERE use_case = 'Image Generation'
GROUP BY use_case, tool
ORDER BY use_case, tool_count DESC;
SELECT tool, use_case, COUNT(use_case) as use_case_count FROM all_datarows
WHERE tool = 'GitHub Copilot'
GROUP BY tool, use_case
ORDER BY tool, use_case_count DESC;

-- Finding 3: Confidence score distribution
SELECT use_case, profession, COUNT(profession) as profession_count FROM combined_batches
WHERE use_case = 'UI Design'
GROUP BY use_case, profession
ORDER BY profession_count DESC;
SELECT profession, use_case, COUNT(use_case) as use_case_count FROM all_datarows
WHERE profession = 'Lawyer'
GROUP BY profession,use_case
ORDER BY use_case_count DESC;

-- Finding 4: Constrained confidence range
SELECT MIN(confidence_without_ai), MAX(confidence_without_ai), MIN(confidence_with_ai), MAX(confidence_with_ai) FROM combined_batches;
SELECT MIN(confidence_without_ai), MAX(confidence_without_ai), MIN(confidence_with_ai), MAX(confidence_with_ai) FROM all_datarows;

-- Finding 5: Coherent pattern of productivity gain
SELECT iterations, AVG(session_length) FROM combined_batches
GROUP BY iterations
ORDER BY iterations;
SELECT iterations, AVG(session_length) FROM all_datarows
GROUP BY iterations
ORDER BY iterations;

-- Finding 6: Productivity gain follows a coherent behavioral pattern
SELECT ROUND(quality_with_ai, 1) AS quality_with_ai, ROUND(AVG(productivity_gain), 1) AS avg_productivity_gain FROM combined_batches
GROUP BY quality_with_ai
ORDER BY quality_with_ai;
SELECT ROUND(quality_without_ai, 1) AS quality_without_ai, ROUND(AVG(productivity_gain), 1) AS avg_productivity_gain FROM all_datarows
GROUP BY ROUND(quality_without_ai, 1)
ORDER BY ROUND(quality_without_ai, 1);






