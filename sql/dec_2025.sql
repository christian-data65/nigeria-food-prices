---- 1. which five(5) food items has the highest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of December-25`,
      `Average of November-25`,
	  `Average of December-24`
FROM dec_2025
ORDER BY  `Average of December-25` DESC
LIMIT 5;

--RESULT:
--Cray fish small white	8586.03519	8606.72333	
--Dried fish, Bonga	7243.910317	7263.979829	
--Beef Boneless	6885.086263	6908.218147	6150.182883
--Goat Meat Bone in	6848.9299	6911.386432	
--Titus, frozen	6341.112222	6413.414469	4725.165443


---- 2. Which five(5) food items has the lowest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of December-25`,
      `Average of November-25`,
	  `Average of December-24`
FROM dec_2025
ORDER BY  `Average of December-25` ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	240.9568469	244.9653384	252.17
--Sweet potatoes 	752.8599377	809.6818681	930.7890081
--Garri white	776.3559046	819.6990852	1184.766183
--Maize (Corn) Grains (White) sold loose	798.9693255	843.7726101	1151.134713
--Garri Yellow	835.2396531	887.9656714	1296.926732


---- 3. Which food items experienced the biggest increases compared with the previous November 2025 ?

SELECT Items_Label,
      ROUND(
           `Average of December-25` - `Average of November-25`, 2
		) AS Monthly_Increase
FROM dec_2025
ORDER BY Monthly_Increase DESC
LIMIT 5;

--RESULT:
--Chicken feet	213.76
--Irish Potatoe	195.69
--Chicken Wings	38.7
--Yam Tuber	19.04
--Vegetable Oil, 75cl	7.66


----  4. Which food items experienced the biggest price decreases compared with the previous November 2025 ? 

SELECT
    Items_Label,
    ROUND(
        `Average of December-25` - `Average of November-25`, 2
    ) AS Monthly_Decrease
FROM dec_2025
ORDER BY Monthly_Decrease ASC
LIMIT 5;

--RESULT:
--Beans Brown	-296.92
--Beans white	-229.7
--Groundnut oil, 75cl	-209.58
--Tomatoes, fresh 	-185.92
--Onions, fresh 	-160.37
 

---- 5. Which geopolitical zone recorded the highest average food prices?

SELECT 'NORTH CENTRAL' AS Zone,
       AVG(`NORTH CENTRAL`) AS Average_Price
FROM dec_2025

UNION ALL

SELECT 'NORTH EAST',
       AVG(`NORTH EAST`)
FROM dec_2025

UNION ALL

SELECT 'NORTH WEST',
       AVG(`NORTH WEST`)
FROM dec_2025

UNION ALL

SELECT 'SOUTH EAST',
       AVG(`SOUTH EAST`)
FROM dec_2025

UNION ALL

SELECT 'SOUTH SOUTH',
       AVG(`SOUTH SOUTH`)
FROM dec_2025

UNION ALL

SELECT 'SOUTH WEST',
       AVG(`SOUTH WEST`)
FROM dec_2025

ORDER BY Average_Price DESC
LIMIT 1;

--RESULT:
--SOUTH EAST	3445.675811458537


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

FROM dec_2025

ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	9366.323442	5689.778363	3676.55
--Mackerel, Frozen	7634.81738	4458.166643	3176.65
--Chicken meat (Frozen)	8081.259558	4914.034286	3167.23
--Ginger, fresh	6662.181609	3788.748446	2873.43
--Goat Meat Bone in	8447.571276	5720.847551	2726.72


---- 7. Which food items experienced the highest percentage price increases year-on-year ?

SELECT
    Items_Label,
    `Average of December-24`,
    `Average of December-25`,
    ROUND(
        (
          (`Average of December-25` - `Average of December-24`)
          / `Average of December-24`
        ) * 100, 2
    ) AS Percentage_Increase
FROM dec_2025
WHERE `Average of December-24` > 0
ORDER BY Percentage_Increase DESC
LIMIT 5;

--RESULT:
--Tilapia fresh fish (Epiya)	4106.716195	5845.43998	42.34
--Cat fresh fish	4347.444551	6068.397123	39.59
--Plantain (unripe)	1550.151384	2140.22687	38.07
--Plantain (ripe)	1533.680968	2081.028641	35.69
--Mackerel, Frozen	4287.654018	5799.043695	35.25


---- 8. Which food items maintained the most stable prices between December 2024 and December 2025 ?

SELECT
    Items_Label,
    `Average of December-24`,
    `Average of December-25`,
    ROUND(
         ABS(`Average of December-25` - `Average of December-24`), 2) AS Price_Difference
FROM dec_2025
ORDER BY Price_Difference ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	252.17	240.9568469	11.21
--Tin Milk-Evaporated, Peak Milk, 150g	1014.741465	1047.46873	32.73
--Irish Potatoe	1818.287632	1902.608963	84.32
--Vegetable Oil, 75cl	3362.834056	3272.206739	90.63
--Rice Local, short-Grained	1944.403899	1845.080933	99.32


---- 9. Which food items experienced a higher percentage price increases than the overall average ?

WITH Price_Changes AS (
    SELECT
        Items_Label,
        ROUND(
            (
                (`Average of December-25` - `Average of December-24`)
                / `Average of December-24`
            ) * 100, 2
        ) AS Percentage_Increase
    FROM dec_2025
    WHERE `Average of December-24` > 0
)

SELECT *
FROM Price_Changes
WHERE Percentage_Increase > (
    SELECT AVG(Percentage_Increase)
    FROM Price_Changes
)
ORDER BY Percentage_Increase DESC;

--RESULT:
--Tilapia fresh fish (Epiya)	42.34
--Cat fresh fish	39.59
--Plantain (unripe)	38.07
--Plantain (ripe)	35.69
--Mackerel, Frozen	35.25
--Titus, frozen	34.2
--Chicken feet	16.45
--Chicken Wings	12.89
--Beef Boneless	11.95
--Yam Tuber	7.8
--Irish Potatoe	4.64
--Tin Milk-Evaporated, Peak Milk, 150g	3.23


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
FROM dec_2025
ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Mackerel, Frozen	Plateau (9079.87)	Zamfara (3760.68)	5319.19
--Dried fish, Bonga	Enugu (10208.05)	Katsina (5207.98)	5000.07
--Goat Meat Bone in	Imo (8747.7)	Kogi (4034.2)	4713.50
--Tilapia fresh fish (Epiya)	Benue (8377.53)	Sokoto (3746.63)	4630.90
--Cat fresh fish	Plateau (8323.59)	Kaduna (3700.07)	4623.52
