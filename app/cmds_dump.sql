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
    product_added_by character varying(50) NOT NULL
);


ALTER TABLE beverage_product_category OWNER TO postgres;

--
-- Name: beverage_product_group_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE beverage_product_group_dtl (
    group_name character(50) NOT NULL,
    filing_qty_cd1 character(10),
    filling_qty_cd2 character(10),
    packing_name_cd character(10),
    packing_qty_cd character(10),
    group_comments character(100)
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
    cstmr_id character varying(10) NOT NULL,
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
    cstmr_id character varying(10) NOT NULL,
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
    cstmr_ledger_type_name character varying(20) NOT NULL,
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
    product_cd character(10) NOT NULL,
    open_mouth_bs numeric,
    shortage_bs numeric,
    seal_pack_shortage_bs numeric,
    burst_bs numeric,
    other_breakage_bs numeric,
    breakage_source character(20) NOT NULL,
    source_id character(10)
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
    is_group_same_price character varying(3) DEFAULT 'Y'::character varying NOT NULL
);


ALTER TABLE prdct_curr_price_scheme OWNER TO postgres;

--
-- Name: product_curr_stock_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE product_curr_stock_dtl (
    prdct_stock_curr_seq numeric(10,0) NOT NULL,
    prdct_stock_curr_time timestamp without time zone NOT NULL,
    product_cd character varying(10) NOT NULL,
    prdct_opening_qty numeric(10,2) NOT NULL,
    prdct_outscheme_sale_qty numeric(10,2),
    prdct_breakage_qty_bs numeric(10,0),
    prdct_curr_available_qty numeric(10,2),
    prdct_mrp numeric(10,0),
    offered_scheme_dtl character varying(200),
    packate_price numeric(10,0),
    prdct_distributed_scheme_qty_bs numeric(10,0),
    curr_prdct_adustment numeric(10,2),
    curr_stock_processed_id numeric(10,0)
);


ALTER TABLE product_curr_stock_dtl OWNER TO postgres;

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
-- Name: sale_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE sale_dtl (
    sale_txn_id character varying(10) NOT NULL,
    cstmr_acnt_no character varying(10) NOT NULL,
    cstmr_id character varying(10) NOT NULL,
    sale_dt timestamp without time zone NOT NULL,
    delivery_mode character varying(10) NOT NULL,
    total_deliver_glasscell numeric(10,2) NOT NULL,
    total_return_glasscell numeric(10,2) NOT NULL,
    total_prev_due_glasscell numeric(10,2) NOT NULL,
    total_net_due_glasscell numeric(10,2) NOT NULL,
    total_return_only_cell numeric(10,2) NOT NULL,
    total_return_only_glass numeric(10,2) NOT NULL,
    sys_gnrtd_total_amount numeric(10,2) NOT NULL,
    sys_gnrtd_total_discount numeric(10,2) NOT NULL,
    total_adjustment_discount numeric(10,2) NOT NULL,
    total_amount_adjustment numeric(10,2) NOT NULL,
    total_net_actual_amount numeric(10,2) NOT NULL,
    total_prev_due_amount numeric(10,2) NOT NULL,
    paid_amount numeric(10,2) NOT NULL,
    total_net_due_amount numeric(10,2) NOT NULL,
    payment_mode character varying(20) NOT NULL,
    scheme_seq_no character varying(10),
    supply_seq_no character varying(10),
    is_breakage_return character varying(3) DEFAULT 'N'::character varying,
    is_scheme_alloted character varying(3) DEFAULT 'Y'::character varying,
    sale_comments character varying(500),
    sold_by character varying(50),
    processed_status character varying(10),
    processed_time timestamp without time zone,
    curr_stock_processed_id numeric
);


ALTER TABLE sale_dtl OWNER TO postgres;

--
-- Name: sale_prdct_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE sale_prdct_dtl (
    prdct_sale_txn_id numeric(10,0) NOT NULL,
    sale_txn_id character(10) NOT NULL,
    prdct_sale_dt timestamp without time zone NOT NULL,
    prdct_cd character(10) NOT NULL,
    prdct_salling_qty numeric(10,2) NOT NULL
);


ALTER TABLE sale_prdct_dtl OWNER TO postgres;

--
-- Name: sale_prdct_payment_detall; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE sale_prdct_payment_detall (
    sale_payment_id numeric(10,0) NOT NULL,
    sale_txn_id character varying(10) NOT NULL,
    group_name character varying(20),
    prdct_cd character varying(10),
    group_prdct_packet_price numeric(10,2) NOT NULL,
    group_or_prdct_qty_outscheme numeric(10,2) NOT NULL,
    sys_gnrtd_prdctgroup_amnt numeric(10,2) NOT NULL,
    sys_gnrtd_prdctgroup_discnt numeric(10,2) NOT NULL,
    prdctgroup_discnt_adjustment numeric(10,2) NOT NULL,
    prdctgroup_amnt_adjustment numeric(10,2) NOT NULL,
    prdctgroup_net_amnt numeric(10,2) NOT NULL
);


