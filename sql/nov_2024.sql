
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


-- Question 2: Which five (5) food items had the lowest prices in the latest reporting month?

SELECT
    Items_Label,
    `Average of Nov-24`,
    `Average of Oct-24`,
    `Average of Nov-23`
FROM nov_2024
ORDER BY `Average of Nov-24` ASC
LIMIT 5;

-- RESULT:
-- Agric eggs (medium size price of one) | 247.2590999 | 235.6734981 | 110.0988721
-- Evaporated tinned milk carnation 170g | 873.77102 | 843.2107901 | 469.7295045
-- Sweet potato | 942.2383441 | 898.5318626 | 490.8030132
-- Evaporated tinned milk (peak), 170g | 991.2039919 | 955.7272365 | 526.8293115
-- Maize grain white sold loose | 1156.908638 | 1080.442104 | 557.3295579


-- Question 3: Which food items experienced the biggest increases compared with the previous month (October 2024)?

SELECT
    Items_Label,
    ROUND(
        `Average of Nov-24` - `Average of Oct-24`, 2
    ) AS Monthly_Increase
FROM nov_2024
ORDER BY Monthly_Increase DESC
LIMIT 5;

-- RESULT:
-- Onion bulb                              | 626.48
-- Vegetable oil:1 bottle,specify bottle   | 427.88
-- Palm oil: 1 bottle,specify bottle       | 319.80
-- Groundnut oil: 1 bottle, specify bottle | 236.46
-- Catfish :dried                          | 216.30


-- Question 4: Which food items experienced the biggest price decreases compared with October 2024?

SELECT
    Items_Label,
    ROUND(
        `Average of Nov-24` - `Average of Oct-24`, 2
    ) AS Monthly_Decrease
FROM nov_2024
ORDER BY Monthly_Decrease ASC
LIMIT 5;

-- RESULT:
-- Beans brown,sold loose                | -77.54
-- Beans:white black eye. sold loose     | -56.62
-- Tomato                                | 6.19
-- Gari white,sold loose                 | 7.34
-- Agric eggs(medium size price of one)  | 11.59


---- 5. Which geopolitical zone recorded the highest average food prices?

SELECT 'NORTH CENTRAL' AS Zone,
       AVG(`NORTH CENTRAL`) AS Average_Price
FROM nov_2024

UNION ALL

SELECT 'NORTH EAST',
       AVG(`NORTH EAST`)
FROM nov_2024

UNION ALL

SELECT 'NORTH WEST',
       AVG(`NORTH WEST`)
FROM nov_2024

UNION ALL

SELECT 'SOUTH EAST',
       AVG(`SOUTH EAST`)
FROM nov_2024

UNION ALL

SELECT 'SOUTH SOUTH',
       AVG(`SOUTH SOUTH`)
FROM nov_2024

UNION ALL

SELECT 'SOUTH WEST',
       AVG(`SOUTH WEST`)
FROM nov_2024

ORDER BY Average_Price DESC
LIMIT 1;

--RESULT:
--SOUTH EAST	3366.408149809302

---- 6. Which food items have the biggest price differences across the six geopolitical zones?

SELECT
    Items_Label,

    GREATEST(
        `NORTH CENTRAL`,
        `NORTH EAST`,
        `NORTH WEST`,
        `SOUTH EAST`,
        `SOUTH SOUTH`,
        `SOUTH WEST`
    ) AS Highest_Zone_Price,

    LEAST(
        `NORTH CENTRAL`,
        `NORTH EAST`,
        `NORTH WEST`,
        `SOUTH EAST`,
        `SOUTH SOUTH`,
        `SOUTH WEST`
    ) AS Lowest_Zone_Price,

    ROUND(
        GREATEST(
            `NORTH CENTRAL`,
            `NORTH EAST`,
            `NORTH WEST`,
            `SOUTH EAST`,
            `SOUTH SOUTH`,
            `SOUTH WEST`
        )
        -
        LEAST(
            `NORTH CENTRAL`,
            `NORTH EAST`,
            `NORTH WEST`,
            `SOUTH EAST`,
            `SOUTH SOUTH`,
            `SOUTH WEST`
        ), 2
    ) AS Price_Difference

