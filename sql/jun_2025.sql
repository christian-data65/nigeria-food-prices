---- 1. which five(5) food items has the highest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of June-25`,
      `Average of May-25`,
	  `Average of June-24`
FROM jun_2025
ORDER BY  `Average of June-25` DESC
LIMIT 5;

--RESULT:
--Cray fish small white	8753.212366	8046.835984	
--Dried fish, Bonga	7024.158293	6703.079156	
--Beef Boneless	6808.960907	6662.924662	5400.544674
--Goat Meat Bone in	6779.490529	6710.94411	
--Agric hen eggs, (a Crate of 30 pieces)	6326.553236	6263.915592	


---- 2. Which five(5) food items has the lowest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of June-25`,
      `Average of May-25`,
	  `Average of June-24`
FROM jun_2025
ORDER BY  `Average of June-25` ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	268.1321912	265.7252501	168.5117875
--Tin Milk-Evaporated, Three Crown Milk, 160g	910.081284	906.0829505	
--Tin Milk-Evaporated, Peak Milk, 150g	1028.285335	1011.746964	801.4948616
--Sweet potatoes 	1039.327128	1045.033024	976.9620222
--Maize (Corn) Grains (White) sold loose	1188.371421	1216.550868	1002.220125


---- 3. Which food items experienced the biggest increases compared with the previous May 2025 ?

SELECT Items_Label,
      ROUND(
           `Average of June-25` - `Average of May-25`, 2
		) AS Monthly_Increase
FROM jun_2025
ORDER BY Monthly_Increase DESC
LIMIT 5;

--RESULT:
--Cray fish small white	706.38
--Dried fish, Bonga	321.08
--Tilapia fresh fish (Epiya)	165.05
--Titus, frozen	162.19
--Beef Boneless	146.04


----  4. Which food items experienced the biggest price decreases compared with the previous May 2025 ? 

SELECT
    Items_Label,
    ROUND(
        `Average of June-25` - `Average of May-25`, 2
    ) AS Monthly_Decrease
FROM jun_2025
ORDER BY Monthly_Decrease ASC
LIMIT 5;

--RESULT:
--Beans Brown	-65.16
--Onions, fresh 	-48.36
--Garri white	-43.6
--Garri Yellow	-41.54
--Irish Potatoe	-35.15


---- 5. Which geopolitical zone recorded the highest average food prices?

SELECT 'NORTH CENTRAL' AS Zone,
       AVG(`NORTH CENTRAL`) AS Average_Price
FROM jun_2025

UNION ALL

SELECT 'NORTH EAST',
       AVG(`NORTH EAST`)
FROM jun_2025

UNION ALL

SELECT 'NORTH WEST',
       AVG(`NORTH WEST`)
FROM jun_2025

UNION ALL

SELECT 'SOUTH EAST',
       AVG(`SOUTH EAST`)
FROM jun_2025

UNION ALL

SELECT 'SOUTH SOUTH',
       AVG(`SOUTH SOUTH`)
FROM jun_2025

UNION ALL

SELECT 'SOUTH WEST',
       AVG(`SOUTH WEST`)
FROM jun_2025

ORDER BY Average_Price DESC
LIMIT 1;

--RESULT:
--SOUTH EAST	3770.5027582195107


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

FROM jun_2025

ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	9628.150074	5962.297063	3665.85
--Mackerel, Frozen	7626.344593	4440.611319	3185.73
--Goat Meat Bone in	8822.576472	5764.804418	3057.77
--Cray fish small white	10619.34332	7579.878874	3039.46
--Beef Boneless	8678.139911	5717.380137	2960.76


---- 7. Which food items experienced the highest percentage price increases year-on-year ?

SELECT
    Items_Label,
    `Average of June-24`,
    `Average of June-25`,
    ROUND(
        (
          (`Average of June-25` - `Average of June-24`)
          / `Average of June-24`
        ) * 100, 2
    ) AS Percentage_Increase
FROM jun_2025
WHERE `Average of June-24` > 0
ORDER BY Percentage_Increase DESC
LIMIT 5;

--RESULT:
--Plantain (unripe)	1325.626226	2305.621653	73.93
--Tilapia fresh fish (Epiya)	3389.29099	5723.023942	68.86
--Titus, frozen	3802.002545	6238.707813	64.09
--Agric hen eggs, 	168.5117875	268.1321912	59.12
--Cat fresh fish	3615.18672	5744.25327	58.89


---- 8. Which food items maintained the most stable prices between June 2024 and June 2025 ?

SELECT
    Items_Label,
    `Average of June-24`,
    `Average of June-25`,
    ROUND(
         ABS(`Average of June-25` - `Average of June-24`), 2) AS Price_Difference
FROM jun_2025
ORDER BY Price_Difference ASC
LIMIT 5;

--RESULT:
--Onions, fresh 	1547.776686	1559.019082	11.24
--Beans Brown	2292.762268	2319.993512	27.23
--Sweet potatoes 	976.9620222	1039.327128	62.37
--Agric hen eggs, 	168.5117875	268.1321912	99.62
--Beans white	2153.869262	2030.076033	123.79


---- 9. Which food items experienced a higher percentage price increases than the overall average ?

WITH Price_Changes AS (
    SELECT
        Items_Label,
        ROUND(
            (
                (`Average of June-25` - `Average of June-24`)
                / `Average of June-24`
            ) * 100, 2
        ) AS Percentage_Increase
    FROM jun_2025
    WHERE `Average of June-24` > 0
)

SELECT *
FROM Price_Changes
WHERE Percentage_Increase > (
    SELECT AVG(Percentage_Increase)
    FROM Price_Changes
)
ORDER BY Percentage_Increase DESC;

--RESULT:
--Plantain (unripe)	73.93
--Tilapia fresh fish (Epiya)	68.86
--Titus, frozen	64.09
--Agric hen eggs, 	59.12
--Cat fresh fish	58.89
--Mackerel, Frozen	53.62
--Plantain (ripe)	48.87
--Vegetable Oil, 75cl	41.32
--Palm oil, 75cl	36.2
--Wheat Flour, Prepacked (2kg)	32.02
--Chicken Wings	28.83
--Tin Milk-Evaporated, Peak Milk, 150g	28.3

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
FROM jun_2025
ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Mackerel, Frozen	Plateau (9055.31)	Zamfara (3550.07)	5505.24
--Dried fish, Bonga	Imo (10250.34)	Taraba (4850)	5400.34
--Goat Meat Bone in	Imo (9377.03)	Kogi (4018.55)	5358.48
--Cray fish small white	Ekiti (11847.17)	Cross River (7096.3)	4750.87
--Cat fresh fish	Plateau (8300.36)	Zamfara (3684.34)	4616.02












































