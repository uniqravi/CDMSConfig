PGDMP     )    :                u            cdms    9.6.2    9.6.3 m    	           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            	           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            	           1262    16396    cdms    DATABASE     �   CREATE DATABASE cdms WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_India.1252' LC_CTYPE = 'English_India.1252';
    DROP DATABASE cdms;
             postgres    false            	           1262    16396    cdms    COMMENT     =   COMMENT ON DATABASE cdms IS 'COLD DRINKS MANAGEMENT SYSTEM';
                  postgres    false    2334                        2615    16397    cdms    SCHEMA        CREATE SCHEMA cdms;
    DROP SCHEMA cdms;
             postgres    false             	           0    0    SCHEMA cdms    COMMENT     )   COMMENT ON SCHEMA cdms IS 'CDMS schema';
                  postgres    false    7                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            !	           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12387    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            "	           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    16742    beverage_product_category    TABLE     �  CREATE TABLE beverage_product_category (
    product_cd character varying(10) NOT NULL,
    flavr_cd character varying(10) NOT NULL,
    filling_qty_cd character varying(10) NOT NULL,
    packing_name_cd character varying(10) NOT NULL,
    packing_qty_cd character varying(10) NOT NULL,
    group_name character varying(20),
    product_added_dt timestamp without time zone,
    product_added_by character varying(50) NOT NULL,
    product_name character varying(50)
);
 +   DROP TABLE cdms.beverage_product_category;
       cdms         postgres    false    7            �            1259    16584    beverage_product_group_dtl    TABLE     0  CREATE TABLE beverage_product_group_dtl (
    group_name character varying(50) NOT NULL,
    filing_qty_cd1 character varying(10),
    filling_qty_cd2 character varying(10),
    packing_name_cd character varying(10),
    packing_qty_cd character varying(10),
    group_comments character varying(100)
);
 ,   DROP TABLE cdms.beverage_product_group_dtl;
       cdms         postgres    false    7            #	           0    0     TABLE beverage_product_group_dtl    COMMENT     c   COMMENT ON TABLE beverage_product_group_dtl IS 'based on filling qty,packet qty,pakage_category,';
            cdms       postgres    false    199            �            1259    16545    cstmr_acnts_dtl    TABLE     
  CREATE TABLE cstmr_acnts_dtl (
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
 !   DROP TABLE cdms.cstmr_acnts_dtl;
       cdms         postgres    false    7            �            1259    16540 	   cstmr_dtl    TABLE     �  CREATE TABLE cstmr_dtl (
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
    DROP TABLE cdms.cstmr_dtl;
       cdms         postgres    false    7            �            1259    16534    cstmr_ledger_category    TABLE     �  CREATE TABLE cstmr_ledger_category (
    cstmr_ledger_type_cd character varying(10) NOT NULL,
    cstmr_ledger_type_name character varying(20) NOT NULL,
    ledger_curr_special_discount numeric(10,2) NOT NULL,
    cstmr_ledger_created_dt timestamp without time zone NOT NULL,
    cstmr_ledger_created_by character varying(50) NOT NULL,
    cstmr_ledger_updt_dt timestamp without time zone,
    cstmr_ledger_updt_by character varying(50)
);
 '   DROP TABLE cdms.cstmr_ledger_category;
       cdms         postgres    false    7            �            1259    16467    datewise_prdct_stock_summery    TABLE       CREATE TABLE datewise_prdct_stock_summery (
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
 .   DROP TABLE cdms.datewise_prdct_stock_summery;
       cdms         postgres    false    7            $	           0    0 "   TABLE datewise_prdct_stock_summery    COMMENT     ]   COMMENT ON TABLE datewise_prdct_stock_summery IS 'datewise summation of individual product';
            cdms       postgres    false    191            �            1259    16631    datewise_scheme_prdct_summery    TABLE     �  CREATE TABLE datewise_scheme_prdct_summery (
    scheme_summery_seq character varying(10) NOT NULL,
    scheme_prdct_cd character varying(10) NOT NULL,
    total_dayalloted_scheme_cs numeric(10,2) NOT NULL,
    prdct_stock_seq numeric(10,0) NOT NULL,
    allotted_to_group_name character varying(20),
    alloted_to_product_cd character varying(10),
    scheme_alloted_dt timestamp without time zone NOT NULL
);
 /   DROP TABLE cdms.datewise_scheme_prdct_summery;
       cdms         postgres    false    7            %	           0    0 #   TABLE datewise_scheme_prdct_summery    COMMENT     }   COMMENT ON TABLE datewise_scheme_prdct_summery IS 'will gonna tell info whole day alloted scheme on which product or group';
            cdms       postgres    false    203            �            1259    16451    datewise_stock_summery    TABLE     �  CREATE TABLE datewise_stock_summery (
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
 (   DROP TABLE cdms.datewise_stock_summery;
       cdms         postgres    false    7            &	           0    0    TABLE datewise_stock_summery    COMMENT     <   COMMENT ON TABLE datewise_stock_summery IS 'Master STOCK ';
            cdms       postgres    false    190            �            1259    16413    filling_qty_category    TABLE       CREATE TABLE filling_qty_category (
    filling_qty_cd character varying(10) NOT NULL,
    filling_qty_ml character varying(20) NOT NULL,
    filling_qty_added_dt timestamp without time zone NOT NULL,
    filling_qty_added_by character varying(50) NOT NULL
);
 &   DROP TABLE cdms.filling_qty_category;
       cdms         postgres    false    7            �            1259    16403    flavour_category    TABLE     �   CREATE TABLE flavour_category (
    flavr_cd character varying(10) NOT NULL,
    flavr_name character varying(50),
    flavr_added_dt timestamp without time zone NOT NULL,
    falvr_added_by character varying(50) NOT NULL
);
 "   DROP TABLE cdms.flavour_category;
       cdms         postgres    false    7            �            1259    16817    operation_monitoring    TABLE     �   CREATE TABLE operation_monitoring (
    operation_nm character varying(100) NOT NULL,
    operation_comment character varying(200),
    operation_group character varying(100),
    operation_status character varying(10) NOT NULL
);
 &   DROP TABLE cdms.operation_monitoring;
       cdms         postgres    false    7            �            1259    16408    packing_name_category    TABLE     �   CREATE TABLE packing_name_category (
    packing_name_cd character varying(10) NOT NULL,
    packing_name character varying(20) NOT NULL,
    paking_added__dt timestamp without time zone NOT NULL,
    paking_added_by character varying(50) NOT NULL
);
 '   DROP TABLE cdms.packing_name_category;
       cdms         postgres    false    7            '	           0    0    TABLE packing_name_category    COMMENT     `   COMMENT ON TABLE packing_name_category IS 'glass,can,minican,tropicana,frooti,slice,water,pet';
            cdms       postgres    false    187            �            1259    16418    packing_qty_category    TABLE     �   CREATE TABLE packing_qty_category (
    packing_qty_cd character varying(10) NOT NULL,
    packing_quantity numeric NOT NULL,
    packing_qty_added_dt timestamp without time zone NOT NULL,
    packing_qty_added_by character varying(50) NOT NULL
);
 &   DROP TABLE cdms.packing_qty_category;
       cdms         postgres    false    7            �            1259    16623    prdct_breakage_dtl    TABLE     �  CREATE TABLE prdct_breakage_dtl (
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
 $   DROP TABLE cdms.prdct_breakage_dtl;
       cdms         postgres    false    7            �            1259    16809    prdct_curr_price_scheme    TABLE     �  CREATE TABLE prdct_curr_price_scheme (
    seq_no character varying(20) NOT NULL,
    product_cd character varying(10) NOT NULL,
    prdct_curr_price numeric(10,2),
    prdct_curr_mrp numeric(10,2),
    prdct_curr_scheme character varying(200),
    price_lastchange_dt timestamp without time zone NOT NULL,
    is_group_same_price character varying(3) DEFAULT 'Y'::character varying NOT NULL
);
 )   DROP TABLE cdms.prdct_curr_price_scheme;
       cdms         postgres    false    7            �            1259    16574    product_curr_stock_dtl    TABLE     j  CREATE TABLE product_curr_stock_dtl (
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
 (   DROP TABLE cdms.product_curr_stock_dtl;
       cdms         postgres    false    7            �            1259    16761    purchase_dtl    TABLE     v  CREATE TABLE purchase_dtl (
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
    DROP TABLE cdms.purchase_dtl;
       cdms         postgres    false    7            �            1259    16766    purchase_prdct_dtl    TABLE     V  CREATE TABLE purchase_prdct_dtl (
    purchased_prdct_seq_no character varying(10) NOT NULL,
    purchase_seq_no character varying(10) NOT NULL,
    product_cd character varying(10) NOT NULL,
    purchase_prdct_qty numeric(10,2) NOT NULL,
    prdct_recieved_dt timestamp without time zone NOT NULL,
    purchase_breakage_seq numeric(10,0)
);
 $   DROP TABLE cdms.purchase_prdct_dtl;
       cdms         postgres    false    7            �            1259    16514    route_map_dtl    TABLE     �  CREATE TABLE route_map_dtl (
    route_cd character varying(10) NOT NULL,
    route_name character varying(50) NOT NULL,
    mapped_village_id character varying(200) NOT NULL,
    route_added_dt timestamp without time zone NOT NULL,
    route_added_by character varying(50) NOT NULL,
    route_last_updt_dt timestamp without time zone,
    route_last_updt_by character varying(50)
);
    DROP TABLE cdms.route_map_dtl;
       cdms         postgres    false    7            (	           0    0    TABLE route_map_dtl    COMMENT     P   COMMENT ON TABLE route_map_dtl IS 'mapped_village_id will be comman_seperated';
            cdms       postgres    false    192            �            1259    16603    sale_dtl    TABLE     �  CREATE TABLE sale_dtl (
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
    DROP TABLE cdms.sale_dtl;
       cdms         postgres    false    7            �            1259    16636    sale_prdct_dtl    TABLE       CREATE TABLE sale_prdct_dtl (
    prdct_sale_txn_id numeric(10,0) NOT NULL,
    sale_txn_id character(10) NOT NULL,
    prdct_sale_dt timestamp without time zone NOT NULL,
    prdct_cd character(10) NOT NULL,
    prdct_salling_qty numeric(10,2) NOT NULL
);
     DROP TABLE cdms.sale_prdct_dtl;
       cdms         postgres    false    7            �            1259    16657    sale_prdct_payment_detall    TABLE     M  CREATE TABLE sale_prdct_payment_detall (
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
 +   DROP TABLE cdms.sale_prdct_payment_detall;
       cdms         postgres    false    7            )	           0    0    TABLE sale_prdct_payment_detall    COMMENT     �   COMMENT ON TABLE sale_prdct_payment_detall IS 'grouping nd different price product code . prdct code will not null incase of its price is different from grouping ';
            cdms       postgres    false    207            �            1259    16613    sale_prdct_scheme_dtl    TABLE     "  CREATE TABLE sale_prdct_scheme_dtl (
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
 '   DROP TABLE cdms.sale_prdct_scheme_dtl;
       cdms         postgres    false    7            *	           0    0    TABLE sale_prdct_scheme_dtl    COMMENT     o   COMMENT ON TABLE sale_prdct_scheme_dtl IS 'is_pending flag will gonna tell sceme is actullay provided or not';
            cdms       postgres    false    201            �            1259    16678    serial_no_generator    TABLE     �   CREATE TABLE serial_no_generator (
    seq_name character varying(20) NOT NULL,
    seq_value numeric,
    seq_prefix character varying(20)
);
 %   DROP TABLE cdms.serial_no_generator;
       cdms         postgres    false    7            �            1259    16646    supply_records    TABLE     �  CREATE TABLE supply_records (
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
     DROP TABLE cdms.supply_records;
       cdms         postgres    false    7            �            1259    16529    supply_vehicle_dtl    TABLE       CREATE TABLE supply_vehicle_dtl (
    vehicle_cd character varying(10) NOT NULL,
    vehicle_type character varying(20) NOT NULL,
    vehicle_no character varying(20),
    vehicle_added_dt timestamp without time zone NOT NULL,
    vehicle_added_by character varying(20) NOT NULL
);
 $   DROP TABLE cdms.supply_vehicle_dtl;
       cdms         postgres    false    7            �            1259    16524    territory_area_dtl    TABLE     +  CREATE TABLE territory_area_dtl (
    territory_cd character varying(10) NOT NULL,
    territory_name character varying(20) NOT NULL,
    territory_distance numeric(10,3) NOT NULL,
    territory_added_dt timestamp without time zone NOT NULL,
    territory_added_by character varying(50) NOT NULL
);
 $   DROP TABLE cdms.territory_area_dtl;
       cdms         postgres    false    7            �            1259    16652    total_supplysale_prdct_dtl    TABLE     �  CREATE TABLE total_supplysale_prdct_dtl (
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
 ,   DROP TABLE cdms.total_supplysale_prdct_dtl;
       cdms         postgres    false    7            	          0    16742    beverage_product_category 
   TABLE DATA               �   COPY beverage_product_category (product_cd, flavr_cd, filling_qty_cd, packing_name_cd, packing_qty_cd, group_name, product_added_dt, product_added_by, product_name) FROM stdin;
    cdms       postgres    false    209   ��       	          0    16584    beverage_product_group_dtl 
   TABLE DATA               �   COPY beverage_product_group_dtl (group_name, filing_qty_cd1, filling_qty_cd2, packing_name_cd, packing_qty_cd, group_comments) FROM stdin;
    cdms       postgres    false    199   ʯ       		          0    16545    cstmr_acnts_dtl 
   TABLE DATA               �   COPY cstmr_acnts_dtl (cstmr_acnt_no, cstmr_id, cstmr_ledger_type_cd, acnt_opening_dt, acnt_open_by, acnt_closing_dt, acnt_closed_by, acnt_closing_due_balance, acnt_closing_due_empty_cs, acnt_closing_comments) FROM stdin;
    cdms       postgres    false    197   %�       	          0    16540 	   cstmr_dtl 
   TABLE DATA               �   COPY cstmr_dtl (cstmr_id, cstmr_fullname, cstmr_fathername, cstmr_territory, cstmr_mob_no, cstmr_email, cstmr_created_dt, cstmr_created_by, cstmr_updt_dt, cstmr_updt_by) FROM stdin;
    cdms       postgres    false    196   B�       	          0    16534    cstmr_ledger_category 
   TABLE DATA               �   COPY cstmr_ledger_category (cstmr_ledger_type_cd, cstmr_ledger_type_name, ledger_curr_special_discount, cstmr_ledger_created_dt, cstmr_ledger_created_by, cstmr_ledger_updt_dt, cstmr_ledger_updt_by) FROM stdin;
    cdms       postgres    false    195   _�       	          0    16467    datewise_prdct_stock_summery 
   TABLE DATA               �  COPY datewise_prdct_stock_summery (prdct_stock_seq, prdct_stock_dt, prdct_dayopening_qty, total_prdct_daypurchase_qty, total_prdct_daysale_outscheme_qty, total_prdct_daysale_withscheme_qty, total_prdct_dayclosing_qty, total_prdct_dayscheme_qty, total_prdct_dayburst_qty, total_prdct_dayleakage_qty, total_prdct_dayopenmount_qty, total_prdct_dayshortage_qty, total_prdct_dayotherless_qty, product_adjustment, stock_serial_no, product_cd) FROM stdin;
    cdms       postgres    false    191   |�       	          0    16631    datewise_scheme_prdct_summery 
   TABLE DATA               �   COPY datewise_scheme_prdct_summery (scheme_summery_seq, scheme_prdct_cd, total_dayalloted_scheme_cs, prdct_stock_seq, allotted_to_group_name, alloted_to_product_cd, scheme_alloted_dt) FROM stdin;
    cdms       postgres    false    203   ��       	          0    16451    datewise_stock_summery 
   TABLE DATA               r  COPY datewise_stock_summery (stock_serial_no, stock_date, total_equivalent_opening_qty, total_equivalent_purchase_qty, total_equivalent_sale_qty, total_equivalent_closing_qty, empty_glasscell_purchase, empty_glasscell_sale, empty_sell_purchase, only_empty_glass_purchase, only_empty_glass_sale, total_available_empty_glasscell_qty, total_broke_glass_bottle) FROM stdin;
    cdms       postgres    false    190   ��        	          0    16413    filling_qty_category 
   TABLE DATA               s   COPY filling_qty_category (filling_qty_cd, filling_qty_ml, filling_qty_added_dt, filling_qty_added_by) FROM stdin;
    cdms       postgres    false    188   Ӱ       �          0    16403    flavour_category 
   TABLE DATA               Y   COPY flavour_category (flavr_cd, flavr_name, flavr_added_dt, falvr_added_by) FROM stdin;
    cdms       postgres    false    186   H�       	          0    16817    operation_monitoring 
   TABLE DATA               k   COPY operation_monitoring (operation_nm, operation_comment, operation_group, operation_status) FROM stdin;
    cdms       postgres    false    213   ݱ       �          0    16408    packing_name_category 
   TABLE DATA               j   COPY packing_name_category (packing_name_cd, packing_name, paking_added__dt, paking_added_by) FROM stdin;
    cdms       postgres    false    187   ��       	          0    16418    packing_qty_category 
   TABLE DATA               u   COPY packing_qty_category (packing_qty_cd, packing_quantity, packing_qty_added_dt, packing_qty_added_by) FROM stdin;
    cdms       postgres    false    189   H�       	          0    16623    prdct_breakage_dtl 
   TABLE DATA               �   COPY prdct_breakage_dtl (breakage_seq, breakage_dt, product_cd, open_mouth_bs, shortage_bs, seal_pack_shortage_bs, burst_bs, other_breakage_bs, breakage_source, leakage_bs) FROM stdin;
    cdms       postgres    false    202   ��       	          0    16809    prdct_curr_price_scheme 
   TABLE DATA               �   COPY prdct_curr_price_scheme (seq_no, product_cd, prdct_curr_price, prdct_curr_mrp, prdct_curr_scheme, price_lastchange_dt, is_group_same_price) FROM stdin;
    cdms       postgres    false    212   �       
	          0    16574    product_curr_stock_dtl 
   TABLE DATA               >  COPY product_curr_stock_dtl (prdct_stock_curr_seq, prdct_stock_curr_time, product_cd, prdct_opening_qty, prdct_outscheme_sale_qty, prdct_breakage_qty_bs, prdct_curr_available_qty, prdct_mrp, offered_scheme_dtl, packate_price, prdct_distributed_scheme_qty_bs, curr_prdct_adustment, curr_stock_processed_id) FROM stdin;
    cdms       postgres    false    198   ��       	          0    16761    purchase_dtl 
   TABLE DATA                 COPY purchase_dtl (purchase_seq_no, challan_no, challan_invoice_no, total_purchased_glass_qty, total_return_empty_glass_qty, total_challan_amount, total_discount_amount, purchase_comment, payment_method, payment_id, paid_amount, challan_dt, total_prdct_qty) FROM stdin;
    cdms       postgres    false    210   ��       	          0    16766    purchase_prdct_dtl 
   TABLE DATA               �   COPY purchase_prdct_dtl (purchased_prdct_seq_no, purchase_seq_no, product_cd, purchase_prdct_qty, prdct_recieved_dt, purchase_breakage_seq) FROM stdin;
    cdms       postgres    false    211   h�       	          0    16514    route_map_dtl 
   TABLE DATA               �   COPY route_map_dtl (route_cd, route_name, mapped_village_id, route_added_dt, route_added_by, route_last_updt_dt, route_last_updt_by) FROM stdin;
    cdms       postgres    false    192   �       	          0    16603    sale_dtl 
   TABLE DATA               M  COPY sale_dtl (sale_txn_id, cstmr_acnt_no, cstmr_id, sale_dt, delivery_mode, total_deliver_glasscell, total_return_glasscell, total_prev_due_glasscell, total_net_due_glasscell, total_return_only_cell, total_return_only_glass, sys_gnrtd_total_amount, sys_gnrtd_total_discount, total_adjustment_discount, total_amount_adjustment, total_net_actual_amount, total_prev_due_amount, paid_amount, total_net_due_amount, payment_mode, scheme_seq_no, supply_seq_no, is_breakage_return, is_scheme_alloted, sale_comments, sold_by, processed_status, processed_time, curr_stock_processed_id) FROM stdin;
    cdms       postgres    false    200   �       	          0    16636    sale_prdct_dtl 
   TABLE DATA               m   COPY sale_prdct_dtl (prdct_sale_txn_id, sale_txn_id, prdct_sale_dt, prdct_cd, prdct_salling_qty) FROM stdin;
    cdms       postgres    false    204   )�       	          0    16657    sale_prdct_payment_detall 
   TABLE DATA                 COPY sale_prdct_payment_detall (sale_payment_id, sale_txn_id, group_name, prdct_cd, group_prdct_packet_price, group_or_prdct_qty_outscheme, sys_gnrtd_prdctgroup_amnt, sys_gnrtd_prdctgroup_discnt, prdctgroup_discnt_adjustment, prdctgroup_amnt_adjustment, prdctgroup_net_amnt) FROM stdin;
    cdms       postgres    false    207   F�       	          0    16613    sale_prdct_scheme_dtl 
   TABLE DATA               �   COPY sale_prdct_scheme_dtl (alloted_scheme_id, scheme_prdct_cd, calculated_scheme_qty_bs, given_scheme_qty_bs, old_given_scheme_bs, pending_scheme_bs, sale_txn_id, alloted_to_group_name, alloted_to_product_cd, scheme_alloted_dt) FROM stdin;
    cdms       postgres    false    201   c�       	          0    16678    serial_no_generator 
   TABLE DATA               G   COPY serial_no_generator (seq_name, seq_value, seq_prefix) FROM stdin;
    cdms       postgres    false    208   ��       	          0    16646    supply_records 
   TABLE DATA               �  COPY supply_records (supply_seq_no, vehicle_cd, total_glass_sent, expected_return_glass, actual_return_glass, lost_glass_qty, cstmr_due_glass_qty, sys_gen_total_supplysale_amnt, sys_gnrted_total_supplysale_discnt, total_supplysale_adjustment_discnt, total_supplysale_adjustment_amnt, total_net_actual_supplysale_amnt, total_cstmr_supplysale_due_amnt, total_supplysale_amnt_recieved, mismatch_amnt, supply_worker_name, supply_vehicle_exit_time, supply_vehicle_back_time, route_covered) FROM stdin;
    cdms       postgres    false    205   �       	          0    16529    supply_vehicle_dtl 
   TABLE DATA               o   COPY supply_vehicle_dtl (vehicle_cd, vehicle_type, vehicle_no, vehicle_added_dt, vehicle_added_by) FROM stdin;
    cdms       postgres    false    194    �       	          0    16524    territory_area_dtl 
   TABLE DATA                  COPY territory_area_dtl (territory_cd, territory_name, territory_distance, territory_added_dt, territory_added_by) FROM stdin;
    cdms       postgres    false    193   =�       	          0    16652    total_supplysale_prdct_dtl 
   TABLE DATA               �   COPY total_supplysale_prdct_dtl (prdct_supplysale_seq, supply_seq_no, product_cd, total_sent_prdct_qty, total_selling_prdct_qty, cstmr_due_prdct_qty, expected_return_qty, actual_return_prdct_qty, prdct_lost_qty, supply_prdct_sale_time) FROM stdin;
    cdms       postgres    false    206   Z�       |           2606    16746 6   beverage_product_category beverage_product_category_pk 
   CONSTRAINT     u   ALTER TABLE ONLY beverage_product_category
    ADD CONSTRAINT beverage_product_category_pk PRIMARY KEY (product_cd);
 ^   ALTER TABLE ONLY cdms.beverage_product_category DROP CONSTRAINT beverage_product_category_pk;
       cdms         postgres    false    209    209            f           2606    16687 8   beverage_product_group_dtl beverage_product_group_dtl_pk 
   CONSTRAINT     w   ALTER TABLE ONLY beverage_product_group_dtl
    ADD CONSTRAINT beverage_product_group_dtl_pk PRIMARY KEY (group_name);
 `   ALTER TABLE ONLY cdms.beverage_product_group_dtl DROP CONSTRAINT beverage_product_group_dtl_pk;
       cdms         postgres    false    199    199            ~           2606    16748 /   beverage_product_category beverage_product_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY beverage_product_category
    ADD CONSTRAINT beverage_product_uniq UNIQUE (flavr_cd, filling_qty_cd, packing_name_cd, packing_qty_cd);
 W   ALTER TABLE ONLY cdms.beverage_product_category DROP CONSTRAINT beverage_product_uniq;
       cdms         postgres    false    209    209    209    209    209            b           2606    16549 "   cstmr_acnts_dtl cstmr_acnts_dtl_pk 
   CONSTRAINT     d   ALTER TABLE ONLY cstmr_acnts_dtl
    ADD CONSTRAINT cstmr_acnts_dtl_pk PRIMARY KEY (cstmr_acnt_no);
 J   ALTER TABLE ONLY cdms.cstmr_acnts_dtl DROP CONSTRAINT cstmr_acnts_dtl_pk;
       cdms         postgres    false    197    197            `           2606    16544    cstmr_dtl cstmr_dtl_pk 
   CONSTRAINT     S   ALTER TABLE ONLY cstmr_dtl
    ADD CONSTRAINT cstmr_dtl_pk PRIMARY KEY (cstmr_id);
 >   ALTER TABLE ONLY cdms.cstmr_dtl DROP CONSTRAINT cstmr_dtl_pk;
       cdms         postgres    false    196    196            ^           2606    16538 )   cstmr_ledger_category cstmr_ledger_cat_pk 
   CONSTRAINT     r   ALTER TABLE ONLY cstmr_ledger_category
    ADD CONSTRAINT cstmr_ledger_cat_pk PRIMARY KEY (cstmr_ledger_type_cd);
 Q   ALTER TABLE ONLY cdms.cstmr_ledger_category DROP CONSTRAINT cstmr_ledger_cat_pk;
       cdms         postgres    false    195    195            V           2606    16471 <   datewise_prdct_stock_summery datewise_prdct_stock_summery_pk 
   CONSTRAINT     �   ALTER TABLE ONLY datewise_prdct_stock_summery
    ADD CONSTRAINT datewise_prdct_stock_summery_pk PRIMARY KEY (prdct_stock_seq);
 d   ALTER TABLE ONLY cdms.datewise_prdct_stock_summery DROP CONSTRAINT datewise_prdct_stock_summery_pk;
       cdms         postgres    false    191    191            p           2606    16635 =   datewise_scheme_prdct_summery datewise_sceme_prdct_summery_pk 
   CONSTRAINT     �   ALTER TABLE ONLY datewise_scheme_prdct_summery
    ADD CONSTRAINT datewise_sceme_prdct_summery_pk PRIMARY KEY (scheme_summery_seq);
 e   ALTER TABLE ONLY cdms.datewise_scheme_prdct_summery DROP CONSTRAINT datewise_sceme_prdct_summery_pk;
       cdms         postgres    false    203    203            T           2606    16455 0   datewise_stock_summery datewise_stock_summery_pk 
   CONSTRAINT     t   ALTER TABLE ONLY datewise_stock_summery
    ADD CONSTRAINT datewise_stock_summery_pk PRIMARY KEY (stock_serial_no);
 X   ALTER TABLE ONLY cdms.datewise_stock_summery DROP CONSTRAINT datewise_stock_summery_pk;
       cdms         postgres    false    190    190            L           2606    16417 ,   filling_qty_category filling_qty_category_pk 
   CONSTRAINT     o   ALTER TABLE ONLY filling_qty_category
    ADD CONSTRAINT filling_qty_category_pk PRIMARY KEY (filling_qty_cd);
 T   ALTER TABLE ONLY cdms.filling_qty_category DROP CONSTRAINT filling_qty_category_pk;
       cdms         postgres    false    188    188            N           2606    16752 %   filling_qty_category filling_qty_uniq 
   CONSTRAINT     c   ALTER TABLE ONLY filling_qty_category
    ADD CONSTRAINT filling_qty_uniq UNIQUE (filling_qty_ml);
 M   ALTER TABLE ONLY cdms.filling_qty_category DROP CONSTRAINT filling_qty_uniq;
       cdms         postgres    false    188    188            D           2606    16407 $   flavour_category flavour_category_pk 
   CONSTRAINT     a   ALTER TABLE ONLY flavour_category
    ADD CONSTRAINT flavour_category_pk PRIMARY KEY (flavr_cd);
 L   ALTER TABLE ONLY cdms.flavour_category DROP CONSTRAINT flavour_category_pk;
       cdms         postgres    false    186    186            F           2606    16754    flavour_category flavr_uniq 
   CONSTRAINT     U   ALTER TABLE ONLY flavour_category
    ADD CONSTRAINT flavr_uniq UNIQUE (flavr_name);
 C   ALTER TABLE ONLY cdms.flavour_category DROP CONSTRAINT flavr_uniq;
       cdms         postgres    false    186    186            H           2606    16412 .   packing_name_category packing_name_category_pk 
   CONSTRAINT     r   ALTER TABLE ONLY packing_name_category
    ADD CONSTRAINT packing_name_category_pk PRIMARY KEY (packing_name_cd);
 V   ALTER TABLE ONLY cdms.packing_name_category DROP CONSTRAINT packing_name_category_pk;
       cdms         postgres    false    187    187            P           2606    16425 ,   packing_qty_category packing_qty_category_pk 
   CONSTRAINT     o   ALTER TABLE ONLY packing_qty_category
    ADD CONSTRAINT packing_qty_category_pk PRIMARY KEY (packing_qty_cd);
 T   ALTER TABLE ONLY cdms.packing_qty_category DROP CONSTRAINT packing_qty_category_pk;
       cdms         postgres    false    189    189            n           2606    16630 $   prdct_breakage_dtl prdct_breakage_pk 
   CONSTRAINT     e   ALTER TABLE ONLY prdct_breakage_dtl
    ADD CONSTRAINT prdct_breakage_pk PRIMARY KEY (breakage_seq);
 L   ALTER TABLE ONLY cdms.prdct_breakage_dtl DROP CONSTRAINT prdct_breakage_pk;
       cdms         postgres    false    202    202            �           2606    16816 -   prdct_curr_price_scheme prdct_cd_crr_uniq_key 
   CONSTRAINT     g   ALTER TABLE ONLY prdct_curr_price_scheme
    ADD CONSTRAINT prdct_cd_crr_uniq_key UNIQUE (product_cd);
 U   ALTER TABLE ONLY cdms.prdct_curr_price_scheme DROP CONSTRAINT prdct_cd_crr_uniq_key;
       cdms         postgres    false    212    212            �           2606    16814 2   prdct_curr_price_scheme prdct_curr_price_scheme_pk 
   CONSTRAINT     m   ALTER TABLE ONLY prdct_curr_price_scheme
    ADD CONSTRAINT prdct_curr_price_scheme_pk PRIMARY KEY (seq_no);
 Z   ALTER TABLE ONLY cdms.prdct_curr_price_scheme DROP CONSTRAINT prdct_curr_price_scheme_pk;
       cdms         postgres    false    212    212            d           2606    16578 0   product_curr_stock_dtl product_curr_stock_dtl_pk 
   CONSTRAINT     y   ALTER TABLE ONLY product_curr_stock_dtl
    ADD CONSTRAINT product_curr_stock_dtl_pk PRIMARY KEY (prdct_stock_curr_seq);
 X   ALTER TABLE ONLY cdms.product_curr_stock_dtl DROP CONSTRAINT product_curr_stock_dtl_pk;
       cdms         postgres    false    198    198            �           2606    16760 )   beverage_product_category product_nm_uniq 
   CONSTRAINT     e   ALTER TABLE ONLY beverage_product_category
    ADD CONSTRAINT product_nm_uniq UNIQUE (product_name);
 Q   ALTER TABLE ONLY cdms.beverage_product_category DROP CONSTRAINT product_nm_uniq;
       cdms         postgres    false    209    209            �           2606    16772    purchase_dtl purchase_seq_no_pk 
   CONSTRAINT     c   ALTER TABLE ONLY purchase_dtl
    ADD CONSTRAINT purchase_seq_no_pk PRIMARY KEY (purchase_seq_no);
 G   ALTER TABLE ONLY cdms.purchase_dtl DROP CONSTRAINT purchase_seq_no_pk;
       cdms         postgres    false    210    210            �           2606    16778 ,   purchase_prdct_dtl purchased_prdct_seq_no_pk 
   CONSTRAINT     w   ALTER TABLE ONLY purchase_prdct_dtl
    ADD CONSTRAINT purchased_prdct_seq_no_pk PRIMARY KEY (purchased_prdct_seq_no);
 T   ALTER TABLE ONLY cdms.purchase_prdct_dtl DROP CONSTRAINT purchased_prdct_seq_no_pk;
       cdms         postgres    false    211    211            X           2606    16518    route_map_dtl route_map_pd 
   CONSTRAINT     W   ALTER TABLE ONLY route_map_dtl
    ADD CONSTRAINT route_map_pd PRIMARY KEY (route_cd);
 B   ALTER TABLE ONLY cdms.route_map_dtl DROP CONSTRAINT route_map_pd;
       cdms         postgres    false    192    192            j           2606    16612    sale_dtl sale_dtl_pk 
   CONSTRAINT     T   ALTER TABLE ONLY sale_dtl
    ADD CONSTRAINT sale_dtl_pk PRIMARY KEY (sale_txn_id);
 <   ALTER TABLE ONLY cdms.sale_dtl DROP CONSTRAINT sale_dtl_pk;
       cdms         postgres    false    200    200            r           2606    16640     sale_prdct_dtl sale_prdct_dtl_pk 
   CONSTRAINT     f   ALTER TABLE ONLY sale_prdct_dtl
    ADD CONSTRAINT sale_prdct_dtl_pk PRIMARY KEY (prdct_sale_txn_id);
 H   ALTER TABLE ONLY cdms.sale_prdct_dtl DROP CONSTRAINT sale_prdct_dtl_pk;
       cdms         postgres    false    204    204            x           2606    16661 3   sale_prdct_payment_detall sale_prdct_payment_dtl_pk 
   CONSTRAINT     w   ALTER TABLE ONLY sale_prdct_payment_detall
    ADD CONSTRAINT sale_prdct_payment_dtl_pk PRIMARY KEY (sale_payment_id);
 [   ALTER TABLE ONLY cdms.sale_prdct_payment_detall DROP CONSTRAINT sale_prdct_payment_dtl_pk;
       cdms         postgres    false    207    207            l           2606    16617 .   sale_prdct_scheme_dtl sale_prdct_scheme_dtl_pk 
   CONSTRAINT     t   ALTER TABLE ONLY sale_prdct_scheme_dtl
    ADD CONSTRAINT sale_prdct_scheme_dtl_pk PRIMARY KEY (alloted_scheme_id);
 V   ALTER TABLE ONLY cdms.sale_prdct_scheme_dtl DROP CONSTRAINT sale_prdct_scheme_dtl_pk;
       cdms         postgres    false    201    201            z           2606    16685    serial_no_generator seq_name_pk 
   CONSTRAINT     \   ALTER TABLE ONLY serial_no_generator
    ADD CONSTRAINT seq_name_pk PRIMARY KEY (seq_name);
 G   ALTER TABLE ONLY cdms.serial_no_generator DROP CONSTRAINT seq_name_pk;
       cdms         postgres    false    208    208            t           2606    16650     supply_records supply_records_pk 
   CONSTRAINT     b   ALTER TABLE ONLY supply_records
    ADD CONSTRAINT supply_records_pk PRIMARY KEY (supply_seq_no);
 H   ALTER TABLE ONLY cdms.supply_records DROP CONSTRAINT supply_records_pk;
       cdms         postgres    false    205    205            Z           2606    16528 #   territory_area_dtl territory_dtl_pk 
   CONSTRAINT     d   ALTER TABLE ONLY territory_area_dtl
    ADD CONSTRAINT territory_dtl_pk PRIMARY KEY (territory_cd);
 K   ALTER TABLE ONLY cdms.territory_area_dtl DROP CONSTRAINT territory_dtl_pk;
       cdms         postgres    false    193    193            v           2606    16656 8   total_supplysale_prdct_dtl total_supplysale_prdct_dtl_pk 
   CONSTRAINT     �   ALTER TABLE ONLY total_supplysale_prdct_dtl
    ADD CONSTRAINT total_supplysale_prdct_dtl_pk PRIMARY KEY (prdct_supplysale_seq);
 `   ALTER TABLE ONLY cdms.total_supplysale_prdct_dtl DROP CONSTRAINT total_supplysale_prdct_dtl_pk;
       cdms         postgres    false    206    206            h           2606    16750 %   beverage_product_group_dtl uniq_group 
   CONSTRAINT     �   ALTER TABLE ONLY beverage_product_group_dtl
    ADD CONSTRAINT uniq_group UNIQUE (filing_qty_cd1, packing_name_cd, packing_qty_cd);
 M   ALTER TABLE ONLY cdms.beverage_product_group_dtl DROP CONSTRAINT uniq_group;
       cdms         postgres    false    199    199    199    199            J           2606    16756 !   packing_name_category uniq_paking 
   CONSTRAINT     ]   ALTER TABLE ONLY packing_name_category
    ADD CONSTRAINT uniq_paking UNIQUE (packing_name);
 I   ALTER TABLE ONLY cdms.packing_name_category DROP CONSTRAINT uniq_paking;
       cdms         postgres    false    187    187            R           2606    16758 $   packing_qty_category uniq_paking_qty 
   CONSTRAINT     d   ALTER TABLE ONLY packing_qty_category
    ADD CONSTRAINT uniq_paking_qty UNIQUE (packing_quantity);
 L   ALTER TABLE ONLY cdms.packing_qty_category DROP CONSTRAINT uniq_paking_qty;
       cdms         postgres    false    189    189            \           2606    16533 !   supply_vehicle_dtl vehicle_dtl_pk 
   CONSTRAINT     `   ALTER TABLE ONLY supply_vehicle_dtl
    ADD CONSTRAINT vehicle_dtl_pk PRIMARY KEY (vehicle_cd);
 I   ALTER TABLE ONLY cdms.supply_vehicle_dtl DROP CONSTRAINT vehicle_dtl_pk;
       cdms         postgres    false    194    194            	   �   x��ұ
�0�y
G*�Kbŭ4U
��M
Bqpp�E��Ŷ6"�h���_�Kt�Ix,�-�6o�TA��W�:nK�)ʶd �J��T�=��}�F �z{�LMݕ&y���XM�D?QnQ�4s��E�P�;Pk�8<�Z���ᛇ*��(vx3g>a=|�x}�w��K�tZ�:-�����3˹����C��0��e<���f�ݔr"��M      	   K   x�320�w�q�72���1� #�?ΐ� W0ϐ3 0$ʌ��2ƪ��4ƭ��7�5E�)�mFh:b���� I�$�      		      x������ � �      	      x������ � �      	      x������ � �      	      x������ � �      	      x������ � �      	      x������ � �       	   e   x�]�1�0D�z}
_ kv�-��IZJ.���@�hʧ_'�S1@�4h�H:�)S�˶�zQ��MU#��e��v&�Ǩ�Ӝ]*�^�,��i��B;l?!}      �   �   x�s�	2 #�`OgWN#Cs]]CCS+Ss+C3=KΠĲL.7�jC� ׀`Od�V��V�&z芍9}=�<�\5|4:�������7���ܟ妜���%��y
.��p�F�h�c���� U3�      	      x������ � �      �   >   x��p5 CNw��`N#Cs]]CC+0�tv��
��4�pA�3FS���� -�      	   .   x��4 CN#N#Cs]]CC+0�tv������ ��h      	   p   x�34�4204�50�50S04�26�21�3�0��w1 NN# 64N���NA��ގ\�f����� �vS.Cs�v#cK++cS=c3#T���n@�>F��� ��%�      	   r   x�rq��w1 cN$��������r��}���Lj�}<�]C\C��L�bu�@]񎁡�n�~��F5�@�����F&
��V&fVF�z�&&�~\1z\\\ � �      
	      x������ � �      	   �   x�M��
�0���S��4i��6���]����Neco�V,���%�劫e�?UJ;��[�� ���bj2�4��0H�����Y޼���E�K/���C}�Xi�u{��<A������ ��	9��ꨈ5�d��j ������m6@�+�a�-��DWh,ؤ�5�6B|
o2}      	   w   x�}�A
�0��ur
/`yi��vYf�2�B���ft@��>��e���S[�c�h~O�cJ� P�x�a�hM^�-�D�}�rK	�	;�ᖈ���?Ap
~�#�G��a�5i�����*D5�      	      x������ � �      	      x������ � �      	      x������ � �      	      x������ � �      	      x������ � �      	   s   x�M��
�@E׹Sj��m�3V��#��_�0}�'���wܸ}v%m4X��9�U!������5�u�ʹĬIO�oE��z��KԼ|�������yY�'%%�vp ��+N      	      x������ � �      	      x������ � �      	      x������ � �      	      x������ � �     