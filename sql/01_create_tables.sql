-- Table: public.companies

-- DROP TABLE IF EXISTS public.companies;

CREATE TABLE IF NOT EXISTS public.companies
(
    company_id integer NOT NULL,
    company_name character varying(100) COLLATE pg_catalog."default",
    ticker character varying(10) COLLATE pg_catalog."default",
    sector character varying(100) COLLATE pg_catalog."default",
    fiscal_year_end_month character varying(10) COLLATE pg_catalog."default",
    CONSTRAINT companies_pkey PRIMARY KEY (company_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.companies
    OWNER to postgres;
-- Table: public.financial_statements

-- DROP TABLE IF EXISTS public.financial_statements;

CREATE TABLE IF NOT EXISTS public.financial_statements
(
    company_id integer NOT NULL,
    fiscal_year integer NOT NULL,
    fiscal_year_end date,
    revenue numeric(18,2),
    cost_of_sales numeric(18,2),
    gross_profit numeric(18,2),
    operating_profit numeric(18,2),
    interest_expense numeric(18,2),
    pretax_income numeric(18,2),
    income_tax numeric(18,2),
    net_profit numeric(18,2),
    cash_and_st_investments numeric(18,2),
    receivables numeric(18,2),
    inventory numeric(18,2),
    current_assets numeric(18,2),
    total_assets numeric(18,2),
    current_liabilities numeric(18,2),
    total_liabilities numeric(18,2),
    total_debt numeric(18,2),
    total_equity numeric(18,2),
    minority_interest numeric(18,2),
    CONSTRAINT financial_statements_pkey PRIMARY KEY (company_id, fiscal_year),
    CONSTRAINT financial_statements_company_id_fkey FOREIGN KEY (company_id)
        REFERENCES public.companies (company_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.financial_statements
    OWNER to postgres;