---- 1. which five(5) food items has the highest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of Dec-24`,
      `Average of Nov-24`,
	  `Average of Dec-23`
FROM dec_2024
ORDER BY  `Average of Dec-24` DESC
LIMIT 5;

--RESULT:
--Frozen chicken	6473.806417	6130.514594	3771.407282
--Beef,boneless	6150.182883	6001.316307	3146.939434
--Catfish :dried	6044.078806	5787.744495	3357.509044
--Mudfish : dried	5632.337094	5345.990902	3137.504105
--Beef Bone in	5153.18488	5073.735812	2696.878807


---- 2. Which five(5) food items has the lowest prices in the latest reporting month ?

SELECT Items_Label, 
	  `Average of Dec-24`,
      `Average of Nov-24`,
	  `Average of Dec-23`
FROM dec_2024
ORDER BY  `Average of Dec-24` ASC
LIMIT 5;

--RESULT:
--Agric eggs(medium size price of one)	252.1654979	247.2590999	110.0443575
--Evaporated tinned milk carnation 170g	887.4509114	873.77102	487.9426325
--Sweet potato	930.7890081	942.2383441	551.9233331
--Evaporated tinned milk(peak), 170g	1014.741465	991.2039919	542.0022275
--Maize grain white sold loose	1151.134713	1156.908638	577.7714732


---- 3. Which food items experienced the biggest increases compared with the previous November 2024 ?

SELECT Items_Label,
      ROUND(
           `Average of Dec-24` - `Average of Nov-24`, 2
		) AS Monthly_Increase
FROM dec_2024
ORDER BY Monthly_Increase DESC
LIMIT 5;

--RESULT:
--Frozen chicken	343.29
--Mudfish : dried	286.35
--Catfish :dried	256.33
--Vegetable oil:1 bottle,specify bottle	215.79
--Onion bulb	179.81


----  4. Which food items experienced the biggest price decreases compared with the previous November 2024 ? 

SELECT
    Items_Label,
    ROUND(
        `Average of Dec-24` - `Average of Nov-24`, 2
    ) AS Monthly_Decrease
FROM dec_2024
WHERE `Average of Dec-24` < `Average of Nov-24`
ORDER BY Monthly_Decrease ASC
LIMIT 5;

--RESULT:
--Beans:white black eye. sold loose	-227.66
--Beans brown,sold loose	-219.64
--Gari white,sold loose	-20.62
--Tomato	-18.68
--Plantain(unripe)	-16.05


---- 5. Which geopolitical zone recorded the highest average food prices?

SELECT 'NORTH CENTRAL' AS Zone,
       AVG(`NORTH CENTRAL`) AS Average_Price
FROM dec_2024

UNION ALL

SELECT 'NORTH EAST',
       AVG(`NORTH EAST`)
FROM dec_2024

UNION ALL

SELECT 'NORTH WEST',
       AVG(`NORTH WEST`)
FROM dec_2024

UNION ALL

SELECT 'SOUTH EAST',
       AVG(`SOUTH EAST`)
FROM dec_2024

UNION ALL

SELECT 'SOUTH SOUTH',
       AVG(`SOUTH SOUTH`)
FROM dec_2024

UNION ALL

SELECT 'SOUTH WEST',
       AVG(`SOUTH WEST`)
FROM dec_2024

ORDER BY Average_Price DESC
LIMIT 1;

--RESULT:
--SOUTH EAST	3484.484612258139


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

FROM dec_2024

ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Catfish :dried	11814.0399	4151.259925	7662.78
--Mudfish : dried	10927.69772	3783.795409	7143.9
--Dried Fish Sardine	7192.237431	4140.938266	3051.3
--Frozen chicken	8195.164356	5335	2860.16
--Tilapia fish (epiya) fresh	5740.472926	3106.516703	2633.96


---- 7. Which food items experienced the highest percentage price increases year-on-year ?

SELECT
    Items_Label,
    `Average of Dec-23`,
    `Average of Dec-24`,
    ROUND(
        (
          (`Average of Dec-24` - `Average of Dec-23`)
          / `Average of Dec-23`
        ) * 100, 2
    ) AS Percentage_Increase
FROM dec_2024
WHERE `Average of Dec-23` > 0
ORDER BY Percentage_Increase DESC
LIMIT 5;

--RESULT:
--Beans brown,sold loose	870.6679454	2501.323525	187.29
--Beans:white black eye. sold loose	829.8619269	2319.042204	179.45
--Broken Rice (Ofada)	1002.10067	2512.326517	150.71
--Yam tuber	818.918532	1905.900979	132.73
--Agric eggs(medium size price of one)	110.0443575	252.1654979	129.15


---- 8. Which food items maintained the most stable prices between December 2023 and December 2024 ?

SELECT
    Items_Label,
    `Average of Dec-23`,
    `Average of Dec-24`,
    ROUND(
         ABS(`Average of Dec-24` - `Average of Dec-23`), 2) AS Price_Difference
FROM dec_2024
ORDER BY Price_Difference ASC
LIMIT 5;

--RESULT:
--Agric eggs(medium size price of one)	110.0443575	252.1654979	142.12
--Sweet potato	551.9233331	930.7890081	378.87
--Evaporated tinned milk carnation 170g	487.9426325	887.4509114	399.51
--Evaporated tinned milk(peak), 170g	542.0022275	1014.741465	472.74
--Maize grain yellow sold loose	589.7542211	1160.215141	570.46


---- 9. Which food items experienced a higher percentage price increases than the overall average ?


WITH Price_Changes AS (
    SELECT
        Items_Label,
        ROUND(
            (
                (`Average of Dec-24` - `Average of Dec-23`)
                / `Average of Dec-23`
            ) * 100, 2
        ) AS Percentage_Increase
    FROM dec_2024
    WHERE `Average of Dec-23` > 0
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
--Beans brown,sold loose	187.29
--Beans:white black eye. sold loose	179.45
--Broken Rice (Ofada)	150.71
--Yam tuber	132.73
--Agric eggs(medium size price of one)	129.15
--Agric eggs medium size	128.46
--Gari yellow,sold loose	116.61
--Rice local sold loose	111.82
--Onion bulb	111.74
--Rice Medium Grained	111.12


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
FROM dec_2024
ORDER BY Price_Difference DESC
LIMIT 5;

--RESULT:
--Mudfish : dried	Abia (11717.68)	Niger (3199.89)	8517.79
--Catfish :dried	Imo (12478.59)	Katsina (4100.14)	8378.45
--Frozen chicken	Yobe (12000)	Ondo (4870)	7130.00
--Dried Fish Sardine	Nasarawa (7669.01)	Niger (2903.57)	4765.44
--Chicken Feet	Niger (5715.05)	Taraba (1250)	4465.05
