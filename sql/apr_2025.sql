---- 1. which five(5) food items has the highest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of Apr-25`,
      `Average of Mar-25`,
	  `Average of Apr-24`
FROM apr_2025
ORDER BY  `Average of Apr-25` DESC
LIMIT 5;

--RESULT:
--Goat Meat Bone in	6708.452752	6892.462296	
--Dried fish, Bonga	6657.742776	6493.784328	
--Cray fish small white	6655.661529	6657.002535	
--Beef Boneless	6544.536858	6523.500991	4711.646954
--Agric hen eggs, (a Crate of 30 pieces)	6150.178072	7670.55919	


---- 2. Which five(5) food items has the lowest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of Apr-25`,
      `Average of Mar-25`,
	  `Average of Apr-24`
FROM apr_2025
ORDER BY  `Average of Apr-25` ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	259.3161525	261.1823463	150.8489099
--Tin Milk-Evaporated, Three Crown Milk, 160g	888.9103697	872.1352708	
--Sweet potatoes 	938.4237847	909.8848798	807.3489329
--Tin Milk-Evaporated, Peak Milk, 150g	994.1917362	999.1796745	725.7396875
--Maize (Corn) Grains (White) sold loose	1239.60966	1278.75952	797.6092865


---- 3. Which food items experienced the biggest increases compared with the previous March 2025 ?

SELECT Items_Label,
      ROUND(
           `Average of Apr-25` - `Average of Mar-25`, 2
		) AS Monthly_Increase
FROM apr_2025
ORDER BY Monthly_Increase DESC
LIMIT 5;

--RESULT:
--Ginger, fresh	370.43
--Dried fish, Bonga	163.96
--Tomatoes, fresh 	126.23
--Chicken Wings	100.61
--Yam Tuber	98.95

----  4. Which food items experienced the biggest price decreases compared with the previous March 2025 ? 

SELECT
    Items_Label,
    ROUND(
        `Average of Apr-25` - `Average of Mar-25`, 2
    ) AS Monthly_Decrease
FROM apr_2025
ORDER BY Monthly_Decrease ASC
LIMIT 5; 

--RESULT:
--Agric hen eggs, (a Crate of 30 pieces)	-1520.38
--Beans Brown	-186.88
--Goat Meat Bone in	-184.01
--Local Rice (Broken)	-153.84
--Beans white	-117.8


---- 5. Which geopolitical zone recorded the highest average food prices?

SELECT 'NORTH CENTRAL' AS Zone,
       AVG(`NORTH CENTRAL`) AS Average_Price
FROM apr_2025

UNION ALL

SELECT 'NORTH EAST',
       AVG(`NORTH EAST`)
FROM apr_2025

UNION ALL

SELECT 'NORTH WEST',
       AVG(`NORTH WEST`)
FROM apr_2025

UNION ALL

SELECT 'SOUTH EAST',
       AVG(`SOUTH EAST`)
FROM apr_2025

UNION ALL

SELECT 'SOUTH SOUTH',
       AVG(`SOUTH SOUTH`)
FROM apr_2025

UNION ALL

SELECT 'SOUTH WEST',
       AVG(`SOUTH WEST`)
FROM apr_2025

ORDER BY Average_Price DESC
LIMIT 1;

--RESULT:
--SOUTH EAST	3591.5820645243894


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

FROM apr_2025

ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	9148.8	5508.5	3640.3
--Mackerel, Frozen	7597.877143	4308.267963	3289.61
--Chicken meat (Frozen)	7633.398255	4904.5	2728.9
--Goat Meat Bone in	8460.540426	5751.618571	2708.92
--Beef Boneless	8305.47061	5776.171115	2529.3


---- 7. Which food items experienced the highest percentage price increases year-on-year ?

SELECT
    Items_Label,
    `Average of Apr-24`,
    `Average of Apr-25`,
    ROUND(
        (
          (`Average of Apr-25` - `Average of Apr-24`)
          / `Average of Apr-24`
        ) * 100, 2
    ) AS Percentage_Increase
FROM apr_2025
WHERE `Average of Apr-24` > 0
ORDER BY Percentage_Increase DESC
LIMIT 5;

--RESULT:
--Plantain (unripe)	1000.407703	2231.808262	123.09
--Plantain (ripe)	1009.052272	2057.39662	103.89
--Yam Tuber	1130.369219	2240.083777	98.17
--Tilapia fresh fish (Epiya)	2828.874747	5489.282025	94.04
--Cat fresh fish	3140.533112	5572.493423	77.44


---- 8. Which food items maintained the most stable prices between April 2024 and April 2025 ?

SELECT
    Items_Label,
    `Average of Apr-24`,
    `Average of Apr-25`,
    ROUND(
         ABS(`Average of Apr-25` - `Average of Apr-24`), 2) AS Price_Difference
FROM apr_2025
ORDER BY Price_Difference ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	150.8489099	259.3161525	108.47
--Sweet potatoes 	807.3489329	938.4237847	131.07
--Tomatoes, fresh 	1123.413498	1283.571214	160.16
--Tin Milk-Evaporated, Peak Milk, 150g	725.7396875	994.1917362	268.45
--Maize (Corn) Grains (White) sold loose	797.6092865	1239.60966	442


---- 9. Which food items experienced a higher percentage price increases than the overall average ?

WITH Price_Changes AS (
    SELECT
        Items_Label,
        ROUND(
            (
                (`Average of Apr-25` - `Average of Apr-24`)
                / `Average of Apr-24`
            ) * 100, 2
        ) AS Percentage_Increase
    FROM apr_2025
    WHERE `Average of Apr-24` > 0
)

SELECT *
FROM Price_Changes
WHERE Percentage_Increase > (
    SELECT AVG(Percentage_Increase)
    FROM Price_Changes
)
ORDER BY Percentage_Increase DESC;

--RESULT:
--Plantain (unripe)	123.09
--Plantain (ripe)	103.89
--Yam Tuber	98.17
--Tilapia fresh fish (Epiya)	94.04
--Cat fresh fish	77.44
--Beans Brown	75.04
--Titus, frozen	74.94
--Agric hen eggs, 	71.9
--Mackerel, Frozen	67.98
--Vegetable Oil, 75cl	62.39
--Wheat Flour, Prepacked (2kg)	61.92
--Beans white	59.68


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
FROM apr_2025
ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Agric hen eggs, (a Crate of 30 pieces)	Enugu (7869.33)	Jigawa (540)	7329.33
--Dried fish, Bonga	Ebonyi (10000)	Osun (4500)	5500.00
--Mackerel, Frozen	Plateau (9000)	Oyo (3500)	5500.00
--Goat Meat Bone in	Imo (9200)	Kogi (4000)	5200.00
--Cat fresh fish	Plateau (8213.1)	Zamfara (3615.22)	4597.88
























