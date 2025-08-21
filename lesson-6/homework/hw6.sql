SELECT DISTINCT
  CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
  CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl;

WHERE (
    SELECT MAX(v)
    FROM (VALUES (ABS(A)), (ABS(B)), (ABS(C)), (ABS(D))) AS vals(v)
) > 0
SELECT id, name
FROM section1
WHERE id % 2 = 1;
SELECT TOP 1 id, name
FROM section1
ORDER BY id ASC;
