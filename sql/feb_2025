---- 1. which five(5) food items has the highest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of Feb-25`,
      `Average of Jan-25`,
	  `Average of feb-24`
FROM feb_2025
ORDER BY  `Average of Feb-25` DESC
LIMIT 5;

--RESULT:
--Cray fish small white	6440.441083	6227.04072	
--Goat Meat Bone in	6298.893396	6202.357505	
--Beef Boneless	6269.458819	6122.568294	3654.561225
--Dried fish, Bonga	6160.021309	6131.980115	
--Agric hen eggs, (a Crate of 30 pieces)	5976.115852	5878.140647	


---- 2. Which five(5) food items has the lowest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of Feb-25`,
      `Average of Jan-25`,
	  `Average of feb-24`
FROM feb_2025
ORDER BY  `Average of Feb-25` ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	251.9405165	248.0413905	139.2802123
--Sweet potatoes 	823.2987	852.5153115	672.8286266
--Tin Milk-Evaporated, Three Crown Milk, 160g	827.3148444	837.2325512	
--Tin Milk-Evaporated, Peak Milk, 150g	931.0347338	928.0016282	635.9995192
--Tomatoes, fresh 	1111.139588	1081.439136	937.8484073


---- 3. Which food items experienced the biggest increases compared with the previous January 2025 ?

SELECT Items_Label,
      ROUND(
           `Average of Feb-25` - `Average of Jan-25`, 2
		) AS Monthly_Increase
FROM feb_2025
ORDER BY Monthly_Increase DESC
LIMIT 5;

--RESULT:
--Cray fish small white	213.4
--Ginger, fresh	165.1
--Beef Boneless	146.89
--Mackerel, Frozen	115.35
--Vegetable Oil, 75cl	114.55


----  4. Which food items experienced the biggest price decreases compared with the previous January 2025 ? 

SELECT
    Items_Label,
    ROUND(
        `Average of Feb-25` - `Average of Jan-25`, 2
    ) AS Monthly_Decrease
FROM feb_2025
ORDER BY Monthly_Decrease ASC
LIMIT 5;

--RESULT:
--Irish Potatoe	-34.5
--Sweet potatoes 	-29.22
--Tin Milk-Evaporated, Three Crown Milk, 160g	-9.92
--Beans white	-9.52
--Maize (Corn) Grains (White) sold loose	0.98


---- 5. Which geopolitical zone recorded the highest average food prices?

SELECT 'NORTH CENTRAL' AS Zone,
       AVG(`NORTH CENTRAL`) AS Average_Price
FROM feb_2025

UNION ALL

SELECT 'NORTH EAST',
       AVG(`NORTH EAST`)
FROM feb_2025

UNION ALL

SELECT 'NORTH WEST',
       AVG(`NORTH WEST`)
FROM feb_2025

UNION ALL

SELECT 'SOUTH EAST',
       AVG(`SOUTH EAST`)
FROM feb_2025

UNION ALL

SELECT 'SOUTH SOUTH',
       AVG(`SOUTH SOUTH`)
FROM feb_2025

UNION ALL

SELECT 'SOUTH WEST',
       AVG(`SOUTH WEST`)
FROM feb_2025

ORDER BY Average_Price DESC
LIMIT 1;

--RESULT:
--SOUTH EAST	3318.407034158537


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

FROM feb_2025

ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	8580.108106	5095.27417	3484.83
--Mackerel, Frozen	7346.742274	4254.43601	3092.31
--Chicken meat (Frozen)	7528	4581.428571	2946.57
--Cray fish small white	7180.822143	4818.333333	2362.49
--Beef Boneless	7951.877731	5593.571429	2358.31


---- 7. Which food items experienced the highest percentage price increases year-on-year ?

SELECT
    Items_Label,
    `Average of Feb-24`,
    `Average of Feb-25`,
    ROUND(
        (
          (`Average of Feb-25` - `Average of Feb-24`)
          / `Average of Feb-24`
        ) * 100, 2
    ) AS Percentage_Increase
FROM feb_2025
WHERE `Average of Feb-24` > 0
ORDER BY Percentage_Increase DESC
LIMIT 5;

--RESULT:
--Plantain (unripe)	858.9919132	2127.671268	147.69
--Plantain (ripe)	846.5005962	1914.499014	126.17
--Beans Brown	1177.925798	2465.962772	109.35
--Tilapia fresh fish (Epiya)	2445.262485	5103.942029	108.73
--Yam Tuber	1009.55599	2022.032913	100.29


---- 8. Which food items maintained the most stable prices between February 2024 and February 2025 ?

SELECT
    Items_Label,
    `Average of Feb-24`,
    `Average of Feb-25`,
    ROUND(
         ABS(`Average of Feb-25` - `Average of Feb-24`), 2) AS Price_Difference
FROM feb_2025
ORDER BY Price_Difference ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	139.2802123	251.9405165	112.66
--Sweet potatoes 	672.8286266	823.2987	150.47
--Tomatoes, fresh 	937.8484073	1111.139588	173.29
--Tin Milk-Evaporated, Peak Milk, 150g	635.9995192	931.0347338	295.04
--Maize (Corn) Grains (White) sold loose	729.4516863	1169.321011	439.87


---- 9. Which food items experienced a higher percentage price increases than the overall average ?

WITH Price_Changes AS (
    SELECT
        Items_Label,
        ROUND(
            (
                (`Average of Feb-25` - `Average of Feb-24`)
                / `Average of Feb-24`
            ) * 100, 2
        ) AS Percentage_Increase
    FROM feb_2025
    WHERE `Average of Feb-24` > 0
)

SELECT *
FROM Price_Changes
WHERE Percentage_Increase > (
    SELECT AVG(Percentage_Increase)
    FROM Price_Changes
)
ORDER BY Percentage_Increase DESC;

--RESULT:
--Plantain (unripe)	147.69
--Plantain (ripe)	126.17
--Beans Brown	109.35
--Tilapia fresh fish (Epiya)	108.73
--Yam Tuber	100.29
--Titus, frozen	93
--Mackerel, Frozen	92.98
--Cat fresh fish	91.57
--Garri Yellow	82.88
--Beans white	82.77
--Agric hen eggs, 	80.89
--Garri white	76.55


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
FROM feb_2025
ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Goat Meat Bone in	Akwa Ibom (9500)	Kogi (3800)	5700.00
--Dried fish, Bonga	Enugu (9000)	Adamawa (4000)	5000.00
--Mackerel, Frozen	Plateau (8517.33)	Oyo (3568.18)	4949.15
--Tilapia fresh fish (Epiya)	Benue (8239.29)	Yobe (3750)	4489.29
--Titus, frozen	Kwara (8343.26)	Yobe (4200)	4143.26





















