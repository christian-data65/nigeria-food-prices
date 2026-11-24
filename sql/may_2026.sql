---- 1. which five(5) food items has the highest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of May-26`,
      `Average of April-26`,
	  `Average of May-25`
FROM may_2026
ORDER BY  `Average of May-26` DESC
LIMIT 5;

--RESULT:
--Cray fish small white	8971.559029	8857.897497	8046.835984
--Titus, frozen	7739.311313	6416.582932	6076.519665
--Dried fish, Bonga	7369.159617	7314.418603	6703.079156
--Beef Boneless	7171.408124	6919.9376	6662.924662
--Goat Meat Bone in	6923.966956	6874.615347	6710.94411


---- 2. Which five(5) food items has the lowest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of may-26`,
      `Average of April-26`,
	  `Average of May-25`
FROM may_2026
ORDER BY  `Average of May-26` ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	261.1417625	259.2181946	265.7252501
--Garri white	813.2421893	808.959232	1341.789862
--Maize (Corn) Grains (White) sold loose	815.825015	811.3322285	1216.550868
--Sweet potatoes 	862.2530707	844.2952065	1045.033024
--Garri Yellow	865.4077122	861.9186108	1438.257432


---- 3. Which food items experienced the biggest increases compared with the previous April 2026 ?

SELECT Items_Label,
      ROUND(
           `Average of May-26` - `Average of April-26`, 2
		) AS Monthly_Increase
FROM may_2026
ORDER BY Monthly_Increase DESC
LIMIT 5;

--RESULT:
--Titus, frozen	1322.73
--Tomatoes, fresh 	382.64
--Ginger, fresh	324.99
--Beef Boneless	251.47
--Yam Tuber	128.63


----  4. Which food items experienced the biggest price decreases compared with the previous April 2026 ? 

SELECT
    Items_Label,
    ROUND(
        `Average of May-26` - `Average of April-26`, 2
    ) AS Monthly_Decrease
FROM may_2026
ORDER BY Monthly_Decrease ASC
LIMIT 5; 

--RESULT:
--Palm oil, 75cl	0.29
--Tin Milk-Evaporated, Three Crown Milk, 160g	1.37
--Agric hen eggs, 	1.92
--Tin Milk-Evaporated, Peak Milk, 150g	2.81
--Groundnuts, roasted,75cl bottle	3.08


---- 5. Which geopolitical zone recorded the highest average food prices?

SELECT 'NORTH CENTRAL' AS Zone,
       AVG(`NORTH CENTRAL`) AS Average_Price
FROM may_2026

UNION ALL

SELECT 'NORTH EAST',
       AVG(`NORTH EAST`)
FROM may_2026

UNION ALL

SELECT 'NORTH WEST',
       AVG(`NORTH WEST`)
FROM may_2026

UNION ALL

SELECT 'SOUTH EAST',
       AVG(`SOUTH EAST`)
FROM may_2026

UNION ALL

SELECT 'SOUTH SOUTH',
       AVG(`SOUTH SOUTH`)
FROM may_2026

UNION ALL

SELECT 'SOUTH WEST',
       AVG(`SOUTH WEST`)
FROM may_2026

ORDER BY Average_Price DESC
LIMIT 1;

--RESULT
--SOUTH EAST	3614.8698550341464


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

FROM may_2026

ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	9549.635554	6001.130116	3548.51
--Chicken meat (Frozen)	8237.575244	5021.632167	3215.94
--Mackerel, Frozen	7642.099864	4565.354489	3076.75
--Goat Meat Bone in	8599.133184	5722.023698	2877.11
--Ginger, fresh	6969.85747	4495.286836	2474.57


---- 7. Which food items experienced the highest percentage price increases year-on-year ?

SELECT
    Items_Label,
    `Average of May-25`,
    `Average of May-26`,
    ROUND(
        (
          (`Average of May-26` - `Average of May-25`)
          / `Average of May-25`
        ) * 100, 2
    ) AS Percentage_Increase
FROM may_2026
WHERE `Average of May-25` > 0
ORDER BY Percentage_Increase DESC
LIMIT 5;

--RESULT:
--Titus, frozen	6076.519665	7739.311313	27.36
--Chicken feet	3506.125073	4006.065554	14.26
--Tomatoes, fresh 	1392.710719	1560.558228	12.05
--Cray fish small white	8046.835984	8971.559029	11.49
--Dried fish, Bonga	6703.079156	7369.159617	9.94


---- 8. Which food items maintained the most stable prices between May 2025 and May 2026 ?

SELECT
    Items_Label,
    `Average of May-25`,
    `Average of May-26`,
    ROUND(
         ABS(`Average of May-26` - `Average of May-25`), 2) AS Price_Difference
FROM may_2026
ORDER BY Price_Difference ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	265.7252501	261.1417625	4.58
--Groundnuts, roasted,75cl bottle	2605.851043	2600.218651	5.63
--Watermelon whole, medium size fresh	2078.497832	2085.60513	7.11
--Irish Potatoe	2081.093365	2104.040138	22.95
--Yam Tuber	2375.398619	2347.086738	28.31


---- 9. Which food items experienced a higher percentage price increases than the overall average ?

WITH Price_Changes AS (
    SELECT
        Items_Label,
        ROUND(
            (
                (`Average of May-26` - `Average of May-25`)
                / `Average of May-25`
            ) * 100, 2
        ) AS Percentage_Increase
    FROM may_2026
    WHERE `Average of May-25` > 0
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
--Titus, frozen	27.36
--Chicken feet	14.26
--Tomatoes, fresh 	12.05
--Cray fish small white	11.49
--Dried fish, Bonga	9.94
--Cat fresh fish	9
--Carrots, fresh	8.83
--Beef Boneless	7.63
--Ginger, fresh	7.28
--Mackerel, Frozen	6.75


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
FROM may_2026
ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Mackerel, Frozen	Plateau (9108.94)	Zamfara (3830)	5278.94
--Dried fish, Bonga	Enugu (10281.96)	Ogun (5312)	4969.96
--Goat Meat Bone in	Imo (8802.1)	Kogi (4036.66)	4765.44
--Chicken meat (Frozen)	Enugu (9126.91)	Taraba (4510)	4616.91
--Tilapia fresh fish (Epiya)	Benue (8377.68)	Sokoto (3812.22)	4565.46





