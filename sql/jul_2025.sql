---- 1. which five(5) food items has the highest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of July-25`,
      `Average of June-25`,
	  `Average of July-24`
FROM jul_2025
ORDER BY  `Average of July-25` DESC
LIMIT 5;

--RESULT:
--Cray fish small white	9380.687073	8753.212366	
--Dried fish, Bonga	7072.976572	7024.158293	
--Beef Boneless	6831.352774	6808.960907	5441.065615
--Goat Meat Bone in	6821.309058	6779.490529	
--Agric hen eggs, (a Crate of 30 pieces)	6294.291026	6326.553236	


---- 2. Which five(5) food items has the lowest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of July-25`,
      `Average of June-25`,
	  `Average of July-24`
FROM jul_2025
ORDER BY  `Average of July-25` ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	270.7705925	268.1321912	185.1027163
--Tin Milk-Evaporated, Three Crown Milk, 160g	923.4343694	910.081284	
--Tin Milk-Evaporated, Peak Milk, 150g	1034.602821	1028.285335	851.0732027
--Sweet potatoes 	1052.971546	1039.327128	970.4995791
--Maize (Corn) Grains (White) sold loose	1166.808507	1188.371421	1029.297475


---- 3. Which food items experienced the biggest increases compared with the previous June 2025 ?

SELECT Items_Label,
      ROUND(
           `Average of July-25` - `Average of June-25`, 2
		) AS Monthly_Increase
FROM jul_2025
ORDER BY Monthly_Increase DESC
LIMIT 5;

--RESULT:
--Cray fish small white	627.47
--Mackerel, Frozen	124.07
--Dried fish, Bonga	48.82
--Palm oil, 75cl	44.38
--Goat Meat Bone in	41.82


----  4. Which food items experienced the biggest price decreases compared with the previous June 2025 ? 

SELECT
    Items_Label,
    ROUND(
        `Average of July-25` - `Average of June-25`, 2
    ) AS Monthly_Decrease
FROM jul_2025
ORDER BY Monthly_Decrease ASC
LIMIT 5; 

--RESULT:
--Garri white	-39.56
--Garri Yellow	-38.04
--Agric hen eggs, (a Crate of 30 pieces)	-32.26
--Tomatoes, fresh 	-26.88
--Maize (Corn) Grains (White) sold loose	-21.56

---- 5. Which geopolitical zone recorded the highest average food prices?

SELECT 'NORTH CENTRAL' AS Zone,
       AVG(`NORTH CENTRAL`) AS Average_Price
FROM jul_2025

UNION ALL

SELECT 'NORTH EAST',
       AVG(`NORTH EAST`)
FROM jul_2025

UNION ALL

SELECT 'NORTH WEST',
       AVG(`NORTH WEST`)
FROM jul_2025

UNION ALL

SELECT 'SOUTH EAST',
       AVG(`SOUTH EAST`)
FROM jul_2025

UNION ALL

SELECT 'SOUTH SOUTH',
       AVG(`SOUTH SOUTH`)
FROM jul_2025

UNION ALL

SELECT 'SOUTH WEST',
       AVG(`SOUTH WEST`)
FROM jul_2025

ORDER BY Average_Price DESC
LIMIT 1;

--RESULT:
--SOUTH EAST	3825.1909526195113


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

FROM jul_2025

ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Cray fish small white	12300.58847	8271.019064	4029.57
--Dried fish, Bonga	9700.129787	5907.389171	3792.74
--Goat Meat Bone in	8934.993101	5769.912538	3165.08
--Beef Boneless	8765.60655	5625.300871	3140.31
--Mackerel, Frozen	7633.3665	4585.262766	3048.1


---- 7. Which food items experienced the highest percentage price increases year-on-year ?

SELECT
    Items_Label,
    `Average of July-24`,
    `Average of July-25`,
    ROUND(
        (
          (`Average of July-25` - `Average of July-24`)
          / `Average of July-24`
        ) * 100, 2
    ) AS Percentage_Increase
FROM jul_2025
WHERE `Average of July-24` > 0
ORDER BY Percentage_Increase DESC
LIMIT 5;

--RESULT:
--Plantain (unripe)	1430.827153	2325.070485	62.5
--Tilapia fresh fish (Epiya)	3648.867179	5727.762682	56.97
--Titus, frozen	4165.903011	6271.450683	50.54
--Cat fresh fish	3926.115462	5778.811188	47.19
--Mackerel, Frozen	3865.419356	5681.31325	46.98


---- 8. Which food items maintained the most stable prices between July 2024 and July 2025 ?

SELECT
    Items_Label,
    `Average of July-24`,
    `Average of July-25`,
    ROUND(
         ABS(`Average of July-25` - `Average of July-24`), 2) AS Price_Difference
FROM jul_2025
ORDER BY Price_Difference ASC
LIMIT 5;

--RESULT:
--Sweet potatoes 	970.4995791	1052.971546	82.47
--Agric hen eggs, 	185.1027163	270.7705925	85.67
--Garri white	1151.790218	1258.637332	106.85
--Beans Brown	2444.807905	2319.265382	125.54
--Maize (Corn) Grains (White) sold loose	1029.297475	1166.808507	137.51


---- 9. Which food items experienced a higher percentage price increases than the overall average ?

WITH Price_Changes AS (
    SELECT
        Items_Label,
        ROUND(
            (
                (`Average of July-25` - `Average of July-24`)
                / `Average of July-24`
            ) * 100, 2
        ) AS Percentage_Increase
    FROM jul_2025
    WHERE `Average of July-24` > 0
)

SELECT *
FROM Price_Changes
WHERE Percentage_Increase > (
    SELECT AVG(Percentage_Increase)
    FROM Price_Changes
)
ORDER BY Percentage_Increase DESC;

--RESULT:
--Plantain (unripe)	62.5
--Tilapia fresh fish (Epiya)	56.97
--Titus, frozen	50.54
--Cat fresh fish	47.19
--Mackerel, Frozen	46.98
--Agric hen eggs, 	46.28
--Plantain (ripe)	42.74
--Yam Tuber	37.81
--Palm oil, 75cl	37.63
--Vegetable Oil, 75cl	37.14
--Wheat Flour, Prepacked (2kg)	28.66
--Beef Boneless	25.55
--Chicken Wings	25.53


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
FROM jul_2025
ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	Imo (10250.34)	Taraba (4850)	5400.34
--Goat Meat Bone in	Imo (9377.03)	Kogi (4026.99)	5350.04
--Mackerel, Frozen	Plateau (9055.31)	Zamfara (3769.58)	5285.73
--Cat fresh fish	Plateau (8300.36)	Zamfara (3587.75)	4712.61
--Tilapia fresh fish (Epiya)	Benue (8353.72)	Yobe (3950)	4403.72







