---- 1. which five(5) food items has the highest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of October-25`,
      `Average of September-25`,
	  `Average of October-24`
FROM oct_2025
ORDER BY  `Average of October-25` DESC
LIMIT 5;

--RESULT:
--Cray fish small white	8690.200282	8754.601455	
--Dried fish, Bonga	7213.33455	7030.168543	
--Goat Meat Bone in	6891.44199	6812.960814	
--Beef Boneless	6850.50967	6861.246548	5858.576746
--Titus, frozen	6415.748644	6352.951259	4509.384058


---- 2. Which five(5) food items has the lowest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of October-25`,
      `Average of September-25`,
	  `Average of October-24`
FROM oct_2025
ORDER BY  `Average of October-25` ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	252.7905521	248.2154462	235.6734981
--Sweet potatoes 	838.9954456	834.3496651	898.5318626
--Garri white	846.6882745	871.7757576	1198.04718
--Maize (Corn) Grains (White) sold loose	904.7357077	888.6815456	1080.442104
--Garri Yellow	925.4296468	961.2109973	1266.314963


---- 3. Which food items experienced the biggest increases compared with the previous September 2025 ?

SELECT Items_Label,
      ROUND(
           `Average of October-25` - `Average of September-25`, 2
		) AS Monthly_Increase
FROM oct_2025
ORDER BY Monthly_Increase DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	183.17
--Tilapia fresh fish (Epiya)	99.91
--Agric hen eggs, (a Crate of 30 pieces)	95.13
--Goat Meat Bone in	78.48
--Cat fresh fish	72.5


----  4. Which food items experienced the biggest price decreases compared with the previous September 2025 ? 

SELECT
    Items_Label,
    ROUND(
        `Average of October-25` - `Average of September-25`, 2
    ) AS Monthly_Decrease
FROM oct_2025
ORDER BY Monthly_Decrease ASC
LIMIT 5; 

--RESULT:
--Wheat Flour, Prepacked (2kg)	-92.56
--Irish Potatoe	-65.77
--Cray fish small white	-64.4
--Rice Long-Grained (Imported)	-64.03
--Beans Brown	-55.23


---- 5. Which geopolitical zone recorded the highest average food prices?

SELECT 'NORTH CENTRAL' AS Zone,
       AVG(`NORTH CENTRAL`) AS Average_Price
FROM oct_2025

UNION ALL

SELECT 'NORTH EAST',
       AVG(`NORTH EAST`)
FROM oct_2025

UNION ALL

SELECT 'NORTH WEST',
       AVG(`NORTH WEST`)
FROM oct_2025

UNION ALL

SELECT 'SOUTH EAST',
       AVG(`SOUTH EAST`)
FROM oct_2025

UNION ALL

SELECT 'SOUTH SOUTH',
       AVG(`SOUTH SOUTH`)
FROM oct_2025

UNION ALL

SELECT 'SOUTH WEST',
       AVG(`SOUTH WEST`)
FROM oct_2025

ORDER BY Average_Price DESC
LIMIT 1;

--RESULT:
--SOUTH EAST	3588.214049492683


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

FROM oct_2025

ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	9997.442492	5475.78056	4521.66
--Mackerel, Frozen	7633.46833	4396.2632	3237.21
--Chicken meat (Frozen)	7946.405275	4903.571429	3042.83
--Goat Meat Bone in	8450.411053	5789.354121	2661.06
--Cray fish small white	9707.25365	7140.359755	2566.89


---- 7. Which food items experienced the highest percentage price increases year-on-year ?

SELECT
    Items_Label,
    `Average of October-24`,
    `Average of October-25`,
    ROUND(
        (
          (`Average of October-25` - `Average of October-24`)
          / `Average of October-24`
        ) * 100, 2
    ) AS Percentage_Increase
FROM oct_2025
WHERE `Average of October-24` > 0
ORDER BY Percentage_Increase DESC
LIMIT 5;

--RESULT:
--Tilapia fresh fish (Epiya)	3944.393697	5819.974591	47.55
--Cat fresh fish	4148.741367	6047.172427	45.76
--Plantain (unripe)	1539.6564	2233.526059	45.07
--Plantain (ripe)	1507.205915	2155.357766	43
--Titus, frozen	4509.384058	6415.748644	42.28


---- 8. Which food items maintained the most stable prices between October 2024 and October 2025 ?

SELECT
    Items_Label,
    `Average of October-24`,
    `Average of October-25`,
    ROUND(
         ABS(`Average of October-25` - `Average of October-24`), 2) AS Price_Difference
FROM oct_2025
ORDER BY Price_Difference ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	235.6734981	252.7905521	17.12
--Rice Local, short-Grained	1944.643674	1913.77517	30.87
--Wheat Flour, Prepacked (2kg)	3747.8655	3786.753134	38.89
--Sweet potatoes 	898.5318626	838.9954456	59.54
--Chicken meat (Frozen)	5971.976202	5899.460025	72.52


---- 9. Which food items experienced a higher percentage price increases than the overall average ?

WITH Price_Changes AS (
    SELECT
        Items_Label,
        ROUND(
            (
                (`Average of October-25` - `Average of October-24`)
                / `Average of October-24`
            ) * 100, 2
        ) AS Percentage_Increase
    FROM oct_2025
    WHERE `Average of October-24` > 0
)

SELECT *
FROM Price_Changes
WHERE Percentage_Increase > (
    SELECT AVG(Percentage_Increase)
    FROM Price_Changes
)
ORDER BY Percentage_Increase DESC;

--RESULT:
--Tilapia fresh fish (Epiya)	47.55
--Cat fresh fish	45.76
--Plantain (unripe)	45.07
--Plantain (ripe)	43
--Titus, frozen	42.28
--Mackerel, Frozen	39.48
--Yam Tuber	18.66
--Palm oil, 75cl	18.21
--Chicken Wings	17.92
--Vegetable Oil, 75cl	17.84
--Beef Boneless	16.93
--Chicken feet	14.43
--Tin Milk-Evaporated, Peak Milk, 150g	10.72
--Onions, fresh 	9.33


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
FROM oct_2025
ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	Ebonyi (10993.31)	Katsina (5085.33)	5907.98
--Mackerel, Frozen	Plateau (9077.08)	Zamfara (3661.67)	5415.41
--Tilapia fresh fish (Epiya)	Bauchi (8761.45)	Sokoto (3776.37)	4985.08
--Goat Meat Bone in	Abia (8934.09)	Kogi (4033.85)	4900.24
--Cat fresh fish	Plateau (8320.53)	Zamfara (3621.58)	4698.95
