---- 1. which five(5) food items has the highest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of May-25`,
      `Average of Apr-25`,
	  `Average of May-24`
FROM may_2025
ORDER BY  `Average of May-25` DESC
LIMIT 5;

--RESULT:
--Cray fish small white	8046.835984	6655.661529	
--Goat Meat Bone in	6710.94411	6708.452752	
--Dried fish, Bonga	6703.079156	6657.742776	
--Beef Boneless	6662.924662	6544.536858	5137.524647
--Agric hen eggs, (a Crate of 30 pieces)	6263.915592	6281.529423	


---- 2. Which five(5) food items has the lowest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of May-25`,
      `Average of Apr-25`,
	  `Average of May-24`
FROM may_2025
ORDER BY  `Average of May-25` ASC
LIMIT 5;

--RESULT:
--Agric hen eggs, 	265.7252501	259.3161525	160.31
--Tin Milk-Evaporated, Three Crown Milk, 160g	906.0829505	888.9103697	
--Tin Milk-Evaporated, Peak Milk, 150g	1011.746964	994.1917362	783.9829097
--Sweet potatoes 	1045.033024	938.4237847	1062.304981
--Maize (Corn) Grains (White) sold loose	1216.550868	1239.60966	950.1584664


---- 3. Which food items experienced the biggest increases compared with the previous March 2025 ?

SELECT Items_Label,
      ROUND(
           `Average of May-25` - `Average of Apr-25`, 2
		) AS Monthly_Increase
FROM may_2025
ORDER BY Monthly_Increase DESC
LIMIT 5;

--RESULT:
--Cray fish small white	1391.17
--Ginger, fresh	535.12
--Titus, frozen	137.23
--Yam Tuber	135.31
--Irish Potatoe	132.49


----  4. Which food items experienced the biggest price decreases compared with the previous April 2025 ? 

SELECT
    Items_Label,
    ROUND(
        `Average of May-25` - `Average of Apr-25`, 2
    ) AS Monthly_Decrease
FROM may_2025
ORDER BY Monthly_Decrease ASC
LIMIT 5; 


--RESULT:
--Beans white	-56.8
--Rice Local, short-Grained	-48.76
--Beans Brown	-44.24
--Palm oil, 75cl	-41.28
--Groundnut oil, 75cl	-35.05


---- 5. Which geopolitical zone recorded the highest average food prices?

SELECT 'NORTH CENTRAL' AS Zone,
       AVG(`NORTH CENTRAL`) AS Average_Price
FROM may_2025

UNION ALL

SELECT 'NORTH EAST',
       AVG(`NORTH EAST`)
FROM may_2025

UNION ALL

SELECT 'NORTH WEST',
       AVG(`NORTH WEST`)
FROM may_2025

UNION ALL

SELECT 'SOUTH EAST',
       AVG(`SOUTH EAST`)
FROM may_2025

UNION ALL

SELECT 'SOUTH SOUTH',
       AVG(`SOUTH SOUTH`)
FROM may_2025

UNION ALL

SELECT 'SOUTH WEST',
       AVG(`SOUTH WEST`)
FROM may_2025

ORDER BY Average_Price DESC
LIMIT 1;

--RESULT:
--SOUTH EAST	3705.198588487805


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

FROM may_2025

ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	9326.656	5550	3776.66
--Mackerel, Frozen	7607.626644	4320.989934	3286.64
--Goat Meat Bone in	8643.934667	5699.895833	2944.04
--Chicken meat (Frozen)	7780.567856	4904.5	2876.07
--Beef Boneless	8540.136732	5793.599686	2746.54


---- 7. Which food items experienced the highest percentage price increases year-on-year ?

SELECT
    Items_Label,
    `Average of May-24`,
    `Average of May-25`,
    ROUND(
        (
          (`Average of May-25` - `Average of May-24`)
          / `Average of May-24`
        ) * 100, 2
    ) AS Percentage_Increase
FROM may_2025
WHERE `Average of May-24` > 0
ORDER BY Percentage_Increase DESC
LIMIT 5;

--RESULT:
--Plantain (unripe)	1139.019616	2307.64077	102.6
--Plantain (ripe)	1106.325713	2079.840307	88
--Yam Tuber	1322.361686	2375.398619	79.63
--Tilapia fresh fish (Epiya)	3148.327558	5557.975986	76.54
--Titus, frozen	3577.47698	6076.519665	69.85


---- 8. Which food items maintained the most stable prices between May 2024 and May 2025 ?

SELECT
    Items_Label,
    `Average of May-24`,
    `Average of May-25`,
    ROUND(
         ABS(`Average of May-25` - `Average of May-24`), 2) AS Price_Difference
FROM may_2025
ORDER BY Price_Difference ASC
LIMIT 5;

--RESULT:
--Sweet potatoes 	1062.304981	1045.033024	17.27
--Tomatoes, fresh 	1479.686037	1392.710719	86.98
--Agric hen eggs, 	160.31	265.7252501	105.42
--Beans white	1847.836919	2040.508123	192.67
--Garri white	1114.719658	1341.789862	227.07


---- 9. Which food items experienced a higher percentage price increases than the overall average ?

WITH Price_Changes AS (
    SELECT
        Items_Label,
        ROUND(
            (
                (`Average of May-25` - `Average of May-24`)
                / `Average of May-24`
            ) * 100, 2
        ) AS Percentage_Increase
    FROM may_2025
    WHERE `Average of May-24` > 0
)

SELECT *
FROM Price_Changes
WHERE Percentage_Increase > (
    SELECT AVG(Percentage_Increase)
    FROM Price_Changes
)
ORDER BY Percentage_Increase DESC;

--RESULT:
--Plantain (unripe)	102.6
--Plantain (ripe)	88
--Yam Tuber	79.63
--Tilapia fresh fish (Epiya)	76.54
--Titus, frozen	69.85
--Agric hen eggs, 	65.76
--Cat fresh fish	64.2
--Mackerel, Frozen	60.55
--Vegetable Oil, 75cl	50.05
--Palm oil, 75cl	47.06


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
FROM may_2025
ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Dried fish, Bonga	Ebonyi (10240)	Borno (4050)	6190.00
--Goat Meat Bone in	Imo (9368.6)	Taraba (3900)	5468.60
--Mackerel, Frozen	Plateau (9003)	Zamfara (3689.44)	5313.56
--Tilapia fresh fish (Epiya)	Benue (8352.85)	Yobe (3400)	4952.85
--Cat fresh fish	Plateau (8218.1)	Yobe (3315.77)	4902.33






























