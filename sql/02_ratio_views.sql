-- View: public.efficiency_ratios

-- DROP VIEW public.efficiency_ratios;

CREATE OR REPLACE VIEW public.efficiency_ratios
 AS
 SELECT c.company_name,
    f.fiscal_year,
    round(f.cost_of_sales / f.inventory, 2) AS inventory_turnover,
    round(f.revenue / f.receivables, 2) AS receivables_turnover
   FROM financial_statements f
     JOIN companies c ON f.company_id = c.company_id;

ALTER TABLE public.efficiency_ratios
    OWNER TO postgres;

-- View: public.growth_ratios

-- DROP VIEW public.growth_ratios;

CREATE OR REPLACE VIEW public.growth_ratios
 AS
 SELECT c.company_name,
    f.fiscal_year,
    f.revenue,
    round((f.revenue - lag(f.revenue) OVER (PARTITION BY f.company_id ORDER BY f.fiscal_year)) / lag(f.revenue) OVER (PARTITION BY f.company_id ORDER BY f.fiscal_year) * 100::numeric, 2) AS revenue_growth_pct,
    round((f.net_profit - lag(f.net_profit) OVER (PARTITION BY f.company_id ORDER BY f.fiscal_year)) / lag(f.net_profit) OVER (PARTITION BY f.company_id ORDER BY f.fiscal_year) * 100::numeric, 2) AS net_income_growth_pct
   FROM financial_statements f
     JOIN companies c ON f.company_id = c.company_id;

ALTER TABLE public.growth_ratios
    OWNER TO postgres;

-- View: public.leverage_ratios

-- DROP VIEW public.leverage_ratios;

CREATE OR REPLACE VIEW public.leverage_ratios
 AS
 SELECT c.company_name,
    f.fiscal_year,
    round(f.total_debt / (f.total_equity - f.minority_interest), 2) AS debt_to_equity,
    round(f.operating_profit / f.interest_expense, 2) AS interest_coverage
   FROM financial_statements f
     JOIN companies c ON f.company_id = c.company_id;

ALTER TABLE public.leverage_ratios
    OWNER TO postgres;
-- View: public.liquidity_ratio

-- DROP VIEW public.liquidity_ratio;

CREATE OR REPLACE VIEW public.liquidity_ratio
 AS
 SELECT c.company_name,
    f.fiscal_year,
    round(f.current_assets / f.current_liabilities, 2) AS current_ratio,
    round((f.current_assets - f.inventory) / NULLIF(f.current_liabilities, 0::numeric), 2) AS quick_ratio
   FROM financial_statements f
     JOIN companies c ON f.company_id = c.company_id;

ALTER TABLE public.liquidity_ratio
    OWNER TO postgres;

-- View: public.profitability_ratio

-- DROP VIEW public.profitability_ratio;

CREATE OR REPLACE VIEW public.profitability_ratio
 AS
 SELECT c.company_name,
    f.fiscal_year,
    f.revenue,
    round(f.gross_profit / f.revenue * 100::numeric, 2) AS gross_margin_pct,
    round(f.operating_profit / f.revenue * 100::numeric, 2) AS operating_margin_pct,
    round(f.net_profit / f.revenue * 100::numeric, 2) AS net_margin_pct,
    round(f.net_profit / (f.total_equity - f.minority_interest) * 100::numeric, 2) AS roe_pct,
    round(f.net_profit / f.total_assets * 100::numeric, 2) AS roa_pct
   FROM financial_statements f
     JOIN companies c ON f.company_id = c.company_id;

ALTER TABLE public.profitability_ratio
    OWNER TO postgres;





