# FMCG Financial Statement Analysis: Nestlé Pakistan, Colgate-Palmolive Pakistan, National Foods

An end-to-end financial analysis of three PSX-listed FMCG companies. Financial statements were structured in **PostgreSQL**, turned into **13 financial ratios using SQL views**, and presented in a **4-page Power BI dashboard**.

**Comparison window:** FY2022-FY2025 (the four years all three companies share)


## Companies analysed

| Company | Ticker | Sector | Fiscal year ends | Data covered |
|---|---|---|---|---|
| Nestlé Pakistan Limited | NESTLE | Dairy, beverages & nutrition | December | FY2021-FY2025 |
| Colgate-Palmolive (Pakistan) Limited | COLG | Oral & personal care, home care | June | FY2022-FY2026 |
| National Foods Limited | NATF | Spices, recipe mixes & convenience foods | June | FY2021-FY2025 |

## Workflow

1. **Data collection:** annual income statement and balance sheet figures for each company (see Data source below).
2. **Staging:** one row per company per year in Excel/CSV (`data/`), with a check sheet confirming that gross profit and the balance sheet tie out.
3. **PostgreSQL:** two tables, `companies` and `financial_statements`, linked by `company_id`.
4. **SQL views:** one view per ratio group (`profitability_ratio`, `liquidity_ratio`, `leverage_ratios`, `efficiency_ratios`, `growth_ratios`). Growth uses the `LAG()` window function to compare each year with the previous one.
5. **Power BI model:** each view is related to a `companies` table (on `company_name`) and to a small years table (on `fiscal_year`), so one year slicer filters every page.
6. **Dashboard:** four pages, each with comparison charts and a short description of what the chart shows.

## Ratios calculated

| Group | Ratio | Formula |
|---|---|---|
| Profitability | Gross margin | Gross profit / Revenue |
| | Operating margin | Operating profit / Revenue |
| | Net margin | Net profit / Revenue |
| | Return on assets (ROA) | Net profit / Total assets |
| | Return on equity (ROE) | Net profit / (Equity - minority interest) |
| Liquidity | Current ratio | Current assets / Current liabilities |
| | Quick ratio | (Current assets - Inventory) / Current liabilities |
| Leverage | Debt-to-equity | Total debt / (Equity - minority interest) |
| | Interest coverage | Operating profit / Interest expense |
| Efficiency | Inventory turnover | Cost of sales / Inventory |
| | Receivables turnover | Revenue / Receivables |
| Growth | Revenue growth | (Revenue - prior year) / Prior year |
| | Net income growth | (Net profit - prior year) / Prior year |

All ratios use year-end balances, not averages.

## Key findings (FY2022-FY2025)

- **Colgate-Palmolive is the strongest overall.** In 2025 it had a 15.9% net margin, a 32.4% ROA, a current ratio of 2.60 and almost no debt (debt-to-equity 0.03). Its revenue growth slowed from 46.7% in 2023 to 2.5% in 2025.
- **Nestlé deleveraged sharply.** Debt-to-equity fell from 3.68 in 2022 to 0.15 in 2025. It has the highest gross margin of the three (about 36% in 2025), but its current ratio stayed below 1.0 in every year (0.77-0.85).
- **National Foods is the growth story, but with thin margins.** Revenue grew every year, from PKR 45.5 billion in 2022 to PKR 101.3 billion in 2025. Its net margin was only 3.4% in 2025, interest coverage fell from 13.8x to 3.1x in 2024, and net income dropped 39.8% in 2024 before rebounding 81.3% in 2025.
- **ROE needs care.** Nestlé's ROE of 261% in 2022 reflects a very small equity base, while its ROA was about 18%. ROA is the fairer efficiency comparison here.

## Design notes

- The comparison window is 2022-2025 because that is the overlap across all three companies. Colgate has no growth figure for 2022, its first year of data.
- Nestlé's fiscal year ends in December; Colgate and National Foods end in June.
- For National Foods, ROE and debt-to-equity use equity excluding minority interest, and net profit is the portion attributable to shareholders.
- Interest expense is stored as a positive number.


## Limitations

- Only three companies and four comparable years, so the findings describe trends rather than prove anything statistically.
- Figures are in nominal PKR and are not adjusted for inflation, which was high in Pakistan during this period.
- Statement line items are standardised by the data provider and may differ slightly from each company's own annual report.
- No industry benchmark or valuation analysis is included.

## Data source

Annual financial statements from [stockanalysis.com](https://stockanalysis.com) (data provided by S&P Global Market Intelligence), pulled in September 2026. Company filings are also available on the [PSX Data Portal](https://dps.psx.com.pk).

*This project is for learning and portfolio purposes only and is not investment advice.*
