---- 1. which five(5) food items has the highest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of March-26`,
      `Average of February-26`,
	  `Average of March-25`
FROM mar_2026
ORDER BY  `Average of March-26` DESC
LIMIT 5;

--RESULT:
--Cray fish small white	8820.59326	8785.158288	6657.002535
--Dried fish, Bonga	7292.624884	7279.894959	6493.784328
--Beef Boneless	6903.310592	6893.872839	6523.500991
--Goat Meat Bone in	6860.540373	6845.738269	6892.462296
--Titus, frozen	6377.756737	6363.686464	5860.007124


---- 2. Which five(5) food items has the lowest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of March-26`,
      `Average of February-26`,
	  `Average of March-25`
FROM mar_2026
ORDER BY  `Average of March-26` ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	256.4849203	248.3492808	261.1823463
--Garri white	801.540394	790.6246042	1362.959315
--Maize (Corn) Grains (White) sold loose	803.2747553	795.8172531	1278.75952
--Sweet potatoes 	828.3438407	805.4089808	909.8848798
--Garri Yellow	853.6471834	841.7366786	1456.651265


---- 3. Which food items experienced the biggest increases compared with the previous February 2026 ?

SELECT Items_Label,
      ROUND(
           `Average of March-26` - `Average of February-26`, 2
		) AS Monthly_Increase
FROM mar_2026
ORDER BY Monthly_Increase DESC
LIMIT 5;

--RESULT:
--Agric hen eggs, (a Crate of 30 pieces)	120.26
--Yam Tuber	35.71
--Irish Potatoe	35.48
--Cray fish small white	35.43
--Ginger, fresh	33.82


----  4. Which food items experienced the biggest price decreases compared with the previous February 2026 ? 

SELECT
    Items_Label,
    ROUND(
        `Average of March-26` - `Average of February-26`, 2
    ) AS Monthly_Decrease
FROM mar_2026
ORDER BY Monthly_Decrease ASC
LIMIT 5; 

--RESULT:
--Semovita, Prepacked (1kg)	-80.62
--Bread (unsliced), 450g	2.7
--Bread (sliced), 450g	2.93
--Tin Milk-Evaporated, Three Crown Milk, 160g	5.12
--Tin Milk-Evaporated, Peak Milk, 150g	5.49
 

---- 5. Which geopolitical zone recorded the highest average food prices?

SELECT 'NORTH CENTRAL' AS Zone,
       AVG(`NORTH CENTRAL`) AS Average_Price
FROM mar_2026

UNION ALL

SELECT 'NORTH EAST',
       AVG(`NORTH EAST`)
FROM mar_2026

UNION ALL

SELECT 'NORTH WEST',
       AVG(`NORTH WEST`)
FROM mar_2026

UNION ALL

SELECT 'SOUTH EAST',
       AVG(`SOUTH EAST`)
FROM mar_2026

UNION ALL

SELECT 'SOUTH SOUTH',
       AVG(`SOUTH SOUTH`)
FROM mar_2026

UNION ALL

SELECT 'SOUTH WEST',
       AVG(`SOUTH WEST`)
FROM mar_2026

ORDER BY Average_Price DESC
LIMIT 1;

--RESULT:
--SOUTH EAST	3531.7491924390247


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

FROM mar_2026

ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	9478.303088	5746.051274	3732.25
--Chicken meat (Frozen)	8132.25635	4962.747143	3169.51
--Mackerel, Frozen	7639.814667	4480.373071	3159.44
--Ginger, fresh	6752.817524	3835.120169	2917.7
--Goat Meat Bone in	8512.272836	5721.014428	2791.26


---- 7. Which food items experienced the highest percentage price increases year-on-year ?

SELECT
    Items_Label,
    `Average of March-25`,
    `Average of March-26`,
    ROUND(
        (
          (`Average of March-26` - `Average of March-25`)
          / `Average of March-25`
        ) * 100, 2
    ) AS Percentage_Increase
FROM mar_2026
WHERE `Average of March-25` > 0
ORDER BY Percentage_Increase DESC
LIMIT 5;

--RESULT:
--Cray fish small white	6657.002535	8820.59326	32.5
--Ginger, fresh	4600.230818	5541.252668	20.46
--Chicken feet	3487.05878	3979.84773	14.13
--Dried fish, Bonga	6493.784328	7292.624884	12.3
--Cat fresh fish	5507.109941	6080.020725	10.4


---- 8. Which food items maintained the most stable prices between March 2025 and March 2026 ?

SELECT
    Items_Label,
    `Average of March-25`,
    `Average of March-26`,
    ROUND(
         ABS(`Average of March-26` - `Average of March-25`), 2) AS Price_Difference
FROM mar_2026
ORDER BY Price_Difference ASC
LIMIT 5;

--RESULT:
--Yam Tuber	2141.130036	2144.696169	3.57
--Agric hen eggs, 	261.1823463	256.4849203	4.7
--Bread (sliced), 450g	1680.174697	1675.308891	4.87
--Semovita, Prepacked (1kg)	2173.117865	2160.420504	12.7
--Watermelon whole, medium size fresh	2040.818733	2068.051119	27.23


---- 9. Which food items experienced a higher percentage price increases than the overall average ?

WITH Price_Changes AS (
    SELECT
        Items_Label,
        ROUND(
            (
                (`Average of March-26` - `Average of March-25`)
                / `Average of March-25`
            ) * 100, 2
        ) AS Percentage_Increase
    FROM mar_2026
    WHERE `Average of March-25` > 0
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
--Cray fish small white	32.5
--Ginger, fresh	20.46
--Chicken feet	14.13
--Dried fish, Bonga	12.3
--Cat fresh fish	10.4
--Titus, frozen	8.84
--Irish Potatoe	8.64
--Tilapia fresh fish (Epiya)	7.62
--Chicken Wings	7.28
--Tin Milk-Evaporated, Three Crown Milk, 160g	6.99


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
FROM mar_2026
ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Mackerel, Frozen	Plateau (9099.33)	Zamfara (3757.92)	5341.41
--Dried fish, Bonga	Enugu (10219.53)	Jigawa (5200.45)	5019.08
--Goat Meat Bone in	Imo (8795.61)	Kogi (4034.54)	4761.07
--Cat fresh fish	Plateau (8323.59)	Kaduna (3680.57)	4643.02
--Tilapia fresh fish (Epiya)	Benue (8377.54)	Sokoto (3751.01)	4626.53
