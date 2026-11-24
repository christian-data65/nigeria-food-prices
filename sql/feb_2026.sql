---- 1. which five(5) food items has the highest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of February-26`,
      `Average of January-26`,
	  `Average of February-26`
FROM feb_2026
ORDER BY  `Average of February-26` DESC
LIMIT 5;

--RESULT:
--Cray fish small white	8785.158288	8660.060921	8785.158288
--Dried fish, Bonga	7279.894959	7268.449112	7279.894959
--Beef Boneless	6893.872839	6874.171309	6893.872839
--Goat Meat Bone in	6845.738269	6825.897527	6845.738269
--Titus, frozen	6363.686464	6343.685265	6363.686464


---- 2. Which five(5) food items has the lowest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of February-26`,
      `Average of January-26`,
	  `Average of February-25`
FROM feb_2026
ORDER BY  `Average of February-26` ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	248.3492808	240.1632791	251.9405165
--Garri white	790.6246042	771.9764099	1277.24707
--Maize (Corn) Grains (White) sold loose	795.8172531	784.5917953	1169.321011
--Sweet potatoes 	805.4089808	744.6545095	823.2987
--Garri Yellow	841.7366786	821.9054783	1378.154706


---- 3. Which food items experienced the biggest increases compared with the previous January 2026 ?

SELECT Items_Label,
      ROUND(
           `Average of February-26` - `Average of January-26`, 2
		) AS Monthly_Increase
FROM feb_2026
ORDER BY Monthly_Increase DESC
LIMIT 5;

--RESULT:
--Cray fish small white	125.1
--Agric hen eggs, (a Crate of 30 pieces)	84.19
--Ginger, fresh	62.4
--Sweet potatoes 	60.75
--Tomatoes, fresh 	52.78


----  4. Which food items experienced the biggest price decreases compared with the previous January 2026 ? 

SELECT
    Items_Label,
    ROUND(
        `Average of February-26` - `Average of January-26`, 2
    ) AS Monthly_Decrease
FROM feb_2026
ORDER BY Monthly_Decrease ASC
LIMIT 5; 

--RESULT:
--Tin Milk-Evaporated, Three Crown Milk, 160g	4.73
--Bread (sliced), 450g	5.37
--Tin Milk-Evaporated, Peak Milk, 150g	5.45
--Semovita, Prepacked (1kg)	6.81
--Chicken meat (Frozen)	7.58


---- 5. Which geopolitical zone recorded the highest average food prices?

SELECT 'NORTH CENTRAL' AS Zone,
       AVG(`NORTH CENTRAL`) AS Average_Price
FROM feb_2026

UNION ALL

SELECT 'NORTH EAST',
       AVG(`NORTH EAST`)
FROM feb_2026

UNION ALL

SELECT 'NORTH WEST',
       AVG(`NORTH WEST`)
FROM feb_2026

UNION ALL

SELECT 'SOUTH EAST',
       AVG(`SOUTH EAST`)
FROM feb_2026

UNION ALL

SELECT 'SOUTH SOUTH',
       AVG(`SOUTH SOUTH`)
FROM feb_2026

UNION ALL

SELECT 'SOUTH WEST',
       AVG(`SOUTH WEST`)
FROM feb_2026

ORDER BY Average_Price DESC
LIMIT 1;

--RESULT:
--SOUTH EAST	3513.534845036585


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

FROM feb_2026

ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	9457.265264	5721.927048	3735.34
--Mackerel, Frozen	7637.392566	4463.300649	3174.09
--Chicken meat (Frozen)	8109.1492	4945.354286	3163.79
--Ginger, fresh	6725.333276	3799.418596	2925.91
--Goat Meat Bone in	8483.332073	5719.698331	2763.63


---- 7. Which food items experienced the highest percentage price increases year-on-year ?

SELECT
    Items_Label,
    `Average of February-25`,
    `Average of February-26`,
    ROUND(
        (
          (`Average of February-26` - `Average of February-25`)
          / `Average of February-25`
        ) * 100, 2
    ) AS Percentage_Increase
FROM feb_2026
WHERE `Average of February-25` > 0
ORDER BY Percentage_Increase DESC
LIMIT 5;

--RESULT:
--Cray fish small white	6440.441083	8785.158288	36.41
--Ginger, fresh	4371.896947	5507.430583	25.97
--Chicken feet	3346.624236	3970.941297	18.66
--Dried fish, Bonga	6160.021309	7279.894959	18.18
--Tilapia fresh fish (Epiya)	5103.942029	5862.404905	14.86


---- 8. Which food items maintained the most stable prices between February 2025 and February 2026 ?

SELECT
    Items_Label,
    `Average of February-25`,
    `Average of February-26`,
    ROUND(
         ABS(`Average of February-26` - `Average of February-25`), 2) AS Price_Difference
FROM feb_2026
ORDER BY Price_Difference ASC
LIMIT 5;

--RESULT:
--Palm oil, 75cl	2384.151114	2386.960282	2.81
--Agric hen eggs, 	251.9405165	248.3492808	3.59
--Sweet potatoes 	823.2987	805.4089808	17.89
--Plantain (unripe)	2127.671268	2154.853817	27.18
--Agric hen eggs, (a Crate of 30 pieces)	5976.115852	6007.352086	31.24


---- 9. Which food items experienced a higher percentage price increases than the overall average ?

WITH Price_Changes AS (
    SELECT
        Items_Label,
        ROUND(
            (
                (`Average of February-26` - `Average of February-25`)
                / `Average of February-25`
            ) * 100, 2
        ) AS Percentage_Increase
    FROM feb_2026
    WHERE `Average of February-25` > 0
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
--Cray fish small white	36.41
--Ginger, fresh	25.97
--Chicken feet	18.66
--Dried fish, Bonga	18.18
--Tilapia fresh fish (Epiya)	14.86
--Cat fresh fish	14.77
--Irish Potatoe	14.38
--Titus, frozen	14.37
--Chicken Wings	13.72
--Tin Milk-Evaporated, Peak Milk, 150g	12.19


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
FROM feb_2026
ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Mackerel, Frozen	Plateau (9089.6)	Zamfara (3751.67)	5337.93
--Dried fish, Bonga	Enugu (10217.23)	Jigawa (5199.4)	5017.83
--Goat Meat Bone in	Imo (8786.11)	Kogi (4032.41)	4753.70
--Cat fresh fish	Plateau (8323.19)	Kaduna (3652.26)	4670.93
--Tilapia fresh fish (Epiya)	Benue (8377.25)	Sokoto (3742.22)	4635.03
