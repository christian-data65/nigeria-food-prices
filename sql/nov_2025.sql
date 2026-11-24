---- 1. which five(5) food items has the highest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of November-25`,
      `Average of October-25`,
	  `Average of November-24`
FROM nov_2025
ORDER BY  `Average of November-25` DESC
LIMIT 5;

--RESULT:
--Cray fish small white	8606.72333	8690.200282	
--Dried fish, Bonga	7263.979829	7213.33455	
--Goat Meat Bone in	6911.386432	6891.44199	
--Beef Boneless	6908.218147	6850.50967	6001.32
--Titus, frozen	6413.414469	6415.748644	4626.82


---- 2. Which five(5) food items has the lowest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of November-25`,
      `Average of October-25`,
	  `Average of November-24`
FROM nov_2025
ORDER BY  `Average of November-25` ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	244.9653384	252.7905521	247.26
--Sweet potatoes 	809.6818681	838.9954456	942.24
--Garri white	819.6990852	846.6882745	1205.39
--Maize (Corn) Grains (White) sold loose	843.7726101	904.7357077	1156.91
--Garri Yellow	887.9656714	925.4296468	1311.03


---- 3. Which food items experienced the biggest increases compared with the previous October 2025 ?

SELECT Items_Label,
      ROUND(
           `Average of November-25` - `Average of October-25`, 2
		) AS Monthly_Increase
FROM nov_2025
ORDER BY Monthly_Increase DESC
LIMIT 5;

--RESULT:
--Vegetable Oil, 75cl	60.26
--Tilapia fresh fish (Epiya)	60.44
--Irish Potatoe	139.6
--Dried fish, Bonga	50.65
--Beef Boneless	57.71


----  4. Which food items experienced the biggest price decreases compared with the previous October 2025 ? 

SELECT
    Items_Label,
    ROUND(
        `Average of November-25` - `Average of October-25`, 2
    ) AS Monthly_Decrease
FROM nov_2025
ORDER BY Monthly_Decrease ASC
LIMIT 5; 

--RESULT:
--Beans Brown	-213.5
--Beans white	-157.23
--Local Rice (Broken)	-103.14
--Cray fish small white	-83.48
--Maize (Corn) Grains (White) sold loose	-60.96


---- 5. Which geopolitical zone recorded the highest average food prices?

SELECT 'NORTH CENTRAL' AS Zone,
       AVG(`NORTH CENTRAL`) AS Average_Price
FROM nov_2025

UNION ALL

SELECT 'NORTH EAST',
       AVG(`NORTH EAST`)
FROM nov_2025

UNION ALL

SELECT 'NORTH WEST',
       AVG(`NORTH WEST`)
FROM nov_2025

UNION ALL

SELECT 'SOUTH EAST',
       AVG(`SOUTH EAST`)
FROM nov_2025

UNION ALL

SELECT 'SOUTH SOUTH',
       AVG(`SOUTH SOUTH`)
FROM nov_2025

UNION ALL

SELECT 'SOUTH WEST',
       AVG(`SOUTH WEST`)
FROM nov_2025

ORDER BY Average_Price DESC
LIMIT 1;

--RESULT:
--SOUTH EAST	3628.102452770732


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

FROM nov_2025

ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	9924.948771	5650.824368	4274.12
--Mackerel, Frozen	7632.423892	4460.098459	3172.33
--Chicken meat (Frozen)	8055.999558	4914.081429	3141.92
--Goat Meat Bone in	8638.042038	5792.046536	2846
--Cray fish small white	9738.917306	7110.451811	2628.47


---- 7. Which food items experienced the highest percentage price increases year-on-year ?

SELECT
    Items_Label,
    `Average of November-24`,
    `Average of November-25`,
    ROUND(
        (
          (`Average of November-25` - `Average of November-24`)
          / `Average of November-24`
        ) * 100, 2
    ) AS Percentage_Increase
FROM nov_2025
WHERE `Average of November-24` > 0
ORDER BY Percentage_Increase DESC
LIMIT 5;

--RESULT:
--Tilapia fresh fish (Epiya)	4039.63	5880.416109	45.57
--Cat fresh fish	4259.99	6097.447924	43.13
--Plantain (unripe)	1566.2	2202.130018	40.6
--Titus, frozen	4626.82	6413.414469	38.61
--Plantain (ripe)	1540.2	2133.623892	38.53


---- 8. Which food items maintained the most stable prices between November 2024 and November 2025 ?

SELECT
    Items_Label,
    `Average of November-24`,
    `Average of November-25`,
    ROUND(
         ABS(`Average of November-25` - `Average of November-24`), 2) AS Price_Difference
FROM nov_2025
ORDER BY Price_Difference ASC
LIMIT 5;

--RESULT
--Agric hen eggs, 	247.26	244.9653384	2.29
--Wheat Flour, Prepacked (2kg)	3819.37	3808.536351	10.83
--Palm oil, 75cl	2466.79	2508.733919	41.94
--Tin Milk-Evaporated, Peak Milk, 150g	991.2	1056.79682	65.6
--Irish Potatoe	1778.96	1706.922417	72.04


---- 9. Which food items experienced a higher percentage price increases than the overall average ?

WITH Price_Changes AS (
    SELECT
        Items_Label,
        ROUND(
            (
                (`Average of November-25` - `Average of November-24`)
                / `Average of November-24`
            ) * 100, 2
        ) AS Percentage_Increase
    FROM nov_2025
    WHERE `Average of November-24` > 0
)

SELECT *
FROM Price_Changes
WHERE Percentage_Increase > (
    SELECT AVG(Percentage_Increase)
    FROM Price_Changes
)
ORDER BY Percentage_Increase DESC;

--RESULT:
--Tilapia fresh fish (Epiya)	45.57
--Cat fresh fish	43.13
--Plantain (unripe)	40.6
--Titus, frozen	38.61
--Plantain (ripe)	38.53
--Mackerel, Frozen	38.41
--Beef Boneless	15.11
--Chicken Wings	14.78
--Chicken feet	12.18
--Yam Tuber	10.87
--Tin Milk-Evaporated, Peak Milk, 150g	6.62
--Vegetable Oil, 75cl	3.73


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
FROM nov_2025
ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	Imo (11533.12)	Katsina (5147.08)	6386.04
--Mackerel, Frozen	Plateau (9079.47)	Zamfara (3701.1)	5378.37
--Tilapia fresh fish (Epiya)	Bauchi (9000)	Sokoto (3738.56)	5261.44
--Goat Meat Bone in	Ebonyi (9001)	Kogi (4034.16)	4966.84
--Cat fresh fish	Plateau (8323.15)	Kaduna (3672.33)	4650.82