ALTER TABLE sale_prdct_payment_detall OWNER TO postgres;

--
-- Name: TABLE sale_prdct_payment_detall; Type: COMMENT; Schema: cdms; Owner: postgres
--

COMMENT ON TABLE sale_prdct_payment_detall IS 'grouping nd different price product code . prdct code will not null incase of its price is different from grouping ';


--
-- Name: sale_prdct_scheme_dtl; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE sale_prdct_scheme_dtl (
    alloted_scheme_id character varying(10) NOT NULL,
    scheme_prdct_cd character varying(10) NOT NULL,
    calculated_scheme_qty_bs numeric(10,2) NOT NULL,
    given_scheme_qty_bs numeric(10,2) NOT NULL,
    old_given_scheme_bs numeric(10,2) NOT NULL,
    pending_scheme_bs numeric(10,2) NOT NULL,
    sale_txn_id character varying(10) NOT NULL,
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
-- Name: supply_records; Type: TABLE; Schema: cdms; Owner: postgres
--

CREATE TABLE supply_records (
    supply_seq_no character varying(10) NOT NULL,
    vehicle_cd character varying(10) NOT NULL,
    total_glass_sent numeric(10,2) NOT NULL,
    expected_return_glass numeric(10,2),
    actual_return_glass numeric(10,2),
    lost_glass_qty numeric(10,2),
    cstmr_due_glass_qty numeric(10,2),
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
    supply_seq_no character(10) NOT NULL,
    product_cd character(10) NOT NULL,
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

COPY beverage_product_category (product_cd, flavr_cd, filling_qty_cd, packing_name_cd, packing_qty_cd, group_name, product_added_dt, product_added_by) FROM stdin;
\.


--
-- Data for Name: beverage_product_group_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY beverage_product_group_dtl (group_name, filing_qty_cd1, filling_qty_cd2, packing_name_cd, packing_qty_cd, group_comments) FROM stdin;
\.


--
-- Data for Name: cstmr_acnts_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY cstmr_acnts_dtl (cstmr_acnt_no, cstmr_id, cstmr_ledger_type_cd, acnt_opening_dt, acnt_open_by, acnt_closing_dt, acnt_closed_by, acnt_closing_due_balance, acnt_closing_due_empty_cs, acnt_closing_comments) FROM stdin;
\.


--
-- Data for Name: cstmr_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY cstmr_dtl (cstmr_id, cstmr_fullname, cstmr_fathername, cstmr_territory, cstmr_mob_no, cstmr_email, cstmr_created_dt, cstmr_created_by, cstmr_updt_dt, cstmr_updt_by) FROM stdin;
\.


--
-- Data for Name: cstmr_ledger_category; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY cstmr_ledger_category (cstmr_ledger_type_cd, cstmr_ledger_type_name, ledger_curr_special_discount, cstmr_ledger_created_dt, cstmr_ledger_created_by, cstmr_ledger_updt_dt, cstmr_ledger_updt_by) FROM stdin;
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
\.


--
-- Data for Name: flavour_category; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY flavour_category (flavr_cd, flavr_name, flavr_added_dt, falvr_added_by) FROM stdin;
\.


--
-- Data for Name: packing_name_category; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY packing_name_category (packing_name_cd, packing_name, paking_added__dt, paking_added_by) FROM stdin;
\.


--
-- Data for Name: packing_qty_category; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY packing_qty_category (packing_qty_cd, packing_quantity, packing_qty_added_dt, packing_qty_added_by) FROM stdin;
\.


--
-- Data for Name: prdct_breakage_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY prdct_breakage_dtl (breakage_seq, breakage_dt, product_cd, open_mouth_bs, shortage_bs, seal_pack_shortage_bs, burst_bs, other_breakage_bs, breakage_source, source_id) FROM stdin;
\.


--
-- Data for Name: prdct_curr_price_scheme; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY prdct_curr_price_scheme (seq_no, product_cd, prdct_curr_price, prdct_curr_mrp, prdct_curr_scheme, price_lastchange_dt, is_group_same_price) FROM stdin;
\.


--
-- Data for Name: product_curr_stock_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY product_curr_stock_dtl (prdct_stock_curr_seq, prdct_stock_curr_time, product_cd, prdct_opening_qty, prdct_outscheme_sale_qty, prdct_breakage_qty_bs, prdct_curr_available_qty, prdct_mrp, offered_scheme_dtl, packate_price, prdct_distributed_scheme_qty_bs, curr_prdct_adustment, curr_stock_processed_id) FROM stdin;
\.


--
-- Data for Name: route_map_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY route_map_dtl (route_cd, route_name, mapped_village_id, route_added_dt, route_added_by, route_last_updt_dt, route_last_updt_by) FROM stdin;
\.


--
-- Data for Name: sale_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY sale_dtl (sale_txn_id, cstmr_acnt_no, cstmr_id, sale_dt, delivery_mode, total_deliver_glasscell, total_return_glasscell, total_prev_due_glasscell, total_net_due_glasscell, total_return_only_cell, total_return_only_glass, sys_gnrtd_total_amount, sys_gnrtd_total_discount, total_adjustment_discount, total_amount_adjustment, total_net_actual_amount, total_prev_due_amount, paid_amount, total_net_due_amount, payment_mode, scheme_seq_no, supply_seq_no, is_breakage_return, is_scheme_alloted, sale_comments, sold_by, processed_status, processed_time, curr_stock_processed_id) FROM stdin;
\.


--
-- Data for Name: sale_prdct_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY sale_prdct_dtl (prdct_sale_txn_id, sale_txn_id, prdct_sale_dt, prdct_cd, prdct_salling_qty) FROM stdin;
\.


--
-- Data for Name: sale_prdct_payment_detall; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY sale_prdct_payment_detall (sale_payment_id, sale_txn_id, group_name, prdct_cd, group_prdct_packet_price, group_or_prdct_qty_outscheme, sys_gnrtd_prdctgroup_amnt, sys_gnrtd_prdctgroup_discnt, prdctgroup_discnt_adjustment, prdctgroup_amnt_adjustment, prdctgroup_net_amnt) FROM stdin;
\.


--
-- Data for Name: sale_prdct_scheme_dtl; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY sale_prdct_scheme_dtl (alloted_scheme_id, scheme_prdct_cd, calculated_scheme_qty_bs, given_scheme_qty_bs, old_given_scheme_bs, pending_scheme_bs, sale_txn_id, alloted_to_group_name, alloted_to_product_cd, scheme_alloted_dt) FROM stdin;
\.


--
-- Data for Name: supply_records; Type: TABLE DATA; Schema: cdms; Owner: postgres
--

COPY supply_records (supply_seq_no, vehicle_cd, total_glass_sent, expected_return_glass, actual_return_glass, lost_glass_qty, cstmr_due_glass_qty, sys_gen_total_supplysale_amnt, sys_gnrted_total_supplysale_discnt, total_supplysale_adjustment_discnt, total_supplysale_adjustment_amnt, total_net_actual_supplysale_amnt, total_cstmr_supplysale_due_amnt, total_supplysale_amnt_recieved, mismatch_amnt, supply_worker_name, supply_vehicle_exit_time, supply_vehicle_back_time, route_covered) FROM stdin;
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
-- Name: flavour_category flavour_category_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY flavour_category
    ADD CONSTRAINT flavour_category_pk PRIMARY KEY (flavr_cd);


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
-- Name: prdct_curr_price_scheme prdct_cd_crr_uniq_key; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY prdct_curr_price_scheme
    ADD CONSTRAINT prdct_cd_crr_uniq_key UNIQUE (product_cd);


--
-- Name: prdct_curr_price_scheme prdct_curr_price_scheme_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY prdct_curr_price_scheme
    ADD CONSTRAINT prdct_curr_price_scheme_pk PRIMARY KEY (seq_no);


--
-- Name: product_curr_stock_dtl product_curr_stock_dtl_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY product_curr_stock_dtl
    ADD CONSTRAINT product_curr_stock_dtl_pk PRIMARY KEY (prdct_stock_curr_seq);


--
-- Name: route_map_dtl route_map_pd; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY route_map_dtl
    ADD CONSTRAINT route_map_pd PRIMARY KEY (route_cd);


--
-- Name: sale_dtl sale_dtl_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY sale_dtl
    ADD CONSTRAINT sale_dtl_pk PRIMARY KEY (sale_txn_id);


--
-- Name: sale_prdct_dtl sale_prdct_dtl_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY sale_prdct_dtl
    ADD CONSTRAINT sale_prdct_dtl_pk PRIMARY KEY (prdct_sale_txn_id);


--
-- Name: sale_prdct_payment_detall sale_prdct_payment_dtl_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY sale_prdct_payment_detall
    ADD CONSTRAINT sale_prdct_payment_dtl_pk PRIMARY KEY (sale_payment_id);


--
-- Name: sale_prdct_scheme_dtl sale_prdct_scheme_dtl_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY sale_prdct_scheme_dtl
    ADD CONSTRAINT sale_prdct_scheme_dtl_pk PRIMARY KEY (alloted_scheme_id);


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
-- Name: supply_vehicle_dtl vehicle_dtl_pk; Type: CONSTRAINT; Schema: cdms; Owner: postgres
--

ALTER TABLE ONLY supply_vehicle_dtl
    ADD CONSTRAINT vehicle_dtl_pk PRIMARY KEY (vehicle_cd);


--
-- PostgreSQL database dump complete
--

