--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md505ea766c2bc9e19f34b66114ace97598';






--
-- Database creation
--

CREATE DATABASE cdms WITH TEMPLATE = template0 OWNER = postgres;
REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


\connect cdms

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: cdms; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE cdms IS 'COLD DRINKS MANAGEMENT SYSTEM';


--
-- Name: cdms; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA cdms;


ALTER SCHEMA cdms OWNER TO postgres;

--
-- Name: SCHEMA cdms; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA cdms IS 'CDMS schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = cdms, pg_catalog;

--
-- Name: calculatedailystock(); Type: FUNCTION; Schema: cdms; Owner: postgres
--

CREATE FUNCTION calculatedailystock(OUT out_status character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$

declare
	v_status VARCHAR(10) ;
    total integer;
BEGIN	
   SELECT count(*) into total FROM CDMS.datewise_prdct_stock_summery;
   v_status:='S';
   out_status:=v_status;
END;

$$;


ALTER FUNCTION cdms.calculatedailystock(OUT out_status character varying) OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- Name: calculatedailystock(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION calculatedailystock() RETURNS character
    LANGUAGE plpgsql
    AS $$
declare
	v_status character varying(10) ;
    total integer;
BEGIN
   SELECT count(*) into total FROM CDMS.datewise_prdct_stock_summery;
   v_status:='S';
   RETURN total;
END;
$$;


ALTER FUNCTION public.calculatedailystock() OWNER TO postgres;

SET search_path = cdms, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: beverage_product_category; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE beverage_product_category (
    product_cd character varying(10) NOT NULL,
    flavr_cd character varying(10) NOT NULL,
    filling_qty_cd character varying(10) NOT NULL,
    packing_name_cd character varying(10) NOT NULL,
    packing_qty_cd character varying(10) NOT NULL,
    group_name character varying(20),
    product_added_dt timestamp without time zone,
    product_added_by character varying(50) NOT NULL,
    product_name character varying(50),
    hsn_code character varying(20)
);


ALTER TABLE beverage_product_category OWNER TO postgres;

--
-- Name: beverage_product_group_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE beverage_product_group_dtl (
    group_name character varying(50) NOT NULL,
    filing_qty_cd1 character varying(10),
    filling_qty_cd2 character varying(10),
    packing_name_cd character varying(10),
    packing_qty_cd character varying(10),
    group_comments character varying(100)
);


ALTER TABLE beverage_product_group_dtl OWNER TO postgres;

--
-- Name: TABLE beverage_product_group_dtl; Type: COMMENT; Schema: cdms; Owner: postgres
--

COMMENT ON TABLE beverage_product_group_dtl IS 'based on filling qty,packet qty,pakage_category,';


--
-- Name: cstmr_acnts_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE cstmr_acnts_dtl (
    cstmr_acnt_no character varying(10) NOT NULL,
    cstmr_id character varying(11) NOT NULL,
    cstmr_ledger_type_cd character varying(10) NOT NULL,
    acnt_opening_dt timestamp without time zone NOT NULL,
    acnt_open_by character varying(50) NOT NULL,
    acnt_closing_dt timestamp without time zone,
    acnt_closed_by character varying(50),
    acnt_closing_due_balance numeric(10,2),
    acnt_closing_due_empty_cs numeric(10,2),
    acnt_closing_comments character varying(200)
);


ALTER TABLE cstmr_acnts_dtl OWNER TO postgres;

--
-- Name: cstmr_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE cstmr_dtl (
    cstmr_id character varying(11) NOT NULL,
    cstmr_fullname character varying(50) NOT NULL,
    cstmr_fathername character varying(50),
    cstmr_territory character varying(10) NOT NULL,
    cstmr_mob_no numeric(12,0),
    cstmr_email character varying(100),
    cstmr_created_dt timestamp without time zone NOT NULL,
    cstmr_created_by character varying(50),
    cstmr_updt_dt timestamp without time zone,
    cstmr_updt_by character varying(50)
);


ALTER TABLE cstmr_dtl OWNER TO postgres;

--
-- Name: cstmr_ledger_category; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE cstmr_ledger_category (
    cstmr_ledger_type_cd character varying(10) NOT NULL,
    cstmr_ledger_type_name character varying(40) NOT NULL,
    ledger_curr_special_discount numeric(10,2) NOT NULL,
    cstmr_ledger_created_dt timestamp without time zone NOT NULL,
    cstmr_ledger_created_by character varying(50) NOT NULL,
    cstmr_ledger_updt_dt timestamp without time zone,
    cstmr_ledger_updt_by character varying(50)
);


ALTER TABLE cstmr_ledger_category OWNER TO postgres;

--
-- Name: datewise_prdct_stock_summery; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE datewise_prdct_stock_summery (
    prdct_stock_seq numeric(10,0) NOT NULL,
    prdct_stock_dt timestamp without time zone,
    prdct_dayopening_qty numeric(10,2) NOT NULL,
    total_prdct_daypurchase_qty numeric(10,2),
    total_prdct_daysale_outscheme_qty numeric(10,2),
    total_prdct_daysale_withscheme_qty numeric(10,2),
    total_prdct_dayclosing_qty numeric(10,2),
    total_prdct_dayscheme_qty numeric(10,2),
    total_prdct_dayburst_qty numeric(10,0),
    total_prdct_dayleakage_qty numeric(10,0),
    total_prdct_dayopenmount_qty numeric(10,0),
    total_prdct_dayshortage_qty numeric(10,0),
    total_prdct_dayotherless_qty numeric(10,0),
    product_adjustment numeric(10,2),
    stock_serial_no numeric(10,0) NOT NULL,
    product_cd character varying(10) NOT NULL
);


ALTER TABLE datewise_prdct_stock_summery OWNER TO postgres;

--
-- Name: TABLE datewise_prdct_stock_summery; Type: COMMENT; Schema: cdms; Owner: postgres
--

COMMENT ON TABLE datewise_prdct_stock_summery IS 'datewise summation of individual product';


--
-- Name: datewise_scheme_prdct_summery; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE datewise_scheme_prdct_summery (
    scheme_summery_seq character varying(10) NOT NULL,
    scheme_prdct_cd character varying(10) NOT NULL,
    total_dayalloted_scheme_cs numeric(10,2) NOT NULL,
    prdct_stock_seq numeric(10,0) NOT NULL,
    allotted_to_group_name character varying(20),
    alloted_to_product_cd character varying(10),
    scheme_alloted_dt timestamp without time zone NOT NULL
);


ALTER TABLE datewise_scheme_prdct_summery OWNER TO postgres;

--
-- Name: TABLE datewise_scheme_prdct_summery; Type: COMMENT; Schema: cdms; Owner: postgres
--

COMMENT ON TABLE datewise_scheme_prdct_summery IS 'will gonna tell info whole day alloted scheme on which product or group';


--
-- Name: datewise_stock_summery; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE datewise_stock_summery (
    stock_serial_no numeric(10,0) NOT NULL,
    stock_date timestamp without time zone NOT NULL,
    total_equivalent_opening_qty numeric(10,0) NOT NULL,
    total_equivalent_purchase_qty numeric(10,0),
    total_equivalent_sale_qty numeric(10,0),
    total_equivalent_closing_qty numeric(10,0),
    empty_glasscell_purchase numeric(10,0),
    empty_glasscell_sale numeric(10,0),
    empty_sell_purchase numeric(10,0),
    only_empty_glass_purchase numeric(10,0),
    only_empty_glass_sale numeric(10,0),
    total_available_empty_glasscell_qty numeric(10,2),
    total_broke_glass_bottle numeric(10,0)
);


ALTER TABLE datewise_stock_summery OWNER TO postgres;

--
-- Name: TABLE datewise_stock_summery; Type: COMMENT; Schema: cdms; Owner: postgres
--

COMMENT ON TABLE datewise_stock_summery IS 'Master STOCK ';


--
-- Name: filling_qty_category; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE filling_qty_category (
    filling_qty_cd character varying(10) NOT NULL,
    filling_qty_ml character varying(20) NOT NULL,
    filling_qty_added_dt timestamp without time zone NOT NULL,
    filling_qty_added_by character varying(50) NOT NULL
);


ALTER TABLE filling_qty_category OWNER TO postgres;

--
-- Name: flavour_category; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE flavour_category (
    flavr_cd character varying(10) NOT NULL,
    flavr_name character varying(50),
    flavr_added_dt timestamp without time zone NOT NULL,
    falvr_added_by character varying(50) NOT NULL
);


ALTER TABLE flavour_category OWNER TO postgres;

--
-- Name: hsn_tax_structure; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE hsn_tax_structure (
    hsn_cd character varying(20) NOT NULL,
    hsn_discription character varying(50),
    cgst numeric(5,0) NOT NULL,
    sgst_or_igst numeric(5,0) NOT NULL,
    cess numeric(5,0) NOT NULL,
    last_added_dt timestamp without time zone NOT NULL
);


ALTER TABLE hsn_tax_structure OWNER TO postgres;

--
-- Name: operation_monitoring; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE operation_monitoring (
    operation_nm character varying(100) NOT NULL,
    operation_comment character varying(200),
    operation_group character varying(100),
    operation_status character varying(10) NOT NULL
);


ALTER TABLE operation_monitoring OWNER TO postgres;

--
-- Name: packing_name_category; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE packing_name_category (
    packing_name_cd character varying(10) NOT NULL,
    packing_name character varying(20) NOT NULL,
    paking_added__dt timestamp without time zone NOT NULL,
    paking_added_by character varying(50) NOT NULL
);


ALTER TABLE packing_name_category OWNER TO postgres;

--
-- Name: TABLE packing_name_category; Type: COMMENT; Schema: cdms; Owner: postgres
--

COMMENT ON TABLE packing_name_category IS 'glass,can,minican,tropicana,frooti,slice,water,pet';


--
-- Name: packing_qty_category; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE packing_qty_category (
    packing_qty_cd character varying(10) NOT NULL,
    packing_quantity numeric NOT NULL,
    packing_qty_added_dt timestamp without time zone NOT NULL,
    packing_qty_added_by character varying(50) NOT NULL
);


ALTER TABLE packing_qty_category OWNER TO postgres;

--
-- Name: prdct_breakage_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE prdct_breakage_dtl (
    breakage_seq numeric(10,0) NOT NULL,
    breakage_dt timestamp without time zone NOT NULL,
    product_cd character varying(10) NOT NULL,
    open_mouth_bs numeric,
    shortage_bs numeric,
    seal_pack_shortage_bs numeric,
    burst_bs numeric,
    other_breakage_bs numeric,
    breakage_source character varying(20) NOT NULL,
    leakage_bs numeric(10,0) NOT NULL
);


ALTER TABLE prdct_breakage_dtl OWNER TO postgres;

--
-- Name: prdct_curr_price_scheme; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE prdct_curr_price_scheme (
    seq_no numeric(10,0) NOT NULL,
    product_cd character varying(10) NOT NULL,
    prdct_curr_price numeric(10,2),
    prdct_curr_mrp numeric(10,2),
    prdct_curr_scheme character varying(200),
    price_lastchange_dt timestamp without time zone NOT NULL,
    is_group_same_price character varying(3),
    base_price_per_cs numeric(10,2)
);


ALTER TABLE prdct_curr_price_scheme OWNER TO postgres;

--
-- Name: prdct_curr_price_scheme_seq; Type: SEQUENCE; Schema: cdms; Owner: postgres
--

CREATE SEQUENCE prdct_curr_price_scheme_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999999
    CACHE 1;


ALTER TABLE prdct_curr_price_scheme_seq OWNER TO postgres;

--
-- Name: product_instant_stock_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE product_instant_stock_dtl (
    prdct_stock_curr_seq numeric(15,0) NOT NULL,
    prdct_stock_curr_time timestamp without time zone NOT NULL,
    product_cd character varying(10) NOT NULL,
    prdct_group_name character varying(30) NOT NULL,
    purchase_invoice_number character varying(20),
    sale_invoice_number character varying(20),
    prdct_opening_qty numeric(10,0),
    prdct_purchase_qty numeric(10,0),
    prdct_outscheme_sale_qty numeric(10,0),
    prdct_distributed_scheme_qty_bs numeric(10,0),
    prdct_breakage_qty_bs numeric(10,0),
    prdct_curr_available_qty numeric(10,0),
    prdct_mrp numeric(10,2),
    offered_scheme_dtl character varying(200),
    packate_price numeric(10,2),
    curr_prdct_qty_adustment numeric(10,0),
    curr_stock_processed_id numeric(10,0)
);


ALTER TABLE product_instant_stock_dtl OWNER TO postgres;

--
-- Name: purchase_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE purchase_dtl (
    purchase_seq_no character varying(10) NOT NULL,
    challan_no character varying(15) NOT NULL,
    challan_invoice_no numeric(15,0) NOT NULL,
    total_purchased_glass_qty numeric(10,0) NOT NULL,
    total_return_empty_glass_qty numeric(10,0) NOT NULL,
    total_challan_amount numeric(10,2) NOT NULL,
    total_discount_amount numeric(10,2) NOT NULL,
    purchase_comment character varying(200),
    payment_method character varying(10),
    payment_id character varying(20),
    paid_amount numeric(10,2),
    challan_dt timestamp without time zone NOT NULL,
    total_prdct_qty numeric(10,0)
);


ALTER TABLE purchase_dtl OWNER TO postgres;

--
-- Name: purchase_prdct_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE purchase_prdct_dtl (
    purchased_prdct_seq_no character varying(20) NOT NULL,
    purchase_seq_no character varying(20) NOT NULL,
    product_cd character varying(10) NOT NULL,
    purchase_prdct_qty numeric(10,2) NOT NULL,
    purchase_prdct_totl_base_amount numeric(10,2) NOT NULL,
    purchase_prdct_totl_discount_amnt numeric(10,2) NOT NULL,
    purchase_prdct_totl_taxable_amount numeric(10,2) NOT NULL,
    purchase_prdct_sgst numeric(10,2) NOT NULL,
    purchase_prdct_igst numeric(10,2) NOT NULL,
    purchase_prdct_cgst numeric(10,2) NOT NULL,
    purchase_prdct_cess_tax numeric(10,2) NOT NULL,
    purchase_prdct_net_amount numeric(10,2) NOT NULL,
    prdct_recieved_dt timestamp without time zone NOT NULL,
    purchase_breakage_seq numeric(10,0),
    per_cs_base_price numeric(10,2) NOT NULL,
    per_cs_net_price numeric(10,2) NOT NULL
);


ALTER TABLE purchase_prdct_dtl OWNER TO postgres;

--
-- Name: route_map_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE route_map_dtl (
    route_cd character varying(10) NOT NULL,
    route_name character varying(50) NOT NULL,
    mapped_village_id character varying(200) NOT NULL,
    route_added_dt timestamp without time zone NOT NULL,
    route_added_by character varying(50) NOT NULL,
    route_last_updt_dt timestamp without time zone,
    route_last_updt_by character varying(50)
);


ALTER TABLE route_map_dtl OWNER TO postgres;

--
-- Name: TABLE route_map_dtl; Type: COMMENT; Schema: cdms; Owner: postgres
--

COMMENT ON TABLE route_map_dtl IS 'mapped_village_id will be comman_seperated';


--
-- Name: sale_breakage_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE sale_breakage_dtl (
    breakage_seq numeric(10,0) NOT NULL,
    sale_invoice_no character varying(13) NOT NULL,
    breakage_dt timestamp without time zone NOT NULL,
    product_cd character varying(10) NOT NULL,
    breakage_bs numeric
);


ALTER TABLE sale_breakage_dtl OWNER TO postgres;

--
-- Name: sale_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE sale_dtl (
    sale_invoice_no character varying(13) NOT NULL,
    cstmr_acnt_no character varying(10),
    cstmr_name character varying(50) NOT NULL,
    address character varying(50) NOT NULL,
    sale_dt timestamp without time zone NOT NULL,
    delivery_mode character varying(10) NOT NULL,
    total_deliver_bs_glass numeric(10,0) NOT NULL,
    total_return_bs_glass numeric(10,0) NOT NULL,
    total_prev_bs_glass numeric(10,0),
    total_net_bs_glass numeric(10,0),
    total_deliver_cell numeric(10,0) NOT NULL,
    total_return_cell numeric(10,0) NOT NULL,
    total_prev_cell numeric(10,0),
    total_net_cell numeric(10,0),
    sys_gnrtd_total_amount numeric(10,2) NOT NULL,
    sys_gnrtd_total_discount numeric(10,2) NOT NULL,
    total_adjustment_discount numeric(10,2) NOT NULL,
    total_amount_adjustment numeric(10,2) NOT NULL,
    total_net_actual_amount numeric(10,2) NOT NULL,
    total_prev_due_amount numeric(10,2),
    paid_amount numeric(10,2) NOT NULL,
    total_net_due_amount numeric(10,2),
    payment_mode character varying(20) NOT NULL,
    supply_seq_no character varying(10),
    is_breakage_return character varying(3) DEFAULT 'N'::character varying,
    is_scheme_alloted character varying(3) DEFAULT 'Y'::character varying,
    sale_comments character varying(500),
    sold_by character varying(50),
    processed_status character varying(10),
    processed_time timestamp without time zone,
    curr_stock_processed_id numeric,
    sale_entry_system_dt timestamp without time zone NOT NULL,
    total_scheme_discount numeric(10,2) NOT NULL
);


ALTER TABLE sale_dtl OWNER TO postgres;

--
-- Name: sale_invoices_prdct_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE sale_invoices_prdct_dtl (
    sale_invoice_no character varying(13) NOT NULL,
    seq_number character varying(15) NOT NULL,
    prdct_group_description character varying(100) NOT NULL,
    group_name character varying(20),
    selling_qty numeric(10,0) NOT NULL,
    base_rate_per_cs numeric(10,2) NOT NULL,
    net_base_amt numeric(10,2) NOT NULL,
    scheme_disocunt_amt numeric(10,2) NOT NULL,
    taxable_amt numeric(10,2) NOT NULL,
    sgst_rate numeric(5,2) NOT NULL,
    sgst_amt numeric(10,2) NOT NULL,
    cgst_rate numeric(5,2) NOT NULL,
    cgst_amt numeric(10,2) NOT NULL,
    cess_rate numeric(5,2) NOT NULL,
    cess_amt numeric(10,2) NOT NULL,
    sys_gross_net_per_cs numeric(10,2),
    sys_gnrtd_net_amt numeric(10,2),
    sys_gnrtd_special_discount_per_cs numeric(10,2) NOT NULL,
    total_sys_gnrtd_discount numeric(10,2) NOT NULL,
    total_discnt_adjustment numeric(10,2) NOT NULL,
    total_amnt_adjustment numeric(10,2) NOT NULL,
    total_prdct_net_amt numeric(10,2) NOT NULL,
    scheme_discnt_per_cs numeric(10,2) NOT NULL
);


ALTER TABLE sale_invoices_prdct_dtl OWNER TO postgres;

--
-- Name: sale_prdct_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE sale_prdct_dtl (
    prdct_sale_txn_id numeric(15,0) NOT NULL,
    invoice_prdct_seq_no character varying(15) NOT NULL,
    prdct_sale_dt timestamp without time zone NOT NULL,
    prdct_cd character(10) NOT NULL,
    prdct_salling_qty numeric(10,0) NOT NULL
);


ALTER TABLE sale_prdct_dtl OWNER TO postgres;

--
-- Name: sale_prdct_scheme_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE sale_prdct_scheme_dtl (
    alloted_scheme_id numeric(10,0) NOT NULL,
    scheme_prdct_cd character varying(10) NOT NULL,
    calculated_scheme_qty_bs numeric(10,0) NOT NULL,
    given_scheme_qty_bs numeric(10,0) NOT NULL,
    old_given_scheme_bs numeric(10,0) NOT NULL,
    pending_scheme_bs numeric(10,0),
    sale_invoice_no character varying(13) NOT NULL,
    alloted_to_group_name character varying(20),
    alloted_to_product_cd character varying(10),
    scheme_alloted_dt timestamp without time zone NOT NULL
);


ALTER TABLE sale_prdct_scheme_dtl OWNER TO postgres;

--
-- Name: TABLE sale_prdct_scheme_dtl; Type: COMMENT; Schema: cdms; Owner: postgres
--

COMMENT ON TABLE sale_prdct_scheme_dtl IS 'is_pending flag will gonna tell sceme is actullay provided or not';


--
-- Name: serial_no_generator; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE serial_no_generator (
    seq_name character varying(20) NOT NULL,
    seq_value numeric,
    seq_prefix character varying(20),
    seq_size numeric DEFAULT 10 NOT NULL
);


ALTER TABLE serial_no_generator OWNER TO postgres;

--
-- Name: supply_records; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE supply_records (
    supply_seq_no character varying(10) NOT NULL,
    vehicle_cd character varying(10) NOT NULL,
    total_glass_bs_sent numeric(10,0) NOT NULL,
    expected_return_bs_glass numeric(10,0),
    actual_return_bs_glass numeric(10,0),
    total_cell_sent numeric(10,0) NOT NULL,
    expected_return_cell numeric(10,0),
    actual_cell_return numeric(10,0),
    lost_glass_bs_qty numeric(10,0),
    lost_cell_qty numeric(10,0),
    cstmr_due_glass_bs_qty numeric(10,0),
    cstmr_due_cell_qty numeric(10,0),
    sys_gen_total_supplysale_amnt numeric(10,2),
    sys_gnrted_total_supplysale_discnt numeric(10,2),
    total_supplysale_adjustment_discnt numeric(10,2),
    total_supplysale_adjustment_amnt numeric(10,2),
    total_net_actual_supplysale_amnt numeric(10,2),
    total_cstmr_supplysale_due_amnt numeric(10,2),
    total_supplysale_amnt_recieved numeric(10,2),
    mismatch_amnt numeric(10,2),
    supply_worker_name character varying(200) NOT NULL,
    supply_vehicle_exit_time timestamp without time zone NOT NULL,
    supply_vehicle_back_time timestamp without time zone,
    route_covered character varying(100)
);


ALTER TABLE supply_records OWNER TO postgres;

--
-- Name: supply_vehicle_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE supply_vehicle_dtl (
    vehicle_cd character varying(10) NOT NULL,
    vehicle_type character varying(20) NOT NULL,
    vehicle_no character varying(20),
    vehicle_added_dt timestamp without time zone NOT NULL,
    vehicle_added_by character varying(20) NOT NULL
);


ALTER TABLE supply_vehicle_dtl OWNER TO postgres;

--
-- Name: territory_area_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE territory_area_dtl (
    territory_cd character varying(10) NOT NULL,
    territory_name character varying(20) NOT NULL,
    territory_distance numeric(10,3) NOT NULL,
    territory_added_dt timestamp without time zone NOT NULL,
    territory_added_by character varying(50) NOT NULL
);


ALTER TABLE territory_area_dtl OWNER TO postgres;

--
-- Name: total_supplysale_prdct_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE total_supplysale_prdct_dtl (
    prdct_supplysale_seq numeric(10,0) NOT NULL,
    supply_seq_no character varying(10) NOT NULL,
    product_cd character varying(10) NOT NULL,
    total_sent_prdct_qty numeric(10,2) NOT NULL,
    total_selling_prdct_qty numeric(10,2),
    cstmr_due_prdct_qty numeric(10,2),
    expected_return_qty numeric(10,2),
    actual_return_prdct_qty numeric(10,2),
    prdct_lost_qty numeric(10,2),
    supply_prdct_sale_time timestamp without time zone
);


ALTER TABLE total_supplysale_prdct_dtl OWNER TO postgres;

--
-- Data for Name: beverage_product_category; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY beverage_product_category (product_cd, flavr_cd, filling_qty_cd, packing_name_cd, packing_qty_cd, group_name, product_added_dt, product_added_by, product_name, hsn_code) FROM stdin;
PROD000006	FLVR000001	ML00000005	TYPE000002	PQTY000001	400_PET_24	2017-04-13 00:00:00	CDMS	400_PEPSI_PET_24	22021010
PROD000011	FLVR000001	ML00000007	TYPE000002	PQTY000001	750_PET_24	2017-07-29 00:00:00	CDMS	750_PEPSI_PET_24	22021010
PROD000003	FLVR000003	ML00000001	TYPE000001	PQTY000001	300_GLASS_24	2017-04-13 00:00:00	CDMS	300_MIRINDA(L)_GLASS_24	22021010
PROD000008	FLVR000005	ML00000001	TYPE000001	PQTY000001	300_GLASS_24	2017-04-25 00:00:00	CDMS	300_Moutain Dew_GLASS_24	22021010
PROD000007	FLVR000001	ML00000001	TYPE000001	PQTY000001	300_GLASS_24	2017-04-14 00:00:00	CDMS	300_PEPSI_GLASS_24	22021010
PROD000004	FLVR000004	ML00000001	TYPE000001	PQTY000001	300_GLASS_24	2017-04-13 00:00:00	CDMS	300_MIRINDA(O)_GLASS_24	22021010
PROD000002	FLVR000002	ML00000003	TYPE000001	PQTY000001	300_GLASS_24	2017-04-12 00:00:00	CDMS	250_SLICE_GLASS_24	22029020
PROD000010	FLVR000006	ML00000006	TYPE000002	PQTY000002	1000_PET_12	2017-07-25 00:00:00	CDMS	1000_AQUFINA_PET_12	22011010
PROD000009	FLVR000002	ML00000002	TYPE000003	PQTY000001	200_TETRA_24	2017-07-25 00:00:00	CDMS	200_SLICE_TETRA_24	22029020
PROD000001	FLVR000001	ML00000002	TYPE000001	PQTY000001	200_GLASS_24	2017-04-12 00:00:00	CDMS	200_PEPSI_GLASS_24	22021010
PROD000014	FLVR000005	ML00000002	TYPE000001	PQTY000001	200_GLASS_24	2017-09-10 00:00:00	CDMS	200_Moutain Dew_GLASS_24	22021010
\.


--
-- Data for Name: beverage_product_group_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY beverage_product_group_dtl (group_name, filing_qty_cd1, filling_qty_cd2, packing_name_cd, packing_qty_cd, group_comments) FROM stdin;
200_GLASS_24	ML00000002	\N	TYPE000001	PQTY000001	\N
300_GLASS_24	ML00000001	ML00000003	TYPE000001	PQTY000001	\N
400_PET_24	ML00000005	\N	TYPE000002	PQTY000001	\N
200_TETRA_24	ML00000002	\N	TYPE000003	PQTY000001	\N
1000_PET_12	ML00000006	\N	TYPE000002	PQTY000002	\N
750_PET_24	ML00000007	\N	TYPE000002	PQTY000001	\N
\.


--
-- Data for Name: cstmr_acnts_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY cstmr_acnts_dtl (cstmr_acnt_no, cstmr_id, cstmr_ledger_type_cd, acnt_opening_dt, acnt_open_by, acnt_closing_dt, acnt_closed_by, acnt_closing_due_balance, acnt_closing_due_empty_cs, acnt_closing_comments) FROM stdin;
0000000002	CSTMR000002	NRMLLDGR01	2017-08-25 00:00:00	CDMS	\N	\N	0.00	0.00	\N
0000000003	CSTMR000002	SPCLLDGR02	2017-09-10 00:00:00	CDMS	\N	\N	\N	\N	\N
0000000004	CSTMR000004	NRMLLDGR01	2017-09-22 00:00:00	CDMS	\N	\N	\N	\N	\N
\.


--
-- Data for Name: cstmr_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY cstmr_dtl (cstmr_id, cstmr_fullname, cstmr_fathername, cstmr_territory, cstmr_mob_no, cstmr_email, cstmr_created_dt, cstmr_created_by, cstmr_updt_dt, cstmr_updt_by) FROM stdin;
CSTMR000002	Maya Saini	Pran	area002	9876459232		2017-08-24 23:23:09.692	CDMS	\N	\N
CSTMR000004	Lalaram Saini	Saini	area001	\N		2017-09-22 08:43:13.842	CDMS	\N	\N
\.


--
-- Data for Name: cstmr_ledger_category; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY cstmr_ledger_category (cstmr_ledger_type_cd, cstmr_ledger_type_name, ledger_curr_special_discount, cstmr_ledger_created_dt, cstmr_ledger_created_by, cstmr_ledger_updt_dt, cstmr_ledger_updt_by) FROM stdin;
SPCLLDGR01	SPECIAL ACCOUNT TYPE 1	5.00	2017-08-22 07:09:37.306855	ADMIN	\N	\N
SPCLLDGR02	SPECIAL ACCOUNT TYPE 2	7.00	2017-08-22 07:10:08.250625	ADMIN	\N	\N
NRMLLDGR01	NORMAL ACCOUNT	0.00	2017-08-22 07:12:01.640111	ADMIN	\N	\N
NOLDGR	NO ACCOUNT	0.00	2017-08-22 07:13:13.380214	ADMIN	\N	\N
\.


--
-- Data for Name: datewise_prdct_stock_summery; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY datewise_prdct_stock_summery (prdct_stock_seq, prdct_stock_dt, prdct_dayopening_qty, total_prdct_daypurchase_qty, total_prdct_daysale_outscheme_qty, total_prdct_daysale_withscheme_qty, total_prdct_dayclosing_qty, total_prdct_dayscheme_qty, total_prdct_dayburst_qty, total_prdct_dayleakage_qty, total_prdct_dayopenmount_qty, total_prdct_dayshortage_qty, total_prdct_dayotherless_qty, product_adjustment, stock_serial_no, product_cd) FROM stdin;
\.


--
-- Data for Name: datewise_scheme_prdct_summery; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY datewise_scheme_prdct_summery (scheme_summery_seq, scheme_prdct_cd, total_dayalloted_scheme_cs, prdct_stock_seq, allotted_to_group_name, alloted_to_product_cd, scheme_alloted_dt) FROM stdin;
\.


--
-- Data for Name: datewise_stock_summery; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY datewise_stock_summery (stock_serial_no, stock_date, total_equivalent_opening_qty, total_equivalent_purchase_qty, total_equivalent_sale_qty, total_equivalent_closing_qty, empty_glasscell_purchase, empty_glasscell_sale, empty_sell_purchase, only_empty_glass_purchase, only_empty_glass_sale, total_available_empty_glasscell_qty, total_broke_glass_bottle) FROM stdin;
\.


--
-- Data for Name: filling_qty_category; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY filling_qty_category (filling_qty_cd, filling_qty_ml, filling_qty_added_dt, filling_qty_added_by) FROM stdin;
ML00000001	300	2017-04-09 22:09:20.52	Ravi
ML00000002	200	2017-04-11 00:00:00	CDMS
ML00000003	250	2017-04-12 18:23:26.993	Ravi
ML00000005	400	2017-04-13 00:00:00	CDMS
ML00000006	1000	2017-07-25 00:00:00	CDMS
ML00000007	750	2017-07-29 00:00:00	CDMS
\.


--
-- Data for Name: flavour_category; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY flavour_category (flavr_cd, flavr_name, flavr_added_dt, falvr_added_by) FROM stdin;
FLVR000002	SLICE	2017-04-10 15:57:16.498	Ravi
FLVR000001	PEPSI	2017-04-10 08:59:14.88	Ravi
FLVR000003	MIRINDA(L)	2017-04-13 00:00:00	CDMS
FLVR000004	MIRINDA(O)	2017-04-13 00:00:00	CDMS
FLVR000005	Moutain Dew	2017-04-25 00:00:00	CDMS
FLVR000006	AQUFINA	2017-07-25 00:00:00	CDMS
\.


--
-- Data for Name: hsn_tax_structure; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY hsn_tax_structure (hsn_cd, hsn_discription, cgst, sgst_or_igst, cess, last_added_dt) FROM stdin;
22021010	CSD	14	14	12	2017-08-19 11:22:50.380263
22029020	Juice	6	6	0	2017-08-19 11:25:50.419561
22011010	Water	9	9	0	2017-08-19 11:27:06.99094
22011020	Soda	9	9	0	2017-08-19 11:27:57.458827
\.


--
-- Data for Name: operation_monitoring; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY operation_monitoring (operation_nm, operation_comment, operation_group, operation_status) FROM stdin;
\.


--
-- Data for Name: packing_name_category; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY packing_name_category (packing_name_cd, packing_name, paking_added__dt, paking_added_by) FROM stdin;
TYPE000001	GLASS	2017-04-11 00:00:00	CDMS
TYPE000002	PET	2017-04-13 00:00:00	CDMS
TYPE000003	TETRA	2017-07-25 00:00:00	CDMS
\.


--
-- Data for Name: packing_qty_category; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY packing_qty_category (packing_qty_cd, packing_quantity, packing_qty_added_dt, packing_qty_added_by) FROM stdin;
PQTY000001	24	2017-04-11 00:00:00	CDMS
PQTY000002	12	2017-07-25 00:00:00	CDMS
\.


--
-- Data for Name: prdct_breakage_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY prdct_breakage_dtl (breakage_seq, breakage_dt, product_cd, open_mouth_bs, shortage_bs, seal_pack_shortage_bs, burst_bs, other_breakage_bs, breakage_source, leakage_bs) FROM stdin;
21	2017-09-21 23:42:52.993	PROD000008	0	0	0	3	0	BUY_BREAKAGE	6
22	2017-09-27 21:15:05.136	PROD000002	0	0	0	4	0	BUY_BREAKAGE	0
\.


--
-- Data for Name: prdct_curr_price_scheme; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY prdct_curr_price_scheme (seq_no, product_cd, prdct_curr_price, prdct_curr_mrp, prdct_curr_scheme, price_lastchange_dt, is_group_same_price, base_price_per_cs) FROM stdin;
1	PROD000003	300.00	0.00	300_GLASS_24|1^PROD000009|1~PROD000010|1	2017-07-31 21:51:51.102771	\N	\N
4	PROD000008	300.00	0.00	300_GLASS_24|1^PROD000009|1~PROD000010|3	2017-07-31 22:03:28.497	\N	\N
5	PROD000002	300.00	0.00	300_GLASS_24|1^PROD000009|1~PROD000010|3	2017-07-31 22:03:28.498	\N	\N
6	PROD000007	300.00	0.00	300_GLASS_24|1^PROD000009|1~PROD000010|3	2017-07-31 22:03:28.499	\N	\N
7	PROD000004	300.00	0.00		2017-08-20 11:51:28.335	\N	\N
8	PROD000003	250.00	0.00	PROD000006|1	2017-08-20 11:52:56.799	\N	\N
9	PROD000001	252.00	0.00		2017-09-02 01:08:57.149	\N	\N
10	PROD000003	350.00	0.00		2017-09-03 21:34:55.812	\N	\N
11	PROD000008	350.00	0.00		2017-09-03 21:34:55.813	\N	\N
12	PROD000004	350.00	0.00		2017-09-03 21:34:55.814	\N	\N
13	PROD000007	350.00	0.00		2017-09-03 21:34:55.814	\N	\N
14	PROD000003	300.00	0.00		2017-09-10 01:22:35.268	\N	\N
15	PROD000014	252.00	0.00		2017-09-10 12:51:17.592	\N	\N
16	PROD000006	460.00	0.00		2017-09-17 18:02:51.674	\N	\N
17	PROD000010	150.00	0.00		2017-09-17 18:03:20.556	\N	\N
\.


--
-- Name: prdct_curr_price_scheme_seq; Type: SEQUENCE SET; Schema: cdms; Owner: postgres
--

SELECT pg_catalog.setval('prdct_curr_price_scheme_seq', 17, true);


--
-- Data for Name: product_instant_stock_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY product_instant_stock_dtl (prdct_stock_curr_seq, prdct_stock_curr_time, product_cd, prdct_group_name, purchase_invoice_number, sale_invoice_number, prdct_opening_qty, prdct_purchase_qty, prdct_outscheme_sale_qty, prdct_distributed_scheme_qty_bs, prdct_breakage_qty_bs, prdct_curr_available_qty, prdct_mrp, offered_scheme_dtl, packate_price, curr_prdct_qty_adustment, curr_stock_processed_id) FROM stdin;
2	2017-09-21 23:42:53.091	PROD000008	300_GLASS_24	1313131	\N	\N	7200	0	0	9	0	\N	\N	\N	\N	\N
3	2017-09-22 23:51:59.587	PROD000011	750_PET_24	\N	0000000000005	\N	0	0	2	0	\N	\N	\N	\N	\N	\N
4	2017-09-22 23:51:59.589	PROD000010	1000_PET_12	\N	0000000000005	\N	0	0	4	0	\N	\N	\N	\N	\N	\N
5	2017-09-22 23:51:59.607	PROD000009	200_TETRA_24	\N	0000000000005	\N	0	0	3	0	\N	\N	\N	\N	\N	\N
6	2017-09-22 23:51:59.61	PROD000008	300_GLASS_24	\N	0000000000005	\N	0	48	7	0	\N	\N	\N	350.00	\N	\N
7	2017-09-22 23:51:59.612	PROD000004	300_GLASS_24	\N	0000000000005	\N	0	72	0	0	\N	\N	\N	350.00	\N	\N
8	2017-09-22 23:51:59.615	PROD000014	200_GLASS_24	\N	0000000000005	\N	0	72	0	0	\N	\N	\N	252.00	\N	\N
9	2017-09-23 12:27:44.24	PROD000010	1000_PET_12	\N	0000000000006	\N	0	0	4	2	\N	\N	\N	\N	\N	\N
10	2017-09-23 12:27:44.243	PROD000009	200_TETRA_24	\N	0000000000006	\N	0	0	2	0	\N	\N	\N	\N	\N	\N
11	2017-09-23 12:27:44.245	PROD000008	300_GLASS_24	\N	0000000000006	\N	0	24	1	3	\N	\N	\N	350.00	\N	\N
12	2017-09-23 12:27:44.247	PROD000007	300_GLASS_24	\N	0000000000006	\N	0	24	0	0	\N	\N	\N	350.00	\N	\N
13	2017-09-23 12:27:44.248	PROD000004	300_GLASS_24	\N	0000000000006	\N	0	24	0	0	\N	\N	\N	350.00	\N	\N
14	2017-09-23 12:27:44.25	PROD000014	200_GLASS_24	\N	0000000000006	\N	0	48	0	0	\N	\N	\N	252.00	\N	\N
15	2017-09-23 12:27:44.251	PROD000003	300_GLASS_24	\N	0000000000006	\N	0	24	0	0	\N	\N	\N	300.00	\N	\N
16	2017-09-27 21:15:05.431	PROD000008	300_GLASS_24	121331	\N	\N	2400	0	0	0	\N	\N	\N	\N	\N	\N
17	2017-09-27 21:15:05.526	PROD000006	400_PET_24	121331	\N	\N	4800	0	0	0	\N	\N	\N	\N	\N	\N
18	2017-09-27 21:15:05.529	PROD000002	300_GLASS_24	121331	\N	\N	1200	0	0	4	\N	\N	\N	\N	\N	\N
19	2017-09-27 21:15:05.531	PROD000010	1000_PET_12	121331	\N	\N	1440	0	0	0	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: purchase_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY purchase_dtl (purchase_seq_no, challan_no, challan_invoice_no, total_purchased_glass_qty, total_return_empty_glass_qty, total_challan_amount, total_discount_amount, purchase_comment, payment_method, payment_id, paid_amount, challan_dt, total_prdct_qty) FROM stdin;
BUY0000010	123131ada	1313131	300	300	74617.20	15702.00	all pvc given	\N		0.00	2017-09-21 00:00:00	300
BUY0000011	ddhhfhf4	153535464	0	0	0.00	0.00		\N		0.00	2017-09-21 00:00:00	0
BUY0000012	eqeqedsa	121331	150	140	438328.06	16122.00	all pvc has been paid	\N		0.00	2017-09-27 00:00:00	470
\.


--
-- Data for Name: purchase_prdct_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY purchase_prdct_dtl (purchased_prdct_seq_no, purchase_seq_no, product_cd, purchase_prdct_qty, purchase_prdct_totl_base_amount, purchase_prdct_totl_discount_amnt, purchase_prdct_totl_taxable_amount, purchase_prdct_sgst, purchase_prdct_igst, purchase_prdct_cgst, purchase_prdct_cess_tax, purchase_prdct_net_amount, prdct_recieved_dt, purchase_breakage_seq, per_cs_base_price, per_cs_net_price) FROM stdin;
P000000014	BUY0000010	PROD000008	300.00	69000.00	0.00	53298.00	0.00	7461.72	7461.72	6395.76	74617.20	2017-09-21 23:42:52.993	21	230.00	248.72
P000000015	BUY0000012	PROD000008	100.00	123452.00	0.00	122219.00	17110.66	0.00	17110.66	14666.28	171106.60	2017-09-27 21:15:05.136	\N	1234.52	1711.07
P000000016	BUY0000012	PROD000006	200.00	122313.00	0.00	121082.00	0.00	16951.48	16951.48	14529.84	169514.80	2017-09-27 21:15:05.136	\N	611.57	847.57
P000000017	BUY0000012	PROD000002	50.00	67034.00	0.00	65721.00	0.00	3943.26	3943.26	0.00	73607.52	2017-09-27 21:15:05.136	22	1340.68	1472.15
P000000018	BUY0000012	PROD000010	120.00	32768.00	0.00	20423.00	0.00	1838.07	1838.07	0.00	24099.14	2017-09-27 21:15:05.136	\N	273.07	200.83
\.


--
-- Data for Name: route_map_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY route_map_dtl (route_cd, route_name, mapped_village_id, route_added_dt, route_added_by, route_last_updt_dt, route_last_updt_by) FROM stdin;
\.


--
-- Data for Name: sale_breakage_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY sale_breakage_dtl (breakage_seq, sale_invoice_no, breakage_dt, product_cd, breakage_bs) FROM stdin;
9	0000000000002	2017-09-16 18:49:26.165	PROD000008	4
10	0000000000003	2017-09-17 15:32:33.399	PROD000008	2
11	0000000000004	2017-09-22 23:41:33.795	PROD000007	4
12	0000000000004	2017-09-22 23:41:33.796	PROD000010	3
13	0000000000004	2017-09-22 23:41:33.796	PROD000011	1
14	0000000000005	2017-09-22 23:51:59.424	PROD000008	7
15	0000000000005	2017-09-22 23:51:59.425	PROD000009	3
16	0000000000005	2017-09-22 23:51:59.426	PROD000011	2
17	0000000000006	2017-09-23 12:27:43.676	PROD000010	2
18	0000000000006	2017-09-23 12:27:43.677	PROD000008	3
\.


--
-- Data for Name: sale_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY sale_dtl (sale_invoice_no, cstmr_acnt_no, cstmr_name, address, sale_dt, delivery_mode, total_deliver_bs_glass, total_return_bs_glass, total_prev_bs_glass, total_net_bs_glass, total_deliver_cell, total_return_cell, total_prev_cell, total_net_cell, sys_gnrtd_total_amount, sys_gnrtd_total_discount, total_adjustment_discount, total_amount_adjustment, total_net_actual_amount, total_prev_due_amount, paid_amount, total_net_due_amount, payment_mode, supply_seq_no, is_breakage_return, is_scheme_alloted, sale_comments, sold_by, processed_status, processed_time, curr_stock_processed_id, sale_entry_system_dt, total_scheme_discount) FROM stdin;
0000000000002	0000000003	Maya Saini s/o Pran Sehasan	Sehasan	2017-09-16 18:49:26.159	OnShop	1224	1224	\N	0	0	51	\N	\N	14456.35	357.00	0.00	0.00	15773.00	\N	15773.00	\N	CASH	\N	Y	Y	\N	CDMS	\N	\N	0	2017-09-16 18:49:26.159	1673.65
0000000000003	0000000003	Maya Saini s/o Pran Sehasan	Sehasan	2017-09-17 15:30:07.474	OnShop	72	72	\N	\N	3	6	\N	\N	933.00	21.00	0.00	0.00	1029.00	\N	1029.00	\N	CASH	\N	Y	Y	\N	CDMS	\N	\N	0	2017-09-17 15:30:07.474	117.00
0000000000004	0000000004	Lalaram Saini s/o Saini Jurehra	Jurehra	2017-09-22 23:41:00.962	OnShop	192	192	\N	\N	8	8	\N	\N	2476.98	0.00	0.00	0.00	2602.00	\N	2602.00	\N	CASH	\N	Y	Y	\N	CDMS	\N	\N	0	2017-09-22 23:41:00.962	125.02
0000000000005	0000000004	Lalaram Saini s/o Saini Jurehra	Jurehra	2017-09-22 23:51:46.572	OnShop	192	192	\N	\N	8	8	\N	\N	2231.14	0.00	0.00	0.00	2506.00	\N	2506.00	\N	CASH	\N	Y	Y	\N	CDMS	\N	\N	0	2017-09-22 23:51:46.572	274.86
0000000000006	\N	Nasroo	Thalchaana	2017-09-23 12:27:15.987	OnShop	144	144	\N	\N	6	6	\N	\N	1682.27	0.00	0.00	0.00	1854.00	\N	1854.00	\N	CASH	\N	Y	Y	\N	CDMS	\N	\N	0	2017-09-23 12:27:15.987	171.73
\.


--
-- Data for Name: sale_invoices_prdct_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY sale_invoices_prdct_dtl (sale_invoice_no, seq_number, prdct_group_description, group_name, selling_qty, base_rate_per_cs, net_base_amt, scheme_disocunt_amt, taxable_amt, sgst_rate, sgst_amt, cgst_rate, cgst_amt, cess_rate, cess_amt, sys_gross_net_per_cs, sys_gnrtd_net_amt, sys_gnrtd_special_discount_per_cs, total_sys_gnrtd_discount, total_discnt_adjustment, total_amnt_adjustment, total_prdct_net_amt, scheme_discnt_per_cs) FROM stdin;
0000000000002	000000000000002	300_GLASS_24350.0	300_GLASS_24	744	259.27	8037.41	0.00	7031.46	14.00	984.41	14.00	984.41	12.00	843.78	317.55	9844.05	7.00	217.00	0.00	0.00	10633.00	0.00
0000000000002	000000000000003	300_GLASS_24300.0	300_GLASS_24	120	224.17	1120.86	0.00	947.86	14.00	132.70	14.00	132.70	12.00	113.74	265.40	1327.00	7.00	35.00	0.00	0.00	1465.00	0.00
0000000000002	000000000000004	200_GLASS_24252.0	200_GLASS_24	360	189.42	2841.34	0.00	2346.64	14.00	328.53	14.00	328.53	12.00	281.60	219.02	3285.30	7.00	105.00	0.00	0.00	3675.00	0.00
0000000000003	000000000000005	300_GLASS_24350.0	300_GLASS_24	72	261.14	783.43	117.00	666.43	14.00	93.30	14.00	93.30	12.00	79.97	311.00	933.00	7.00	21.00	0.00	0.00	1029.00	39.00
0000000000004	000000000000006	300_GLASS_24350.0	300_GLASS_24	120	252.59	1262.95	45.32	1217.63	14.00	170.47	14.00	170.47	12.00	146.12	340.94	1704.68	0.00	0.00	0.00	0.00	1750.00	9.06
0000000000004	000000000000007	300_GLASS_24300.0	300_GLASS_24	48	220.81	441.63	45.70	395.93	14.00	55.43	14.00	55.43	12.00	47.51	277.15	554.30	0.00	0.00	0.00	0.00	600.00	22.85
0000000000004	000000000000008	200_GLASS_24252.0	200_GLASS_24	24	189.71	189.71	34.00	155.71	14.00	21.80	14.00	21.80	12.00	18.69	218.00	218.00	0.00	0.00	0.00	0.00	252.00	34.00
0000000000005	000000000000009	300_GLASS_24350.0	300_GLASS_24	120	259.78	1298.90	171.15	1127.75	14.00	157.89	14.00	157.89	12.00	135.33	315.77	1578.85	0.00	0.00	0.00	0.00	1750.00	34.23
0000000000005	000000000000010	200_GLASS_24252.0	200_GLASS_24	72	189.88	569.63	103.71	465.92	14.00	65.23	14.00	65.23	12.00	55.91	217.43	652.29	0.00	0.00	0.00	0.00	756.00	34.57
0000000000006	000000000000011	200_GLASS_24252.0	200_GLASS_24	48	189.80	379.60	68.60	311.00	14.00	43.54	14.00	43.54	12.00	37.32	217.70	435.40	0.00	0.00	0.00	0.00	504.00	34.30
0000000000006	000000000000012	300_GLASS_24350.0	300_GLASS_24	72	256.70	770.10	70.35	699.75	14.00	97.97	14.00	97.97	12.00	83.97	326.55	979.65	0.00	0.00	0.00	0.00	1050.00	23.45
0000000000006	000000000000013	300_GLASS_24300.0	300_GLASS_24	24	223.65	223.65	32.78	190.87	14.00	26.72	14.00	26.72	12.00	22.90	267.22	267.22	0.00	0.00	0.00	0.00	300.00	32.78
\.


--
-- Data for Name: sale_prdct_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY sale_prdct_dtl (prdct_sale_txn_id, invoice_prdct_seq_no, prdct_sale_dt, prdct_cd, prdct_salling_qty) FROM stdin;
34	000000000000002	2017-09-16 18:49:26.163	PROD000008	624
35	000000000000002	2017-09-16 18:49:26.164	PROD000007	120
36	000000000000003	2017-09-16 18:49:26.164	PROD000003	120
37	000000000000004	2017-09-16 18:49:26.165	PROD000014	360
38	000000000000005	2017-09-17 15:32:33.399	PROD000008	72
39	000000000000006	2017-09-22 23:41:33.792	PROD000008	72
40	000000000000006	2017-09-22 23:41:33.793	PROD000007	48
41	000000000000007	2017-09-22 23:41:33.794	PROD000003	48
42	000000000000008	2017-09-22 23:41:33.795	PROD000014	24
43	000000000000009	2017-09-22 23:51:59.423	PROD000008	48
44	000000000000009	2017-09-22 23:51:59.422	PROD000004	72
45	000000000000010	2017-09-22 23:51:59.424	PROD000014	72
46	000000000000011	2017-09-23 12:27:43.674	PROD000014	48
47	000000000000012	2017-09-23 12:27:43.675	PROD000007	24
48	000000000000012	2017-09-23 12:27:43.675	PROD000004	24
49	000000000000012	2017-09-23 12:27:43.674	PROD000008	24
50	000000000000013	2017-09-23 12:27:43.676	PROD000003	24
\.


--
-- Data for Name: sale_prdct_scheme_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY sale_prdct_scheme_dtl (alloted_scheme_id, scheme_prdct_cd, calculated_scheme_qty_bs, given_scheme_qty_bs, old_given_scheme_bs, pending_scheme_bs, sale_invoice_no, alloted_to_group_name, alloted_to_product_cd, scheme_alloted_dt) FROM stdin;
8	PROD000010	0	4	0	\N	0000000000002	300_GLASS_24	\N	2017-09-16 18:49:26.167
9	PROD000010	3	3	0	\N	0000000000003	300_GLASS_24	\N	2017-09-17 15:32:33.4
10	PROD000007	2	2	0	\N	0000000000004	200_GLASS_24	\N	2017-09-22 23:41:33.798
11	PROD000008	1	1	0	\N	0000000000004	300_GLASS_24	\N	2017-09-22 23:41:33.799
12	PROD000010	4	4	0	\N	0000000000004	300_GLASS_24	\N	2017-09-22 23:41:33.799
13	PROD000010	4	4	0	\N	0000000000005	300_GLASS_24	\N	2017-09-22 23:51:59.428
14	PROD000008	4	4	0	\N	0000000000005	300_GLASS_24	\N	2017-09-22 23:51:59.428
15	PROD000009	3	3	0	\N	0000000000005	200_GLASS_24	\N	2017-09-22 23:51:59.429
16	PROD000010	4	4	0	\N	0000000000006	300_GLASS_24	\N	2017-09-23 12:27:43.678
17	PROD000009	2	2	0	\N	0000000000006	300_GLASS_24	\N	2017-09-23 12:27:43.679
18	PROD000008	1	1	0	\N	0000000000006	200_GLASS_24	\N	2017-09-23 12:27:43.679
\.


--
-- Data for Name: serial_no_generator; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY serial_no_generator (seq_name, seq_value, seq_prefix, seq_size) FROM stdin;
PACKINGTYPE_SEQ	3	TYPE	10
FLAVOUR_SEQ	6	FLVR	10
PACKINGQTY_SEQ	2	PQTY	10
FILLINGQTY_SEQ	7	ML	10
SUPPLY_SEQ	1	SP	10
SALE_PRDCT_TXN_ID	51	\N	15
SALE_BREAKAGE_SEQ	19	\N	10
SALE_SCHEME_SEQ	19	\N	10
PROD_SEQ	14	PROD	10
SALE_INVOICE	6	\N	13
INVOICED_PRDCT_SEQ	13	\N	15
BREAKAGE_SEQ	23	\N	10
INSTANT_STOCK_SEQ	20	\N	15
PURCHASE_SEQ	12	BUY	10
PURCHASE_PROD_SEQ	18	P	10
CUSTOMER_SEQ	4	CSTMR	11
LEDGER_SEQ	4	\N	10
\.


--
-- Data for Name: supply_records; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY supply_records (supply_seq_no, vehicle_cd, total_glass_bs_sent, expected_return_bs_glass, actual_return_bs_glass, total_cell_sent, expected_return_cell, actual_cell_return, lost_glass_bs_qty, lost_cell_qty, cstmr_due_glass_bs_qty, cstmr_due_cell_qty, sys_gen_total_supplysale_amnt, sys_gnrted_total_supplysale_discnt, total_supplysale_adjustment_discnt, total_supplysale_adjustment_amnt, total_net_actual_supplysale_amnt, total_cstmr_supplysale_due_amnt, total_supplysale_amnt_recieved, mismatch_amnt, supply_worker_name, supply_vehicle_exit_time, supply_vehicle_back_time, route_covered) FROM stdin;
\.


--
-- Data for Name: supply_vehicle_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY supply_vehicle_dtl (vehicle_cd, vehicle_type, vehicle_no, vehicle_added_dt, vehicle_added_by) FROM stdin;
\.


--
-- Data for Name: territory_area_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY territory_area_dtl (territory_cd, territory_name, territory_distance, territory_added_dt, territory_added_by) FROM stdin;
area001	Jurehra	0.000	2017-08-24 21:57:10.753671	CDMS
area002	Sehasan	12.000	2017-08-24 21:57:40.184355	CDMS
area003	Pai	10.000	2017-08-24 21:58:08.738988	CDMS
area004	Sonokhar	14.000	2017-08-24 21:58:35.747533	CDMS
\.


--
-- Data for Name: total_supplysale_prdct_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY total_supplysale_prdct_dtl (prdct_supplysale_seq, supply_seq_no, product_cd, total_sent_prdct_qty, total_selling_prdct_qty, cstmr_due_prdct_qty, expected_return_qty, actual_return_prdct_qty, prdct_lost_qty, supply_prdct_sale_time) FROM stdin;
\.


--
-- Name: beverage_product_category beverage_product_category_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY beverage_product_category
    ADD CONSTRAINT beverage_product_category_pk PRIMARY KEY (product_cd);


--
-- Name: beverage_product_group_dtl beverage_product_group_dtl_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY beverage_product_group_dtl
    ADD CONSTRAINT beverage_product_group_dtl_pk PRIMARY KEY (group_name);


--
-- Name: beverage_product_category beverage_product_uniq; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY beverage_product_category
    ADD CONSTRAINT beverage_product_uniq UNIQUE (flavr_cd, filling_qty_cd, packing_name_cd, packing_qty_cd);


--
-- Name: cstmr_acnts_dtl cstmr_acnts_dtl_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY cstmr_acnts_dtl
    ADD CONSTRAINT cstmr_acnts_dtl_pk PRIMARY KEY (cstmr_acnt_no);


--
-- Name: cstmr_dtl cstmr_dtl_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY cstmr_dtl
    ADD CONSTRAINT cstmr_dtl_pk PRIMARY KEY (cstmr_id);


--
-- Name: cstmr_ledger_category cstmr_ledger_cat_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY cstmr_ledger_category
    ADD CONSTRAINT cstmr_ledger_cat_pk PRIMARY KEY (cstmr_ledger_type_cd);


--
-- Name: cstmr_dtl cstmr_uniq; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY cstmr_dtl
    ADD CONSTRAINT cstmr_uniq UNIQUE (cstmr_fullname, cstmr_fathername, cstmr_territory);


--
-- Name: datewise_prdct_stock_summery datewise_prdct_stock_summery_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY datewise_prdct_stock_summery
    ADD CONSTRAINT datewise_prdct_stock_summery_pk PRIMARY KEY (prdct_stock_seq);


--
-- Name: datewise_scheme_prdct_summery datewise_sceme_prdct_summery_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY datewise_scheme_prdct_summery
    ADD CONSTRAINT datewise_sceme_prdct_summery_pk PRIMARY KEY (scheme_summery_seq);


--
-- Name: datewise_stock_summery datewise_stock_summery_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY datewise_stock_summery
    ADD CONSTRAINT datewise_stock_summery_pk PRIMARY KEY (stock_serial_no);


--
-- Name: filling_qty_category filling_qty_category_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY filling_qty_category
    ADD CONSTRAINT filling_qty_category_pk PRIMARY KEY (filling_qty_cd);


--
-- Name: filling_qty_category filling_qty_uniq; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY filling_qty_category
    ADD CONSTRAINT filling_qty_uniq UNIQUE (filling_qty_ml);


--
-- Name: flavour_category flavour_category_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY flavour_category
    ADD CONSTRAINT flavour_category_pk PRIMARY KEY (flavr_cd);


--
-- Name: flavour_category flavr_uniq; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY flavour_category
    ADD CONSTRAINT flavr_uniq UNIQUE (flavr_name);


--
-- Name: packing_name_category packing_name_category_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY packing_name_category
    ADD CONSTRAINT packing_name_category_pk PRIMARY KEY (packing_name_cd);


--
-- Name: packing_qty_category packing_qty_category_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY packing_qty_category
    ADD CONSTRAINT packing_qty_category_pk PRIMARY KEY (packing_qty_cd);


--
-- Name: prdct_breakage_dtl prdct_breakage_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY prdct_breakage_dtl
    ADD CONSTRAINT prdct_breakage_pk PRIMARY KEY (breakage_seq);


--
-- Name: prdct_curr_price_scheme prdct_curr_price_scheme_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY prdct_curr_price_scheme
    ADD CONSTRAINT prdct_curr_price_scheme_pk PRIMARY KEY (seq_no);


--
-- Name: product_instant_stock_dtl product_curr_stock_dtl_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY product_instant_stock_dtl
    ADD CONSTRAINT product_curr_stock_dtl_pk PRIMARY KEY (prdct_stock_curr_seq);


--
-- Name: beverage_product_category product_nm_uniq; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY beverage_product_category
    ADD CONSTRAINT product_nm_uniq UNIQUE (product_name);


--
-- Name: purchase_dtl purchase_seq_no_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY purchase_dtl
    ADD CONSTRAINT purchase_seq_no_pk PRIMARY KEY (purchase_seq_no);


--
-- Name: purchase_prdct_dtl purchased_prdct_seq_no_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY purchase_prdct_dtl
    ADD CONSTRAINT purchased_prdct_seq_no_pk PRIMARY KEY (purchased_prdct_seq_no);


--
-- Name: route_map_dtl route_map_pd; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY route_map_dtl
    ADD CONSTRAINT route_map_pd PRIMARY KEY (route_cd);


--
-- Name: sale_breakage_dtl sale_breakage_dtl_pc; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY sale_breakage_dtl
    ADD CONSTRAINT sale_breakage_dtl_pc PRIMARY KEY (breakage_seq);


--
-- Name: sale_dtl sale_dtl_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY sale_dtl
    ADD CONSTRAINT sale_dtl_pk PRIMARY KEY (sale_invoice_no);


--
-- Name: sale_invoices_prdct_dtl sale_invoices_prdct_dtl_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY sale_invoices_prdct_dtl
    ADD CONSTRAINT sale_invoices_prdct_dtl_pk PRIMARY KEY (seq_number);


--
-- Name: sale_prdct_dtl sale_prdct_dtl_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY sale_prdct_dtl
    ADD CONSTRAINT sale_prdct_dtl_pk PRIMARY KEY (prdct_sale_txn_id);


--
-- Name: sale_prdct_scheme_dtl sale_prdct_scheme_dtl_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY sale_prdct_scheme_dtl
    ADD CONSTRAINT sale_prdct_scheme_dtl_pk PRIMARY KEY (alloted_scheme_id);


--
-- Name: serial_no_generator seq_name_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY serial_no_generator
    ADD CONSTRAINT seq_name_pk PRIMARY KEY (seq_name);


--
-- Name: supply_records supply_records_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY supply_records
    ADD CONSTRAINT supply_records_pk PRIMARY KEY (supply_seq_no);


--
-- Name: territory_area_dtl territory_dtl_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY territory_area_dtl
    ADD CONSTRAINT territory_dtl_pk PRIMARY KEY (territory_cd);


--
-- Name: total_supplysale_prdct_dtl total_supplysale_prdct_dtl_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY total_supplysale_prdct_dtl
    ADD CONSTRAINT total_supplysale_prdct_dtl_pk PRIMARY KEY (prdct_supplysale_seq);


--
-- Name: beverage_product_group_dtl uniq_group; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY beverage_product_group_dtl
    ADD CONSTRAINT uniq_group UNIQUE (filing_qty_cd1, packing_name_cd, packing_qty_cd);


--
-- Name: packing_name_category uniq_paking; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY packing_name_category
    ADD CONSTRAINT uniq_paking UNIQUE (packing_name);


--
-- Name: packing_qty_category uniq_paking_qty; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY packing_qty_category
    ADD CONSTRAINT uniq_paking_qty UNIQUE (packing_quantity);


--
-- Name: supply_vehicle_dtl vehicle_dtl_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY supply_vehicle_dtl
    ADD CONSTRAINT vehicle_dtl_pk PRIMARY KEY (vehicle_cd);


--
-- PostgreSQL database dump complete
--

\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

