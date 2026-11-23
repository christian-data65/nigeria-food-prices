
-- Question 1: Which five (5) food items had the highest prices in the latest reporting month?

SELECT
    Items_Label,
    `Average of Nov-24`,
    `Average of Oct-24`,
    `Average of Nov-23`
FROM nov_2024
ORDER BY `Average of Nov-24` DESC
LIMIT 5;

-- RESULT:
-- Frozen chicken  | 6130.514594 | 5971.976202 | 3645.891982
-- Beef,boneless  | 6001.316307 | 5858.576746 | 3029.500972
-- Catfish :dried | 5787.744495 | 5571.441975 | 3276.628868
-- Mudfish : dried| 5345.990902 | 5139.912141 | 2982.688137
-- Beef Bone in   | 5073.735812 | 4914.621883 | 2630.015235
