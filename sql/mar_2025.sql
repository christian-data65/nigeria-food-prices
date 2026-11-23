---- 1. which five(5) food items has the highest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of Mar-25`,
      `Average of Feb-25`,
	  `Average of Mar-24`
FROM mar_2025
ORDER BY  `Average of Mar-25` DESC
LIMIT 5;

--RESULT:
--Agric hen eggs, (a Crate of 30 pieces)	7670.55919	5976.115852	
--Goat Meat Bone in	6892.462296	6298.893396	
--Cray fish small white	6657.002535	6440.441083	
--Beef Boneless	6523.500991	6269.458819	4309.16432
--Dried fish, Bonga	6493.784328	6160.021309	


---- 2. Which five(5) food items has the lowest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of Mar-25`,
      `Average of Feb-25`,
	  `Average of Mar-24`
FROM mar_2025
ORDER BY  `Average of Mar-25` ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	261.1823463	251.9405165	147.9233373
--Tin Milk-Evaporated, Three Crown Milk, 160g	872.1352708	827.3148444	
--Sweet potatoes 	909.8848798	823.2987	689.4675645
--Tin Milk-Evaporated, Peak Milk, 150g	999.1796745	931.0347338	669.7089003
--Tomatoes, fresh 	1157.345719	1111.139588	959.6835235


---- 3. Which food items experienced the biggest increases compared with the previous February 2025 ?

SELECT Items_Label,
      ROUND(
           `Average of Mar-25` - `Average of Feb-25`, 2
		) AS Monthly_Increase
FROM mar_2025
ORDER BY Monthly_Increase DESC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	261.1823463	251.9405165	147.9233373
--Tin Milk-Evaporated, Three Crown Milk, 160g	872.1352708	827.3148444	
--Sweet potatoes 	909.8848798	823.2987	689.4675645
--Tin Milk-Evaporated, Peak Milk, 150g	999.1796745	931.0347338	669.7089003
--Tomatoes, fresh 	1157.345719	1111.139588	959.6835235


----  4. Which food items experienced the biggest price decreases compared with the previous February 2025 ? 

SELECT
    Items_Label,
    ROUND(
        `Average of Mar-25` - `Average of Feb-25`, 2
    ) AS Monthly_Decrease
FROM mar_2025
ORDER BY Monthly_Decrease ASC
LIMIT 5; 

--RESULT:
--Agric hen eggs, 	9.24
--Tin Milk-Evaporated, Three Crown Milk, 160g	44.82
--Tomatoes, fresh 	46.21
--Bread (sliced), 450g	46.99
--Onions, fresh 	62.81


---- 5. Which geopolitical zone recorded the highest average food prices?

SELECT 'NORTH CENTRAL' AS Zone,
       AVG(`NORTH CENTRAL`) AS Average_Price
FROM mar_2025

UNION ALL

SELECT 'NORTH EAST',
       AVG(`NORTH EAST`)
FROM mar_2025

UNION ALL

SELECT 'NORTH WEST',
       AVG(`NORTH WEST`)
FROM mar_2025

UNION ALL

SELECT 'SOUTH EAST',
       AVG(`SOUTH EAST`)
FROM mar_2025

UNION ALL

SELECT 'SOUTH SOUTH',
       AVG(`SOUTH SOUTH`)
FROM mar_2025

UNION ALL

SELECT 'SOUTH WEST',
       AVG(`SOUTH WEST`)
FROM mar_2025

ORDER BY Average_Price DESC
LIMIT 1;

--RESULT:
--SOUTH EAST	3528.593039385366


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

FROM mar_2025

ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	8924.127277	5496.045918	3428.08
--Mackerel, Frozen	7735.617764	4476.375264	3259.24
--Chicken meat (Frozen)	7610	4707.142857	2902.86
--Goat Meat Bone in	8361.522482	5730.190571	2631.33
--Cat fresh fish	6827.209083	4316.095238	2511.11


---- 7. Which food items experienced the highest percentage price increases year-on-year ?

SELECT
    Items_Label,
    `Average of Mar-24`,
    `Average of Mar-25`,
    ROUND(
        (
          (`Average of Mar-25` - `Average of Mar-24`)
          / `Average of Mar-24`
        ) * 100, 2
    ) AS Percentage_Increase
FROM mar_2025
WHERE `Average of Mar-24` > 0
ORDER BY Percentage_Increase DESC
LIMIT 5;

--RESULT:
--Plantain (unripe)	933.1569891	2214.56528	137.32
--Beans Brown	1234.402185	2616.263611	111.95
--Plantain (ripe)	947.3490445	2002.584172	111.39
--Yam Tuber	1068.776458	2141.130036	100.33
--Tilapia fresh fish (Epiya)	2728.632983	5459.042143	100.07


---- 8. Which food items maintained the most stable prices between March 2024 and March 2025 ?

SELECT
    Items_Label,
    `Average of Mar-24`,
    `Average of Mar-25`,
    ROUND(
         ABS(`Average of Mar-25` - `Average of Mar-24`), 2) AS Price_Difference
FROM mar_2025
ORDER BY Price_Difference ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	147.9233373	261.1823463	113.26
--Tomatoes, fresh 	959.6835235	1157.345719	197.66
--Sweet potatoes 	689.4675645	909.8848798	220.42
--Tin Milk-Evaporated, Peak Milk, 150g	669.7089003	999.1796745	329.47
--Onions, fresh 	938.8667194	1434.849827	495.98


---- 9. Which food items experienced a higher percentage price increases than the overall average ?

WITH Price_Changes AS (
    SELECT
        Items_Label,
        ROUND(
            (
                (`Average of Mar-25` - `Average of Mar-24`)
                / `Average of Mar-24`
            ) * 100, 2
        ) AS Percentage_Increase
    FROM mar_2025
    WHERE `Average of Mar-24` > 0
)

SELECT *
FROM Price_Changes
WHERE Percentage_Increase > (
    SELECT AVG(Percentage_Increase)
    FROM Price_Changes
)
ORDER BY Percentage_Increase DESC;

--RESULT:
--Plantain (unripe)	137.32
--Beans Brown	111.95
--Plantain (ripe)	111.39
--Yam Tuber	100.33
--Tilapia fresh fish (Epiya)	100.07
--Titus, frozen	87.58
--Beans white	85.8
--Mackerel, Frozen	84.47
--Garri white	81.75
--Garri Yellow	81.17
--Cat fresh fish	80.95
--Agric hen eggs, 	76.57


---- 10. Which food items have the biggest price differences between states?
--
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
FROM mar_2025
ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Mackerel, Frozen	Plateau (9965.28)	Zamfara (3415)	6550.28
--Goat Meat Bone in	Akwa Ibom (10340)	Kogi (3850)	6490.00
--Dried fish, Bonga	Ebonyi (10004.01)	Osun (4420)	5584.01
--Cat fresh fish	Plateau (8213.1)	Zamfara (3590)	4623.10
--Titus, frozen	Kwara (8927.29)	Oyo (4485.35)	4441.94






















