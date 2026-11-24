---- 1. which five(5) food items has the highest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of September-25`,
      `Average of August-25`,
	  `Average of September-24`
FROM sep_2025
ORDER BY  `Average of September-25` DESC
LIMIT 5;

--RESULT:
--Cray fish small white	8754.601455	8806.616268	
--Dried fish, Bonga	7030.168543	7019.717617	
--Beef Boneless	6861.246548	6860.069305	5633.598921
--Goat Meat Bone in	6812.960814	6810.85277	
--Titus, frozen	6352.951259	6310.328619	4416.927115


---- 2. Which five(5) food items has the lowest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of September-25`,
      `Average of August-25`,
	  `Average of September-24`
FROM sep_2025
ORDER BY  `Average of September-25` ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	248.2154462	254.696752	219.6385052
--Sweet potatoes 	834.3496651	877.8346398	870.153685
--Garri white	871.7757576	932.5318107	1170.248227
--Maize (Corn) Grains (White) sold loose	888.6815456	951.0393817	1065.135279
--Tin Milk-Evaporated, Three Crown Milk, 160g	900.7322712	910.2792792	


---- 3. Which food items experienced the biggest increases compared with the previous August 2025 ?

SELECT Items_Label,
      ROUND(
           `Average of September-25` - `Average of August-25`, 2
		) AS Monthly_Increase
FROM sep_2025
ORDER BY Monthly_Increase DESC
LIMIT 5;

--RESULT:
--Titus, frozen	42.62
--Cat fresh fish	41.48
--Groundnut oil, 75cl	33.31
--Semovita, Prepacked (1kg)	27.46
--Chicken meat (Frozen)	21.04


----  4. Which food items experienced the biggest price decreases compared with the previous August 2025 ? 

SELECT
    Items_Label,
    ROUND(
        `Average of September-25` - `Average of August-25`, 2
    ) AS Monthly_Decrease
FROM sep_2025
ORDER BY Monthly_Decrease ASC
LIMIT 5; 

--RESULT:
--Agric hen eggs, (a Crate of 30 pieces)	-142.19
--Maize (Corn) Grains (White) sold loose	-62.36
--Garri white	-60.76
--Cray fish small white	-52.01
--Ginger, fresh	-48.6


---- 5. Which geopolitical zone recorded the highest average food prices?

SELECT 'NORTH CENTRAL' AS Zone,
       AVG(`NORTH CENTRAL`) AS Average_Price
FROM sep_2025

UNION ALL

SELECT 'NORTH EAST',
       AVG(`NORTH EAST`)
FROM sep_2025

UNION ALL

SELECT 'NORTH WEST',
       AVG(`NORTH WEST`)
FROM sep_2025

UNION ALL

SELECT 'SOUTH EAST',
       AVG(`SOUTH EAST`)
FROM sep_2025

UNION ALL

SELECT 'SOUTH SOUTH',
       AVG(`SOUTH SOUTH`)
FROM sep_2025

UNION ALL

SELECT 'SOUTH WEST',
       AVG(`SOUTH WEST`)
FROM sep_2025

ORDER BY Average_Price DESC
LIMIT 1;

--RESULT:
--SOUTH EAST	3711.375222065854


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

FROM sep_2025

ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	9778.775955	5483.026694	4295.75
--Goat Meat Bone in	8995.083979	5778.561265	3216.52
--Mackerel, Frozen	7641.832788	4448.166894	3193.67
--Chicken meat (Frozen)	8001.409199	4904.5	3096.91
--Beef Boneless	8673.775624	5734.882849	2938.89


---- 7. Which food items experienced the highest percentage price increases year-on-year ?

SELECT
    Items_Label,
    `Average of September-24`,
    `Average of September-25`,
    ROUND(
        (
          (`Average of September-25` - `Average of September-24`)
          / `Average of September-24`
        ) * 100, 2
    ) AS Percentage_Increase
FROM sep_2025
WHERE `Average of September-24` > 0
ORDER BY Percentage_Increase DESC
LIMIT 5;

--RESULT:
--Tilapia fresh fish (Epiya)	3850.971021	5720.069284	48.54
--Plantain (unripe)	1511.094305	2226.438539	47.34
--Cat fresh fish	4060.286849	5974.66938	47.15
--Titus, frozen	4416.927115	6352.951259	43.83
--Plantain (ripe)	1500.428178	2153.844999	43.55


---- 8. Which food items maintained the most stable prices between September 2024 and September 2025 ?

SELECT
    Items_Label,
    `Average of September-24`,
    `Average of September-25`,
    ROUND(
         ABS(`Average of September-25` - `Average of September-24`), 2) AS Price_Difference
FROM sep_2025
ORDER BY Price_Difference ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	219.6385052	248.2154462	28.58
--Irish Potatoe	1662.812362	1633.090407	29.72
--Sweet potatoes 	870.153685	834.3496651	35.8
--Rice Local, short-Grained	1914.77286	1952.940172	38.17
--Rice Long-Grained (Imported)	2403.860841	2319.307628	84.55


---- 9. Which food items experienced a higher percentage price increases than the overall average ?

WITH Price_Changes AS (
    SELECT
        Items_Label,
        ROUND(
            (
                (`Average of September-25` - `Average of September-24`)
                / `Average of September-24`
            ) * 100, 2
        ) AS Percentage_Increase
    FROM sep_2025
    WHERE `Average of September-24` > 0
)

SELECT *
FROM Price_Changes
WHERE Percentage_Increase > (
    SELECT AVG(Percentage_Increase)
    FROM Price_Changes
)
ORDER BY Percentage_Increase DESC;

--RESULT:
--Tilapia fresh fish (Epiya)	48.54
--Plantain (unripe)	47.34
--Cat fresh fish	47.15
--Titus, frozen	43.83
--Plantain (ripe)	43.55
--Mackerel, Frozen	41.32
--Vegetable Oil, 75cl	23.85
--Yam Tuber	23.01
--Palm oil, 75cl	21.96
--Beef Boneless	21.79
--Chicken Wings	20.56
--Chicken feet	14.15
--Agric hen eggs, 	13.01


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
FROM sep_2025
ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Goat Meat Bone in	Imo (9636.3)	Kogi (4032.63)	5603.67
--Dried fish, Bonga	Imo (10595.16)	Borno (5074.28)	5520.88
--Mackerel, Frozen	Plateau (9067.73)	Zamfara (3799.12)	5268.61
--Cat fresh fish	Plateau (8310.32)	Zamfara (3507.45)	4802.87
--Tilapia fresh fish (Epiya)	Benue (8376.42)	Sokoto (3819)	4557.42
