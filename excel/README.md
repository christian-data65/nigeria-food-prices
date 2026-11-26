# Excel Data Inspection and Power Query

## Purpose

Microsoft Excel and Power Query were used in this project for data inspection, basic data cleaning, and combining tables within each monthly workbook.

Excel was not used for the main data analysis. The main analysis was performed separately using MySQL.

## Data Structure

The project contains 19 monthly workbooks. Each workbook contains two tables:

1. `selected_food_table`
2. `zone all time`

Power Query was used to combine these two tables within each workbook for inspection and preparation.

## Data Inspection Activities

The following checks were carried out:

1. **Missing Values:** Checked for blank cells.
2. **Duplicate Records:** Checked for duplicate food items.
3. **Data Types:** Checked numeric and text columns.
4. **Highest and Lowest:** Confirmed that these columns contain state names and prices.
5. **Regional Columns:** Checked the six regional price columns.
6. **Average Prices:** Checked for negative average prices.
7. **MoM and YoY:** Inspected monthly and yearly price movement values.

## Dataset Inspection Findings

- Total rows: 44
- Total columns: 14
- Missing values: None found
- Duplicate food items: None found
- Negative average prices: None found
- Negative MoM values: 
- Highest and Lowest columns: Text
- Regional price columns: Numeric

## Tools and Features Used

- Microsoft Excel
- Power Query
- Go To Special (Blanks)
- Remove Duplicates
- Number Format
- Conditional Formatting

## Conclusion

Excel and Power Query were used for data inspection, basic cleaning, and combining the two tables within each monthly workbook.

The 19 monthly workbooks were kept separate. The tables were not combined into one large dataset.

The main data analysis was performed using MySQL, while Power BI will be used for dashboard development in a later project phase.

Inspection findings will be documented as each monthly workbook is reviewed.
