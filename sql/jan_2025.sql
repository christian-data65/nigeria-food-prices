---- 1. which five(5) food items has the highest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of Jan-25`,
      `Average of Dec-24`,
	  `Average of Jan-24`
FROM jan_2025
ORDER BY  `Average of Jan-25` DESC
LIMIT 5;

--RESULT:
--Cray fish small white	6227.04072		
--Goat Meat Bone in	6202.357505		
--Dried fish, Bonga	6131.980115		
--Beef Boneless	6122.568294	6150.182883	3315.781106
--Agric hen eggs, (a Crate of 30 pieces)	5878.140647		


---- 2. Which five(5) food items has the lowest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of Jan-25`,
      `Average of Dec-24`,
	  `Average of Jan-24`
FROM jan_2025
ORDER BY  `Average of Jan-25` ASC
LIMIT 5;


--RESULT:
--Tin Milk-Evaporated, Three Crown Milk, 160g	837.2325512		
--Sweet potatoes 	852.5153115	930.7890081	615.4725835
--Tin Milk-Evaporated, Peak Milk, 150g	928.0016282	1014.741465	575.7830624
--Tomatoes, fresh 	1081.439136	1453.495668	845.2582399
--Maize (Corn) Grains (White) sold loose	1168.337972	1151.134713	633.912053

---- 3. Which food items experienced the biggest increases compared with the previous December 2024 ?

SELECT Items_Label,
      ROUND(
           `Average of Jan-25` - `Average of Dec-24`, 2
		) AS Monthly_Increase
FROM jan_2025
ORDER BY Monthly_Increase DESC
LIMIT 5;


--RESULT:
--Cray fish small white	6227.04
--Goat Meat Bone in	6202.36
--Dried fish, Bonga	6131.98
--Agric hen eggs, (a Crate of 30 pieces)	5878.14
--Ginger, fresh	4206.8


----  4. Which food items experienced the biggest price decreases compared with the previous December 2024 ? 

SELECT
    Items_Label,
    ROUND(
        `Average of Jan-25` - `Average of Dec-24`, 2
    ) AS Monthly_Decrease
FROM jan_2025
WHERE `Average of Jan-25` < `Average of Dec-24`
ORDER BY Monthly_Decrease ASC
LIMIT 5;

--RESULT:
--Chicken meat (Frozen)	-976.78
--Onions, fresh 	-690.19
--Vegetable Oil, 75cl	-386.87
--Tomatoes, fresh 	-372.06
--Palm oil, 75cl	-252.81


---- 5. Which geopolitical zone recorded the highest average food prices?

SELECT 'NORTH CENTRAL' AS Zone,
       AVG(`NORTH CENTRAL`) AS Average_Price
FROM jan_2025

UNION ALL

SELECT 'NORTH EAST',
       AVG(`NORTH EAST`)
FROM jan_2025

UNION ALL

SELECT 'NORTH WEST',
       AVG(`NORTH WEST`)
FROM jan_2025

UNION ALL

SELECT 'SOUTH EAST',
       AVG(`SOUTH EAST`)
FROM jan_2025

UNION ALL

SELECT 'SOUTH SOUTH',
       AVG(`SOUTH SOUTH`)
FROM jan_2025

UNION ALL

SELECT 'SOUTH WEST',
       AVG(`SOUTH WEST`)
FROM jan_2025

ORDER BY Average_Price DESC
LIMIT 1;

--RESULT:
--SOUTH EAST	3306.7692514724995


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

FROM jan_2025

ORDER BY Price_Difference DESC
LIMIT 5;


--RESULT:
--Chicken meat (Frozen)	7440	4400	3040
--Mackerel, Frozen	7344.777166	4350.171958	2994.61
--Dried fish, Bonga	8147.919829	5263.593074	2884.33
--Goat Meat Bone in	7629.240804	5276.529173	2352.71
--Cray fish small white	6954.076357	4683.333333	2270.74


---- 7. Which food items experienced the highest percentage price increases year-on-year ?

SELECT
    Items_Label,
    `Average of Jan-24`,
    `Average of Jan-25`,
    ROUND(
        (
          (`Average of Jan-25` - `Average of Jan-24`)
          / `Average of Jan-24`
        ) * 100, 2
    ) AS Percentage_Increase
FROM jan_2025
WHERE `Average of Jan-24` > 0
ORDER BY Percentage_Increase DESC
LIMIT 5;

--RESULT:
--Plantain (unripe)	811.9451666	2119.068929	160.99
--Beans Brown	976.584071	2458.533288	151.75
--Plantain (ripe)	810.6669788	1876.025866	131.42
--Beans white	921.3782243	2123.852994	130.51
--Tilapia fresh fish (Epiya)	2214.428414	5065.363191	128.74


---- 8. Which food items maintained the most stable prices between January 2024 and January 2025 ?

SELECT
    Items_Label,
    `Average of Jan-24`,
    `Average of Jan-25`,
    ROUND(
         ABS(`Average of Jan-25` - `Average of Jan-24`), 2) AS Price_Difference
FROM jan_2025
ORDER BY Price_Difference ASC
LIMIT 5;

--RESULT:
--Tomatoes, fresh 	845.2582399	1081.439136	236.18
--Sweet potatoes 	615.4725835	852.5153115	237.04
--Tin Milk-Evaporated, Peak Milk, 150g	575.7830624	928.0016282	352.22
--Onions, fresh 	881.1976532	1367.621563	486.42
--Maize (Corn) Grains (White) sold loose	633.912053	1168.337972	534.43


---- 9. Which food items experienced a higher percentage price increases than the overall average ?


WITH Price_Changes AS (
    SELECT
        Items_Label,
        ROUND(
            (
                (`Average of Jan-25` - `Average of Jan-24`)
                / `Average of Jan-24`
            ) * 100, 2
        ) AS Percentage_Increase
    FROM jan_2025
    WHERE `Average of Jan-24` > 0
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
--Plantain (unripe)	160.99
--Beans Brown	151.75
--Plantain (ripe)	131.42
--Beans white	130.51
--Tilapia fresh fish (Epiya)	128.74
--Yam Tuber	120.78
--Garri Yellow	117.71
--Garri white	111.03
--Cat fresh fish	109.29
--Mackerel, Frozen	108.21


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
FROM jan_2025
ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Mackerel, Frozen	Plateau (8696.05)	Zamfara (3196.67)	5499.38
--Goat Meat Bone in	Akwa Ibom (8687.5)	Kogi (3925)	4762.50
--Dried fish, Bonga	Enugu (8900)	Bayelsa (4202.78)	4697.22
--Tilapia fresh fish (Epiya)	Benue (8239.29)	Kebbi (3692.11)	4547.18
--Titus, frozen	Kwara (8343.26)	Taraba (4000)	4343.26

