FROM nov_2024

ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Catfish :dried	10862.27888	4072.557523	6789.72
--Mudfish : dried	9780.005346	3656.514939	6123.49
--Tilapia fish (epiya) fresh	5689.519344	2878.326574	2811.19
--Dried Fish Sardine	6781.80838	4099.372082	2682.44
--Frozen chicken	7634.548791	5291.666667	2342.88

---- 7. Which food items experienced the highest percentage price increases year-on-year ?

SELECT
    Items_Label,
    `Average of Nov-24`,
    `Average of Nov-23`,
    ROUND(
        (
          (`Average of Nov-24` - `Average of Nov-23`)
          / `Average of Nov-23`
        ) * 100, 2
    ) AS Percentage_Increase
FROM nov_2024
WHERE `Average of Nov-23` > 0
ORDER BY Percentage_Increase DESC
LIMIT 5;

--RESULT:
--Beans brown,sold loose	2720.960842	838.8491506	224.37
--Beans:white black eye. sold loose	2546.702546	800.486773	218.14
--Onion bulb	1878.00151	683.7783959	174.65
--Broken Rice (Ofada)	2485.138865	940.1597359	164.33
--Yam tuber	1836.008545	772.7244469	137.6

---- 8. Which food items maintained the most stable prices between November 2023 and November 2024 ?

SELECT
    Items_Label,
    `Average of Nov-23`,
    `Average of Nov-24`,
    ROUND(
         ABS(`Average of Nov-24` - `Average of Nov-23`), 2) AS Price_Difference
FROM nov_2024
ORDER BY Price_Difference ASC
LIMIT 5;

--RESULT:
--Agric eggs(medium size price of one)	110.0988721	247.2590999	137.16
--Evaporated tinned milk carnation 170g	469.7295045	873.77102	404.04
--Sweet potato	490.8030132	942.2383441	451.44
--Evaporated tinned milk(peak), 170g	526.8293115	991.2039919	464.37
--Maize grain white sold loose	557.3295579	1156.908638	599.58

---- 9. Which food items experienced a higher percentage price increases than the overall average ?


WITH Price_Changes AS (
    SELECT
        Items_Label,
        ROUND(
            (
                (`Average of Nov-24` - `Average of Nov-23`)
                / `Average of Nov-23`
            ) * 100, 2
        ) AS Percentage_Increase
    FROM nov_2024
    WHERE `Average of Nov-23` > 0
)

SELECT *
FROM Price_Changes
WHERE Percentage_Increase > (
    SELECT AVG(Percentage_Increase)
    FROM Price_Changes
)
ORDER BY Percentage_Increase DESC
LIMIT 10;

--RESULT:
--Beans brown,sold loose	224.37
--Beans:white black eye. sold loose	218.14
--Onion bulb	174.65
--Broken Rice (Ofada)	164.33
--Yam tuber	137.6
--Agric eggs medium size	135.74
--Rice local sold loose	126.02
--Gari yellow,sold loose	125.61
--Plantain(unripe)	125.45
--Rice Medium Grained	124.77

---- 10. Which food items have the biggest price differences between states?

SELECT
    Items_Label,
    `Highest`,
    `Lowest`,
    ROUND(
        CAST(SUBSTRING_INDEX(`Highest`, '(', -1) AS DECIMAL(10,2))
        -
        CAST(SUBSTRING_INDEX(`Lowest`, '(', -1) AS DECIMAL(10,2)),
        2
    ) AS Price_Difference
FROM nov_2024
ORDER BY Price_Difference DESC
LIMIT 5;

--Catfish :dried	Imo (12181.27)	Kano (3950.44)	8230.83
--Mudfish : dried	Abia (10329.43)	Plateau (3145.69)	7183.74
--Dried Fish Sardine	Nasarawa (7474.67)	Niger (2900.57)	4574.10
--Chicken Feet	Niger (5713.05)	Taraba (1200)	4513.05
--Tilapia fish (epiya) fresh	Ebonyi (6384.57)	Taraba (2200)	4184.57

