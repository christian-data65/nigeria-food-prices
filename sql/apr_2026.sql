---- 1. which five(5) food items has the highest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of April-26`,
      `Average of March-26`,
	  `Average of April-25`
FROM apr_2026
ORDER BY  `Average of April-26` DESC
LIMIT 5;

--RESULT:
--Cray fish small white	8857.897497	8820.59326	6655.661529
--Dried fish, Bonga	7314.418603	7292.624884	6657.742776
--Beef Boneless	6919.9376	6903.310592	6544.536858
--Goat Meat Bone in	6874.615347	6860.540373	6708.452752
--Titus, frozen	6416.582932	6377.756737	5939.287289


---- 2. Which five(5) food items has the lowest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of April-26`,
      `Average of March-26`,
	  `Average of April-25`
FROM apr_2026
ORDER BY  `Average of April-26` ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	259.2181946	256.4849203	259.3161525
--Garri white	808.959232	801.540394	1345.097851
--Maize (Corn) Grains (White) sold loose	811.3322285	803.2747553	1239.60966
--Sweet potatoes 	844.2952065	828.3438407	938.4237847
--Garri Yellow	861.9186108	853.6471834	1422.339848


---- 3. Which food items experienced the biggest increases compared with the previous March 2026 ?

SELECT Items_Label,
      ROUND(
           `Average of April-26` - `Average of March-26`, 2
		) AS Monthly_Increase
FROM apr_2026
ORDER BY Monthly_Increase DESC
LIMIT 5;

--RESULT:
--Yam Tuber	73.76
--Tomatoes, fresh 	72.97
--Ginger, fresh	40.57
--Titus, frozen	38.83
--Cray fish small white	37.3


----  4. Which food items experienced the biggest price decreases compared with the previous March 2026 ? 

SELECT
    Items_Label,
    ROUND(
        `Average of April-26` - `Average of March-26`, 2
    ) AS Monthly_Decrease
FROM apr_2026
ORDER BY Monthly_Decrease ASC
LIMIT 5; 

--RESULT:
--Semovita, Prepacked (1kg)	0.75
--Agric hen eggs, 	2.73
--Palm oil, 75cl	2.95
--Tin Milk-Evaporated, Three Crown Milk, 160g	3.58
--Tin Milk-Evaporated, Peak Milk, 150g	5.15
 

---- 5. Which geopolitical zone recorded the highest average food prices?

SELECT 'NORTH CENTRAL' AS Zone,
       AVG(`NORTH CENTRAL`) AS Average_Price
FROM apr_2026

UNION ALL

SELECT 'NORTH EAST',
       AVG(`NORTH EAST`)
FROM apr_2026

UNION ALL

SELECT 'NORTH WEST',
       AVG(`NORTH WEST`)
FROM apr_2026

UNION ALL

SELECT 'SOUTH EAST',
       AVG(`SOUTH EAST`)
FROM apr_2026

UNION ALL

SELECT 'SOUTH SOUTH',
       AVG(`SOUTH SOUTH`)
FROM apr_2026

UNION ALL

SELECT 'SOUTH WEST',
       AVG(`SOUTH WEST`)
FROM apr_2026

ORDER BY Average_Price DESC
LIMIT 1;

--RESULT:
--SOUTH EAST	3551.6363168073167


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

FROM apr_2026

ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	9509.677632	5777.218001	3732.46
--Chicken meat (Frozen)	8167.037111	5014.632167	3152.4
--Mackerel, Frozen	7641.171273	4507.250337	3133.92
--Ginger, fresh	6812.917261	3881.120169	2931.8
--Goat Meat Bone in	8547.994987	5721.663338	2826.33


---- 7. Which food items experienced the highest percentage price increases year-on-year ?

SELECT
    Items_Label,
    `Average of April-25`,
    `Average of April-26`,
    ROUND(
        (
          (`Average of April-26` - `Average of April-25`)
          / `Average of April-25`
        ) * 100, 2
    ) AS Percentage_Increase
FROM apr_2026
WHERE `Average of April-25` > 0
ORDER BY Percentage_Increase DESC
LIMIT 5;

--RESULT:
--Cray fish small white	6655.661529	8857.897497	33.09
--Chicken feet	3502.697044	3992.012354	13.97
--Ginger, fresh	4970.658843	5581.824918	12.3
--Dried fish, Bonga	6657.742776	7314.418603	9.86
--Cat fresh fish	5572.493423	6094.103149	9.36


---- 8. Which food items maintained the most stable prices between April 2025 and April 2026 ?

SELECT
    Items_Label,
    `Average of April-25`,
    `Average of April-26`,
    ROUND(
         ABS(`Average of April-26` - `Average of April-25`), 2) AS Price_Difference
FROM apr_2026
ORDER BY Price_Difference ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	259.3161525	259.2181946	0.1
--Bread (sliced), 450g	1688.399846	1682.596329	5.8
--Agric hen eggs, (a Crate of 30 pieces)	6150.178072	6143.112662	7.07
--Yam Tuber	2240.083777	2218.459373	21.62
--Watermelon whole, medium size fresh	2057.348805	2079.237962	21.89


---- 9. Which food items experienced a higher percentage price increases than the overall average ?

WITH Price_Changes AS (
    SELECT
        Items_Label,
        ROUND(
            (
                (`Average of April-26` - `Average of April-25`)
                / `Average of April-25`
            ) * 100, 2
        ) AS Percentage_Increase
    FROM apr_2026
    WHERE `Average of April-25` > 0
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
--Cray fish small white	33.09
--Chicken feet	13.97
--Ginger, fresh	12.3
--Dried fish, Bonga	9.86
--Cat fresh fish	9.36
--Titus, frozen	8.04
--Mackerel, Frozen	7.38
--Tilapia fresh fish (Epiya)	7.22
--Tin Milk-Evaporated, Peak Milk, 150g	6.13
--Irish Potatoe	5.99


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
FROM apr_2026
ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Mackerel, Frozen	Plateau (9104.61)	Zamfara (3776.99)	5327.62
--Dried fish, Bonga	Enugu (10278.16)	Katsina (5242.35)	5035.81
--Goat Meat Bone in	Imo (8798.1)	Kogi (4035.96)	4762.14
--Cat fresh fish	Plateau (8323.8)	Kaduna (3710.87)	4612.93
--Tilapia fresh fish (Epiya)	Benue (8377.62)	Sokoto (3780.1)	4597.52





