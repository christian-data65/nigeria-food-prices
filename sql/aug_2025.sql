---- 1. which five(5) food items has the highest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of August-25`,
      `Average of July-25`,
	  `Average of August-24`
FROM aug_2025
ORDER BY  `Average of August-25` DESC
LIMIT 5;

--RESULT:
--Cray fish small white	8806.616268	9380.687073	
--Dried fish, Bonga	7019.717617	7072.976572	
--Beef Boneless	6860.069305	6831.352774	5553.804223
--Goat Meat Bone in	6810.85277	6821.309058	
--Titus, frozen	6310.328619	6271.450683	4235.564093


---- 2. Which five(5) food items has the lowest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of August-25`,
      `Average of July-25`,
	  `Average of August-24`
FROM aug_2025
ORDER BY  `Average of August-25` ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	254.696752	270.7705925	198.6349405
--Sweet potatoes 	877.8346398	1052.971546	850.3149979
--Tin Milk-Evaporated, Three Crown Milk, 160g	910.2792792	923.4343694	
--Garri white	932.5318107	1258.637332	1124.39838
--Maize (Corn) Grains (White) sold loose	951.0393817	1166.808507	1028.332196


---- 3. Which food items experienced the biggest increases compared with the previous July 2025 ?

SELECT Items_Label,
      ROUND(
           `Average of August-25` - `Average of July-25`, 2
		) AS Monthly_Increase
FROM aug_2025
ORDER BY Monthly_Increase DESC
LIMIT 5;

--RESULT:
--Cat fresh fish	154.38
--Chicken feet	102.81
--Chicken Wings	56.5
--Mackerel, Frozen	44.2
--Titus, frozen	38.88


----  4. Which food items experienced the biggest price decreases compared with the previous July 2025 ? 

SELECT
    Items_Label,
    ROUND(
        `Average of August-25` - `Average of July-25`, 2
    ) AS Monthly_Decrease
FROM aug_2025
ORDER BY Monthly_Decrease ASC
LIMIT 5; 
 
--RESULT:
--Cray fish small white	-574.07
--Beans Brown	-471.45
--Yam Tuber	-398.26
--Irish Potatoe	-362.11
--Garri Yellow	-356.71


---- 5. Which geopolitical zone recorded the highest average food prices?

SELECT 'NORTH CENTRAL' AS Zone,
       AVG(`NORTH CENTRAL`) AS Average_Price
FROM aug_2025

UNION ALL

SELECT 'NORTH EAST',
       AVG(`NORTH EAST`)
FROM aug_2025

UNION ALL

SELECT 'NORTH WEST',
       AVG(`NORTH WEST`)
FROM aug_2025

UNION ALL

SELECT 'SOUTH EAST',
       AVG(`SOUTH EAST`)
FROM aug_2025

UNION ALL

SELECT 'SOUTH SOUTH',
       AVG(`SOUTH SOUTH`)
FROM aug_2025

UNION ALL

SELECT 'SOUTH WEST',
       AVG(`SOUTH WEST`)
FROM aug_2025

ORDER BY Average_Price DESC
LIMIT 1;

--PESULT:
--SOUTH EAST	3708.0528404902443


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

FROM aug_2025

ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	9854.944877	5524.891395	4330.05
--Goat Meat Bone in	8956.208202	5774.405635	3181.8
--Mackerel, Frozen	7637.668452	4557.501445	3080.17
--Chicken meat (Frozen)	7950.165334	4897	3053.17
--Beef Boneless	8672.459454	5691.26867	2981.19


---- 7. Which food items experienced the highest percentage price increases year-on-year ?

SELECT
    Items_Label,
    `Average of August-24`,
    `Average of August-25`,
    ROUND(
        (
          (`Average of August-25` - `Average of August-24`)
          / `Average of August-24`
        ) * 100, 2
    ) AS Percentage_Increase
FROM aug_2025
WHERE `Average of August-24` > 0
ORDER BY Percentage_Increase DESC
LIMIT 5;

--RESULT:
--Tilapia fresh fish (Epiya)	3711.359823	5731.0788	54.42
--Plantain (unripe)	1450.317335	2205.446962	52.07
--Cat fresh fish	3934.227216	5933.186716	50.81
--Titus, frozen	4235.564093	6310.328619	48.98
--Mackerel, Frozen	3941.58939	5725.509644	45.26


---- 8. Which food items maintained the most stable prices between August 2024 and August 2025 ?

SELECT
    Items_Label,
    `Average of August-24`,
    `Average of August-25`,
    ROUND(
         ABS(`Average of August-25` - `Average of August-24`), 2) AS Price_Difference
FROM aug_2025
ORDER BY Price_Difference ASC
LIMIT 5;

--RESULT:
--Irish Potatoe	1650.743232	1670.964946	20.22
--Sweet potatoes 	850.3149979	877.8346398	27.52
--Rice Long-Grained (Imported)	2329.049694	2358.888379	29.84
--Agric hen eggs, 	198.6349405	254.696752	56.06
--Maize (Corn) Grains (White) sold loose	1028.332196	951.0393817	77.29


---- 9. Which food items experienced a higher percentage price increases than the overall average ?

WITH Price_Changes AS (
    SELECT
        Items_Label,
        ROUND(
            (
                (`Average of August-25` - `Average of August-24`)
                / `Average of August-24`
            ) * 100, 2
        ) AS Percentage_Increase
    FROM aug_2025
    WHERE `Average of August-24` > 0
)

SELECT *
FROM Price_Changes
WHERE Percentage_Increase > (
    SELECT AVG(Percentage_Increase)
    FROM Price_Changes
)
ORDER BY Percentage_Increase DESC;

--RESULT:
--Tilapia fresh fish (Epiya)	54.42
--Plantain (unripe)	52.07
--Cat fresh fish	50.81
--Titus, frozen	48.98
--Mackerel, Frozen	45.26
--Plantain (ripe)	43.86
--Palm oil, 75cl	33.28
--Agric hen eggs, 	28.22
--Vegetable Oil, 75cl	26.9
--Yam Tuber	25.54
--Chicken Wings	23.74
--Beef Boneless	23.52
--Chicken feet	17.02


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
FROM aug_2025
ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	Enugu (10605.56)	Taraba (4471.61)	6133.95
--Goat Meat Bone in	Imo (9636.3)	Kogi (4031.42)	5604.88
--Mackerel, Frozen	Plateau (9063.66)	Zamfara (3738.09)	5325.57
--Cray fish small white	Osun (10950)	Bayelsa (6150.33)	4799.67
--Cat fresh fish	Plateau (8308.01)	Zamfara (3639.81)	4668.20



