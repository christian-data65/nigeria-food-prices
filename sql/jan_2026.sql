---- 1. which five(5) food items has the highest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of January-26`,
      `Average of December-25`,
	  `Average of January-25`
FROM jan_2026
ORDER BY  `Average of January-26` DESC
LIMIT 5;

--RESULT:
--Cray fish small white	8660.060921	8586.03519	6227.04072
--Dried fish, Bonga	7268.449112	7243.910317	6131.980115
--Beef Boneless	6874.171309	6885.086263	6122.568294
--Goat Meat Bone in	6825.897527	6848.9299	6202.357505
--Titus, frozen	6343.685265	6341.112222	5467.231345


---- 2. Which five(5) food items has the lowest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of January-26`,
      `Average of December-25`,
	  `Average of January-25`
FROM jan_2026
ORDER BY  `Average of January-26` ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	240.1632791	240.6865767	248.0413905
--Sweet potatoes 	744.6545095	752.8599377	852.5153115
--Garri white	771.9764099	776.3559046	1267.634881
--Maize (Corn) Grains (White) sold loose	784.5917953	798.9693255	1168.337972
--Garri Yellow	821.9054783	835.2396531	1358.958418


---- 3. Which food items experienced the biggest increases compared with the previous December 2025 ?

SELECT Items_Label,
      ROUND(
           `Average of January-26` - `Average of December-25`, 2
		) AS Monthly_Increase
FROM jan_2026
ORDER BY Monthly_Increase DESC
LIMIT 5;

--RESULT:
--Ginger, fresh	83.18
--Cray fish small white	74.03
--Irish Potatoe	70.84
--Carrots, fresh	32.7
--Dried fish, Bonga	24.54


----  4. Which food items experienced the biggest price decreases compared with the previous December 2025 ? 

SELECT
    Items_Label,
    ROUND(
        `Average of January-26` - `Average of December-25`, 2
    ) AS Monthly_Decrease
FROM jan_2026
ORDER BY Monthly_Decrease ASC
LIMIT 5; 

--RESULT:
--Palm oil, 75cl	-59.19
--Groundnut oil, 75cl	-58.47
--Vegetable Oil, 75cl	-51.26
--Onions, fresh 	-49.13
--Semovita, Prepacked (1kg)	-35.92
 

---- 5. Which geopolitical zone recorded the highest average food prices?

SELECT 'NORTH CENTRAL' AS Zone,
       AVG(`NORTH CENTRAL`) AS Average_Price
FROM jan_2026

UNION ALL

SELECT 'NORTH EAST',
       AVG(`NORTH EAST`)
FROM jan_2026

UNION ALL

SELECT 'NORTH WEST',
       AVG(`NORTH WEST`)
FROM jan_2026

UNION ALL

SELECT 'SOUTH EAST',
       AVG(`SOUTH EAST`)
FROM jan_2026

UNION ALL

SELECT 'SOUTH SOUTH',
       AVG(`SOUTH SOUTH`)
FROM jan_2026

UNION ALL

SELECT 'SOUTH WEST',
       AVG(`SOUTH WEST`)
FROM jan_2026

ORDER BY Average_Price DESC
LIMIT 1;

--RESULT:
--SOUTH EAST	3466.185461051218


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

FROM jan_2026

ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	9455.656769	5684.867174	3770.79
--Mackerel, Frozen	7635.314499	4415.930797	3219.38
--Chicken meat (Frozen)	8098.9932	4915.128571	3183.86
--Ginger, fresh	6708.196609	3880.918596	2827.28
--Goat Meat Bone in	8450.107331	5719.896304	2730.21


---- 7. Which food items experienced the highest percentage price increases year-on-year ?

SELECT
    Items_Label,
    `Average of January-25`,
    `Average of January-26`,
    ROUND(
        (
          (`Average of January-26` - `Average of January-25`)
          / `Average of January-25`
        ) * 100, 2
    ) AS Percentage_Increase
FROM jan_2026
WHERE `Average of January-25` > 0
ORDER BY Percentage_Increase DESC
LIMIT 5;

--RESULT:
--Cray fish small white	6227.04072	8660.060921	39.07
--Ginger, fresh	4206.799549	5445.032695	29.43
--Chicken feet	3293.629575	3953.0386	20.02
--Dried fish, Bonga	6131.980115	7268.449112	18.53
--Titus, frozen	5467.231345	6343.685265	16.03


---- 8. Which food items maintained the most stable prices between January 2025 and January 2026 ?

SELECT
    Items_Label,
    `Average of January-25`,
    `Average of January-26`,
    ROUND(
         ABS(`Average of January-26` - `Average of January-25`), 2) AS Price_Difference
FROM jan_2026
ORDER BY Price_Difference ASC
LIMIT 5;

--RESULT:
--Plantain (unripe)	2119.068929	2120.544523	1.48
--Agric hen eggs, 	248.0413905	240.1632791	7.88
--Palm oil, 75cl	2329.542805	2366.280066	36.74
--Agric hen eggs, (a Crate of 30 pieces)	5878.140647	5923.164846	45.02
--Tomatoes, fresh 	1081.439136	1024.646044	56.79


---- 9. Which food items experienced a higher percentage price increases than the overall average ?

WITH Price_Changes AS (
    SELECT
        Items_Label,
        ROUND(
            (
                (`Average of January-26` - `Average of January-25`)
                / `Average of January-25`
            ) * 100, 2
        ) AS Percentage_Increase
    FROM jan_2026
    WHERE `Average of January-25` > 0
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
--Cray fish small white	39.07
--Ginger, fresh	29.43
--Chicken feet	20.02
--Dried fish, Bonga	18.53
--Titus, frozen	16.03
--Cat fresh fish	15.82
--Tilapia fresh fish (Epiya)	15.46
--Chicken Wings	14.79
--Mackerel, Frozen	12.83
--Beef Boneless	12.28


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
FROM jan_2026
ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Mackerel, Frozen	Plateau (9080.42)	Zamfara (3726.84)	5353.58
--Dried fish, Bonga	Enugu (10285.18)	Jigawa (5188.46)	5096.72
--Goat Meat Bone in	Imo (8749.27)	Kogi (4033.29)	4715.98
--Tilapia fresh fish (Epiya)	Benue (8377.24)	Sokoto (3738.56)	4638.68
--Cat fresh fish	Plateau (8323.31)	Kaduna (3700.2)	4623.11

