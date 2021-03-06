PGDMP     7                    w            cdms    9.6.2    11.1 �    u	           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            v	           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            w	           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            x	           1262    24576    cdms    DATABASE     �   CREATE DATABASE cdms WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_India.1252' LC_CTYPE = 'English_India.1252';
    DROP DATABASE cdms;
             postgres    false            y	           0    0    DATABASE cdms    COMMENT     =   COMMENT ON DATABASE cdms IS 'COLD DRINKS MANAGEMENT SYSTEM';
                  postgres    false    2424                        2615    24577    cdms    SCHEMA        CREATE SCHEMA cdms;
    DROP SCHEMA cdms;
             postgres    false            z	           0    0    SCHEMA cdms    COMMENT     )   COMMENT ON SCHEMA cdms IS 'CDMS schema';
                  postgres    false    5            �            1255    24578    calculatedailystock()    FUNCTION     P  CREATE FUNCTION cdms.calculatedailystock(OUT out_status character varying) RETURNS character varying
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
 J   DROP FUNCTION cdms.calculatedailystock(OUT out_status character varying);
       cdms       postgres    false    5            �            1255    81999 $   wrong_purchase_entry_igst_updt(text)    FUNCTION     �  CREATE FUNCTION cdms.wrong_purchase_entry_igst_updt(inv text) RETURNS void
    LANGUAGE plpgsql
    AS $$
begin
update  cdms.purchase_prdct_dtl set purchase_prdct_igst=purchase_prdct_sgst+purchase_prdct_cgst
where purchase_seq_no=
(select purchase_seq_no from cdms.purchase_dtl where challan_invoice_no=inv);
update cdms.purchase_prdct_dtl set purchase_prdct_sgst=0,purchase_prdct_cgst=0
where purchase_seq_no=
(select purchase_seq_no from cdms.purchase_dtl where challan_invoice_no=inv);
end;
$$;
 =   DROP FUNCTION cdms.wrong_purchase_entry_igst_updt(inv text);
       cdms       postgres    false    5            �            1259    57344    application_users    TABLE     �   CREATE TABLE cdms.application_users (
    user_id numeric(10,0) NOT NULL,
    user_name character varying(10) NOT NULL,
    role_name character varying(20) NOT NULL,
    password character varying(20) NOT NULL
);
 #   DROP TABLE cdms.application_users;
       cdms         postgres    false    5            �            1259    24580    beverage_product_category    TABLE       CREATE TABLE cdms.beverage_product_category (
    product_cd character varying(10) NOT NULL,
    flavr_cd character varying(10) NOT NULL,
    filling_qty_cd character varying(10) NOT NULL,
    packing_name_cd character varying(10) NOT NULL,
    packing_qty_cd character varying(10) NOT NULL,
    group_name character varying(20) NOT NULL,
    product_added_dt timestamp without time zone,
    product_added_by character varying(50) NOT NULL,
    product_name character varying(50),
    hsn_code character varying(20)
);
 +   DROP TABLE cdms.beverage_product_category;
       cdms         postgres    false    5            �            1259    24583    beverage_product_group_dtl    TABLE     5  CREATE TABLE cdms.beverage_product_group_dtl (
    group_name character varying(50) NOT NULL,
    filing_qty_cd1 character varying(10),
    filling_qty_cd2 character varying(10),
    packing_name_cd character varying(10),
    packing_qty_cd character varying(10),
    group_comments character varying(100)
);
 ,   DROP TABLE cdms.beverage_product_group_dtl;
       cdms         postgres    false    5            {	           0    0     TABLE beverage_product_group_dtl    COMMENT     h   COMMENT ON TABLE cdms.beverage_product_group_dtl IS 'based on filling qty,packet qty,pakage_category,';
            cdms       postgres    false    187            �            1259    65541    claim_breakage_prdct_dtl    TABLE     �  CREATE TABLE cdms.claim_breakage_prdct_dtl (
    seq_num numeric(10,0) NOT NULL,
    header_claim_id character varying(20) NOT NULL,
    product_cd character varying(15) NOT NULL,
    product_qty_bs numeric(10,0) NOT NULL,
    cell_qty_without_bs numeric(10,0),
    mrp numeric(10,2) NOT NULL,
    basic_amt numeric(10,2) NOT NULL,
    discount_amt numeric(10,2) NOT NULL,
    taxable_amt numeric(10,2) NOT NULL,
    tax_amt numeric(10,2) NOT NULL,
    net_amt numeric(10,2) NOT NULL
);
 *   DROP TABLE cdms.claim_breakage_prdct_dtl;
       cdms         postgres    false    5            �            1259    65536    claim_header    TABLE     :  CREATE TABLE cdms.claim_header (
    claim_id character varying(10) NOT NULL,
    claim_type character varying(50) NOT NULL,
    claim_amount numeric(10,2) NOT NULL,
    linked_claim_detail_id character varying(50),
    claim_status character varying(10) NOT NULL,
    linked_company_claim_id numeric(20,0),
    approved_amount numeric(10,2),
    initiation_date timestamp without time zone NOT NULL,
    initiated_by character varying(10) NOT NULL,
    claim_approve_dt timestamp without time zone,
    give_cell_qty numeric(10,0),
    given_glass_qty numeric(10,0)
);
    DROP TABLE cdms.claim_header;
       cdms         postgres    false    5            �            1259    24586    cstmr_acnts_dtl    TABLE       CREATE TABLE cdms.cstmr_acnts_dtl (
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
 !   DROP TABLE cdms.cstmr_acnts_dtl;
       cdms         postgres    false    5            �            1259    24589 	   cstmr_dtl    TABLE     �  CREATE TABLE cdms.cstmr_dtl (
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
    DROP TABLE cdms.cstmr_dtl;
       cdms         postgres    false    5            �            1259    24592    cstmr_ledger_category    TABLE     �  CREATE TABLE cdms.cstmr_ledger_category (
    cstmr_ledger_type_cd character varying(10) NOT NULL,
    cstmr_ledger_type_name character varying(40) NOT NULL,
    ledger_curr_special_discount numeric(10,2) NOT NULL,
    cstmr_ledger_created_dt timestamp without time zone NOT NULL,
    cstmr_ledger_created_by character varying(50) NOT NULL,
    cstmr_ledger_updt_dt timestamp without time zone,
    cstmr_ledger_updt_by character varying(50)
);
 '   DROP TABLE cdms.cstmr_ledger_category;
       cdms         postgres    false    5            �            1259    24595    datewise_prdct_stock_summery    TABLE       CREATE TABLE cdms.datewise_prdct_stock_summery (
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
       cdms         postgres    false    5            |	           0    0 "   TABLE datewise_prdct_stock_summery    COMMENT     b   COMMENT ON TABLE cdms.datewise_prdct_stock_summery IS 'datewise summation of individual product';
            cdms       postgres    false    191            �            1259    24598    datewise_scheme_prdct_summery    TABLE     �  CREATE TABLE cdms.datewise_scheme_prdct_summery (
    scheme_summery_seq character varying(10) NOT NULL,
    scheme_prdct_cd character varying(10) NOT NULL,
    total_dayalloted_scheme_cs numeric(10,2) NOT NULL,
    prdct_stock_seq numeric(10,0) NOT NULL,
    allotted_to_group_name character varying(20),
    alloted_to_product_cd character varying(10),
    scheme_alloted_dt timestamp without time zone NOT NULL
);
 /   DROP TABLE cdms.datewise_scheme_prdct_summery;
       cdms         postgres    false    5            }	           0    0 #   TABLE datewise_scheme_prdct_summery    COMMENT     �   COMMENT ON TABLE cdms.datewise_scheme_prdct_summery IS 'will gonna tell info whole day alloted scheme on which product or group';
            cdms       postgres    false    192            �            1259    24601    datewise_stock_summery    TABLE     �  CREATE TABLE cdms.datewise_stock_summery (
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
       cdms         postgres    false    5            ~	           0    0    TABLE datewise_stock_summery    COMMENT     A   COMMENT ON TABLE cdms.datewise_stock_summery IS 'Master STOCK ';
            cdms       postgres    false    193            �            1259    24604    filling_qty_category    TABLE     	  CREATE TABLE cdms.filling_qty_category (
    filling_qty_cd character varying(10) NOT NULL,
    filling_qty_ml character varying(20) NOT NULL,
    filling_qty_added_dt timestamp without time zone NOT NULL,
    filling_qty_added_by character varying(50) NOT NULL
);
 &   DROP TABLE cdms.filling_qty_category;
       cdms         postgres    false    5            �            1259    73728    firm_or_seller_dtl    TABLE     �   CREATE TABLE cdms.firm_or_seller_dtl (
    firm_cd character varying(30) NOT NULL,
    firm_name character varying(100) NOT NULL,
    firm_gstn_number character varying(15) NOT NULL
);
 $   DROP TABLE cdms.firm_or_seller_dtl;
       cdms         postgres    false    5            �            1259    24607    flavour_category    TABLE     �   CREATE TABLE cdms.flavour_category (
    flavr_cd character varying(10) NOT NULL,
    flavr_name character varying(50),
    flavr_added_dt timestamp without time zone NOT NULL,
    falvr_added_by character varying(50) NOT NULL
);
 "   DROP TABLE cdms.flavour_category;
       cdms         postgres    false    5            �            1259    24610    hsn_tax_structure    TABLE     H  CREATE TABLE cdms.hsn_tax_structure (
    hsn_cd character varying(20) NOT NULL,
    hsn_discription character varying(50),
    cgst numeric(5,0) NOT NULL,
    sgst_or_igst numeric(5,0) NOT NULL,
    cess numeric(5,0) NOT NULL,
    last_added_dt timestamp without time zone NOT NULL,
    igst numeric(5,0) DEFAULT 0 NOT NULL
);
 #   DROP TABLE cdms.hsn_tax_structure;
       cdms         postgres    false    5            �            1259    81924    non_beverage_prdct_sale_dtl    TABLE     �  CREATE TABLE cdms.non_beverage_prdct_sale_dtl (
    nb_sale_invoice_no character varying(13) NOT NULL,
    seq_number character varying(15) NOT NULL,
    product_cd character varying(100) NOT NULL,
    selling_qty numeric(10,0) NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    net_base_amt numeric(10,2) NOT NULL,
    disocunt_amt numeric(10,2) NOT NULL,
    taxable_amt numeric(10,2) NOT NULL,
    sgst_rate numeric(5,2) NOT NULL,
    sgst_amt numeric(10,2) NOT NULL,
    cgst_rate numeric(5,2) NOT NULL,
    cgst_amt numeric(10,2) NOT NULL,
    igst_rate numeric(5,2),
    igst_amt numeric(10,2),
    cess_rate numeric(5,2) NOT NULL,
    cess_amt numeric(10,2) NOT NULL,
    sys_gnrtd_net_amt numeric(10,2)
);
 -   DROP TABLE cdms.non_beverage_prdct_sale_dtl;
       cdms         postgres    false    5            �            1259    81929    non_beverage_product_category    TABLE     '  CREATE TABLE cdms.non_beverage_product_category (
    non_bev_product_cd character varying(10) NOT NULL,
    product_name character varying(30) NOT NULL,
    hsn_code character varying(20),
    product_added_dt timestamp with time zone NOT NULL,
    group_name character varying(20) NOT NULL
);
 /   DROP TABLE cdms.non_beverage_product_category;
       cdms         postgres    false    5            	           0    0 /   COLUMN non_beverage_product_category.group_name    COMMENT     c   COMMENT ON COLUMN cdms.non_beverage_product_category.group_name IS 'returnable or not returnable';
            cdms       postgres    false    222            �            1259    81936    non_beverage_sale_dtl    TABLE     v  CREATE TABLE cdms.non_beverage_sale_dtl (
    nb_sale_invoice_no character varying(13) NOT NULL,
    cstmr_acnt_no character varying(10),
    cstmr_or_firm_name character varying(50) NOT NULL,
    address character varying(50) NOT NULL,
    nb_sale_dt timestamp without time zone NOT NULL,
    invoice_type character varying(3),
    cstmr_firm_gstn character varying(15)
);
 '   DROP TABLE cdms.non_beverage_sale_dtl;
       cdms         postgres    false    5            �            1259    24613    operation_monitoring    TABLE     �   CREATE TABLE cdms.operation_monitoring (
    operation_nm character varying(100) NOT NULL,
    operation_comment character varying(200),
    operation_group character varying(100),
    operation_status character varying(10) NOT NULL
);
 &   DROP TABLE cdms.operation_monitoring;
       cdms         postgres    false    5            �            1259    24616    packing_name_category    TABLE        CREATE TABLE cdms.packing_name_category (
    packing_name_cd character varying(10) NOT NULL,
    packing_name character varying(20) NOT NULL,
    paking_added__dt timestamp without time zone NOT NULL,
    paking_added_by character varying(50) NOT NULL
);
 '   DROP TABLE cdms.packing_name_category;
       cdms         postgres    false    5            �	           0    0    TABLE packing_name_category    COMMENT     e   COMMENT ON TABLE cdms.packing_name_category IS 'glass,can,minican,tropicana,frooti,slice,water,pet';
            cdms       postgres    false    198            �            1259    24619    packing_qty_category    TABLE     �   CREATE TABLE cdms.packing_qty_category (
    packing_qty_cd character varying(10) NOT NULL,
    packing_quantity numeric NOT NULL,
    packing_qty_added_dt timestamp without time zone NOT NULL,
    packing_qty_added_by character varying(50) NOT NULL
);
 &   DROP TABLE cdms.packing_qty_category;
       cdms         postgres    false    5            �            1259    24625    prdct_breakage_dtl    TABLE     �  CREATE TABLE cdms.prdct_breakage_dtl (
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
       cdms         postgres    false    5            �            1259    24631    prdct_curr_price_scheme    TABLE     �  CREATE TABLE cdms.prdct_curr_price_scheme (
    seq_no numeric(10,0) NOT NULL,
    product_cd character varying(10) NOT NULL,
    prdct_curr_price numeric(10,2),
    prdct_curr_mrp numeric(10,2),
    prdct_curr_scheme character varying(200),
    price_lastchange_dt timestamp without time zone NOT NULL,
    is_group_same_price character varying(3),
    base_price_per_cs numeric(10,2)
);
 )   DROP TABLE cdms.prdct_curr_price_scheme;
       cdms         postgres    false    5            �            1259    24634    prdct_curr_price_scheme_seq    SEQUENCE     �   CREATE SEQUENCE cdms.prdct_curr_price_scheme_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999999999999
    CACHE 1;
 0   DROP SEQUENCE cdms.prdct_curr_price_scheme_seq;
       cdms       postgres    false    5            �            1259    24636    product_instant_stock_dtl    TABLE     *  CREATE TABLE cdms.product_instant_stock_dtl (
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
 +   DROP TABLE cdms.product_instant_stock_dtl;
       cdms         postgres    false    5            �            1259    24639    purchase_dtl    TABLE     D  CREATE TABLE cdms.purchase_dtl (
    purchase_seq_no character varying(10) NOT NULL,
    challan_no character varying(15) NOT NULL,
    challan_invoice_no character varying(15) NOT NULL,
    total_purchased_glass_qty numeric(10,0) NOT NULL,
    total_return_empty_glass_qty numeric(10,0) NOT NULL,
    total_challan_amount numeric(10,2) NOT NULL,
    total_discount_amount numeric(10,2) NOT NULL,
    purchase_comment character varying(200),
    payment_method character varying(10),
    payment_id character varying(30),
    paid_amount numeric(10,2),
    challan_dt timestamp without time zone NOT NULL,
    total_prdct_qty numeric(10,0),
    payment_date date,
    firm_name character varying(200),
    firm_gstn_number character varying(20),
    return_invoice_no character varying(20),
    total_purchase_bottle_qty numeric(10,0) DEFAULT 0 NOT NULL,
    total_purchase_cell_qty numeric(10,0) DEFAULT 0 NOT NULL,
    total_return_bottle_qty numeric(10,0) DEFAULT 0 NOT NULL,
    total_return_cell_qty numeric(10,0) DEFAULT 0 NOT NULL,
    return_empty_invoice_no character varying(20)
);
    DROP TABLE cdms.purchase_dtl;
       cdms         postgres    false    5            �            1259    81941    purchase_non_beverage_prdct_dtl    TABLE     !  CREATE TABLE cdms.purchase_non_beverage_prdct_dtl (
    purchased_prdct_seq_no character varying(20) NOT NULL,
    purchase_seq_no character varying(20) NOT NULL,
    non_bev_product_cd character varying(10) NOT NULL,
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
    unit_price numeric(10,2) NOT NULL
);
 1   DROP TABLE cdms.purchase_non_beverage_prdct_dtl;
       cdms         postgres    false    5            �            1259    24642    purchase_prdct_dtl    TABLE     �  CREATE TABLE cdms.purchase_prdct_dtl (
    purchased_prdct_seq_no character varying(20) NOT NULL,
    purchase_seq_no character varying(20) NOT NULL,
    product_cd character varying(10) NOT NULL,
    purchase_prdct_qty numeric(10,0) NOT NULL,
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
    per_cs_net_price numeric(10,2) NOT NULL,
    mrp numeric(10,2)
);
 $   DROP TABLE cdms.purchase_prdct_dtl;
       cdms         postgres    false    5            �            1259    24645    route_map_dtl    TABLE     �  CREATE TABLE cdms.route_map_dtl (
    route_cd character varying(10) NOT NULL,
    route_name character varying(50) NOT NULL,
    mapped_village_id character varying(200) NOT NULL,
    route_added_dt timestamp without time zone NOT NULL,
    route_added_by character varying(50) NOT NULL,
    route_last_updt_dt timestamp without time zone,
    route_last_updt_by character varying(50)
);
    DROP TABLE cdms.route_map_dtl;
       cdms         postgres    false    5            �	           0    0    TABLE route_map_dtl    COMMENT     U   COMMENT ON TABLE cdms.route_map_dtl IS 'mapped_village_id will be comman_seperated';
            cdms       postgres    false    206            �            1259    24648    sale_breakage_dtl    TABLE       CREATE TABLE cdms.sale_breakage_dtl (
    breakage_seq numeric(10,0) NOT NULL,
    sale_invoice_no character varying(13) NOT NULL,
    breakage_dt timestamp without time zone NOT NULL,
    product_cd character varying(10) NOT NULL,
    breakage_bs numeric
);
 #   DROP TABLE cdms.sale_breakage_dtl;
       cdms         postgres    false    5            �            1259    24654    sale_dtl    TABLE     e  CREATE TABLE cdms.sale_dtl (
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
    total_scheme_discount numeric(10,2) NOT NULL,
    invoice_type character varying(3)
);
    DROP TABLE cdms.sale_dtl;
       cdms         postgres    false    5            �            1259    24662    sale_invoices_prdct_dtl    TABLE     g  CREATE TABLE cdms.sale_invoices_prdct_dtl (
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
    scheme_discnt_per_cs numeric(10,2) NOT NULL,
    igst_rate numeric(5,0),
    igst_amt numeric(10,0)
);
 )   DROP TABLE cdms.sale_invoices_prdct_dtl;
       cdms         postgres    false    5            �            1259    24665    sale_prdct_dtl    TABLE       CREATE TABLE cdms.sale_prdct_dtl (
    prdct_sale_txn_id numeric(15,0) NOT NULL,
    invoice_prdct_seq_no character varying(15) NOT NULL,
    prdct_sale_dt timestamp without time zone NOT NULL,
    prdct_cd character(10) NOT NULL,
    prdct_salling_qty numeric(10,0) NOT NULL
);
     DROP TABLE cdms.sale_prdct_dtl;
       cdms         postgres    false    5            �            1259    24668    sale_prdct_scheme_dtl    TABLE       CREATE TABLE cdms.sale_prdct_scheme_dtl (
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
 '   DROP TABLE cdms.sale_prdct_scheme_dtl;
       cdms         postgres    false    5            �	           0    0    TABLE sale_prdct_scheme_dtl    COMMENT     t   COMMENT ON TABLE cdms.sale_prdct_scheme_dtl IS 'is_pending flag will gonna tell sceme is actullay provided or not';
            cdms       postgres    false    211            �            1259    24671    serial_no_generator    TABLE     �   CREATE TABLE cdms.serial_no_generator (
    seq_name character varying(20) NOT NULL,
    seq_value numeric,
    seq_prefix character varying(20),
    seq_size numeric DEFAULT 10 NOT NULL
);
 %   DROP TABLE cdms.serial_no_generator;
       cdms         postgres    false    5            �            1259    24678    supply_records    TABLE     �  CREATE TABLE cdms.supply_records (
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
     DROP TABLE cdms.supply_records;
       cdms         postgres    false    5            �            1259    24681    supply_vehicle_dtl    TABLE       CREATE TABLE cdms.supply_vehicle_dtl (
    vehicle_cd character varying(10) NOT NULL,
    vehicle_type character varying(20) NOT NULL,
    vehicle_no character varying(20),
    vehicle_added_dt timestamp without time zone NOT NULL,
    vehicle_added_by character varying(20) NOT NULL
);
 $   DROP TABLE cdms.supply_vehicle_dtl;
       cdms         postgres    false    5            �            1259    24684    territory_area_dtl    TABLE     S  CREATE TABLE cdms.territory_area_dtl (
    territory_cd character varying(10) NOT NULL,
    territory_name character varying(20) NOT NULL,
    territory_distance numeric(10,3) NOT NULL,
    territory_added_dt timestamp without time zone NOT NULL,
    territory_added_by character varying(50) NOT NULL,
    route_cd character varying(1)
);
 $   DROP TABLE cdms.territory_area_dtl;
       cdms         postgres    false    5            �            1259    24687    total_supplysale_prdct_dtl    TABLE     �  CREATE TABLE cdms.total_supplysale_prdct_dtl (
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
       cdms         postgres    false    5            k	          0    57344    application_users 
   TABLE DATA               R   COPY cdms.application_users (user_id, user_name, role_name, password) FROM stdin;
    cdms       postgres    false    217   ��       L	          0    24580    beverage_product_category 
   TABLE DATA               �   COPY cdms.beverage_product_category (product_cd, flavr_cd, filling_qty_cd, packing_name_cd, packing_qty_cd, group_name, product_added_dt, product_added_by, product_name, hsn_code) FROM stdin;
    cdms       postgres    false    186   ��       M	          0    24583    beverage_product_group_dtl 
   TABLE DATA               �   COPY cdms.beverage_product_group_dtl (group_name, filing_qty_cd1, filling_qty_cd2, packing_name_cd, packing_qty_cd, group_comments) FROM stdin;
    cdms       postgres    false    187   ��       m	          0    65541    claim_breakage_prdct_dtl 
   TABLE DATA               �   COPY cdms.claim_breakage_prdct_dtl (seq_num, header_claim_id, product_cd, product_qty_bs, cell_qty_without_bs, mrp, basic_amt, discount_amt, taxable_amt, tax_amt, net_amt) FROM stdin;
    cdms       postgres    false    219   ��       l	          0    65536    claim_header 
   TABLE DATA               �   COPY cdms.claim_header (claim_id, claim_type, claim_amount, linked_claim_detail_id, claim_status, linked_company_claim_id, approved_amount, initiation_date, initiated_by, claim_approve_dt, give_cell_qty, given_glass_qty) FROM stdin;
    cdms       postgres    false    218   �      N	          0    24586    cstmr_acnts_dtl 
   TABLE DATA               �   COPY cdms.cstmr_acnts_dtl (cstmr_acnt_no, cstmr_id, cstmr_ledger_type_cd, acnt_opening_dt, acnt_open_by, acnt_closing_dt, acnt_closed_by, acnt_closing_due_balance, acnt_closing_due_empty_cs, acnt_closing_comments) FROM stdin;
    cdms       postgres    false    188   k      O	          0    24589 	   cstmr_dtl 
   TABLE DATA               �   COPY cdms.cstmr_dtl (cstmr_id, cstmr_fullname, cstmr_fathername, cstmr_territory, cstmr_mob_no, cstmr_email, cstmr_created_dt, cstmr_created_by, cstmr_updt_dt, cstmr_updt_by) FROM stdin;
    cdms       postgres    false    189   �      P	          0    24592    cstmr_ledger_category 
   TABLE DATA               �   COPY cdms.cstmr_ledger_category (cstmr_ledger_type_cd, cstmr_ledger_type_name, ledger_curr_special_discount, cstmr_ledger_created_dt, cstmr_ledger_created_by, cstmr_ledger_updt_dt, cstmr_ledger_updt_by) FROM stdin;
    cdms       postgres    false    190         Q	          0    24595    datewise_prdct_stock_summery 
   TABLE DATA               �  COPY cdms.datewise_prdct_stock_summery (prdct_stock_seq, prdct_stock_dt, prdct_dayopening_qty, total_prdct_daypurchase_qty, total_prdct_daysale_outscheme_qty, total_prdct_daysale_withscheme_qty, total_prdct_dayclosing_qty, total_prdct_dayscheme_qty, total_prdct_dayburst_qty, total_prdct_dayleakage_qty, total_prdct_dayopenmount_qty, total_prdct_dayshortage_qty, total_prdct_dayotherless_qty, product_adjustment, stock_serial_no, product_cd) FROM stdin;
    cdms       postgres    false    191   �      R	          0    24598    datewise_scheme_prdct_summery 
   TABLE DATA               �   COPY cdms.datewise_scheme_prdct_summery (scheme_summery_seq, scheme_prdct_cd, total_dayalloted_scheme_cs, prdct_stock_seq, allotted_to_group_name, alloted_to_product_cd, scheme_alloted_dt) FROM stdin;
    cdms       postgres    false    192   �      S	          0    24601    datewise_stock_summery 
   TABLE DATA               w  COPY cdms.datewise_stock_summery (stock_serial_no, stock_date, total_equivalent_opening_qty, total_equivalent_purchase_qty, total_equivalent_sale_qty, total_equivalent_closing_qty, empty_glasscell_purchase, empty_glasscell_sale, empty_sell_purchase, only_empty_glass_purchase, only_empty_glass_sale, total_available_empty_glasscell_qty, total_broke_glass_bottle) FROM stdin;
    cdms       postgres    false    193   �      T	          0    24604    filling_qty_category 
   TABLE DATA               x   COPY cdms.filling_qty_category (filling_qty_cd, filling_qty_ml, filling_qty_added_dt, filling_qty_added_by) FROM stdin;
    cdms       postgres    false    194         n	          0    73728    firm_or_seller_dtl 
   TABLE DATA               P   COPY cdms.firm_or_seller_dtl (firm_cd, firm_name, firm_gstn_number) FROM stdin;
    cdms       postgres    false    220   �      U	          0    24607    flavour_category 
   TABLE DATA               ^   COPY cdms.flavour_category (flavr_cd, flavr_name, flavr_added_dt, falvr_added_by) FROM stdin;
    cdms       postgres    false    195         V	          0    24610    hsn_tax_structure 
   TABLE DATA               q   COPY cdms.hsn_tax_structure (hsn_cd, hsn_discription, cgst, sgst_or_igst, cess, last_added_dt, igst) FROM stdin;
    cdms       postgres    false    196   B	      o	          0    81924    non_beverage_prdct_sale_dtl 
   TABLE DATA                 COPY cdms.non_beverage_prdct_sale_dtl (nb_sale_invoice_no, seq_number, product_cd, selling_qty, unit_price, net_base_amt, disocunt_amt, taxable_amt, sgst_rate, sgst_amt, cgst_rate, cgst_amt, igst_rate, igst_amt, cess_rate, cess_amt, sys_gnrtd_net_amt) FROM stdin;
    cdms       postgres    false    221   
      p	          0    81929    non_beverage_product_category 
   TABLE DATA                  COPY cdms.non_beverage_product_category (non_bev_product_cd, product_name, hsn_code, product_added_dt, group_name) FROM stdin;
    cdms       postgres    false    222   H      q	          0    81936    non_beverage_sale_dtl 
   TABLE DATA               �   COPY cdms.non_beverage_sale_dtl (nb_sale_invoice_no, cstmr_acnt_no, cstmr_or_firm_name, address, nb_sale_dt, invoice_type, cstmr_firm_gstn) FROM stdin;
    cdms       postgres    false    223   �      W	          0    24613    operation_monitoring 
   TABLE DATA               p   COPY cdms.operation_monitoring (operation_nm, operation_comment, operation_group, operation_status) FROM stdin;
    cdms       postgres    false    197   *      X	          0    24616    packing_name_category 
   TABLE DATA               o   COPY cdms.packing_name_category (packing_name_cd, packing_name, paking_added__dt, paking_added_by) FROM stdin;
    cdms       postgres    false    198   G      Y	          0    24619    packing_qty_category 
   TABLE DATA               z   COPY cdms.packing_qty_category (packing_qty_cd, packing_quantity, packing_qty_added_dt, packing_qty_added_by) FROM stdin;
    cdms       postgres    false    199   �      Z	          0    24625    prdct_breakage_dtl 
   TABLE DATA               �   COPY cdms.prdct_breakage_dtl (breakage_seq, breakage_dt, product_cd, open_mouth_bs, shortage_bs, seal_pack_shortage_bs, burst_bs, other_breakage_bs, breakage_source, leakage_bs) FROM stdin;
    cdms       postgres    false    200         [	          0    24631    prdct_curr_price_scheme 
   TABLE DATA               �   COPY cdms.prdct_curr_price_scheme (seq_no, product_cd, prdct_curr_price, prdct_curr_mrp, prdct_curr_scheme, price_lastchange_dt, is_group_same_price, base_price_per_cs) FROM stdin;
    cdms       postgres    false    201   �&      ]	          0    24636    product_instant_stock_dtl 
   TABLE DATA               �  COPY cdms.product_instant_stock_dtl (prdct_stock_curr_seq, prdct_stock_curr_time, product_cd, prdct_group_name, purchase_invoice_number, sale_invoice_number, prdct_opening_qty, prdct_purchase_qty, prdct_outscheme_sale_qty, prdct_distributed_scheme_qty_bs, prdct_breakage_qty_bs, prdct_curr_available_qty, prdct_mrp, offered_scheme_dtl, packate_price, curr_prdct_qty_adustment, curr_stock_processed_id) FROM stdin;
    cdms       postgres    false    203   �'      ^	          0    24639    purchase_dtl 
   TABLE DATA               �  COPY cdms.purchase_dtl (purchase_seq_no, challan_no, challan_invoice_no, total_purchased_glass_qty, total_return_empty_glass_qty, total_challan_amount, total_discount_amount, purchase_comment, payment_method, payment_id, paid_amount, challan_dt, total_prdct_qty, payment_date, firm_name, firm_gstn_number, return_invoice_no, total_purchase_bottle_qty, total_purchase_cell_qty, total_return_bottle_qty, total_return_cell_qty, return_empty_invoice_no) FROM stdin;
    cdms       postgres    false    204   8e      r	          0    81941    purchase_non_beverage_prdct_dtl 
   TABLE DATA               �  COPY cdms.purchase_non_beverage_prdct_dtl (purchased_prdct_seq_no, purchase_seq_no, non_bev_product_cd, purchase_prdct_qty, purchase_prdct_totl_base_amount, purchase_prdct_totl_discount_amnt, purchase_prdct_totl_taxable_amount, purchase_prdct_sgst, purchase_prdct_igst, purchase_prdct_cgst, purchase_prdct_cess_tax, purchase_prdct_net_amount, prdct_recieved_dt, unit_price) FROM stdin;
    cdms       postgres    false    224   Q�      _	          0    24642    purchase_prdct_dtl 
   TABLE DATA               �  COPY cdms.purchase_prdct_dtl (purchased_prdct_seq_no, purchase_seq_no, product_cd, purchase_prdct_qty, purchase_prdct_totl_base_amount, purchase_prdct_totl_discount_amnt, purchase_prdct_totl_taxable_amount, purchase_prdct_sgst, purchase_prdct_igst, purchase_prdct_cgst, purchase_prdct_cess_tax, purchase_prdct_net_amount, prdct_recieved_dt, purchase_breakage_seq, per_cs_base_price, per_cs_net_price, mrp) FROM stdin;
    cdms       postgres    false    205   H�      `	          0    24645    route_map_dtl 
   TABLE DATA               �   COPY cdms.route_map_dtl (route_cd, route_name, mapped_village_id, route_added_dt, route_added_by, route_last_updt_dt, route_last_updt_by) FROM stdin;
    cdms       postgres    false    206   �      a	          0    24648    sale_breakage_dtl 
   TABLE DATA               n   COPY cdms.sale_breakage_dtl (breakage_seq, sale_invoice_no, breakage_dt, product_cd, breakage_bs) FROM stdin;
    cdms       postgres    false    207         b	          0    24654    sale_dtl 
   TABLE DATA               �  COPY cdms.sale_dtl (sale_invoice_no, cstmr_acnt_no, cstmr_name, address, sale_dt, delivery_mode, total_deliver_bs_glass, total_return_bs_glass, total_prev_bs_glass, total_net_bs_glass, total_deliver_cell, total_return_cell, total_prev_cell, total_net_cell, sys_gnrtd_total_amount, sys_gnrtd_total_discount, total_adjustment_discount, total_amount_adjustment, total_net_actual_amount, total_prev_due_amount, paid_amount, total_net_due_amount, payment_mode, supply_seq_no, is_breakage_return, is_scheme_alloted, sale_comments, sold_by, processed_status, processed_time, curr_stock_processed_id, sale_entry_system_dt, total_scheme_discount, invoice_type) FROM stdin;
    cdms       postgres    false    208   �      c	          0    24662    sale_invoices_prdct_dtl 
   TABLE DATA               �  COPY cdms.sale_invoices_prdct_dtl (sale_invoice_no, seq_number, prdct_group_description, group_name, selling_qty, base_rate_per_cs, net_base_amt, scheme_disocunt_amt, taxable_amt, sgst_rate, sgst_amt, cgst_rate, cgst_amt, cess_rate, cess_amt, sys_gross_net_per_cs, sys_gnrtd_net_amt, sys_gnrtd_special_discount_per_cs, total_sys_gnrtd_discount, total_discnt_adjustment, total_amnt_adjustment, total_prdct_net_amt, scheme_discnt_per_cs, igst_rate, igst_amt) FROM stdin;
    cdms       postgres    false    209   u"      d	          0    24665    sale_prdct_dtl 
   TABLE DATA               {   COPY cdms.sale_prdct_dtl (prdct_sale_txn_id, invoice_prdct_seq_no, prdct_sale_dt, prdct_cd, prdct_salling_qty) FROM stdin;
    cdms       postgres    false    210   �-      e	          0    24668    sale_prdct_scheme_dtl 
   TABLE DATA               �   COPY cdms.sale_prdct_scheme_dtl (alloted_scheme_id, scheme_prdct_cd, calculated_scheme_qty_bs, given_scheme_qty_bs, old_given_scheme_bs, pending_scheme_bs, sale_invoice_no, alloted_to_group_name, alloted_to_product_cd, scheme_alloted_dt) FROM stdin;
    cdms       postgres    false    211   n2      f	          0    24671    serial_no_generator 
   TABLE DATA               V   COPY cdms.serial_no_generator (seq_name, seq_value, seq_prefix, seq_size) FROM stdin;
    cdms       postgres    false    212   3      g	          0    24678    supply_records 
   TABLE DATA               c  COPY cdms.supply_records (supply_seq_no, vehicle_cd, total_glass_bs_sent, expected_return_bs_glass, actual_return_bs_glass, total_cell_sent, expected_return_cell, actual_cell_return, lost_glass_bs_qty, lost_cell_qty, cstmr_due_glass_bs_qty, cstmr_due_cell_qty, sys_gen_total_supplysale_amnt, sys_gnrted_total_supplysale_discnt, total_supplysale_adjustment_discnt, total_supplysale_adjustment_amnt, total_net_actual_supplysale_amnt, total_cstmr_supplysale_due_amnt, total_supplysale_amnt_recieved, mismatch_amnt, supply_worker_name, supply_vehicle_exit_time, supply_vehicle_back_time, route_covered) FROM stdin;
    cdms       postgres    false    213   (4      h	          0    24681    supply_vehicle_dtl 
   TABLE DATA               t   COPY cdms.supply_vehicle_dtl (vehicle_cd, vehicle_type, vehicle_no, vehicle_added_dt, vehicle_added_by) FROM stdin;
    cdms       postgres    false    214   E4      i	          0    24684    territory_area_dtl 
   TABLE DATA               �   COPY cdms.territory_area_dtl (territory_cd, territory_name, territory_distance, territory_added_dt, territory_added_by, route_cd) FROM stdin;
    cdms       postgres    false    215   b4      j	          0    24687    total_supplysale_prdct_dtl 
   TABLE DATA               �   COPY cdms.total_supplysale_prdct_dtl (prdct_supplysale_seq, supply_seq_no, product_cd, total_sent_prdct_qty, total_selling_prdct_qty, cstmr_due_prdct_qty, expected_return_qty, actual_return_prdct_qty, prdct_lost_qty, supply_prdct_sale_time) FROM stdin;
    cdms       postgres    false    216   5      �	           0    0    prdct_curr_price_scheme_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('cdms.prdct_curr_price_scheme_seq', 29, true);
            cdms       postgres    false    202            �           2606    57348 (   application_users application_users_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY cdms.application_users
    ADD CONSTRAINT application_users_pkey PRIMARY KEY (user_id);
 P   ALTER TABLE ONLY cdms.application_users DROP CONSTRAINT application_users_pkey;
       cdms         postgres    false    217            x           2606    24691 6   beverage_product_category beverage_product_category_pk 
   CONSTRAINT     z   ALTER TABLE ONLY cdms.beverage_product_category
    ADD CONSTRAINT beverage_product_category_pk PRIMARY KEY (product_cd);
 ^   ALTER TABLE ONLY cdms.beverage_product_category DROP CONSTRAINT beverage_product_category_pk;
       cdms         postgres    false    186            ~           2606    24693 8   beverage_product_group_dtl beverage_product_group_dtl_pk 
   CONSTRAINT     |   ALTER TABLE ONLY cdms.beverage_product_group_dtl
    ADD CONSTRAINT beverage_product_group_dtl_pk PRIMARY KEY (group_name);
 `   ALTER TABLE ONLY cdms.beverage_product_group_dtl DROP CONSTRAINT beverage_product_group_dtl_pk;
       cdms         postgres    false    187            z           2606    24695 /   beverage_product_category beverage_product_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY cdms.beverage_product_category
    ADD CONSTRAINT beverage_product_uniq UNIQUE (flavr_cd, filling_qty_cd, packing_name_cd, packing_qty_cd);
 W   ALTER TABLE ONLY cdms.beverage_product_category DROP CONSTRAINT beverage_product_uniq;
       cdms         postgres    false    186    186    186    186            �           2606    65545 4   claim_breakage_prdct_dtl claim_breakage_prdct_dtl_pk 
   CONSTRAINT     u   ALTER TABLE ONLY cdms.claim_breakage_prdct_dtl
    ADD CONSTRAINT claim_breakage_prdct_dtl_pk PRIMARY KEY (seq_num);
 \   ALTER TABLE ONLY cdms.claim_breakage_prdct_dtl DROP CONSTRAINT claim_breakage_prdct_dtl_pk;
       cdms         postgres    false    219            �           2606    65540    claim_header claim_header_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY cdms.claim_header
    ADD CONSTRAINT claim_header_pkey PRIMARY KEY (claim_id);
 F   ALTER TABLE ONLY cdms.claim_header DROP CONSTRAINT claim_header_pkey;
       cdms         postgres    false    218            �           2606    24697 "   cstmr_acnts_dtl cstmr_acnts_dtl_pk 
   CONSTRAINT     i   ALTER TABLE ONLY cdms.cstmr_acnts_dtl
    ADD CONSTRAINT cstmr_acnts_dtl_pk PRIMARY KEY (cstmr_acnt_no);
 J   ALTER TABLE ONLY cdms.cstmr_acnts_dtl DROP CONSTRAINT cstmr_acnts_dtl_pk;
       cdms         postgres    false    188            �           2606    24699    cstmr_dtl cstmr_dtl_pk 
   CONSTRAINT     X   ALTER TABLE ONLY cdms.cstmr_dtl
    ADD CONSTRAINT cstmr_dtl_pk PRIMARY KEY (cstmr_id);
 >   ALTER TABLE ONLY cdms.cstmr_dtl DROP CONSTRAINT cstmr_dtl_pk;
       cdms         postgres    false    189            �           2606    24701 )   cstmr_ledger_category cstmr_ledger_cat_pk 
   CONSTRAINT     w   ALTER TABLE ONLY cdms.cstmr_ledger_category
    ADD CONSTRAINT cstmr_ledger_cat_pk PRIMARY KEY (cstmr_ledger_type_cd);
 Q   ALTER TABLE ONLY cdms.cstmr_ledger_category DROP CONSTRAINT cstmr_ledger_cat_pk;
       cdms         postgres    false    190            �           2606    24703    cstmr_dtl cstmr_uniq 
   CONSTRAINT     z   ALTER TABLE ONLY cdms.cstmr_dtl
    ADD CONSTRAINT cstmr_uniq UNIQUE (cstmr_fullname, cstmr_fathername, cstmr_territory);
 <   ALTER TABLE ONLY cdms.cstmr_dtl DROP CONSTRAINT cstmr_uniq;
       cdms         postgres    false    189    189    189            �           2606    24705 <   datewise_prdct_stock_summery datewise_prdct_stock_summery_pk 
   CONSTRAINT     �   ALTER TABLE ONLY cdms.datewise_prdct_stock_summery
    ADD CONSTRAINT datewise_prdct_stock_summery_pk PRIMARY KEY (prdct_stock_seq);
 d   ALTER TABLE ONLY cdms.datewise_prdct_stock_summery DROP CONSTRAINT datewise_prdct_stock_summery_pk;
       cdms         postgres    false    191            �           2606    24707 =   datewise_scheme_prdct_summery datewise_sceme_prdct_summery_pk 
   CONSTRAINT     �   ALTER TABLE ONLY cdms.datewise_scheme_prdct_summery
    ADD CONSTRAINT datewise_sceme_prdct_summery_pk PRIMARY KEY (scheme_summery_seq);
 e   ALTER TABLE ONLY cdms.datewise_scheme_prdct_summery DROP CONSTRAINT datewise_sceme_prdct_summery_pk;
       cdms         postgres    false    192            �           2606    24709 0   datewise_stock_summery datewise_stock_summery_pk 
   CONSTRAINT     y   ALTER TABLE ONLY cdms.datewise_stock_summery
    ADD CONSTRAINT datewise_stock_summery_pk PRIMARY KEY (stock_serial_no);
 X   ALTER TABLE ONLY cdms.datewise_stock_summery DROP CONSTRAINT datewise_stock_summery_pk;
       cdms         postgres    false    193            �           2606    24711 ,   filling_qty_category filling_qty_category_pk 
   CONSTRAINT     t   ALTER TABLE ONLY cdms.filling_qty_category
    ADD CONSTRAINT filling_qty_category_pk PRIMARY KEY (filling_qty_cd);
 T   ALTER TABLE ONLY cdms.filling_qty_category DROP CONSTRAINT filling_qty_category_pk;
       cdms         postgres    false    194            �           2606    24713 %   filling_qty_category filling_qty_uniq 
   CONSTRAINT     h   ALTER TABLE ONLY cdms.filling_qty_category
    ADD CONSTRAINT filling_qty_uniq UNIQUE (filling_qty_ml);
 M   ALTER TABLE ONLY cdms.filling_qty_category DROP CONSTRAINT filling_qty_uniq;
       cdms         postgres    false    194            �           2606    73734 (   firm_or_seller_dtl firm_gstn_number_uniq 
   CONSTRAINT     m   ALTER TABLE ONLY cdms.firm_or_seller_dtl
    ADD CONSTRAINT firm_gstn_number_uniq UNIQUE (firm_gstn_number);
 P   ALTER TABLE ONLY cdms.firm_or_seller_dtl DROP CONSTRAINT firm_gstn_number_uniq;
       cdms         postgres    false    220            �           2606    73732 )   firm_or_seller_dtl firm_or_buyer_dtl_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY cdms.firm_or_seller_dtl
    ADD CONSTRAINT firm_or_buyer_dtl_pkey PRIMARY KEY (firm_cd);
 Q   ALTER TABLE ONLY cdms.firm_or_seller_dtl DROP CONSTRAINT firm_or_buyer_dtl_pkey;
       cdms         postgres    false    220            �           2606    24715 $   flavour_category flavour_category_pk 
   CONSTRAINT     f   ALTER TABLE ONLY cdms.flavour_category
    ADD CONSTRAINT flavour_category_pk PRIMARY KEY (flavr_cd);
 L   ALTER TABLE ONLY cdms.flavour_category DROP CONSTRAINT flavour_category_pk;
       cdms         postgres    false    195            �           2606    24717    flavour_category flavr_uniq 
   CONSTRAINT     Z   ALTER TABLE ONLY cdms.flavour_category
    ADD CONSTRAINT flavr_uniq UNIQUE (flavr_name);
 C   ALTER TABLE ONLY cdms.flavour_category DROP CONSTRAINT flavr_uniq;
       cdms         postgres    false    195            �           2606    81940 $   non_beverage_sale_dtl nb_sale_dtl_pk 
   CONSTRAINT     p   ALTER TABLE ONLY cdms.non_beverage_sale_dtl
    ADD CONSTRAINT nb_sale_dtl_pk PRIMARY KEY (nb_sale_invoice_no);
 L   ALTER TABLE ONLY cdms.non_beverage_sale_dtl DROP CONSTRAINT nb_sale_dtl_pk;
       cdms         postgres    false    223            �           2606    81935 4   non_beverage_product_category nonB_product_name_uniq 
   CONSTRAINT     w   ALTER TABLE ONLY cdms.non_beverage_product_category
    ADD CONSTRAINT "nonB_product_name_uniq" UNIQUE (product_name);
 ^   ALTER TABLE ONLY cdms.non_beverage_product_category DROP CONSTRAINT "nonB_product_name_uniq";
       cdms         postgres    false    222            �           2606    81945 <   purchase_non_beverage_prdct_dtl non_beve_pur_prdct_seq_no_pk 
   CONSTRAINT     �   ALTER TABLE ONLY cdms.purchase_non_beverage_prdct_dtl
    ADD CONSTRAINT non_beve_pur_prdct_seq_no_pk PRIMARY KEY (purchased_prdct_seq_no);
 d   ALTER TABLE ONLY cdms.purchase_non_beverage_prdct_dtl DROP CONSTRAINT non_beve_pur_prdct_seq_no_pk;
       cdms         postgres    false    224            �           2606    81928 :   non_beverage_prdct_sale_dtl non_beverage_prdct_sale_dtl_pk 
   CONSTRAINT     ~   ALTER TABLE ONLY cdms.non_beverage_prdct_sale_dtl
    ADD CONSTRAINT non_beverage_prdct_sale_dtl_pk PRIMARY KEY (seq_number);
 b   ALTER TABLE ONLY cdms.non_beverage_prdct_sale_dtl DROP CONSTRAINT non_beverage_prdct_sale_dtl_pk;
       cdms         postgres    false    221            �           2606    24719 .   packing_name_category packing_name_category_pk 
   CONSTRAINT     w   ALTER TABLE ONLY cdms.packing_name_category
    ADD CONSTRAINT packing_name_category_pk PRIMARY KEY (packing_name_cd);
 V   ALTER TABLE ONLY cdms.packing_name_category DROP CONSTRAINT packing_name_category_pk;
       cdms         postgres    false    198            �           2606    24721 ,   packing_qty_category packing_qty_category_pk 
   CONSTRAINT     t   ALTER TABLE ONLY cdms.packing_qty_category
    ADD CONSTRAINT packing_qty_category_pk PRIMARY KEY (packing_qty_cd);
 T   ALTER TABLE ONLY cdms.packing_qty_category DROP CONSTRAINT packing_qty_category_pk;
       cdms         postgres    false    199            �           2606    24723 $   prdct_breakage_dtl prdct_breakage_pk 
   CONSTRAINT     j   ALTER TABLE ONLY cdms.prdct_breakage_dtl
    ADD CONSTRAINT prdct_breakage_pk PRIMARY KEY (breakage_seq);
 L   ALTER TABLE ONLY cdms.prdct_breakage_dtl DROP CONSTRAINT prdct_breakage_pk;
       cdms         postgres    false    200            �           2606    24725 2   prdct_curr_price_scheme prdct_curr_price_scheme_pk 
   CONSTRAINT     r   ALTER TABLE ONLY cdms.prdct_curr_price_scheme
    ADD CONSTRAINT prdct_curr_price_scheme_pk PRIMARY KEY (seq_no);
 Z   ALTER TABLE ONLY cdms.prdct_curr_price_scheme DROP CONSTRAINT prdct_curr_price_scheme_pk;
       cdms         postgres    false    201            �           2606    81933 +   non_beverage_product_category product_cd_pk 
   CONSTRAINT     w   ALTER TABLE ONLY cdms.non_beverage_product_category
    ADD CONSTRAINT product_cd_pk PRIMARY KEY (non_bev_product_cd);
 S   ALTER TABLE ONLY cdms.non_beverage_product_category DROP CONSTRAINT product_cd_pk;
       cdms         postgres    false    222            �           2606    24727 3   product_instant_stock_dtl product_curr_stock_dtl_pk 
   CONSTRAINT     �   ALTER TABLE ONLY cdms.product_instant_stock_dtl
    ADD CONSTRAINT product_curr_stock_dtl_pk PRIMARY KEY (prdct_stock_curr_seq);
 [   ALTER TABLE ONLY cdms.product_instant_stock_dtl DROP CONSTRAINT product_curr_stock_dtl_pk;
       cdms         postgres    false    203            |           2606    24729 )   beverage_product_category product_nm_uniq 
   CONSTRAINT     j   ALTER TABLE ONLY cdms.beverage_product_category
    ADD CONSTRAINT product_nm_uniq UNIQUE (product_name);
 Q   ALTER TABLE ONLY cdms.beverage_product_category DROP CONSTRAINT product_nm_uniq;
       cdms         postgres    false    186            �           2606    24731    purchase_dtl purchase_seq_no_pk 
   CONSTRAINT     h   ALTER TABLE ONLY cdms.purchase_dtl
    ADD CONSTRAINT purchase_seq_no_pk PRIMARY KEY (purchase_seq_no);
 G   ALTER TABLE ONLY cdms.purchase_dtl DROP CONSTRAINT purchase_seq_no_pk;
       cdms         postgres    false    204            �           2606    40961    purchase_dtl purchase_uniq 
   CONSTRAINT     m   ALTER TABLE ONLY cdms.purchase_dtl
    ADD CONSTRAINT purchase_uniq UNIQUE (challan_no, challan_invoice_no);
 B   ALTER TABLE ONLY cdms.purchase_dtl DROP CONSTRAINT purchase_uniq;
       cdms         postgres    false    204    204            �           2606    24733 ,   purchase_prdct_dtl purchased_prdct_seq_no_pk 
   CONSTRAINT     |   ALTER TABLE ONLY cdms.purchase_prdct_dtl
    ADD CONSTRAINT purchased_prdct_seq_no_pk PRIMARY KEY (purchased_prdct_seq_no);
 T   ALTER TABLE ONLY cdms.purchase_prdct_dtl DROP CONSTRAINT purchased_prdct_seq_no_pk;
       cdms         postgres    false    205            �           2606    24735    route_map_dtl route_map_pd 
   CONSTRAINT     \   ALTER TABLE ONLY cdms.route_map_dtl
    ADD CONSTRAINT route_map_pd PRIMARY KEY (route_cd);
 B   ALTER TABLE ONLY cdms.route_map_dtl DROP CONSTRAINT route_map_pd;
       cdms         postgres    false    206            �           2606    24737 &   sale_breakage_dtl sale_breakage_dtl_pc 
   CONSTRAINT     l   ALTER TABLE ONLY cdms.sale_breakage_dtl
    ADD CONSTRAINT sale_breakage_dtl_pc PRIMARY KEY (breakage_seq);
 N   ALTER TABLE ONLY cdms.sale_breakage_dtl DROP CONSTRAINT sale_breakage_dtl_pc;
       cdms         postgres    false    207            �           2606    24739    sale_dtl sale_dtl_pk 
   CONSTRAINT     ]   ALTER TABLE ONLY cdms.sale_dtl
    ADD CONSTRAINT sale_dtl_pk PRIMARY KEY (sale_invoice_no);
 <   ALTER TABLE ONLY cdms.sale_dtl DROP CONSTRAINT sale_dtl_pk;
       cdms         postgres    false    208            �           2606    24741 2   sale_invoices_prdct_dtl sale_invoices_prdct_dtl_pk 
   CONSTRAINT     v   ALTER TABLE ONLY cdms.sale_invoices_prdct_dtl
    ADD CONSTRAINT sale_invoices_prdct_dtl_pk PRIMARY KEY (seq_number);
 Z   ALTER TABLE ONLY cdms.sale_invoices_prdct_dtl DROP CONSTRAINT sale_invoices_prdct_dtl_pk;
       cdms         postgres    false    209            �           2606    24743     sale_prdct_dtl sale_prdct_dtl_pk 
   CONSTRAINT     k   ALTER TABLE ONLY cdms.sale_prdct_dtl
    ADD CONSTRAINT sale_prdct_dtl_pk PRIMARY KEY (prdct_sale_txn_id);
 H   ALTER TABLE ONLY cdms.sale_prdct_dtl DROP CONSTRAINT sale_prdct_dtl_pk;
       cdms         postgres    false    210            �           2606    24745 .   sale_prdct_scheme_dtl sale_prdct_scheme_dtl_pk 
   CONSTRAINT     y   ALTER TABLE ONLY cdms.sale_prdct_scheme_dtl
    ADD CONSTRAINT sale_prdct_scheme_dtl_pk PRIMARY KEY (alloted_scheme_id);
 V   ALTER TABLE ONLY cdms.sale_prdct_scheme_dtl DROP CONSTRAINT sale_prdct_scheme_dtl_pk;
       cdms         postgres    false    211            �           2606    24747    serial_no_generator seq_name_pk 
   CONSTRAINT     a   ALTER TABLE ONLY cdms.serial_no_generator
    ADD CONSTRAINT seq_name_pk PRIMARY KEY (seq_name);
 G   ALTER TABLE ONLY cdms.serial_no_generator DROP CONSTRAINT seq_name_pk;
       cdms         postgres    false    212            �           2606    24749     supply_records supply_records_pk 
   CONSTRAINT     g   ALTER TABLE ONLY cdms.supply_records
    ADD CONSTRAINT supply_records_pk PRIMARY KEY (supply_seq_no);
 H   ALTER TABLE ONLY cdms.supply_records DROP CONSTRAINT supply_records_pk;
       cdms         postgres    false    213            �           2606    24751 #   territory_area_dtl territory_dtl_pk 
   CONSTRAINT     i   ALTER TABLE ONLY cdms.territory_area_dtl
    ADD CONSTRAINT territory_dtl_pk PRIMARY KEY (territory_cd);
 K   ALTER TABLE ONLY cdms.territory_area_dtl DROP CONSTRAINT territory_dtl_pk;
       cdms         postgres    false    215            �           2606    24753 8   total_supplysale_prdct_dtl total_supplysale_prdct_dtl_pk 
   CONSTRAINT     �   ALTER TABLE ONLY cdms.total_supplysale_prdct_dtl
    ADD CONSTRAINT total_supplysale_prdct_dtl_pk PRIMARY KEY (prdct_supplysale_seq);
 `   ALTER TABLE ONLY cdms.total_supplysale_prdct_dtl DROP CONSTRAINT total_supplysale_prdct_dtl_pk;
       cdms         postgres    false    216            �           2606    24755 %   beverage_product_group_dtl uniq_group 
   CONSTRAINT     �   ALTER TABLE ONLY cdms.beverage_product_group_dtl
    ADD CONSTRAINT uniq_group UNIQUE (filing_qty_cd1, packing_name_cd, packing_qty_cd);
 M   ALTER TABLE ONLY cdms.beverage_product_group_dtl DROP CONSTRAINT uniq_group;
       cdms         postgres    false    187    187    187            �           2606    24757 !   packing_name_category uniq_paking 
   CONSTRAINT     b   ALTER TABLE ONLY cdms.packing_name_category
    ADD CONSTRAINT uniq_paking UNIQUE (packing_name);
 I   ALTER TABLE ONLY cdms.packing_name_category DROP CONSTRAINT uniq_paking;
       cdms         postgres    false    198            �           2606    24759 $   packing_qty_category uniq_paking_qty 
   CONSTRAINT     i   ALTER TABLE ONLY cdms.packing_qty_category
    ADD CONSTRAINT uniq_paking_qty UNIQUE (packing_quantity);
 L   ALTER TABLE ONLY cdms.packing_qty_category DROP CONSTRAINT uniq_paking_qty;
       cdms         postgres    false    199            �           2606    57350 #   application_users username_uniqcons 
   CONSTRAINT     a   ALTER TABLE ONLY cdms.application_users
    ADD CONSTRAINT username_uniqcons UNIQUE (user_name);
 K   ALTER TABLE ONLY cdms.application_users DROP CONSTRAINT username_uniqcons;
       cdms         postgres    false    217            �           2606    24761 !   supply_vehicle_dtl vehicle_dtl_pk 
   CONSTRAINT     e   ALTER TABLE ONLY cdms.supply_vehicle_dtl
    ADD CONSTRAINT vehicle_dtl_pk PRIMARY KEY (vehicle_cd);
 I   ALTER TABLE ONLY cdms.supply_vehicle_dtl DROP CONSTRAINT vehicle_dtl_pk;
       cdms         postgres    false    214            k	   0   x�3�LN�-�tv��wt��������8�2�3J���\1z\\\ ҳ�      L	     x���ϒ�@���������Xe	*뿍[���%�C��g����������u��n�d�M^�Ӯ�\��U��sW����\]
�.�4��/ܛpF���9�3�>����r�/����'Fl��X�\c���	q�.Y|�wSˠ[��B����T���d*��4�?3�Y�퓮K��s�9����\}��+�<{�hӀz6��p�B)��\'�d���XOv|��N���:6�
*���!��{����I�C�MH�]Z���ގ�k����$c� �&A���p�*��b���	�P�'�G��Q�1�*bb�wO6���S`��B��Ω��oD��-dEt�!gІ�Rm��S���i �C�賭Ɏ���*�9� ���*�',��a��B��ɔ
�>��Y�%;Ǩo�a���>k뵓\���d�j���ZB�tղ��p@E�X����٭t�����n�ull���k�C����?͊VJP��UZ6�t���jh�O+��Z���ٖZ�eh�*�SQ`:U�s&l�AC�J{o�|��JE[�`�H(�п?�M�~�~8�H����\�t9��%��fE��+|�"r	�p���"�k}z&�	�?���v�,�eF�n�I�wo�Ά�о�$�F7xr���Bz�}	�8�1{�1�fs��9�*:�Jϋ/q<;�'����}���d�.~�9�ܱ���.�nd�����)�k�&���`Ƴ�:^��:�]x	�C|��{���t�9Q��)G���aʟ�6�ц���E=&��l�'~w݁�1�Ù�N@io}b.l|S����l��4��m�^���[�<�o�;n½z
�0�4W;�}��a��Iַ~�)ϡ����^Ihx_��9C����)w( _�ħxw��{�܈�	ǯ��>�o���s��3�Xd�ܖ>6��v�(��Qz�aJ��,����9��`�S��aJ�f7�wk������Of����Ć0�c�:�z�Y��E���� �f�*7�֯X��fY�5�|mW�=�%�؅��i:��k�.�      M	   �   x����
�0���a�n6�z�J����B��-Z�&Y�)!|����{�U�9��w��lh2۷fy��o���PzD��C�)=A)�&":�bEUs ��կ��hi>��%!gC(��"E��5k�bBP'&�P�ΫD��,�EXg��I��Ax1-�i���J�NE�0bL��l&R
o��_z/�w���7!�$���      m	   �  x��Xˎ$�<g~LB|KG�{1������ԫ�\�����SE��r���������������n��^��|J�H��v�`�cpqӧ��)H���=�d�V������-ŀtF"�A�P�#�\Xd ��w0��,��pZ��[��i����d�9x9"e��P��n()]h��gE�#v�E{ؿ��r ���?�u,A9�ڎ�o|�L�С���伜#m4��R�_8 ��CА��B�c�#B�$)҇rMQ�j�\���eciCՄ#KAЃ84�r��:7�%�Y�PH.�@��6�y9 6�a��Mˠ<�O���-RS�p�uy*c;P+v�U���@H��jz�H�z��C>4�A�5��r�P�d};Px��ȥ')E�1��Ęʊ�{L�O��8Er0�+�P��a���F���� 
��XG��j�,M�dq���a}�8e�ڐ%Z��a��D��L�{������b�\�'yj��r;hPGW��ol)nʿ*.hs9^sC�к6��;x<�@���&� ��p:���ʜv/�e1��&�@:G�rW'�BO]��
�8�&y�n�˿1#Z$��U���yK�ͻ�:H��C�AY�g]���M�.U�A�M�F4bN0t���S�&�CL�)���8�8���#�]K��p�}��m�������ߪ�&�r��*�1�Pk��
��/�Sp۩4
ί���W��f�C�^��ZA�ѿ2 ��)�I��!hٞ�1n��H8h�~�'9(�5�X�o�$0���SDUfL�"ys�F>�=e��v �w/��͒!�	�p�^N&W���.>۹�r����(��h���@is�8�f)ԇ�I�j)���̀��+�e���wH��ᖒ�|^)�糱�7��(���,��,|�ъ�R$])[mVβ��$\'g0^�C���<�ֹ�-��L��n	r�W��@o�g���́�';���ksX���a���zK�~�}HM�>�	r�����g;���mv�%��seI/�W��b<Ү�M@�P1E��4�R����Kz;��jo��yh��k4��qw��i���UR�~1����+�(��ajckn��/��:�x����!���G�vk��k~m�]�+����x��z~�#c|�wj!K�$���F��G�NK����-QO�n���"0�5jG���BCM����GyJ��(� �_x��ԯ)���f|�S�[9�[�^:��1�c���k=�1�
��u�+p����(6��H�1���%��u�8�V�1���(.����#��(/�J��or}k����l������XK�~�]A�~�
a���d�.���8��
)�����W��j��`/4�<5h�u-�D}V:O�^2�}��S���yWJQh���mްVE,��K��㣂�s5(��7`R��;��)ҧY��97_�u�y���%�gޑ���PWȈf�Z]�u_8�t{��~N���-���6g�~3�zھ��K�;��}��azP      l	   �  x�u�K��0���)r�S�v�tP�E����E���6�^%�g�'?*��O�_�h������ӷ������Ժ�탸�^^�+�ZyE���f�ܾ����,�|�}�9��h�S��Z�� ���?�(�ֺ�%�Y��p�s���<����k��r,�%:���`+�q�/���4����N5��=�:���I��6�E8Z��!�}���G�b����� n�z�$���X]�^�����*�V5W��
�<��NChT(�[4~��n|�|�=��$��Z�Z=x����t�h��b,��@�9�8\�����ƺ�8:[���\ڱ�e�ѳ����c��x��=i'-�;~R�؁��Vh3�������)��O���t8�d+��I|&��U�o莞mm�	�W���љ��}��ﴧG]�{��@�Z�K����lP�Xy4��m������c2U�z�CO9�
�>��>��������$%.�M0� �l(�G'&QQ-|���*:__�<����-ߣ�� �Pt��_��I��o�x�e��v
�vʃn&E���q�)٧d����A&�Nh~�ɞ-�N@��Lj��3��9;�)fqP�f�e�B�l?-�ԕ�B�=�	H~�c
x/���{�`Ӱv_��r�����      N	   @   x�30�SN��� 0ۘ38�����=�������B��T��X���
�8�]|�9c��W� ��n      O	   R   x�s�2 cN�������ҼԢD�Ģ��S�?NN#C]S]#c#C+S+Sc=sccNg�`��?�=... 9�      P	   �   x�}�A
�0����)rüc��$J4��E������"�¿��Y����s�2���{]�4�����j&g �/
���*8Gu3t��#����kB�WcD#�\�<�<��#�(��*��We<�]���{����f�R�@�      Q	      x������ � �      R	      x������ � �      S	      x������ � �      T	   �   x���1�0����\��ٮ��F2�r�sQ��d)��O�]���0j�B;����|i���Π#�acp���i�?�)s3�C��#n�����Dk�V�+ء	=�Jx�Ag�����K/VC|t���܏��LV\�      n	   `   x�+Ύ70s��p�021�3�
�V�V	rtq
�D��*K,*͋7�pttt323��1�
�s
�SprsrtwV����qu�DS����� ��0      U	     x����n� ��ߧ�X ��nѱ�RP�6�/�,;l�?�ֺ,!�x�}���,�\
�:#�cRc�!����}�^���	2�^;=4b�E����j�4&K�Y�z	x|�	���|{��*0L����}�A���|�9����-�7B>!)��ä�d(�ɍV,Э�5Cy,V{չ���>�4zF�$�B�Q;�(Ϫ�dlJZB7�E$Hk�����vl�\[�V��������j�a�Y���;�~ZF��A%j���Y�C���;����,˾M�o      V	   �   x�u�MK1�����/����L�ւȂ�-x�R��^l��N�w&�~�?"�6�5qZ������F�&�2BTH�$:���~9����'�%����U���Η���S��XGXCnɂdS|!�};=���z$��Ė{�G����i�_V�!eU����0 tu����oan�(�Ri��F+�D��-7�y�����%V��!��=5D�      o	   
  x���˒�6E��Q�����T����@�����\�Y����}��IH!�b�`�㷿���wQ�A��6�)n�P���c�:^�~��~r�<^;�R{�+L@�����wh�z�P�y�`���K���F&��=�B���&���d�+1�K�s|r=��"���5�2d�K�)[l�A|9B��M�`,"�-�z��C�.��E��M����������T� xvU� |#"zF7x�6uTa>0��zj��?���Q"�t}�P��!�]�È%3ܑ-Ҙb����!C5
��>�X"!՜�2#�O\��*�����7�"��$��=�,��7�Q�g��aC��0�&���U���>Ȋ���T!�xc�I#F�8!�j���ɉY�xZv��J,�]�6��I�䍬��1=��~}�PoR�AfXJ��L�J��3&G��/�Po�s�ipn�(��̌9n��(�9��I���Z��`i��Z�F�s���c��J>G��D(�;�L({��h<'F��1��P���K���O�#��+2�M��W�Pf�8ջ��$G�'$}��8Nm��ӗ���`TO2����Ս�ֆ=y�4]�mC������5BDۆ�Sc͓�v��3[#3����	�G(�yX�͌�j���^�@�5q4!a�xC��E�kˣˍ�L��&�:���� �YsHdy��Ăb��V�DϵT!I�l�����,J񊰫c$�9�X��S(u��0���2b� r�c��P�Xω$g���a�)D�=�"�B�y��1/I۶a�	���^=a�w���iNk�zM����GG����z�w%�`ӆe֟yY����,΃�l�xB�]U���v�0�c�U�]1��PrfM�t�5e��:^WǺk�.�qV�,� ���gN��q�>d�c�B�3Z�Dʈ����"���XRa�8mqvul1�B{D+�[��j�Ä��^U)�yUU5�������F,��sre�_��Y́�b����Wɩ�Ϭ��|hUIƫw�$��&o�I��Q��|��|�A�0��mAI��	�z�k�s�u�#�nb�E/ޘƂ8�� �/��C�d�)� ���R��<�ȼew��I'��,�s�U�U�0��kAо�o���kA�؊s�Nc��B�-�1}-m�ق�Y}-o��iz���u��͑�|p���ǛXO����z�=�lLcA?~N)i�V���&Icڅ�Oo�@�[�b��^�t��u��d�lŋ�Yo�4$����/�PG~�r�b��Q�C�)W�݂����M'�_?���v���O��#/B��t��y?�h�q�؋zǍ��Ջ�:.h��W�b(1����}�X�P*0��S��kb=X�x�Ֆ�gf���s{8i_y�ӯG���P�y"n�	�����G����� ZMl�@oE�<��u�5��V���"�f�L[�L��"N�>������]��i�����U̮G`��d4��B�bT�cY!@� \�{�c}@��Q�'YA�:/���R��
j����V��}��>z����^۠Λ@����5��I�t-�9���?�Y�_
%�ŗfI�	}@�w�Qo�r� �z[P�s�4jHJ�0���¨��:�ș�z�j���aX�\�aC�;?	��Xo��"��f�d%�Z��WE�i*����ս�P[�<Z�]%)V�ob��������Q�R7�+y	���B��H�C�6�u6#ҭv�|�!=�!���Q)�G��P�%�L���>����C2eí&��'F�����νY�����]��b�o�:�vGz(��&��so6��&�뵧��\�y<*�����ATGr Hz���|�:�KB�݌�mF��Dw3h�6#�O�wRԠ�I�V�{�KP礈���ی�ٌ$����lF��íhZf�^`�y��`�c�`wt�.0I�s[���N�M�!��)C9B�Z�Nr�4������M;�PtT��[�4�q�2�_ݨ�s?!H��V�(l�ﴇr�3�zm.�\�:�J�؊��B.�7���T�[�tcT3��e�j�D��̣����tی�ڻU�v�fv�v�PG#�L{�V�S@v����ۉ���J���7�S�1Y���$��7�1�T�@s�S��::�\T��E�%�^f�$)���z���S�=�9,3���c��N�B�͌F���E�:��>N Z��E�Z���Ԃ�̨A�3��ƌb�u}�s��P�H�8��XE"[dטƋ�z��|1�j}�ɞ��;sK�3S��wbԠΉQ����uN���(��_���?ʄk+��`��C��5\��w՘�3�-��A���9�1*���rk[��,Sܹz/��y�e��S�H*�.tu�&kʽ&+ց�̑{����kk,��9Թ&�%+^�Ɩ��NLIQ��)�ۋ�و�;FQ��c��c�yQ�:�EIK=�ͨA��(�0���x@}��{���/?�/4h���s&l��g
&��c�:b�ۗZ�EQV��S�W���*���u6b���@c��������/ �T      p	   e   x�]�1�0��9EwD�c'����F����OzK��u����&`_ F�ڇ�����Ǩ��C*����L�<�Fb,O�"�-k���;�ň�      q	   ]  x����NMů�S�0����wۂ
��*�V������ޔH<;_�U%~�x||�w�����������0=��������ߖ��n��^��F�ױ^C�b�#�@!���������_*�����ac�����#�L3�J���l���}�>2�yNy�Q��.�eF���>�.�`����q���H!g��.3�<�@�)ϐBj���~.��������������x�����f��������~�tw�k��?~Ng.s����eY>��\�#�y9���}���k��i�:K�a������L�&`�I�~1� S�@�1J.��f�����K�Y:�:2MT"ؔCE��
��F��?jnލ�3;�̈3aH�3��S�?,E�6i����������%��9UѮ{Vބlב�c�f����_h��w�P |���7L�k��搸��m�hւ�����fы��]f�&.�V��Qg`���,K��J*n���u�������"��E���t�Z�K���$���րRP!��=#���UO�����Э�����A���j-#�]]Kf ��_�-�i��A6{M:X:}ж�vS��4��M����mq�f�fL��|��`o��㚑��CN~��Q��F���:��jSr��П�CNCd�:W=s->�M��Y��M��s�{I�v�=p���?x�;���ڜ�&�V��?|�&�	���1���v���CI�����q��l&��&���B<�j�B�i/f�	w�@��j
�f�I��.��&��).a�^�d��9h���6wQ�P 7~@ܔ��YiN��}S��*�}�V��(2H�o��NlB��������NkՑk�y�����F��2 s]*�P�; :�1��ã=�(�-tR�{jBm�
�S;;�Z�'��z#.�u��F 3����(4po6�l$Jki����=lGd'�t�X���:��ͽ� n����F%�ve$�����nm]���-X|晪�B=Lۋ܎u��̺�&i0��p��@GX�M�j /���� ��r���Z\�ʊ���K�"�|ٞ���Ѝ�qm��Y��[��"J����F�n^p5�f�I�B�<�9!��u�q���Zp`5���N�݅����]'�AR��L[����D�tbB�A[��J�:�H�0�*����J���r{�S���3��2��)�ˏ\����kW�iˈ���[ɫ-IS����m�J�71��U0tj�U|FVɺ	���x��Vp��CqR�bt���ޅ�����ؤ���_��OL�DU��/��y�c��\ۭ�����t���YB��Y�/6�-ҙ���1�kH�j�'db}~@�+3(��hb�/�4 L�ͼ���n�����S\=5�ĝb(���[h��s���S��0�j@��xH��vO��� �wrR�J�h���_gR��Xlj���x����,{�ح�B/Щŀ Wr�-"���x< @��!���	)��H�'��*=��:��=Δ����Ng(�l�&%S�3wnp@�tt,=�I�y@�d��o8d�Hn�ٞ�ƥ�S#(�l�&}$S�;Q/��J�J��|������u�-      W	      x������ � �      X	   Q   x��p5 CNw��`N#Cs]K]#+0�tv��
��4�p!B�1���B�	.u&�!�!A���h*c���� �)"�      Y	   Y   x��4 CN#N#Cs]K]#+0�tv��
�)3�44"B�1�%�L8�@�,t�uMp)3�44)�kd��,F��� ��'M      Z	   �
  x���I�.����N�x�8i���Yd��@���I�U*ɮ2�{�I%�3���O�?3|�vP9�R���_���o�~��+~��������_���W�Q��A*�1��q(⁔�������v��7��#�/�[�:�'�es~�u]śn�3�7��`N�y���;��o�$����:���F�ã~}���x�|PO����#�o������=�{�p���G�#Sj]bru�������T	b����7��TR�-tx�/O����j/�+^����g֫�� ��-/r������"M����3�	c7���v�*��e��T&ˁ��
c��˅C�F�t���v��8�EO�1��6q1�%�~�������	��Kj��d��_�d0=�S�p��nw�����RyX��;2k�קk����m�t������O^�-��%N\k��d�݄�Y,i������d�Ą��c9DTv)x���*}@�j�����վ���;/ϟ�y��j���6^��$�]>Oكb�kȩ���e�)|�of��a�煗��?����2?�S���W�A�2D�/_<��TVg���;�~�h�>h�xJ63��s8��_ޯ<����\��:[���2�_��W{>P�A��x��M��߅��a�q�m��q��g�\��_V�C�'|�:j�Ă��D���� �����}�x�3��܂�+�Ϋ�o�#(�����QU���Ɠ>��_n����+y�=ñ(}���ۗ)z�Us�j�ħ��A�'���@�������5#��;�N��L1�Qd����|�[��×g���u�u�i�敶���s�Ē��7\eG�����	�y�Yc]�z��ѨS찘ԳG�[����7����*-�=���Q�7�����Íz<�W���4XĘ�՛�uOs��m^3���?eO�ϒs3���̷�7��0�]���1ǫ}�Ѳ�D2=�����-o��=�4��j9f_���q����VB��ц��ܮ�~�����f�F���1�Afz�\<V���F�t٭n<��Ÿ�r���~��])!������(�����y�IO��`����O� ���ㆣ� !�Lg��2V�8��%*h�S$�t���3�ER���ݗ�/&�1����[�ރazo�Y���D�N�oY��_�������!�e�GI6�B�mFs���߾ ���ޞ)�|�t+m6X=���-`�ݚ�6y:���A_��[8h}!�e�ju:4�<�[a�n��+,:�v���^������}[��=�0V�?��0�*���X��Ձ��	 6��U��b����O��hd]�+�����^8y���` W��Z�,��N���_ �x�(B�������\ �`���QU�z�f��E��!����Ս��}�|�+�VU.=��
q��}U��0P�}��=Ʋ, f	4�`  X7��0��Cl�jΊ�1QSr��ԟ�����|�W���-������_"z(�ih[;6��?T����,����,`�#��m���	x��{b��0�d��	{��e����*8[��e�)��B@��G��{U����ZdR�$V=���?p��F��-�}i��7o�����ϟU�O�J�
��_��k+%�`�������hJ�^���٤f�[T�����G�������f�D�x̂\��'��-E�o��g�C��?�?�'�����q���*)���ښ��S��"r(�B��Cp�=����j�_���g��1��j����)~ַ�6*A��`���/u��6�N���>�Ϭ���U����s$)S�l��˰V��`�d
 ����/����)��-���gCJ��)�c���Y5�h�
�Bo��Zc�� ݦ.>��/�N/<M�˩X�3e�jt�`U�A��rW#�{f��d��g�/���@���z����J���Z�^���!���Z �'��P �W7���R�������S�����RP�:p(���8E��P� �~B�d$I��@�h*<�X6n,k����
6�4̪���φ���=\�*�<���!`�7���%��~����T0�X7Ά��^��f<a� ��]��'��Ń_�����p}6���zq[���ɟe5��������� '�����Zc�o�0�nS�pt���>�6�o�>�́ڔ?��g1��-�Ý- ���M���l	ϟ��AP�A�� �v�$�ڹ	0�?Ξ���-�����)`��L���ނ9�� ��|P��I��P��]�}[���~�m���TLX�����O�*�&�A�;;�c�f?�rJ���O�;62L�r�~�� c���~<���2��p��j x���68��gGW����|�O�%8�;�߼���5	�O=���u��T��\��?�����`	GG`�.����8:�/�"V=��h޳P� R�����p���x�����0y�a�^Cy�����P�mɞ1d?��Y��Q�$�����Sd����d�����~�b=]�r�#~��p݇�_�_'��5$$U�?�ɏ:���`�/��{'��H�|`����*��0���X�!���C�|q�7ƙ����qL`v�Ap	^�������٠�L����>Ģ$�|�D�j��Ģo$��諓��K,�A����[q<I*?�䫕�l����*?�Y�Ȃ_���R]�f�[�����~���H��y      [	   �   x���=� �N������s[u���QZ(�@���٦�����E�P�C1(8Cyc*>D�)��^���!���������/N�� O�0NIa�,�ݔqS�~ʸ���0�c	[7XFĨDNh�(����E�#�\���g`/���[���)��      ]	      x�����,�m���O�^��Ա��`dN.���EJ�]%J̓~�x�1^ïU%��!���_!�5��P_�_H������_��'�$�������?�����p�-��ǟ�������������2!� �?�#Ĩ�L( .��g�B���"8r��R��+�h2�����A�� ��������?��_�/�#W�3R��և��㜯������_M��p�DP9�~��&��$�W��E6�MYZX��"#)�����Z++��0Ή������_�8�����o�		�� }�uB� U��ԗ�h����M�_7���7¡�~���ک~џ�H�#�Y_	AD�0,҅������MA�jP& #�K���o���?B�O��6>R��Q�϶��;�,���2b�G���_���9����(+[:��[Y�8^�\OU�k�_�^���\m�Zy�a��XeF3}~h�ajC�	�U8N���JAFdt�bw2��g�4�D(3*	{������H���Q������K���E���9�Ӡ���))��+�@�Ӡ� ��F�A �B�N"�ڌה�GQdDDC5FQĘ�s�,�%��ABS�7���� �P�s� L |��v`*��T��͋5�eDޙ�oD�� ����XcT�۝�Y�JC�7������֥���}IW��e�ܝ'n_�� �R*�|���g�4	�T�iL2�__^!�G{K5A���\�)ʈ�]�!̽;%]_G�h]�S��60���( �-U����ڧ����Rm�~W�ص�e�W�h�i������q,�V�����@�N3-d�re˒�( �Ku����R3��5�����H����sL*Y�$��/^��mNIV �9���5��\d�i�_6��yժ�[���.�����y���H�T���0��B
·��Q�&MK��=��R�6~$�jJ-����[+��H2"nk� �S�eP��A�Ԣ���C������8�e�%�5��H¿�Ӽ����Sʮ^d��cc=�� #�
�x,L�'TAf0?�P��NsN��+�`e�"c�$6�m>�iP��(�7 9"��^y"��	O.�r�֬�0έ��O
>k&�,�m%�f�!�*����Je��w�@/���\N	7v� �����6��A0��
�m��EX��H&��s���$�E�0&��bb KZR�	�w�gE~���`�LH�c�/#�pnu��m�x�_��\�bU����&tn�2�z�< dxO ��|��l$0�.ê�@s/?�`?��έ��Cza>�4vm��oC�2@�2��:�Z'�")vq�ۃ�
��b��Ȍ��	$ԯ@�q��a1�B`Z';�w'�L'�1��f (⣧��YZC�!��k��p����fvw3v>���p��e
��3n> Q�ˈ΋�EH
��if�*dPsxPd�w:�9 s�`����=�C��M.���%�ļa�Afl�Af���H���?���@��2z�L�Sw�ӹ=�#���\�,�2#���a�3&��_S�Ǒ�CQ\�a�uXdD٘�/O2�iy��Q��H:Z�-�
�c�Do/�B�M��1��O�e,3���P �ʎ��qo�$@!x����#�PpGt �z����~m/LG榁�z��6�)�2���2�ff�)i����R@5�|����AY�����1'��Y2{����!���U<�������w�L��>E���ɂٛ��'��3Y0{+N�\suGPĒ�(��iC0*��f�V	DR��������(Kn�X���8)r5���`3��	u�G}Z7��q�}�
�l �^d�S�p����4,c��P�"��,�����`V��`sLA�����,(�=�1�'_��H(3��/?0B?h�A�� ?�ﮦ'���֣»�Ν��ܛ��0�R(A)�a_�Ҫ�7÷	c�]���U�?��{�����q0��_=�
{RZ�Yi�|��C�v�#�����3��r0��
��ň���<�Ӻ���^���g�a����w���G/�<.�d��9ݙd@s���bD�Q}����[��=��S�7:rtϥ
�m$9ˌZ���Ȁ�ކ9�4� z�U�T�$��b�&"Jp��9�r0�����J����*�����"��d挄���.j/��<v߳`��Ք!�@�0ny�Q�H��C�Tkh��{h+��|3�iܖ� �wBrp��~%� fw���VB)
��S�S!���Re �� C<ֹ���0�~�j���n 5��}�x�� �FUq��VT��3ͫ$Cx
�1���:~��Rrr���u���L�������������v}]�dƪ�����%RW=��G�3�uC���4=wGg�P��?�9�6��~[�)��Wc���@��"p�O�
�9˖�l���rؚ�\��~xN�`��<&hQ&���.�,BRc�/7�M�����H����n�$�s�cOEب
S�Խr'�����Ρњ��yh0�yh`2���dɁ"ڞaE�c@��d�i��DЄH�ޗKt�lm��!�������4��$SȽ
�$��x� 37��[���3EF���n&���#Ryѹ��a�����!��Ɉ�Ҍь=!(ߐf{�d��e���s��'�V4) '�iXfB��*���tu*
m!$����do:g�:d��1�a�E�x��b]g�B(��� ����d�,<G��m��Y�단^C�8����yL�(�L2������T�+����,�X�l��c1*��F��I��Qb;"��Jq˥��eFu�r�}R`Q�kc4�ʊXe�ӋU+8º�"6�.�r�1����A�VH	S�z��Z�{���2G�@�����f��p�J�>�(ʈ�$�s�i�Z��𼻄���L�Ԛ'�/�y�Y�d�.H��1�T!����ܙ`!����y����� ���� ։�"�e-To �Z��Rc�G��D/e�l}�����P~���sw��R��;.>Ai�gV� ����C�	P[)�[�.���$�DN��B0 Y��H�'��e��,2�����b{U0�h�5�� b|�z$?�#�2��	[[^N'�V����w�1�}ޥU�oD��q��a�V���;��QL�f������3�KJ�!�6��LI�x�a�a���z@~�Bh5�c����d���(?1��|�d��0�tq�����&"b w�N_J'���VaZ�yR�^�Sp�ʖ�h��"��L�E~��Γ~�Jl��(�{�O�~φh��(3�;�m/E �P���[_)���lE]��0��*�,#6�H`���\dۦ�Z���s����4o��rފ�e��ח`&�an2�Y�Ş���y9���%o�Š=�Aa_���y��Up~!�פB
�:��y��(�\�~${�ӂ��ٮ���q�j~�
���/�;c�!�����+��b���7֎:�-X��=]��� L�v!؏�5(�g!X����Q��ڲ�e�p;VT�%�0� ��@�V��y�0�Y�2���)�� ��TM
`��oo����dE����|P �\�� L�]�U�v+�i�C����f����ʹ��s��M�9��m�-��~����Z�\��y�^����;`%���U�j�;��z.V�Fo"Ɉf�a^ΒmL��'R�4@j�S�.J��'3��`�b�c��b|تH�՞�����ؚL��٘aL��@����4C��s�Oݨ�7��r��a���z�G��&T��EGD��RU���"����!_�B($E>i{�N �u@!+�=�#z�����%��o���~(�Ѽj�)T���s��rSh Q�j�O^�#���a�a�}.�qC'@����;�G�@��3|G*-�oG@
��<� ,K� ���JyN%�M(���%H
�.ļ0��@���?�0��s�n�
V��    �9{����1���e�&G���B[Mc��)�I�0�y�$
�z�_��L2�|��  9�,@c"�B���;]�3�;,?�h9�	�
���-�o��x`�M(L
��Y�zc�NQ�a��Y��:I!��V�C�a+���ʌ�߼�|��6��D��PPH�/d�,�lq���� �p^��()��.��v�zx��~�!l=*��0�_�S)*��칌`y���0Ks�C��Ne���M���VR)=�Uɱ� Ϯ
�3�^$o�3��4�hb �h�U�o��� ��󫄸j�M`�U�x3Ya�W�>o1�Ű-]Q��g�U�o�Y�wA��_\�:RW���v��4�1O�A�j���.�]�X��~9�a�h��z3�L:�P`�j���3���3�Ea�[g��ɉ�͐��嬯&�x!���`^aY���zm�쬡�H=2ogNX��� �rF��;����k�0��O�ROKSv����p��{��N�6Chw��=w4�Y�[��b:Jޘ�y�Е�d��==�;�������a+��R���O[�S&5��\�_)�����<S�����ߒ~�]�c`�d�wOgۮΤ��+v��O,���O�4��l���v�,�m�p��W(�°��Ŵ� f	}���Pd Ͻ����* �E}ź����P�h��ވغ��5{3ҞM�"�&F�w��0~�E�����:�b�V���P�	3v)�N��}є	Q&�e�fƀ�f�!����y�h���S�j9���t�����H��f�b>�~��bT���4{�1%l
�WBΰ��ҶP�]��G#y��NF�٨����hO7�%V��@�� �����'�m%��tanWOD�B����V�
z��շ�JA�|$�1������e��ˏ�OD�
P{��kբ��BH�c)^����Ԭǣ/�8b�E�Z�.���"^��� � ����<0D�8!1�j�ZtE(Gk/[�ٙ����Ĉ����H̡.۳�ǟ>{��2�{�Ek����M$w�f�1(G*z���h#�`��B�?�D`��,�֌H�ڙ ��a�i�4bT,���]�B�ǐ��&D X�	�BpCm�<�#����+�x8�X��p�wI)H.b[�;)�������b��0�N Þ
��
:5�Z ��%*�o��V������������WZ��F��
�˔U���G�vq���nE�V���O�1ƫ�2竂���A�X�H��G�w�jV��i+C-Ҫ������d�޽�a>���-$��ˣd�Ǹ�w
���^m�{\��|�U�o�{fp�uA�q��7"/&���}1�J��+��w:Z��k:d�����|�B�V�n����?{�1l[*���0��ܦ��9����2 �~�(��~� �;��˶�p�BɎ���ݜ�h�A8,Ȅ����1Ի7dW�C:k{)վ�}��̅�-�P�d�֏��aD��P�n�S�!v����c�7�>��f�bˊO��=�3��ܷ*��,�T
���l�h��,wv���;��h�V��ɖ�HR��+�$��p/��1�D�{e\ �z1��p�P�Q0���L
�=R��X���1G���*sfko�IF0����+d'�U�{vp��2hsa�E�V��WU�)�g��t^��4�R9m��� ��-�Z~3\��3�n���*�i� !إ�/H���%�������p��9��VeU��l1 �#LRY��C��Ce��&��}�J�gBs*V���s&^������G��j��N� ��]f�n=Q*���Rj�r!2;[-D�D����J�a������_o}e͋�A��%�O�~\qA`?��TNm�����J
�!���_����<� �l��;��@��&+$�q�]Ù�? ��s/8I}нԻ_,�WF�Z��W��fׄ�YXV�N���c�|�mU�7�9�T^*�ȟ��l��7���қ�@o��`�qH�
��ڋ5��RxDp#�Qڊ��e�إ&��^X��[�mb�Y��E�՚�ǿz- /H¯�WH����η�
�����يBɛ���x�B��6�>�����Jy�J�K�2[��16�<� �@�&ݕ�Q�mZ�����zğg���89��û�m;�a�������k��#S�v9 ���q���6�ޣ>�"���d@SK�&Oʭ��j�O�~V� 7�eq馧��(��EnBӂ�9Os��nx����&�P�N��k�"/$���N�Hz��� �x'X.���Y蹨9����ȃh=v��hWs�76��SddA�1�����D�-��:���J�X	2�J� Vq�QxW�m@Y�N$ �g�y!�Ʈ��V h���Dt�%X�����촘�(e�כu�I�jvL��x��ϡԑAl&|%X�����$1�-���!��mª�7!z�1 ��U�o@�c��v�2�)xO�-B�2��ʝ?�:QU-�Q�պ&L��D$?�Q{�`�Qd���{É�O�������똴�gY�9���lJaU�� �5'��ɀ�k�C����M�����@��Q��N4t�7=N�+'���,�����V_�D������|��m�(��t�`�L`�I�t��BY���)%q[~��[��~"����"�A��1-Wj���]!��\c�,zCL���`�GL�� +�<EY��[�w�U�<EI��T���	~�-c��"��v���ǚ7����±�9��T�U���5ۍ��j�-��I�h��"�Uq?��rK�f$_���ޢ�������Y���w=��銳~�Z��t
�h�B0D;�,R�E�y�b:�9��-C��* 7ktAX��c���,���$��%�s���R^�#w�+��
m�@�T��_g�fOu���Z~T?�-��=0�RZ�;a�D��-��u+!=�U�oFQ�&�0#Pf���a�l���U���S
���Y?�j�/�u^�ڳ�:�V&�R7k<q�3���z`6N�OI��̐r�	�V<%ۄ����t�� ��}�`�Ť\e�WSv����4�QS6�0J��8��+/��N�j* "���l�
ʄ���sƈ�_S��҃���xʎ[h/U/��0|O+cx{nI
��{.��{T�+�� ��~�6�2F�8��9)2����nV�@���T�`�)R�.?^�"�OE�n�V;�z��1��T��S��c�Ǯ�b�Z�BŴU�/U]�&�O2�n�c���B��{�y�+퓥���T����-ƨ=�ʘ��@�nl�an�5+��0�o�� ��3au�I�r���?+�����]Vj@J�L�)�]�@��z����H�N�4s}!�R �Rj @���&�I��8dd�h��T:��y�2@o�i�A��� X���G��<�� ��[Gde"n�.=���R�/�jdc�}&���	?� �.+S�`>�OI�b>�?ag�hc��d���p�U��7[1��	/��vM��9�N�I~���z�!ج#��0�U���6D;�-�A��
�D�н.��e�Ky��[D�Z�|H�?HV��f���UW�Z��!R�O�VL�@�i�6�PJa8�����ê����q��C���aU�[���~����)!�ʈ�Ч�A�	�
�g@E�	4D{�$�9�S�>����Q����ϑ�=B������FI1{6��pK�s�����E�T�~gUV�I6��(L@S n��<��A!dŖ �)���� v|Jń��d�_շ������{N���,�RF��t鄜v�~�LO@k�*9�3E�ʮ]�P�n�ퟔ���/����f�'�1>�Lؼ0����i���Gs*G1�?��Q�|BE��y�^Ft&�$ӵ0�AF���*���r�)�.ř�,[��2�V��Li�������ۘ[
_F���2��/���
�Ȕ�P�^�!7�a�kT [��u��dB�7`�.1( ���0��"?嫛N�V�9���7�(3��[��h�︡ �`ƭ�5�C>�j��    tE1
a"�Zg�N�)��A� ��zx�FQ�����L�XeJ��zbX�����T�I���), ��n �{9<���d����'���	��t��ԙ��ܣ��N��n��e$ŅB�{dr��lOJ��������RZ&� iU�7��}' �i_��F�Yzd�NX5<^E�[�d��vF�j��`�f�lb��ϼ*��ؘpư��r^U�C�{�~2����H�^�~�z�}�,)Y~��y�;^U��j|ٲW��F{�s0�)��1 �����sR(��wbܯ�EzR�9O�ګ8G�;W-I��:�9Yt�cB�hgUE�
2D?>%Y�"Z-�;$�K��Er?��y���u˸)�I��G�mTD�'tzD�^�B�l��Fk��{vd��h�g���)I�����3dl��Uo��e�}#D �U��b9R�_s��K��U?�����T�W��w��r�6nދu�5Ȣ��|�GQt��֐l�把`���)�$�˼��W�FY2���|ȵ"?sM�X�����,ˍ����@�V��W�$QO	A��^�9=�*)�/�A[��P���$zhkS ,�4.` �[OnA��N�m�2A߫t����S�;Bw�u[z�;�K����Ec���Yd��0D�����jy�!��5�O(�[�U��G$Z[x���˲�"�8�٢6=�7��W׎����n{q!O���B�'����'���2X��#�fdDy�qn������Eh���� ���2歷d�_%�B[�Ԩe")�%�"�5�Ɏ|�\BT Z<ɏ�> ຆ��9Rª�;��۷�m�a����\��\����}��[���D�.�Vm��f%��M�lE�X����9��`��)�jn/�y�g��?�[���R`U�[�q�)[��V-�������E?[���caB82���gy�''[�$��V�J�x�+�E��Ky�c򭜨E�]L~*c ��-0���9 �f�n�74YtU#�w%c�%�/�C���T�ƞ5~�S�K\�t�Fi?$w�Z$Y4���C�]0���RH=�j�vX��R�&Q��4D���W�Ev�JG1<Ҭș��`Qd�4C���c�g��a?�<{�-�)� My7_���l-d�������I$Xd�gq��F��T�L�!Td뗎!�9ؤ�i!���g+�+�p0��UI�P%O�x돎�����ic�dc/*�Io�X|jʪN�BY0�]�H.�BE�_�I� �L
U�5.�b�b�&�^N:Al�]b	���舞�+1�3�+	�#d�lJI{�҈�h0~>mk@$E��s��M2FY�Z�q��2JL�\�^Dw�2Um�".��zp���&�Ȣ���!�l�PbUD�9/�?�)��L�!�47SX��܌E��{*�g&�,.TN���I�0X��\c�DGI4!����
z�^�[�v%EYt�k��V��44O����hU�)�]�=%eY2�a�5����t�Em�c���/�J�p5����XH=���f��&K֭�G���9�r�qM?���w%�D��)�ލ�mGXC����_2��J^;a?O�<Գ����������W(�<�(2
;����1�E����{�N��rI�".���6^��8��2'%�Ex
��9o�c��Duˎ�UA�� &c��d@�4��!�SP�B�}��!�ݕ�T;]6����p%�QAl$��N�_��O�y�&[���E��B���n&�nF]J����}�?�)�e
�Ļp�����,JF���5��H��J�����Sѫ4;��S�u7�����,Mf�J�R�鄰^�K2A��|�� �Fc�g2(�����Ae��zf\�rs��bBԽc�FY�S0${;A�J�˚J?	�V��!��m�K�f�a�b��@���<���7���^ӵR�,�h0D??[<ck�E���C���x"���b�_t�ޱ|�u/�<!K�h�,juKT�/f�FE4����	�ds>qJ��)`u���8$_F���V*��_;˓�dD �'^�P�}i�.����z��όڟ=+��D ��ky��nBo�]���[������6ڽ	�E�|��Ѻv�-OML;���w�8R�/�ݣ�m6����Ӵ�fX�5[���f�Y������'�wY4ɢ�OR6������q}o@���e�mUC�E�PC����b���]E����Ýb=��PDф��vH6���,��qȵ��54E��Xb��z�����~[��ķG�G2d�!��k0������N�[ߙzţ��u�[AGHf4?�1 ZK�H�OIR��u�0��b���:%?�GO��C��e�E��ރ~���ַ�!�4:+����JW?j�竍��'\�=���{.kh��~��峖�=*Yt՗�m���h`���%zH��Ί�VC��`ۂ@�%swȴi�oa�Y8���/��
q*���ҝ7͡�ϵ�r(TL"������� z/�xT��۞�b��O�g���P�Z��d<M!�G襵t �	P��\�H������� VC*�L���3��pT	e@V�Y'��!�H&���W��(���k��姎bԊm�r2 J�l2����^�)u�)A�x]l�@�R�z�W*� J=XWa��0��<3��eb�ܺ�3�o�v9޺�4�<t�D�A��-�!��u5��(^��y��ֈ2�i���\�5�(�tr{u�"oC)�n�1*��D9� �����n�5��_c�Gs�Ժ�X�h'�>l��a�8� �}9'�(}d�q��W��� �5��}ZM˥�Vg�zGA}|7=c<۫h��QP���)#]���t�V��;�iL�����zG<}Ifw�ɝ1�����%W{ur�Ǵz�:��Y�����`[w��Gn<��L����zj��(?H�1�`������Ѝ��
~��s3�O�3����+�0��\3Sث@R��nH��2?��Y� C�ŻƷ	��(#��x�f2@�L���\�����n5Fy,�5Z�T�|:��~�mcBʳ���Z�k1���T��Æ��F��t���å~�1�_��k3��|]s�eGݜc��[G*�.�]
��7�ٽ�2t�iB��RQ��ߖ��z��)A��,8͖�F��0��=�eƆ�1ư�Ź(4A�U�-�m�Ӭ�	��b�"���:!�6P
��`DK	�e���Wྖ,�n���d�a�Y����d;k��o�<�B<�����l����L&��w�P]�+���M@������d�Y��l;��֡���t�8j��B�[9��(�eJU����Q�l�e��;�?���wg�^N��=����z��֚e�I�b���]ٖ^���*�6bϘ�je4��d�E}�f��uҘZ^:�0�H}�"���+D��'�x�Qj�C�N��Z��({ k#��9��#�ڢBP��3�IFx��'�yjC�{�^�}EC;j�˥��E�+Xe`j+�b�����3�}H吞����^�s6qX�>��-=܎��zs�5�Z
`��'�L��.wX~��3��u����B��Ze��jc���.�!�
u�S=��i��g��vRu�O�`=�,��y�s�J�eG��ɶ�vGRu���!�nN5�Ղ�W���!U+ø�
s�kwp�Cu�����@��"v�_�S�V�^m�v�Z-����d�5R�,\;�d�	��PW�jp�z�3�I>Eo�\H��Ӣ���+�,�7۞�3��K~�$�S������~�N�����hOƟ�@e#��\����$:jG#�g9�X	y1�A���� $9&@���
�x�d���1�!S�ze��Ս��0���C">��y�jH2�(m.0LWN�(3���/���0)�Pb��H�z`IS���>��� �	P�@>�W�eY�R��ցU�O�nAF���P��W£D��Z ��$��"7N���DC�񺼜�My�h�\�1>�X{��j�-��)���?�(#�t�	�Hh�&@���������A�"�=u]�5�(
���Q�ۄ�Xj�=BS�j����/L�i���w&��%E���W�7 k  ����_F?��-Q�$PwV�a�[$�Ng'N0/q����D�O�I/*�T��K䵘d�F]n&�����e�E\�������q�q��ZO��'�j�݌>�L���ӞH+����L����r!����E�=�V3��`F�֙:�'�ja����Q�D]��*����2	$ȋ��Sw�8������x�/8m_�s�sr>�m�Ol��p{�N��[KE��/u���2G�n�Te�мs�l��绥���"�yЃ�[���K<��z��.�  +(űr�9����K�� #c�!�ǩ0ȉ�(�A�n��0��eol����` �
H����2� c%Y�<��^����N��wO����D@��+�ǀ�̀w�Z��}�o��V훖���ʏk�u0��~��LW)2 ��z#��$��D+ 3vl���;ĵ�2D�7���(��X��;mJ���ũ��B���mz�K�8"�/���W��p�mp��w���_|����'�q�q�贵���l���d4�ᷙ�fj�;���j)�<� 2A�%-O�A@�����i��#��Sq�2@6:#�w`�7�y��A���d�����0���]��Y0�l�MՐ�T:}���<�|�Nߞ �Pe�ߛ�3l��Mal(4c+d�� C��Z�4;L��v{?�����֓����-���V�Uk$�j��m����*����IE�S����$�������Z����Q��@�
P��5�a��H�de���a��Yz�a8���@�b���	u�v�s�gm�kÿm��Wz�D�E��{"g��e�(��
? $���|R[��B`^��{�"��?�h`�B�!�)4���
�q�e�
�pl<����m��À�ݟ ��ӱC���ܔ���5 ��/r�P?y��)M�O�� )����sc�V!�`O�e� ��w�P�~�u]�w��@`��[t"X�"�e1���3����ŕq{4�_A?F�i�lh2��	��zٺ�DHӃ/�	(�e�i� IG���\H5�If0�K�p��z��`e���d@��ۀ� �D�`y  `Y��͢������OfU�bU C�{I��J�F�4kD��T"�}���;�NS8�{�Q�����؍��F�<�����g�m�:�cQr�9�z���q��� �v�L�b]�NF��Q;�fBC��rN ����MD�jO�"�� �{b��fsB����j�v�G�AXFU�ή�䛻"�E~����<�7JX��A�a!�v��\�nBȡ�+�	�G�0��t�P>	�O�ˁ�[B8-�9��s!2ݾ�(��-����uA�I�d��� f)1�V�B�6�kE&4�U�!�����q��/φ�h2\�g�C�� <W'��)�L`�fEo�4Ի��ƞ�z����\F��#� $�~�y΀V`@�a�y�����IIfD��
gd۞NY���$H0w�Td��{���[U����0���MF0O���>�A�A!x�:��� #�g��0TVT�y>�����o������^��)�9�7�@�
8!Q�čX1s�NH�!��c��H����0�AB�E��9�a�@�������2!^��"|�:��!ߧ�d
����H
<�w4�=���o���r�-�|ſ��%Hd#�_�����6��> * ����}B�	�!&?h��L0j7Ys-�JQ �Gd�9�*3����F!��d�Wؖl������.�܄�KX�i9n~�
"��1�LO��ۊ2�/N��2�+�(%�-�6mk�	1������*R�&L���v�ybB��g�1l�j-
·E�[�U�M���s�4�\󟎧��5<��"�L���~<�'Dy�Z��Y>c�s~�`�)H���`�B�Nr�R���v�L�R�tHm'!)�͒B�LYF�UC�Y�1=�b����wٟW�MWq�2���v��iZ�)�9S�*p���L�+�1�靄 2����´J ��`m��CX�RZ�zq � �tc�j�$ I!8}L8�r[@�" +�����ح�� �<`Z��{�V���W��D�Hs��z���9, 4��e;� ȐKd@lK d�Q�V��{-���w��~��G��k���ӷ HFl�51�����qNL�1z�V�b/.j�W5�^
��eg�bM��k�}��aM��wƒ�,�`��	)2�oe�!#nR��T����D_�g�k�����O�<��l��s�� x�tu�dzIK�t[����j�z�tЖT�K
I��{"�<�ѢeR�M*ưM*L
���0	�-���Zh=b$W�u��ǋ�LG�wI!�	EHa����2C9U"������{yѕ���/��ZH}�l}fgHt�9¶O�g�Q��!���"������ԉ@/
o=�9����<��2��h��j0��y����,VQ��U��.;#&��r�lU�=	8r�ol[�B�d�^Ʉ���r�݌�0����T	.��מ��l&�@N2�@�49�>�s�	,�N6E'D��)��h}�Uc�&�>��ist���<��0�ߐ��P;PK�0��Oc:L��1X���d���c��Aw?��)
*�M�7g9�a�^�h���_�C��L�I�2�ݦ��D�*�$C��T�!��U�����#�g;(E&�3]��-b!��h,�U��q���+L����ʗ���J���T�H��z�~@ ����b`�(X�D)���I���ÅaB����!f��dzAu��˗Z�,3�{@�m,ԡ��؅�X�r_%�y�3M�օÕ��Fb��ȊOY�&"��'�as�=�d@�^K�1�Q�@a��T~s� �zK�?N�/�d8+N�lcsM��]}2�%Y|����Sb���J�ftQ�&d��&�C(C����{��@2$����:o_o��0�eJ��'�djƦ�yPk=y26��B���I)"��P?۠xsSe�~�}RSH��*ǟ�̀@P ��)%�q��� �L���} S��� ��J���)���6�C�f�/�]��D�2 �`Ixo�`�����NH�_i���XiT�wVm�)�I��B�:�[0����.� ���d˕V��8�=;�²SA&8/9`/-D0� _g'��	кG��EJW����n�W��4Z��x��e'%~Sb�	��uc߀E�w	�/��>�F�m�: �R{Ee6���I��r�'������� �I�!<
��P�9ֱqRoSЫֱ]^��Nǟ���$Ha!�
ȧ=�",sx_��'"��T���b��`F1�.��R~�A2���b�F����_���3&��      ^	      x��}K�$�q޹�+�L3�E��S�0�BX.W����O:�d4�������՝UEi�C6{�;����������?��[M�V3�u��n!Pp��_{�������?�z��������|u�O�r��SZ>���k�w��s�M��߹~߇ۯ_��������ۯ7���_�s���������o���g�?���wP���[����]k�uy�
 ���A�(��� �ȟ�C:0��WD�%�[e�U�Hqs����	D��Gm�J�h�­Vϴ��n��;0V��-8wK͗"���4�X �G$���÷�~�����?���O���|�����?����r�?�����F=o~T��L�]6�����GRI�i�� �Y����ǯ�㷯7O�|���3������%<���q4��1�[iz7��Θ��x��;cP�o�������o��(��{:��}Q��C<~���!jv ;pQ�)����G�=h&+ڭ�$,QZ^$P����b�E?�S)T)�"3�~|��o���^�ƗM~fv�d�m$&3m�bYВ_a۝������6�M�9��/C��a	�@�X�y��g�>��I#?�qn�h_�U�O2.���4���&+�^ߓ?����?��v��ۑ7����+B���@a47>�Fi+���#���yZ�'��޿��*�G�ʗ��N	����bЀ�	��a	���i�[^ �_+��Ψv��o�O��qv�;oCr,P��Ϛ�'���+;�;��Y�����3��tDL�&a�K��n���~��7��ėñ�lG�7�a��u����#��77Y��*��[x��M��b�%R^ ظ���T
Ѕ�$&�	_��|��ĳ��Sf������gE�����xۮ���(���w�Y�09�y������Ef)�,��Ыl&FS�O"g�r�c8�(��^0�ΚH=��+��U���Q�R.�\��I�W����j�z���L��q�`C܊Z��^��D�#�k��i4.�!>/?7E�238��y����'��GI�׺�� ,�w������������3��\���G���]=��W{|���33�ų7S-��lj�W��<̜^!m�&���*>�h�Y4�U����o4M����ڞ�)Ma8�isс�mm`��M'FM�C�T�ˡ���ꉭ��h�����-�Ϻ��u�<V������*~9rJ�p���Yͥs;�W��C7�8�Ț��$����U5�(�48ivr,�\L,����	u?����-l���ס�?�"�sX���{����X�0�Rc���oA��2��Y��>�[��8�P������k8��t4� ����hU'vJbu�v�v����A�����R1��W?��O��O�B�!dE��"�r�}�oy _O�ev�S��Mlh�=�$��x��b|(���/:�cn|9����E5Q���-��Q��I����^�N�E���EM����سl�g�)���.�oJ9xv�C�#�Âo��hh��z&����i��?|��u��4���&���T��,+��Y������hԅ�\�G�NF&�M��k�޴�J���W�I��X�v���p�n�*q	�U��\��ud�}�ZN��R�Y-�Ʉ�\��>`f=Lm��B��!�tz���g&�}e��!�BU�DR0���I���`bf��c|��a���C�łYU�$��k���V!�7��(��R����2E�g�!��{C���(;��żr��Ӈh�$�¬WHZ��̏�*��!b���$#w�(|�N�JȝG�*Y�|�sɛS��kp+�D��ź�+;�s��	EgY��S� 9����a�4PQ���{+7 ��ae�ˆXk��Y�!R7̎���Ht����������\t-y|ѳc�ё?�*����4�c����IG�M<��ڞ5�'�a_u�CHb'�ǲ�s�s&vC��I,!�o}������Z5E|`����~�/��H�2"Z�^���f3��>��}?>���� L���2��ln�*�egvHs��+���j����U�4d�������pf휃ĬBX�jS������c�gF�G��t�W{f���r���K�=$bKU�}no�l����D��%�^NҘC�n�d��f�[��Affֲ�R\� !�X�e0!>�3�.%0�E����L���;\� �%p:�,�qJ�S?�.��J�6,���W��R�I� ~���o�v�/N=�}#�'NBFoQ�����tńR�aAjP8P�="@T�y��&x�W�,:.ڐ` :Z�g�����JЛ�D��}��폘|L#��^��Ҧ��۝�l��	J���[}�Q>�#��4���#��!�*���lO�1&�E[/� 冠b;jeZ�_v	�7����U����(|���藞w���"!T��/����C�r2��*ϋk�c��}dMv(��%�-|�=�"�Y)�1��q���� qaj�2��/�s���P������M(a�Xk���{��eR�.�gp�`���\4�ӟ���w���OGʌ+��\-�u`��L��,����0���e#���[�\��m�e������U��f�Ƽ�sD)�0/�nb��m�$w�1��k��B%'��NR�� ߡ��҇�-?��4���S-"й�s��V��W�$��W2�=�t��ht'�K�I}X���ɨ+5�%��5�]l����O��fw#�	�K���[@����Oۀ���R���w�T\�;3�A)�@�/�����0-�	o����!��1xS�7p���b�{?+eq1���&$��m��{�E�9u߿�NP��CX��<�uq���b�>25��o8U�|���6���AC���g��l5�׋b �QH�*5�gk��{�9�����/�Wb�+$Cqo{����T�d��y�lj!W��Ň����?�eC=ԃ�A��q�Ll�:'	� �`k�6���OK����[MK��PLC��C`�.QfE�Ch����+���(��Y�ʆ&wh\_M�m��'Ee�b�`�/�����CM�ڸ����t�C�ʵK�Zk�!�8�\8T}��^R�3��;=�T+mr�.��k���~��5^�Ov�zD���
̋gB�E?U<�E���[�+��Z��NT��Du(�Y��g��6�����'���Y����6�͙�&HnBy�In8PU(Z��P���޳ԇS����$��"ʷ�ʆ�nܩ�(�;X�(Y�e��X��(�
��(�� ��L~�D9>`W�q�c>�L���RDT��h�Y����'G�2�;{��P���/K"6 Ո��	>�DUXe�\L�;�������o@#̗��tE�6>[mAKBmqS�2:��L�o�J�`_NDr�d�X����Y�<F����^+��ؙ�y4��CL�>ج�,�WZ������AN��N��Id�%��ka�h�b�B*���l��̽��(X_8]��~��5�UѺ{�A:�Cj�!;pz:O�B�h���n�4;�Ԉn�hr�S�'4D܁� x����~��K=ڰ���G�qņ[����C��2'�%٬��ȡ�z�h�Y� �}��$�Þ��qO�NL�����[�<���Zؒ�̲�+�bD��V�qT\8��Ѿd�M�H���b:l�s�"b9 �,�N���Τ��o��Kӣ�
�ϻ����Cx�U���D/1�=��B坥9�GY�0���g����d'l��Z��e�]�O4y���R6�ղx8N�J��GF��\���|�5ơ��	�ܜ͢�!7��k42z�Αٹ	y�	|�w�~�c��cKRc�fybG�IyW�tH��)�#W�W,�Mͬ�╘%�j�C����g���Ip�`�ű��=���x&����
���j�3��o!����O��/A���dR�95�A�7Y;<+� ����ܮ����a��(iy�L�a������/jGO�I �Z{�ú:WTEQ�]���hm �s����X��2K4�!�q]�[������)z��f�����%��N���    K���f����ٗ*��o�/�v�����'F��Ҷ�B�P�}�O��3ӌ3;a��K��!8WT7��,�K�!�9�"
(��n�_IYd�aR;�A������E��u6��
#�!Kg��KvUURlQ�K;���V@�ݙI'��ro�I5�h|��������2i'�u�NO�p��� �e�i:��ΪZ�-<kg�����R0^Z��r�����l�lb���`�H!���q���3SQ�=��NnP�z�cv�s��t�S��`�Hl�1�c)�C> ����'�?�[T=�@N���He,���S��M�4������9��B+6�=�X(��C�yN*�C)`���2%;�D��j��u�0%�����:�c�K��F<'2'����"*�u�2�G&��E�ӵ{�G�K�����88�2�ԛ�v{_�$g�[I�>Y����'q�8D<�e�dEC>J��&5U�����%�w���MJ���*��{�n�g�����g�A�{&`�#�ṵ�E$���}uE��V�	�:۾�Bd6Ou��vW,�+f�T��#tQ�½;
i�����]��ΒÒ;���ClF��M�{,X<OH����|,�WĨ��� �ҏ2s'5WX��~�	*`�o}�X�5�Y��Vm�M�Qm��f�h��kxWpo�X[&�m+�ҩ��@�JK����R��!>z�y8�ַ�	S�>\��u��rWi�(�:+�PA#s�}b�؍r�Ǉ%������S�n�>&}dd^���2��2��ٮ��ۘ�]�!�a͏h.%��Д1�;��a��'�$J��s�;�ȡ��N"�20e�Z?Q�aژ��3��q���Ǿ�����Ke3�06�.A���RgZ;��v���E,���`BnX�`b)ˬ�V��&�J�Äe�ʥ\�Yjz�%��Jm��:T���N��B�Ӯ3����c�4��#ӹr�"=�Ϡ�*%��vf���#�����ڒ��PM�Lr��ͷvC.h�b���N�.�0��b�^U���O�L�g�3��LKF��A�����.O����	����vv��Ɔ�R�r�\�]�����z���NuNX좖kg!2^�Qv��ų�푕ܠ�&f]+���ud��WL���|���
�4,��:��c$���o0�[Ĩ�}]�������T�d�u�f����6��z���pȌ�7�׬e�!�.r��M�G*�V�6���f�r�oQ ��K�e�rz!��_���2M�9����͒)�C"ߊ�8�� ��	6�#Y��롩_us��8�n�7P��P�tU��/��}��ypsKuSO�J����oט����޸�#���b_4���8�B���D���2Q&�}9�ûB�w��KA�����l��z�X�E���>ք'�(�/F.'�a��\
:O���V�"״���謫@~��ؾ��uP���c
:m�]����p#�!da�W�x���"���{/%Z���lPS(�V�֖�cq��qtG!��d�fs��Nv�.BzϜi�d��XL#�Ð�l  ���� ټ}�������@-{�MNT�̝���"�����at �o���Vo��LE{�DEP	=��F�	��(�	$[�lT9C���â���	�n��+����CL�>(�ɺ��9x��SG�ig{����!y� �p�Y�iR\�����Lǋ �����zg��DSddY�[����6�q��:R3cRE7Ů�q���d�a2�w�C��[�����0o
IaL�<ou�N����m��C�Nz�6��Y�*Ζ[?*�4u�����8�"�򴳽���y�����aJ��g2��la�uaVB�Qc=U*��L�V�0�6�2ŧan�����v�/��]�dU˥��h&�8B�`j��:m;�`�S�t�~�X\X��6�`�u�L�n���90����}"񝙙�A�c�RA���OhQ?�8W�vs0W&q$slH�^y	Y�i)jUS9��~(��}�-q\Q�C�����#�}�
|�����?1��3F�$�j�L�c� �+=�[,��jyL�:�t���&��Q��X-vtZ�I��	�Wl�	&�Κ��|�R���0�v��y
cd��+
�)~�Sx ���[��.>y�(|}��P�jZ"�%�y�I��44��<��]}�z�E�tg��"�m��g�G�q_�]u���E��KY
�������v��$�I0�-(T�6E�V:0�&�����ujA�m
�	s�� 6���k�?p���p��O��Ury�O�|�;��}��fV18�ۣD�Z�����} x`�+f�
$����Ʊ�`o��NK��ml�g��9�
��d}�|�M���?(/�������e��?��/bI��{0iG��zK�C�6M�D6���&��)��R�Fyj�����,����"iP�uأuW�C��I�����#������]���K hf�5����I�"��M��-�F�bh���Ǐ|Sc��mB�x�� �S��p{3 t�s���N�`��,M����%�v�$�����Vb����|[�|n���Z�&X%��|��ի�78:e�\�-�]��6�Ud���F:�n�j]�[�ɌY7ӂt�Os�o���K�R����.{g|�8a��?F�N݆o�NI���ZS�$*2,k͐�r0N`v4}�t$�?����´��sww?���z�'eіmK����&D��̫�=�Cq�����,��)L��6d�}X6����5��g:q����K��M�&������.[R�*>�xfF5��=64���#h���g�>��dv��H�p)60�%���=�	Ҽ�Z�y=M�W�=��:��!E.�g��:3�[��ձ��l$�fs��j>5���S���r��l=�k3��hWt��~S�	�����,6(�y;� �d`.�bY���Y�Ԧ�D���B�	������h���;�I�w�@}�N���.�R�Ò,�q�vʳ��;'%V��Dr��:�-�j4�j����n��d��ʾM���4�ԙZ�2;����n&5�Z,BK*'r���FP����3������6�����e��rk�{���eL�f��y�޴1��j*��z#�����Tb".b߿*��a߽R'����"6����g�R���t"�P�azar/�����sC�gga.���(�t��d5��M��S �_'���H��Lh<�J?�&�߿�>,�y���U�e�����(�|g�h��p-��w&���0!��pEƲ�𴫲Sl�1]�:7Х`c�[�1��߀H<���Cc[f)��6\��a����ha%�JPʶ�Fȏ�	ɯ�~_�S��a��GI)���A��c��S^O�G!�X��aqU�k��j�z.Kc��6��W�#/ţ�a��RDu=�������<{	3�u�[�X3�q�d-ך������L�2�I5�}ʄ�ă�
���������?t��9�E&�n⇭�x#̴���Cv����&}�q1��j���-*�1^����S��QՐ��:�x�^���G���mU��*&�u �t���T�M��D)�76��f��A���;�Lܭw���-��  ���NR	�*�F��|'�� Irwo��в��R�`Pc�lx�n���1�L?h�X*��DQxu���#�����μ�����͈�@HSO�m��.j�=ܐa��G�g���2�y�R؛�fОm&g���G�{/����bs.�T��K��M3����lpLq�7�]����J(�����[%՞�58�	��j�<�c�Iଳ�{�d��}c�����r/[>��fB_o��(����e�s\�7��]�½��<` ��x2�Di�Κ���i1ad�ڜ;|������3���NCi��|��u�!��i��`�)(���k���Ж�L��֩n�Ѳ�B�]Z1v!z��އ���=�{d:���Zl�M	2���}y0�65s��&up��9i��F��@��"�kE��c	NN�������4F�/_t���x� �  ��
��i-Y{�����X�i���������)ĝ�׈\_�J�ͫD���:��BT����rbd�n$��v�W��r�����l�(�����-'4l�I5S�`��dO�C�=�E�W�V��ѵ����3��]�N�ee�`�<�IZg�bz%�0��X�#�3xL�}Dr�A�|Ҕ�V� f�f!�[�O��޻mDfI ���O���$�k,���X�pW8�}��3�a�a2"��b.Q��{,�nvD�C_$]�Y8A�'j��@�[�J��j�g��yV���2*XpPgA�>y�H��"Ԇ������a��h��I��yG2U'�S���0���ڵB̜�&S���$b��J�
���z3�ou XNv�����f9[׬Ve[!;�Ӥo�5�'֟9jEU��g�
ߝվ�=�T��hWu�	s[d��#�5:���VL-����m�H鉦|e�C�均iAD��s����&}��z{�V3sY�	R�i��[�x�I&��Th��[��)���o�r-���'|�m���M�Y��F��'3ñ�l�<r��4%���<�L�v\Ø^��x�j2�Hm�X����t����0$/e���"A@[`���:v��1�ǰǠ�'�u��f�$�ɪ[�G��&����d|LV`2m��Xb����A���'kB�,b�`j�?��ӗ�������_�ן������_��/������x3�StMT'�5���!O�͘���Ъ@���A�ҲBx�2��.O��5}��M�����x�/�& P���͒O��b�S�Xy
�c���x�'2C�3�n�v�kn]�`�",��Nfv,G`=_i��__鸶���� �D̀�������aCr�9���ګ��&Ra3Y��!}�9%�V�m��t��m�R����0�bѻS�6�0��)�����(��AL�Q��צ������$�zUL#��Ǩ��f����
x�<�H�u�*b	0�<�3����'4��>�CI��������{�lyE�tOo��_���L�B��~�_������p�d[+��۾����ҕ�X�7�h�i1��6>�0����E���o!��.�)$�e��C��K�����L^�#�cD�,�>���U���7b�ܲ9�j�2ßOd�ύI{�-vJj�zu9,&�dK����F�13�\�t��V�\Hw�$rӝ#iL��О3�o^�B�����/5�D")_� ���	�>�yY�K�-D#45E*&�����0��T0�؂�K�d��͒{ޖ�5�N���͆?z�>�WEs��f~=���1�j��S�������{������6��u쟥>�	o�Ue���3?���h
�:l�Ø�
��-Wm�I��x+�Ɉ���hB���Q�!����7�z�IudX~b�Vb�UB���`-A�^�1c��sQ;�[�C�N&��{2ff��C��#FI�Hf�p2k1n�K�H|�tcw<�{J#�]���qj���{{�.&����2a��ٱet�PU��X�no@�����_\V�^�xl�H��ꪖ�X*h\�&��k�"���F`V˽4M {4=��)i�gs���:[+����ZY�D��DUc�s��&���Yb�����R
B,��֏u�7/���������e'M�oX��w6��W�mwSH'#�%2�0=b�
;�U�I���˸V�rw*y�������4��ܑ��V��25R~Tay�ՃBY/f�b��!>��9�䱃�[4�յ 0���z�X�Ub;l9n��EcQ�^ki�;���no�{*�٢Y¼?��L�����(@7�N
��z�5��7��G,I3�h4&��R;�\�ơ����X���j�aE����]�+���[G8���s�m	�x�r��'��\��m'�I����������j	�N�:@֬�U�8�9bt�k��<�y��"�&����h��ڃr����g��=
T�SG����,-z��e�7�p:���X=&챙@9�D5�qm��pB��#�S@$���z�����P{��s� �I<Y���{��z�U׍ �ѭa�������a�84ni�1v�mg
���WB|!�=sw(�_�\�)���9v�����M�����i���O���KYzk,������.�O�(*�Ѭ�X�c�x4m�2Ě�N���RhCܻ��M{I�hA�ѥ�����u�޵�o��ѻ����o�ڲpI�.Ր�,�`>���'���p�Mw.��$�VC���pw��w��U��t���ʝ1gB^��WK��Cĳ��V��W�G�3YYgC	�n{G[H�FvC���y@�Z��|����G��ñ���kH��f�
�� Ǝ���iC\������$5�y���{#'B��8D[}��R��p�T:�_>+R>N�Ѣ	C�eJ�<.�&�X�t#߈�"���0���TlC�	)�e�\�U��B�E��J�7�f����>m��.-JIQfAp���\��r���kT8��	���6F(--�HR��?���ؗE�g_�^�l����u����)�C���/��%�C����o_~����߾~��_���?�������6�L;����34�^�ٟ�w�E�t������,,��c����~��˷������?�����>z���K-G��[�T����;��AU?��f��ާ�u�?;�i�K��AG�,�G�	�|p,��e��ǆ�k���M�ǥ����N���#j������y^�	�JX�fYG)$\BfTb\6Y�t&��+�Ϯ�&{�//^i�6�JeR��*�����A{BLO�85w߿4`Ve�O	�Nh�ʷ�B����Kq]�	e!�0[���ڄ��QJ��ќ����_��!�\N���[;�X�e����pS�Z��a�����R&u-�۰����ͬ�"���D}�=o�(�5�9V�ki~]K�f`���D#l`9u���Q���9��L�G��3�Qg�o$�e�F�um!�\��7lI[�&U����=�[�E��Jo�� �P�@�9��������w�R��a      r	      x��\ͮ#7�^;Oq^�")J���Y��b����q��)˧O%� @Lw�IQ��?��O)�����>��ǿ�����O# ��%�G�>L(ȩ�����mk9�}@��_I~A�J����maz���?�|T^,��0R"��o3��/b#�ޠ^r:�k����9��Wr�� V^0=�P]ʡ�ƌ�8���x��Q��l���!F��BOLp��&���4��|L��3���^Ȕ�;50�Gu��5P�-��џRn�[OP�M�X`|��2ȯv?��n���џ�
��G���~���_�4�$bt�.P���T_Y�+Ƿ���%�P�HϜ���UЦ,�C6�AF�eX-/�$'~)�d}Uа㷨Hy��W
rcY2=j�mA<T�l��'�� �Y����1��єu��lB'9U�F�k�G.���* u�P��*�~����A�9?(H���*2.�؝I諀���_sɃd�>X]���Z�=�R�,�I^2�~�VU�[�����4�����	�9N��.�S��HPM��	���M us�o��{*�����w|L"��:�f.���\H�&��b�׸���G��_����I����Y��7�Q~�X����΃F#XrkQ�Snt�#����Z��
x�Ɩ�-��
x�*�8+�	!���+Ź�@"�����G��f�'�����Y� Ȕ���G���'A6w�)��T�����aHۮ ղ9R��S���q��HSz���t�"M�5\�٘�Ա�H�Ox"D�~��Y@� 9�a->E�~=58���(S�߉$��')�z����\2�����A��!fB�x�.`�T�V�}(�d�(է��2
hSnLF���|z ��S%!m����&�5�5Ӕ�K�~�@��p�$ܰ�V�9c=�~%�D�iQ�8/S��Ճ'��{(_���\:xL�n}5�au���y�=����MA2=QK�
Qv�Sx��v����EJ�
�#�;�({����9o����:�Ϭ�#��G��)�%��6e��؃칃��N����6�{�)���w�Avgt�3�W�p4-����6��({u6�7��w���9^�.�^q�~��z�ܙ\��y����)x3pjcS\-S�KI��/!�{Ŏ�K�:��.uS�@&�k(ȅ��(~�K�f_�[�M�Me�����ր�.~��Z�@G�T�B
<t�:Ѿz=H�����4b�1�Sٛ�����2e�w�gn�$9��#��{����:>~d��Z*� �7��ߵ�G�Av����s��q��}u�kR��,�g�������I��M�N�7؃�=�@��)�S5p5}�ޢu��	�4J�֦��y���y�w�Av�E�K�͏빶7�����$S��ʹ�(>8��fc�Qs�%RP`�6 I��7XV�'�w,����T��h���;h���-G��2�������FӮ��(�^���n��T<�'ZFX4�:�+�ױ�2� �L�񱯲���'"��q��	���>ʏ.��f�o����ۙV��h�Pb�~��QHS~�����LP�;�A}0$;7k@���,�Z�Y���)�]��(?9�K����8@3��m��$�)w��	|T��%�s�+
ȫ�O�[���<ſS��>�� �ȏi��"ՅۓҜ����# �
= �nAͻ-'�A2�@�y fnN�I�<���E�J�>j������Dh�s��R5�"�Hx�JMl����4� �)���'�D=�;�\p=�O/DIl^�=�����bL�h�\����R�����h����-A�R[�2t��51d@�Y q�.�;(B�s:��DƜ�w���~��c�k��k���m
K�3�����&~������_�����(�kj���	� �3�K'9?��Y�Ou�ٗ2��M�{���<�+�n�匃���5V�c�N���ʗҦ���Ü��%�>*���K��y~��uo/�9�A|�^��<?^�{����m×�$EH��(��)�m��Qv�_��1����@m{jP�y^�<��K�{��'{�7ƹG㖷V�:C�`)���L�oiqM���}�)�y��\~Y->��<�K�)�-'��Av��c�wS_�8Xw]b+3�Do�R�2pW_{В�~lr�E��,��yPMS�c��ϠN���&&4�Xm/�Q�<E��>PطVw�EN8��V��!����l+����>(�"K�� V��Һ�mX��6/�A1�k����ۗ���G��;Š���a�(�Y&�>j ܾo�Հy^x\n��J����z��ӕ����M��LZbk�*�	�)��8^��M�?���>4c�G�$ǐ�S�{B�+v��5x�'R=؇f�mjʰ����oO�^�ٝ݅T鍊;�@Y�,�\�&��u��͝	|��zm�?0���Vc��;�9��p
O��=�������up��}
���)�m��Qv7���gd/k?�l����\G=��>`��u���m�lX+Lzf���.wXz�Qϱ�wO?�>j���sH�dW �|�4��Yf 2��9a&`��2��m����ؽ�8�O
SI�đ�	�7�Qz7�ȗ���;�&��c{O�}�Z�|!��i��ٻ�q�s(EE.��?)��w�l��]a��WZG�5��麦"�L��;�`v��S�j���V ��;���ܼ �d����i�E��JS�{��؃�n�?����u�w�
�����Ŏ�KOt���R��/$�&� �u��\;�����L�B��f�&��z��|�����uZV����XX�!���n�?���G�6�Gx��&:N���?A=QKk�9�-���ʸ�]��C�/��H��W�AQ��T>�#��9���{h���^�Lރ�q�v�h%�RO9�)��=����	�Ϝh)�$��'9��6e��=0�G�I���-ŶN�&;�R�� ��#D��\9Hl1��
p����{C�ßT����#B���"������@��`D)=�?$��)x���G���#�w��7x�B��ʌQ��/q���>�~P@O���\'��[1j�"���L�oH ��Qv7HVbկ>m�6�K�O��
g���H�7�A"�LL�D�3OP�a�il2������ӑ�{�smh��|T ��7����Kq������;�� �Ik{�}e��0Y�T�<h�aʁ�@�Bq�PYs���=�i��X��p0�h-~bJ�@N��{�8h��8X=����^��=e {�A���i�"���4�#�z��OSO��8Q�=��|v#��𽯍�����XuIP�)��}e;�:��_S�� Wט������*��;����fj���֑RTC�j��f�Q�'X'EZlj@�-���h��>*��wԡ�O�scg�'��|�] ���{�.L�Ӹ,I��{ ��b���A�!�cx"S�M�>*�Ub5$Au�Dͽ�tR���?^f
��R��q����I�)>L��FÖHrρN
�I�Ӟ@h�&vu�-� O�Ja�'+ƭ� S�)��A�fj�po;0av]���hv��^���j��O�24g�x�@p�h����"7N}R�pNPG��])}���k��~�^ru�jN���q�&��-A߃v�m�@�3�A��C/`�P�]tPT,�8\�'r�a|��=�|��,�%��XX{�Fi5�Ap'�U��L�ș��h�8�uf�0T@y��=#S�A�	ɥ7Z~�]9؆�Ql	R|�QhS��N���y�fk$�_=)���#:yB���%�^o�۟������7���𜗶Jg}�`�6US{=�|��ݩ�H&��)t�\ܒ�x�]�Sn˄_��I��G����lCp��BH_�܉�\z�����^_*pC�r὚.p@��<\.A\� ۃ�4[�X�{LB.�A\� #|T�+�w{�J�q/El�,y���U��ޛ�W�An̀��jj��;UHڂG-�	�V �  �)��9(�(��B^��	�'{w��svs�'���Q�@�&�e;���ѥ��c�������\�Dw �n���G����`/�9�I���AY��A��h&��-����v��T&��a��/�b|�xצ��~"x^e��-��wЃ�=���zox?��I�Lox�
н������S�(��w��L~㠬���y����7zl�/��n��H������I!S9{�� �y��L�)D��D4���<)�+����X�,�p�?)`q/�{�(3�=|���]m��oz�+	}���*������W���I+��$�2�Ao;��T���N*�*��~��u��l~?(��v�.����KO�e��=��.\f�b�=��/��i1`��Tx�3x{b�d`{B��/D�@;g�2���X�VR�a�@��|��)>M�r��?u�T�l��#tX�����k��ce���{�8�C�m��s�p^�x��%g�p�>j��P�4�㼗�ʫٽrj���$0p[��
Я���������{R�mT`P@��6�
?(�t�8���6q�����:�����!R�Isp|4ホ�b*�+�m)>V�N��2��������N�QY�T}@���hn;~�@�����h�X�#Qle���a��:��w[9�m4��� �.SnT�@�9�O�Ɓ��F˒F�i���}���?�����~3�      _	      x�̽[�,9�5��=��@D�U����~0���"�*C��+��NcWe�҅")r�\���������?�����c��ܯ�B����/�~�F������\}�
R�r�wT�&����\��;���گ�����
��������e	#�⏧���Ɵ�/������9�������/�W����°��>S�W�����!D��(��!���y�	�ߡI���`�0'ɇz���9�SU�c�TH��/E�/���o�ߌ13ڼ�`�/�XP�� C9�(C|�*}��@��V�ej߁��S[���յ�4X�����E����o��@��ܠy����4Վ��U�b�'�H�����������Un/h({���W��
K4ۚ|K�����K�?��>^�(�(����iZ�K$sD����a����2!�t�|����)��I'�vj{}GFߑ�z,�E�߬���,��D�~E��J�'����jq�+�Io���������-+4��=�8�x�O�ɶ���W��
>�����Ba�PXmxQMJ]Bq�S9U/��t�f��z���˯��Ll<Ѽ3L��C�:�찄"��������O|�(2���W0);ٌ�AY0�-�=�{_Ѽ�F�<�xr�ƒ-џK�Z�?�o�.Tǣ�Kr��h(����7���d��*Gz��Ԃ�+0>�����cU�v#�B�$�yu���/|���-��C䳝*��p,[��4}��B��%H��6 /��y��Wq9+���� �����#y	�D�6���yH�kȱy�\K�W�L��P�<��W<����s��b�7'�!Rv�wIۺKJ*8y�3"��_����l|��Sײ��c�S�F"�/�7�!�w�1�`HlD�$����fD�U����E�;��َ��ގR[!�R�QW�Y7r
��C�N�\�\7~FpˁIr�P0�K):�e|V�ܠA7h�j�@K4^N!�X}��@�ϼs\��K�1�a��`ޮ���`�ؕl���:$��	f����i���ނ���<�%� #�-�C
9���B�0l����|������%���r��n�!V/�f�Ϻr�(Y+�1�7X�DTU]�t�W�9$C�1�A2$�D�E�Lje�r��l���OsHD��S�����~��Y�� "�,�����e�ǃ�HJ
);���m|h�+ �sR�P�˓�P�����(���K4�G����D��nWˁɣ��جa�`�����[D0��"j+DP��5�����h����D黬?{^ls�T���nh2����� �n't?o�->�d*,I���;���� %{,�����g��rH��Ĩ�dO%D�Rʰ�y�Jу���IA�(=8��(�X9��v�JT��&���j�ưD�cS�7z�H)(����ɼ��i�:T!�"���a�%"V%op�KD^�_r���S�������/Y��|��C�� r��~������(QZ"
���d����1
��۩��or���BĊ�ǈ�u��V���&�����o"�<���>2	�ȭ�QE�,�o֏b�Y"
�H�"*+DnKHз�ՓW��7��|<�}0���dO�W<0��@��0�F��g	gG���M8�8��g��y��W9e��y��F2k�^�y���r�>�ʛ�?~�.$bK.��$ �y��oG�|lԦ��ԯ��s�
XDi�h�}��]��T|����� 4�x'@�������ї��+^�%�؆K���F�>GC��_����[D�7���*�X�d�C7�Z�	����*��Z�u+��(_����gX@u�]>�T�R�c�(A6�Yi�����p��s���~XE嵌 $[��&m��u[|���W��а�",��#��Q���cx��-�cx�l,�v��R	����JkV�و?&fagF	yĉ�E��3>�m7S�%��A�����~7d���8�0����wp�.��Wp���,�a�FE������k�W$�Z�����"� "�$�Q�����%46�*�U^}�ݗoQ� �KD��ʊӕ?$�
�J��D��?v7"�Y��Oo��x�3��L�x$�"vs�=~>'�'z���q�%�@D6p�ӖZ�����vC>t�"�Bh��ޯٷ�-�%��K!�2�f���"��w�M]�9g�!�w{(%�P��/'v�+<0�0��!xGqqx_7�Hj����g3'�e�0�	mBQΝ����rw�u'�깂H�٧�NM��'n��fNQV�T�rb�y�/K��%�nİ��څ7"/r�==l�!��I�N@X��!��4."S�2A�OQa}�+����J�ě|�`�Oο��ߝO�rnq?�`�%n��+����ScK�}��}9.��P��<a��+�Vp��|���/���D�o��O�u3�xl<���<w8���W}E�Nƭ�JYBQ���#������.�X䪑�z�?�[6�Vg<u����	$�ڃ���`l�&�����F0��;<	FMṯ�x�
�|��е�f��d1,ؓ�!�9D�AAC^��LS=M,?�X4�C|uu�jj�ŭv>-آ�#=�l�'��c�6|���s�־��D�Ľ�l[K�V�ɺ������N�n����_�A���$��%bS8�HF��y$��5m�${������a��.x@wpʍ�k�H����<�b����	�m�#.g��|+R`�Ȓhz�O��y5�B�
���_(o����pp�%� j��6y��8.6B=�S�Ts�������7��
�eX߼�x1�ԝ�(kW��6�s� �.V�ñ��\�^�p�����b;v�#/Zw�cVB�x��>U�.���kb{�W��/�Q��4�SH�;���X���xk�նҰ���-�Ǳa,�[Z:���#���$p�Z~1x�Ѱ�jXV�Pi�'U=������Ϭ���Ѽe�_α+���e�6Z�@��_���a�z�C�So�8��'��P��E�N��n]�3%k*����9����ݟ�ˁ!�ß:E�ؖ�ܑ�J=ԊH]���x�\��#--Y1�m��O|��A�k1��9 ̃�o���,یyq�Z^��6���$L�%H��	wx��ѭ.�X?:������;8om3�6}�r<��W�̈́IY�)��R�FcPG��
�*= �b�ov[+@��a4��-�"ټ%��䆚�#'C��"��!�zY�vpޭe�H���c�[;�8,�|bkY<�9��ϻ� �ß&�����܏A&��gRK��#+]a4$����*�QN�t����&��R��.ݴMNOJ��mί
T]�ӂ���4|V��u�W�$O�����~���	#���k�T����<)/��{@�C���놪K@���[5��mđε�`�^���Ъs��;X�c��jKX�W�Po�(F�I�-k��=�d�&4�D���b��m,S�b�hf�9(o�����{\��V-�����@�!����3�'v��Uſ����dIRN}��z>��!�XLك
���@��ry1,"r�٭����B��.x�PIY��������HL����B	���
ƗoC~{3K��OW�A��D� S1f��l}���-G�Ӈ�
!�e��!�o���$�1YU�=55gj�z��+��.���z��u������� x�����Y�s�E��B�դz��9i�-�c���6$
�a�_)o��j�a����65*~*�z�� B܄7>�$���a�T�t�O��DY�#��^����#s-6�s�}(�?䗀�5;�ުFS���[w(WZ7�$���Čb&�B���g1$�ī&"�Y���a�;L�E����|������<;_��4/�;��<�$(~>�;B�B�h^��MY(������"�Z39�C�=�y��7h���&��P>����g�_��[��P�
�)�P��/�ڂxWwE��%L�>�
�����    �-�\yH����.�}��+�S!��9WdA�l����5KT�(��7ӕU�2��|@֓�=&S�b0It����6�Y�B�&P��!�Y��@H�ɹ_���T�X���'��4;i�E��u'���˵wh���qh"w�sR�Q�j���Ҧ�dqD"]0�%��-���h�.�xA�������at�T��*ܙ-tH�;��Pb<�	�����!� �;�bJX�����8�H�Ll���RQ�l1I�Ȼ�c�n���Y�u(���f��?M���W3���m��m)�yWE��� �����O,��
R1��XX�������o�K<<�E�WL]�,j����t	�%��nX�yW�E�p$�r��3��"��NVIᜬ��NV�/��"TH���,�LZq�^���	S9����(5�}-�rZ嬵L=�oBf�F�&��-�B���\d�- �sD�j���r������a&j@)/`�rd2RB�����5�mwK�6�JE��cA�C�30q��U�����\�7���PЏ�
�?���+���NZN��᥈�SY����װ!E0�h�H���b�]/76pR�P! 6���\$L�D^-��ꮥ��Z�o��U����a�g�I����!���`��U��ڑ�B�����NH�xW�A�1�C@��Q׍�n�e�֊P�%����L�\���;��L,/FN_A�M7/*{?����"Ic-z}�O�:H��)3�D�������&�8�/�q;�j�.!�p�)� �
7=��k*k /�R���.=����2B?vrQ��-G�'���Î	��9l���j����=@�-G�AX0��iNTu�	�'[�
-�!�4o/E-�������0@�K@�°�>�U������zC`�%y���-��B�B$�!z�GD�r�WXG��>W�2���w9}d��,��M��R� �b�u�i�����-�"��k�ϔ���5��u�Nr�Fx�S���]`��J�ˋ>�b�A)#�S'���]'oK�;����z�K��>��s���}�PY���%>�$��|iEY��hB�m=Nv�H��>��䶄�V]�� �̛��Z%�Y��q�Vr����������{h��������T�-8��E�t4N��8ʓi8$�HSC�f���[\~��4�*��:!����/>f��U�f������<�1z�܇hH�y�y�^L��G]P�#SU����g)�ER���s�(�MU(/�3a��߳@�����
��<�% ^?p�YW�H$d��j���3CB^����;\!mp�8߅�U����f�r�D}��zx���	�Y�lQ��CJ3c��q��Q��'@e	�%� �~	�%b�L*X��!�3V��j�{=�գ|H2���o���\q������Փ�؋�;�DZ+�v�^�2�|��!$D�s9��4l�Qܬ@ŭ ��l����WhY�嶌��c��3
kp�Y�݌!"��ϰ@N�;IL8A�t�E����?��3�uA��� ��7�u�a��M�]��!�pCa9h���ɼ���yy��'B%G�"O>�+�PޯS��<!GecC���j���|�9��Cj�� ����6v`
훝�P�~���H�̵��w���8����Cj����J��0!2�v�Nm��$FQ�>�I��ϩ(NvX�{���iZ�7��O�[�?Xt��o����+��Z�M�c�⥢����s�R{��Z/�t��(KN�S��"Z�3-�g]$/�����0�����A�Ds�1�K0H�DlY��4լ���zD����6�2,���y{^���x��)K�Whj]�vm�	��х�\�@"����
{��L^�͓�a���h�_#���
��^H���,����}f�"#�լ[|�/ej��Tq&\U�M"��Z/ܤ���� #_�v"��p��S��'����6������J!;D`���R��71��hx��_��� �E�80����F&�Q.n�C�ZxUy��d�AY�-����
F�9�Uυ�)eS@�e��.D�S#���)���yk�Z�8;I)}����z�/��X`���3����VD��y
��.ޛ:�0/N�h�����-�|"��
�ݾ2%{q�\&=GH��ߙw�R�c�4R�M�ñOq6�2n�qX��_�LB����`�l�gb�Z��E�_��=sy�3r��dL�"�m��@O=-kS�g������P�w��^v���,���Fsr.�F����&S�g���w���9�TC���5������-�Xq��?De����B�/`�_d_�-Q,���ykCH/ ȁu�i�X�8^$8������_=~���tj~�?���c��?����z�K
֓L&^1�K�`Uz�#o����A�.�Lў���0���Z�B򭗫���h/к��	U��?�x=F$ӷ�m7&"�8'��Ĥ�Ls�T��dZ���9�
� ��w�0��A��]�������+�,�(Y�jz���|(�����%Z���T�^�����R���4�`��n|�Q���j�k�Η�$a�p��WC`�	����4Wh�\�|&Da9c`��UB������W�^ި�B�MR&!���2�^͛���F�(&��՘�3SvC
r~Ŕ���X�h��󌂔m�	SZb��1�,����Kd�:����N�w%%y�K��*Rs�>�/.�eĶ�h�v��-��lK��݊�K�p�G��<�J&�ͽ ����ի��3��D�$��N�%(�5�	�2Mь!���N;�E��)S*�X`�eR)�'��m��ҔC.>7�]Q!��mY)O��m�Z��V>y��``��Of{���b6%}v��Q��cv�{(���T��}V����U��ؗx�䗘Hꎒ���7��ﯟ���|D����.�<�^1�(j�)�0��"+$A`��t�UG9����>#G�`tmFH���!��:���RýU��8�H�de�� ���p���Z�_��s���&6�� �WS�����K4��$����K��
���v��ܣ�ݲt(c�9��73�W�$
���Nn\�lk�X�7KեJ�dz�Y���r�$�RD�YD�C4����>BM�����L#vx�+46�!�˱j������q �2�]����y&�BV�+/�	v�7
Mޥ3��B�ˍciHy�z�A'û��ʾ����/d/�Xv+۔�ّ��	���X<
7p��K訑����-U�J�3cWa�������]�)g����*�	�_���6����mq	��gF��[­=���&�y�G2i�A�����kǔ�Y�_�`�핋0G-�?�M�L��@f���Bv/j�KP҃���Y\�j/�9��v���QA�B��=�3��-��H�$Ԡ���x*�=���qS��>+s@��:�R(+V=r�ҷ�G��I��$T�F�D�0�1E|i*B��{0jz�7�0�dn��@��FE|���f	��l���e���4U#IMI�b�$ܣ���+�9wئC�ʽ,�W��� Eln���Hk�y<Ǎ[0#~۟+�%���Э�B�Ѿ=�=1M6Y�r/��)K0�¯�f�0	]��;�R��SL�ٴ���-mS�Dd.I�G	2.h^��Cp��!��o0m'.-1���{;<��;�5��%����<�!��4�Uś<Y�Wh;Ô���L��������L]ΐP��7�:^>~G䑀�� �e�
�z���5������cA)x�y��R�2u���5eh�G�jkH|ʄ#F?	1O��K4R� ����Lh���.�J�Ѓ��.��Q5:�l��E��2u�O7�q��O��8�:�^h�J�?BBˑ��n��_���{-N;��W�Rt�n���Q�C����E�4,&�.��*�+@���@�V���ML��tg��w�y���!@�oW�r�;��_�l��M}b�n[��e4UD"�^�5K��G�f+�2
��JKXU�){��R1�����I�l�h�
�    �=y��2�d6X�v
�q��#��͇�����"Mx���A2�����q=p���%��I[!����)�KSo-%�F��"�si�{%w�� �7�}�S6��.�W�}�O�!�n���$�zH�;<�S�ܥk�d	f)��CH��&G;@[@a9@��KZZLG�C"��:�1��j�̳��*L�]�H������yH�'��G�V��������.͕��3:/��"%��?�p�(���7Xw�D_�l
���ᥩA�֌�d��C�7p�D>�����aaݍ֩���)h�`�N�!;�O�P����
�W�W�����_��c^����jK@S��BR��t���w���8픀�4�H�d\���!H|�+N�<����k��Mi`�/�p"��B�g1E���!��0S����G���=�|��IX!��H#�\�tD�f���s�قJ~�T��_/��E�̐��l�e��c�xsŚ:�QW@a���
�Q��]s4{5�L���(Cz��n-�::���(~`��|���<�3p I�~����K�/ �x�rL`���K��Z���!Qh�'���za��قJq?Uu
���ڝV�!�pHC��ؕ��R�k���Nx�^�r��4�qӁz�u�~������ɽ��Pt�V%Xپ��0O�M���[��({���)b���E�,0�(�6:B٠<�ʇ���<7T	��G�߈Mk�ĉ��eX�
� 
�L�!~�W�*���{�/~14��5�����%f*�+���o�I��yJ5_��4�)��j�'2~�Xq���GM`�X,�4M�A��C���ԎS�Y�4$>ꃖ����Aõ�Z]B{&�w=P��_S�˫C�D�� BB+@}�N&�I�4Ł�SY��������:a���H���:��<�Yb�u�B��,f`��D$��-W�Sg�6���X�Y�4�(�U�WPXN��jw�Δ��j�>�i�`*�@I3bL��  uK*�`F�ct�.���9�e܎�v%��'눖��+)/�G/{$`��M���ʭN� �G����]4���-��\A��_݋�)�E��:�v �]���3���%T]��(v�|��J!H�ی�#�b=�,*)�=i ��O���=�Ъ�ʝ@6���O�ϰa��C��b����R���� ���>35��}�,��L*���f3��$uj��(�/>`��b�8KWYʶ���#�˱z\�@�-rSQX���{�����H[
%��lR�LX�z�Y!Fvp_ܒW@��z�|I��ٰ4ń�}􄳠�5w���߅&�[(���%)hP�2;M ���}�P[��n�2��v��
|mY#Դ�%������(jɰ�W�_Q�Z���
��e��2��e
k=��^���1PLyb��ZI�~�xJ��[D��"Z�I�V�n��v��rp�;����}	_%�	[D�+�td'�c%%Me���Q^���1���,���e�I�����Brհu!�=KXv�i˴[I��'ZL���"�lj�΁ �;]�4���$Vid��W����S ��KJZx�R^�4<ȑ���I2<$>Qx����L6��r��#��~�ג�i�S�X&J1W�y0_&"��5ܤ�%I�5K�U�
F��(�Υ����7�٣d*��C��[�M�2�
�t)�gr1�+����3%N�_F&��q���E�#D�{�/V�1��!Cbe�~��I;hH��hZ_���8)��6�����p���r4&����V=-�
�j��Mn���$��i�'!:�d�"5�P���R)#x֪�5��3u��3����P�dA�E�-]��E��Av`6���R��l����t�-)�K��A�
//qB�'M�x�5a�7��Ծq��9���V�mL�b��ʺ^�X���:��Wcb��*�V�d3��{,����n˙*�rm����֌y���E�&�>v��<��v#$*�rXϺ�T)�|�TH+}0s�T]`E�����5Ygc-�,ݣ�&��C�2gFe�Y|h1�M��_ЎAZC%d���B �X��&�t�����)T,s_D���k�S����Ս<dWLCH�G��S~����)�0�{�y��H��M])����
�)h"_v�<Js7��x3%����g��rނ�鳷����EU5���ޙ�Ag��C"��:�7������ٲ��Y�|y�/K�=a����q��/�ئT�&����I�:>��^U�.�f�y���VH]���NTC��\�
RE�T�z��L�b���>�!z�i��L�b�ӷtm�;6�3j�����!!�q��"˯��^F�T�uQ
�D' �T:R��3��x��%,�)�+-��1i�E��ސ�W�}����{���Z\B��]E���I�+�z�<Y��U�5������	�@Q��"�т�#G��<����
��'�T���� MV���t�e�Td'1�y��_���kU��7�4�I���NM^�5S���8��$��u��i���F��c�/ը}�*�<ǉ7���Q��!_N��Ֆ�{��W�ho��@ԃe���5ԅ�c�y�����w� �N�U���cپӻ�"�O{�]XjҾ6��O@�=~�YL肳�o���Ϟ�߼��*m*�@=o�����$a8���=��@�\���٤J�\��P!��'������{��d�J�>C('�<�64!_��L;{�@��Y�����:���N5��<U<%�zKXZOF�{��K5��+(����{��
�?X�l1i3"�ㅄ�+w�*b��k��Kذ|ǀ�>�o�-q����z�m�Y��z�}k��o��Xȋ�:A	'�{Me�"�T��\?.Ɣq!�4�6we
$��A(u�|���"���� s|��7���䗣�)�$}�kZ��OX訔��p@���/~,,�=i�. m�^S*i �y(mT���I����!S�U��p��M��^��y�
L�d-�+��؎'�3jm�&=6��:w6��q?U�A�4Kg����*��u_`�%��
IW����4���:e\�@�%�j96{�T�B|��Ǜ40����k�hm	���v��n���N��T����6"�w��LI���r�hn��)�4h�LTԿ �+͕��
�^�T���Vt4�+(SLi�4���Q�qH�94��'����y�4�e�2Ŕ�]8*�-�!�ӈ�QCu�f`���tm��)�ls�W­��هT�:B�?. !C�}e*�ʶ%�R�6g\��w��CD�	�����zy��u7Ne	��
��M0��c�������҅�V;J���D�G����f%!~#��ϐ���	��Ҁz�*�ɾ?�zJ;<�?@�WH��H�rL�`m�]$q9&O�,�l�b���l�ܷ'hYPl��;V�`�'��2eҀ�x�#���@�T���^6Քm������qq���;��0T�ɛT;5h�)��z�v�7tf��?���>�z�v���T}�+(�۬(SM9��hV�v#�HHyc��H�u���h	�1Kz�fcI���f~��2%��_��ڔ�������������C�X�b�G�o�(�?�la�@�[Xi�w��/��(�)�逄̣G�
>��>G)�GSe"D�Zɋ*�GY�(��ً��zHl�����
%S3����54U���
l�g��#���Yq
AZ��f��"�6q���M�T]�ސ�/�<RjPx<��˔P����K�wU����(+}�@��Q81�ne�	���b� �¨�S�
�6���SKqD��!�M�wf���l�W�A2rv���z1�{���V`(	���o�&��\tZ�ā�D�S3�H� ������f�g���9�[��^�#Ww�8*�/�=]�#T�t���g���rd�aLUd���?A�D�s'LYd�¼ro?Q/�`ʙ��o� _ 	�����RW�(��x�4(�4.�&�F��OLpK<�¶��8������C�tK<;��C�k��g�������X��T�
�MžJ�
���<Dʽn���7"�J����[[XF    +7{~>��@>������TB��_bh��M�ғ�T�2�S	�&��XZ���]G����M[`ðݙv#T���e!�ُ_�,/Ӑ�K�laI���v¢O����݌�
У$qWPu{���	��d�˱ڜ)�$wͽ|n�EB������.�Տ�p��y ��O1dk�{�zʛ��'�����;p[bn{��5��|�\#y��QxԐx�wGK<+"�7��RO��Fl:��x<k!'P���^�-�ԛ�E��ܐ��>&�)��$S拲2S&P�e�y���J�[��Tܯ����_2��z����+�mNn	�$e=�]�4�R&!�z�?d4�)?�/�V�hr7	��I<�i�͉n|�HF���� ��@_��TM�A
+P$,�}@"R\� �*�1ZgH#3	�7|h;[i9[�,_@�$�}zrț�%�W#�:
�+4��3���¦��`GB{=P0t�u/E�.k˷	��ӟq��@T�]#�%�^2��L�!w�tjc�������Z�ڭ���?�׮�`Q{�||Q' ڜdg��(���'7��/�~�Γo��`��`���Z��r�m���j��pg��)9]1��#$�n�os=�Y�8a� ��Z�ֆƳؑM��Ԇ�x�WJ�v����v���64�Տ|�O�@���<ɢ���:��1
g|G%e�Է�M�"���ǯ��+�։ų�"�Y��"�B���˝td���R�"���ii_=�j�i��-67�3KB
�^�R)i��<�g�D`��
Q�ğ k+d�a���U�e����O���1�g�vK���+!�tJ�d����~���r�l�\��J��1c��4$b�PȜ��j�*�`in��-��'����Eu1�>����d�9�����>���94��M	��c�c�0�	�Mí�@_a����.ܱ�Bil�|�� ��nbH+$��8i78y�A����f
e9[��T��"��gJ��"C�N)rG�/��_q�R�|�Iz�C��?�Ֆ� ��
�N-E���k�-��#��c2�����F�3����)��"�n�#bK A��$�WR�B��!w,H'g�v�A�B�?Db�5{�ց��'�&��Ӌ1�0�[6I��`W̩[�t�-�B�C�H�[��1io�I�(�k����������d�e������GT��D�K�Y��.���U*#�#FC��%15�7[dm[�c["�B&YG���3����=�s'ڎ��Zǘ�
M�IJM�\uo|�Si���P��]�H��L��/�g�#{7���}+5�Wg�ď��i��S��&8$bSSI��f��cFW_��7g�Y��ȥ!5r'���'�^�T��T<$��4&��+*���!�_�lN����%(��@By�w"�/5ֻI�g%��䥍;�cXԜN}��7;��D�Lt'-G�yZ����N��U菞zU��x��t�;!-�g�o"��Qz�T�=��D��B_��F��e��I�>LH���T����S�0��}F_!���
U���Xn�"b��e�#XuP��-V������h^*�I�ti�³_An���ڹ���ك�G�Pv���<�Pl��߇ft���ۏ���
ߞ���O�D"����V*�qƍ.��
u}J����Q1P�Ӟ�k~���P���E����BDr��R��j�+�.�e7c�����'x�hw��#�"�+D#�A��U�P(li����h]2���߬/�`U�?�`���#�n�?a{����܊�N\O~E�B����#��"�!Q���7��Y2���3*|�ɓ�������c+w�m����0�I[�54����~�����/�_!���rB�Q%� }BY�sHq9J�V��.,i9JPW������>�MX
у�nO��G}N��;�,R>�F���>�L䑨���=�Yd9a���!��*t�&.�l�~�4K�F��R�l�����YoI��@����v=�L���m�?�>��_5���@A�I���J �J�]5u��g����<˸N���W 3�z� ��΢y�T����/�P���x�86��%�����!3h��sB���iZ"A鑒%�>#	K$���4qz�.m��.R��p�>"g|����g�!2�A�W�]i	"�� �
�X�u��#���Q����7:]�gbK#��56�x�¥�:��,7�f�V�E��B#�����yF�� ��e*�B����4��3i+��1�Y8R�H��-y��(�y����eLz|v���s�sF��$|��9J����>��R%���X-�|�{DIia}T��0�7��I .����	�R�&�n(�7K�� �;�r��n���I���Sz�Mx���g5��!wz�x��ݶ���^k63q@BsD�Y�릚Q��Ipos�;>���&Sz�����U���t͒�ڭ���Ա%oR�MZɅ����0Is�ݰ�$Ul��m�%c�+<������J�O?r�+��*2�m����]eٛRɐ>�r2"v�\�n�M�d�&;�+���,F3��"�+��(�c2�9[[�؝�����v��!4����]���
O�>2L1 YB����*)$U�-�X@]���!oA�s��/Q=F�����ɔG@��=,m��)���l�\'��,}�Mtl1il�j�
��Q�"�_\2�sϗAJKL�٤W�y){꺲ڪ��u:��i�7[h�Z�b3z{j��Ԩ�{��F�cŧ�+8j+��K��Kj�����θB����L�N2|��� �<����V2e��%���+2�n��4e�R9�c�Q�T2^	�L���M�{�r��m$=������UWDw�u��hG�c��
K��~�!�dj&�SkQ\!�̭��BK��{0�v	iwM����߃	���,';̊+0����ŭ��6h�s����3X�M�	�S��)�kf���7QȋR߃�K���<�P�)�� �Ճ�3�$!%SP�$$�3��[{5��y��h萇�&;��<Y��TƩ���F,W`�k��rSY��Q�|

�l��;��TU�k�k��4��+�/�PƽEV�+!i�Q�r�Ĩ͂�E8�H6#��^�K<F�O��ҎÆǝo�ջ�S���7+d�;�q$5u?Vi���b����B�g>���>�[�����QJ��������|1���0���Љ-�ߎ{���G9`�����]���gMi*'c���j��"�NB�� z��36$*����b�|�ZB�v���(��/J�h�K�*����Ʀ{j�rc�M[p@
N*`	���f	�����`o4� _�L&�qH>�����w�Le\����hS<�������$��:�r2N�;�����ז��@Ǝ�YM��!nf�
�USYV�;P�yߢ
+T=�%��E2���b:��s�e���W�j)M��N�f2N��%W��A�5ԑ�p@:�R���}d*l ���)��S�rOꐐ�;�z�6Q��f	n˹�Ub��A��	4�˫�W$�;�ҰR+�z)�&e9�a�/;�˟t�H�CHSQ��yM�%$��Q΃�m\l�柮��EŠ���%�J��T�$�SƉ�S+�޻�*�7]��`~��3τpKHI?�'+�B��&?�M��#�ԙ��&y��h�ZX섻���l����jxL	e��W��l���#	��m�����	�P�O�ְ6�f�(ウ��I*}�f�yy���KCK�y;A��`��M%er/�w�q��-d���E��|	s@f�c���@
+HH��3w��DC�����z�縜������}H�sXi	+��}�h�',���d��c�Oy�i�L}e2m�ۯ\��-o�A�ɧ��>>u,����Mq�+���`��_Re���%u�����3�Gg���Ɋ��F�U౩��R��sD�Oޚ�zeک�u�؆)*MܵA�O� ������N�=��������?�._@��}��V������|R}/�l4e���|b�    8g6�J���#��R�%SN��fSB/v������͔���.KL�Ed
)���)8M3�53
)��ـ�,�~{C`Tm!/0!w�"ȝ�k*)��	+QÐu��4��n�ڌa2���($�[L ؂J+P�{z��j�����8A!6�n�vފ)���:�p�F�0;��6���;}���-��O`J)S���S'����mc�$����?��Ģ]�Z����8&N4�3�΢HwX6I�ɔMڹ��K�&����������6��K)^��o�-����L������m?����w ��wC�u(Me��4�z�iCE�Y��8w&m�G�5q���J	֐���D�3�TQ��A\�u��@>qC���0%�)�Dyus��b�4Ś��oc��yL�t�a�;XNߨmk<�"^`YZE���E1��Q�X:Z�z�t���J0yI����p��d
+Ӕ�"�ǿ{g���)�G�B���R��Cgϸ8z�Q*KL��x���Ț�W@͝�b�ĪlP��-0N��� { -}9F���d�*���u��� ��K{K�Fg#�͜�N9SK���������"7e�v��H��� �΀�焅�p��(�o�t��E�'�q-�F;Ug/�z�Z��ې��7d[���6��b��	}��U"�ȇ������7���kg��ɦ�=��I�$IiC.��xP[I�KlG����.���09��7{H�T҂�=e�Y1hε�M��b�8F�<3�
^��&�᱕���d
$��2�f����n�hy�����B�!�.�M:�)���rX<Bx���x0���KH�S�\���}�Ga�"2��F�;R^�WE�Rh��	p��C���(P~;F�l*S��E7?�ķ´K2�yjg/.j��☨���ix!�oB@ ��ᑾ}���v��Lqd�6;z$u~�i��L�d�c�������vj��Ƀ�	6�T��D)��c;�x��� 2.Mr�cO��2�]�#��bBm�TY���[�z���˳�T$&
�ьWrH-�>��"�W�e��J�.qiUÎ�f��|�t�nS'Ɛ��y7^ěI�*.�֯�����V{�[X�3_ڇ?����h9J`�Be��_b{�;l=R�LuS���|��;yDu܎�G:�S��uց�{���Y	����83O�,���a���*�� �<;Ft	�M翧40Hl��%��\r�
��:w�\3�]����]�6�Mk�S�"�ަlz�$S�������HO@���F���,�_7�vQ/S�����t$MѸ�,m4���5�ԐJ'w%t3N����jK\�.c�	\B=�L�i����?�4u���k7b]�����z�벓MݦEӭ�i<fi�d�G�'.���K8����B	�feS���!ԟ�F�}{�b�{;Lq	�#�t�B5�v��
��>�	C��0T�Q���]�D����ϦV3��A�3'F�/�m*E�=R}���VG�ML6���Z��HFUGT�#����Mufn#��ܹs���Q��B�z傔�-*�>oa�j�\�P??m���G#;'�:ɔe�) �ഽ B��n�L5f��x�6=ֆ�V���o��&�d�ǔ�hw��bL���>�x�rʼ�ᅺ��:{���.�U�NRU�(.g��;��e?F�l��0I����-�]d�/���O^�X��~�C[��N�����4j��7!��Lq�"ٝ�0bG8.����F���.��ֻ�SXY�g�G	Z8�
l�~]�zl�_��-�%tk��Nq��x���0�s-y�}k�xߝ�~��^�� �Q����ÜG���/i�	5/ ��:�3Ĕ\�O�,^A��`��L�ey8qi�A�G�ʽ?��l�l�,����ٔ�+0l��T\����r�`p�Ӄ�Q
�	�־Z/j��X�!�jÅ�M�e��y�$2�tZ?�B�k)�r��!��E��|Y�%�������J6������&�MɥA��TQ��a`����B%=���"g�ʙ��!W���?��J�'Bz�t�B�g�J&	��4��A&i�4���AY7ɦ���lc�:SEY�N^��z�?x2�,�Ę�p�atEХ��(ޤ�%���Ȧ��Ηt�vz�zM���E4���gj³�����+�Bʒ>�)D�};��9�y�����O8AWD���B�KHO��ô3<LeI�a�6�I�!��3dM�d��ג���T��)�]��,�/�d�f>��Ӧv�\��~^P��]Hu	�.zݷ����\_!�d��h�).������C�o�D�'B���Md?�J�#�	W��xS>i0����5H:Y��ue���/2ϩ�6�"$�����d�u6����%R���Ll�5�����xf�m?$���l�$-�n^����,�T���b�պ�c�s,e�d�J�M�Qu�U���z���mlє!�)l�{�y)�2�Y�uC��*%^�JkGr�
[X���W&��B��YrK��E����y���sg+�-\�_�����1f�k*}$�B�;�L1I�\�!~��n���!��G�d}n�wo�[H�F�K����v�-��*�sU[z=���$S@l|��#�^U���>t��B��v����Ϙה�r��kL�v1�%��A	)F����J�;�\�A�@=O*��v��6�Ce2���l���j�sM��naY��r끘\��>8F/����ֳ^�b�v����k/�_|.�씷Is�׌�� ��nW֫�/��)�ъ(ݺ&y�^ۧ=��_P�_`����c"X�nY�����7� ���n%�$�:�i2&���~4�v��l��u1��iSy� �<R�і�%D(����i&ـJ����ӝ�j�-�3�f�G�B_E��_VQYa!����Pf����7�&o�T���D�P���v�$1�mN��[�d������u>�YJO�l4�I[�=�T ���2�Tφk�<�3UғD%L��k~%��"��:!�;;�d�8���g#���$x��GA$�W�1Qt�'H�r`�h_!Q�&:f����g��'tNw�����,���G���FY����J2�y<3:�u7�!�S�_^m-�a�v/����~���b��ڵ�_}%tEG���ӂ��$�@����w_I�m�=��v1�|�%�������4��N��{C3׻����N׭M7�b�W�5<~�%{��Y�4�:)�����D��l�����f0��ǒ�=�9*o��>{�@�wV�,���%�#0&[�͝���6�� ���@�M�C�� M��7Ş���y_R�΀����)%���_�;��v��&@�UMz)K�E��6>���,!�� ��Ҧܿ��6��J��H�s=K��!,��c���ـC�亇�)�h'��7<����6�!G��O��W�u��G��Az����]���Y�$)i�zn/���CN�����\��� �&�7z_H�R��{���bR��Dt�4�ʴ]5���W�{���z��/����P�u��m�b�Z��M����6�XLXK2Ӯ�3�LrS��ݰ��h����n��Ԧ6��YZ����%�H�q�я�N�x�nn`mG)/au*+r��k��{�&���%^����w�v����i�2wϴ�`P�X��w
_t��PLzO�ȶ�j�����)&����Om!k�xaUa{�'�ROTC"�`�N��?���lXaڔ>��ӦhMT:IUQd$b<�vv�3�`"����2zo4���>��,Z�;_(`�Gi��Zi�Ҽ�/����hSM�#�k��2��Z3̚C�I�3�*��ih*|[^LzF�FH>
�'[T�Q�E�pU�Q�_��R��Iw�4Oh�"�B��v1�%�g��;zO�a��Oh�&�Y�;�������-'��E����%��P���n�δ�i��T:�c�NH��������
',y��C������}H��MFM�,��VH�GG�Y�G�35��ǐ�6}x����v_Y�[v���ٸ��E���m�Pc8���b*�,�8���E޸h�Q;�n*~x    �Zb������Q1��pڧ���i���'\��������f�}�l�ae�+���!"5o�LJ6����v� �֯��4J6�ڐ����p����p�w��["z��u��YWqR�JO����̕���8͠���Eu���gn+R�`��;s��ZJ]bz�<�
�FI��B�X���.�S�r�L��}H��?H玣�a6�RyT����S4K�PM����2��>���	�X�rW��q�3��ӕd2�s��=�qwZ��$W�;�|�p��Ո�ntO��	�
J$�5QZ�j�{�v�(9$=%�B��2��l���ι�TP��^]�2�|JW��٧��"U�QWS�*h���q����G萚�u�XD0�ֺ<��&8�e�/�v�K@��&��@M��d�۔a�(OC�[:��и���T���0#\�����J�:���E�ph����2�y���
i����+D�3�����P]X�Г���"�KDOeN/�lN�z��-�����;J��YW��Hq=�mʸF1���σ{@��f��]����(I6 �$nd�%/����9���O�
*�d	���[bz<��'[`���(�D/��F(5��w�������J~	G*8�H%ߍ���vD����Y�{,����f,fw�=md �{���I���{f��Ȉ-�PI���������(�dvۅ�����x��B�q�&�z��kb|��ژ��N��&[�g���UQ�zj��<�@����L���K�k�j9뛨�>��d�#Q�=����՛���!QA�Ƥ���n�+m$ⱌF���ϙj��4\0� ��ڐT�o����<6i�?< 
Kr�;���!��Ф��/��ϻ�%_�¤)�e��
ʨ��ѯI�S!��M��!�-�x�vc���*Kd���Qt.NE;�bP$C�?	3jh~�
3Ǟ6������z��x?Qבbҽ�ӡ�t�
����p>�i.�CwT\�x����C+0�ʔ�-�v u#�Ս��R�y���K��!�T�~�;����x�L���GPIhg���بy㺖ϱS��u��M��x�%2z0�}
d,�u~R�xO�;" �֑�7_���?id,����� V^�CQ�5��7r��L�$ZCy�"�]3��*Ś'������V]��=&�eg��$��nx�p�wH�e)�_��E�|�E���gL�*�V���؍���Ӟ��}vj�����;A*���������W"PE�	�7�^sΘ�Sg���59�9�F닽Z�4��ǴNq�+(��lG���ۂ���n���E�̬Q�7�R/�-O����v�衻�es(v^��6�X̡��r�s������1�
��#���vv��}r=R�e�]ȮG�Ǟx��6�^MΉ�.��H�%�מ��P7%;e,�Mӝ!�Y�唗7�xe��T@r�=4�̧Lt-��U�>��{a<�0��z�
��"D\�3%Ļi4�~rɟ� ,�bJ��Ѫ��ɪ��r��� #"Q�l�3�{*���г��,mq�e�>8�$��~��n˫�ɪ�!�¬d32�8�l���~�8��͇U�Y�뵗N�����
L�S����ׅय़�N�y�t�ó� ����A�+Ǫv65�Hlf��>?�h����@a	h��e��MۤF4-��Cs�y����-��*��?���ғLp��)�I2	�z�=q-����_u	�I�{�L�D��]. ՞��(��䗀���/�@q��uZ�!|d�<	]P��?�2O՚���WX K��:��07*���=uz\c�jZ��l��Q�q~ J��D���|���g2�� -��Q^�*���jR(�1���8YI��v1�^���D����a����5���34y��ɭ����D��]F�+�%����il8�?�x�����cI
�Aڄ�I,	Bg�s�����>��;�����0�}ÿ;zw��[/`��i��l�ə|l�P�ޑ(#��*� ����B�C
ޘ�C����٤[<1���ZIe9@}m'��tH�Cw`RO���#@u	(ȵnfW�<Q�MO��BI^�\�K<b���+��r3�a���9L�\M��go��tH�j\����_`	3
���Fq72�Z�8,/�:���� ��1�z1Ae�	�m����=x��/@���~Q���4s?�\a��k�˰�L�g:oQ��M�wR��H�m	��ĝ��XE�d��m�!���ips���A�oce�"�h5M��D��
��G�n`��&B����r��b�Qt���.=��oa�q*�Qa�RP'g���� )J{>�hzt|�U)���Ȩ�j��
-ǺD�8K�*������ũ��'ܦ�~��
̳��@;�ޘ���e� ��ƼD�8����6�����?�.I[\O���m&!&���*�Mna�%����z�6��d�8�s~Jz(Ұ|�8t�L�ЖP���@��ݤE��E���㡓dR��H��<H�u��7Z�Ц#x3�0�#��%�]�Đ���A�L	Ax��C���k$�
?����t7Rf���6��Pl[�.�	V�\T���}`/�v���8e�o�ন�����6 ����+�]7�D��mH#_H^l1��r砘<�7%o)��Tj9�M���WZ���Jɶ��P�/�So�NrH#���}�$!(Bg���.����.����%��bK�.��	M"��!����ṽ�k�$M��<*�|ʹc�۫ǎ$H��-�|�.�4���M��տ���ʣ�H�MK���i�ӎ��$�$��q(�0�Y�CN��4���^�E�ô�-6� iJ�}�#��r���K�w���4���ױ[����l���P�T�1?�="���V�Ig����6���6!H�D���d�v�+ߦ�4��>��p�"�-�Sy��SD#66�G��H��9���}��م�(��)2I�*�%	լ�{��F3^�L}ّf��ˍ�q)�L9�'s�t!��E�J��Z�-�����䳖��UWTΆs��&;"[N��@IəE��;��ْ�|��m��6w�9H�(�cve*�GH_f1�@�ipC���������G�|G`�.hMYg��.(S�F�G��ғ����P1�-i�ې��\�Ta�~�Q�����M�v���V�!OI�}��ݧ���@�w�2��{*���fD���g�T64���(a�i[�X��<�Q	ן�'�
��z3N	��y�^���%��F�5hK����cv���c�\�}���(i��>o6r�xe3y���1[!ُc�|�H��� �����^*����Ig�!I9.eT*���U31bn��%�E	C`�6 �r\�MF����Ǧ� y�i*82o45��Ɓ:����ٸȗn�P��v�3O(3�Зy�l�u��}i��`<�!Q�r���I{rHt��Z�;����Iל�G܀+���&g�&�F��M��
3�\H���/R�����l1Z��1�g��=5BQ�N[*[%˦�z�X<�Ͳiq5:	�ZTn��d�ڔ�!�D���HvBtJ^TB�:cu��x��Ђ4Rl������I3Ma҂�n���?5�~rPs�&{HR������6<*yfG(!��~�)������.����@��z��`�$�<72�?}E������CBc����w�.���16*���Ԫ&��ᤘ�w}�� �/���r?��-$�"Xo8Hz|���9�r��m;�?�rn�<U%<��K>rB.-Bkw�,�9hC��Ƈ��d9�US��'1��(�2;�7~T�[lu��Qݹ�����|��~��n;�>�s߼�C�IڨZT��&·%"6W��3�%��]oB��rce��CN?W��%v�X�9R�R�Il��F�g0<�q�R�������@1�vy
x�~mN}D�����Q4�+Eu.aX�?���@�X�����dN�7�]r@�z4����Z���G��?�T��/�3Ro=GQ�U9�q(��pV`#N���f����K2������
�/	#m�(�[ ER8[�c���sW�-ތN࿑�����K��    �-�3�"48������Ay�� qmY��nTL����<)�K[�n��ĥ�ӏXy��5��nkm��s!qx Φ�R�&������&�&�i�+��24�4y
'�l�ja����Y�'�����5K�$�| ��r�p���X^�J�S;q�w�$ ahj=C�C��"�^kL7c�SC&�&����$��@S�r�p��F$g�i��~�"`	�$��h��O\ád*�R55%>���n�)�ِ4Z6Ϛ����jjZ��6Bݼ��y�N���A����2�r���V�t��
���ćꈰ�bwG�ݘB�����0��5t��[ԆW&��$e ���`�H�w~,KDV4����`��> :�}�SΫ�!Q�y�o�Z�l��%6!H ��h�E �?�ȁ���Z�г\oFkw̙��L��#u���y��U�푦�!�S����L~M��QJ���:� x�r�k�L�C�Q��)y1-,Ļ�(x!�Hw�������@/M%B�xj�i(�gV_�	�����x!���4�;v��%-���J^A��_@)�Q!�Xý&�}�JG��CFϹ�U�Y�����5�&D;d�^`�I�t!ǁ&�``FE���ju\���|T������և�I[�s
���M&Ұ��R��^�OB�Y,G�� ���O�@k�v�d`�9aMQm��i0����#��4i�}C���;���4���^��۟v�_�B��X�,M�.�ȅ�7Ga�^�dxz�۟#\�)ߌ�W+���멬�x�� K��_��*�Y�<�y���g�;�=^����:*cmNH�rXH�eS�k6w �pKƅ�"���M�����d��{7	�i�xL�'w����������Z4c����dR���ߌ�rڄ0t6��o��3��wM�C�;7�>3u�*��g�$U����v:A��Id��4��g������P�#��^n��S�s�є�;��6ܨ�8ޜVO\���Z_�x�-&�_�f)ƴל�nO��T��k���8�)�mkV�)�)/1����zk���oA�ξ~�CI��fCԣ�}����7�!�R�
-����
!���O�Q���Lg�?Gg����!jK0������	����+���H��xdG���s��BE.��PLdy���^dC�mY�6q�AP� }f�-i59ݍ�^2�����0z������v*ӐOc#w*Ҡ0��:���Ӽ�`�rˍ[@}ǅ�І���R�a?�v����QB����PM�qCX�	 �ӳ����z�:��
P'�'>-FR�b�[]����:�x��|�Q&ɱ�|y�����B%s^���Ǜ��I��RFU�����?�l��R�Aϯjp1L(���E���k6��f�R	��j�|;��I�Mf2���z�3�-�:����8���1m�������	
K@��c� c����R(�M3P��p��m4P���],F�ć�U��~̼�u���f6Ղc����� �B�B�ݖ�L�K@Or�.a����p�\h�ă�X)* ;��G湔��A�w�:L�b�If48P]�ع��3�:�C�3�[�3��A�삤��ϣavS�8��oI���L@���զ�6�2��e�1x�c}	
�/7�2��i
\�V��r}�'Ҹ8/�x��vy���oFjc!�cf19I���3X�sզ-ә���`�Bk�L�h���2󌦭����)�K�7��kØ(�l�ӟsj_� ��1�e*uG�rr	��P��=�V9�n3��C�9H���'�h�i4^J�ĀXT7+B?�{�I~BIM�`�~e�?dr;�"�
t9TsT��������BrGS�݊��2�+�L�M�#C�".�`�J�igg�����Ϟ7M��4����g.�����V���L���l#�\qOA	H���eAg'�1K_�������QY!bO'���`xe�b�ų�<6�V�
�� ��p�� ��i�%��v�F
>��F	U>/
��ŕ���-���iKP$�ٵ���I��Z�P���v�p1p!],���xsBfq���g��[c.��P�H�|��셑�r|�U�L;uh2\��<qE�@��" ��j��Q�py�_{�B���l|�}51(��J4����J\��Sԓ:8�v�ǣ��9r�3v{8��t70o����
�#W+$�ȤhZ���S4;�9��LYD.��MiQYHޡN3��Wژ$�t�8m��&I�L|��ZӼ��K�:�)sl�R�?�d�5��;F�$�L�U.u��9��ԅއ�H�� �ݩ�;͘i�8��	���Y��Y=��jo���q��^y��
�r��ԗ�:=w��GI9��Q
 �Gc��J�y���͙�Q����^ό��g����1m]��ِ�y��F�|QOE�f�f�N^"���5bd��}����(����AC��-���ƿ����Iܬӕ�$&研1GzTLT�ܙ5���i���i��?��XT�wKnT�h���h�6(ɍ�Ot�fcnb&��!�0���[f�dz>kP�����WH/��iǧ�P�J�/��ɍ������q���e��/}���9������$d�i���@��ǡ�娨pL����*��|�h�]�e��eٷ۪,QiԢe�i�El]�d��3\��T�K-��*�=| �H{�W���aJzFqyC���aLJG
�в�v����G�6&�/-��m��w���/����%�G-���}٩�1:4��}EԿ�(#�L)��F�M�m U_��S�O���y}�-�����P�w�᮶)2��|�)$��
\�<�c���$�x����ٰU��ǀ@#Ջ������Q����?�6��W ,l�l��K=3��\HoȪv���abq�n����c�c�Q�#�z�7�C'	��
�F��1iuTx��-��Z}�0��F�����N���#��~�6�af��\z?j���O�^LEk�Рz~MS^�\�5Dx뫰����M�0��s_a�@w��oⲣ箼�{<|M�F�z^B��+Ʀk[X3��Q�U�Sji���ćOѹ6�w��B�p@H*��_"Ұ��� /�J��6*1R*��G��T(3��tp��y����#ɎX��+4Ĩd�r����(!a}�J�NHP�*�7�
�9��~�5�a�mJP���!҈|�/��4~}x��ڦ\C&��c�����ֱ֎G��\o���3�W�=�m}Cbmsf?UK��USbj��J=���בd�|ۯ�B&>N�N)?����4
�l�j3���H���mGƇkWe�nD�a#�j�v?���0��CV���Bw��[H��ڦ�G\k��)VdQ���ٱ%�&�N����,�RXΖ�\E�����%	�g~�� �6������-Z�EM�<[q9[��QbL5�ە����c�k;��,��ͨ(�C��l����(H��o�+��ۅ��]3�8��8:���m�~���¤"^z�+}��%��cڴ�n�U`A�,A���j��ca3�%���
����Wԃ�l�툄���ڍ�s���@u
ξ�Q �S؈GF1�̝�A��l�y�vp�Qd�V^�2CIlv��j�z���H�\��M:m�*'a0��Ke%���B[��[�͊�٤��/��~SXbz��1�i�����i{'H5̇~#ݷ�@yn�S��L��㴅d6V��� /�>B�5Vΐ����i�{�`��W*�ӝ��&ҪP"�;��)s�-���Г�7HZM�s�NJ����4FWh���)r��WۢfAт��Ƌ�*�"Ӫ�9����>��
k;�b���+�L��E֍�r�_�8_ƃ�vr�t��U�#�G�?�(�9s�\����ڦ��s�Ai��D+Iiٟ'�z�bmS��I�%��rf��Y�X�/������7tV%�{�u	
���X�(�tTΣ��G-���JYBA�&�¢���^+=kՙx�~J�E�T�5��ųS��'2_!�"Q?��/dH�/�>����X�b��v���M��g� k  ��`���x��jp
��N�Fjsb#�٦�KU{vZ�Co�ҥ�� ���ig<Oп���z:�[�>��*���ўʝ�Q0,��)�G��W��1��Sy���\-�&�[��8��җ�o�ʌ��o�%䖔�	��4�����k��Q��~t`z�oL�A24�>���2�77z�)!�3it����7�"�v��(�z�B�Fg�R��YB۝�����.��Y���TJ�
8�4��o�����d	iw�k_U9y���uLf�MN��V�`���pl�tS��C���8�R�睺co�F>��Z���l<����ݪ2|�>�QB 3	A)ى���N�O�#-��6�w��u=]��sw����z�b�דa7��$�'�
�x����3�~��잓]^��.tCy�&�ֹipq\���Xy��8.c�����*�)��=|pٳ'm��@��
Ut��}}(>���{v؏t@�۬���w8{՚`H�M.<yt xǁs�s�|�O8�ك	��N/<i[D��x0��n�@�'^Q����P�*�y��+*�c�+cf^
�="d�Kn}+�䈌N��q�1�aڜ�F��bzP�u	iw*�c�T��v�MH�id��(I�dK�g���y��wWL��+�)!�����䔿�3�t�n-9	��L=m荧!���	���)Չ��|�Bú�bkKl�SA, :�Hr�w"�!}ģ0��.���v�6��!:�)EG����:��G%�����[Vc\�5�K�n�Cz�S����� ]��,R���#�f��?�	���l����{}{�ժ9�Z�'7��l�x�G���F����.߭ ��SbD6�:&�S��P�2b�+��
2mN���}!�k�Al�8�K ����l��H��!�f�tq��/H���xh0��>eZ �,���eD��dr�cĶ�����Lo�||����O�[H̍���I����NW=쵍7=/�7�I�@[��6K�n_0�oW�
��R�
�����_���2kYD�;���Oǂy"j'��$�����b8�}=8�*)?��6(<(�}^��,������+/�餰+2R�@��l��G4Hଉ��m;ѡf�����U�����}	ig���n|��xD�7*��Lz�wz=�":�ܘ�U��x������]�1�DP�(�`��.��0���"�|�aңM=
/�kPN"���p���T��$He�@'��K��ţJu�R�>H'!t���7),�<�m|G�[�'t��G7�/"*'���)4#�
t��;�D�	n�H�Nml�t��>rX��@�T���u�����(���ru��A1�焾&�l�����1Q��&��E���h�{2^];�����}S_bz��_`�]��-1y�����a¡���Q���(�Ch~��m��������_BS8X�ٝ�,��vl۾H�j�h>َх��hV~_���#��x�d<N������v���c��5������$��mn-���Jf��Tڷ���e�w\�����7Fˬ1�}?2QL%#��-���lT��MX�r�����!��f��h}Ap��"O��)��I����hcۥ��h�(��5�Z�s��B2��&�҆(�&�q�������GV���x�- �t��ZZa{�m���ۼ��@=9[`�.#�˦`���NAj\�Rŧ&���`,��G_م$�Ofh�r�������n7��?p�-��ɉ���VXq,.P�<��/�<�Y\!ٸ{X!y���i��{\.��w�/bJ+L�E����,��\M��bڶ@��	+��Fb���@O�ҳ�Y�7H��ȸ�W7⡏��Ό�,�S~Lpu��,�u/΍���OpEZ-#��)$�|jr��[-�I�FV����.�S���� ��l�)V���+����QV!j��ы�7�|�3"�'�O���O�_�u3����YUs�$�HY�TC�rDi�X���%�gBH�gn��,1=hg����̎�lA�}�I�B|�ʥ�ܝ2:��N�(63�n�y(��LF{�Gǣ�4�=�T�`�r�#C�a� ���=���>��+�!��0�[����0�r4���-���S�$���y|ӎP\��� N�������� h6K      `	      x������ � �      a	   �   x���11�:�"�L>��P��X{�s�k�&V��7���:'��������zp/�-=���geOJ�������!R�}TL���R̙%�2n�y��T��N�BA'�~TC4/�:�2B[RC/?�%5%<~h��_%l�R�M�8Ծ�l�%�*D�e�e�      b	   �  x���Ko9��Χ�/`�H�97�	6����)
��Þ
��8�_j�yX�'֤A= Z��>DJ��q��e�vx������=�z������n�w�;����:=�V������:����L�!(�w������B��O���^����'Yٍ�(>�����^���8v�c�ۣSƝh\��Y���:g���T�"�i���vhV�c,�׆g4�Ӕ�"�� ��}��׮G��h���O�9g؊e�����8�4��to�
�.�@�1*_�f�oř���V���-Ɇ�c�r~E�BN�E���!g���p
i1����������{"]�j&,��� 8-��m@�/���B�q��������t��gw�����z������zC=�p����h�z��A�l�|lw8>�Ⱦ��-�A���H7R���K��RG��_g��h�o�ӹ��w�Ar{B���b[X��ek�	RUR�V� �
˂r�d3�렂��Ќ�h�	>��e�8M��8��b�>�I���S�����[�:S��Y7��iJm�F8Y���m�IL��9̘�(��M�沵��1�y�B���¾�נ�����"�\�|�bپ-(Ky��a@�{�.MO��<	1^��#���)�E���=����h��t�L���x�4�h
m�fu:(#�C;��~���3�E���S������"P�(���R<�ǘKǙ0׋_�3
� ��,�[y*u	ǬN�F�hҡl�Co.c���f��V̵�܎Rj�,�	��,_˰�=�a�r)�0n<Zx#N�����a>�.82�g���P�y�(pU���0���0L��ʀ_�G��\N��$��H"��9z�q�F�X��)��5LU����CP9�� `���͉��Y����Js���z���q� &��ށ�%� ݬ��,���R 9�Tj���av=���]h���
�j����Qk����cH�g!�+�2/+�}�h��R(�,ן��#w�4�)�W��[��zq�n#Y�J$��+ @v���+i���g�P���V�ZYd��%���Dމ��G^$�����@cCǗln��%�0*S��ּG��c�ʥm �5�����΂z�&e���;4{��>9�f���݈B�W�$�B�L�V�Z}��uss�?'�I�      c	   i  x��[Ɏ9=��b� �}9�ð=�h��:6�2��4$%QJŜ�U(d�����'."K��c̦��6��ۯ���}������qo��x��l.m:�]��z����])^kW�����k�{��w9��ÃPm�z�Xؾ�~���f�%��t�q�t�4nOJ��F�&��KpϪf�ٓ�= �=b|4�t�}T�5	�-��)?.t���8Z����"tz�ׄ5tb������g7ݫ���ƣ���� n�x^���+��i��{, J�M#5h� �m 
��|�Z���fz��-ԆQ�������i��!$�iu�Y@�)���7Sv���B7���p�١q����?���֟�y��=��}�[ �k���%����h �wQa���2�����n;���t��db��r��H ��u�I@s�P��"���=Fn�?>���� ��AO�;JG[\�X�>4{t���|���5�M��	�	-�;6*^Z<p����Px��������Ote�8�mq�w'�~�)�!�ݛQ:p؜��6AN�_�.+U�Z���0�?�Eagfs)���#�򇭅�×�X�|����9��F;�p�Sp3��Ɣ��
�g�q@_�4�ՃXE2,���lA���pZw;�4�7��b�?�n�:��?5WM�x�_�����q�q��	�\thez��k���X��(�i��J��9�Bn!��b'�T��C�j�qo=�)�p��!ɍ;ܥ����y4��k�d�1���;(�W�N<ivٰ�Z��Bp��5,�g,���(�,����!h�N�<��<׼ۆ.9a�z�Eݢ,`��qr�����`�%[48gf���0{FB��Z��ζ���b��2�P�9ɕ��C��s�Lů #�6 [CXa����`��X�����1W�)H������3�M�-�b�R��9пt����DR�=}��<H��'��In��7
In�n"��5�{���uaZͮ:/��{����fq�1�K��oU���V<h�E�*����IB�� 6hQM�ˠ\�A�� ~
�Q5�HkD�TMsi}�N-��y��
�qڢ�����F���g�4:��Y66
d�Z�a-�'saZ|���B7�*c���Z��8�gC?HY�w	"hg�] w	�);��1jw���J�.ؓ���i4g�� U}gpP�ς�������"e�	��s���KF���@����c>E"\S�Q%�k�ġ�aO�����e|� ���F�=�f�̪������<��f���k3K��� 	UB%��awT2�@<.��$5�w${�"MI-t�~C���������k�U�7��mB+���qM&�8�� �]\���N��[`�M���M�$��XKS)Hz�� ��Ö��[qQg�*a�U�$�Dj��+/g��4m0H�y�c�g8�����o�	�ub~���JkbF�'m�%����Ɍ"�j@;�Xy�򀶞b��!,p���5�{R5���$?��Z���0S�Z"�@H}�>�@'�jךwp�V�R��mV�4r0�������;�XG�Bk����Ph�s5o�M=3����1�#o}�jh�%ߌ��C�J4�"�O�-u��\ĕ��H�rp�/t]�׎s ؾ�:���@�-�|�j����F��vZSޑ[8�5� ���x��>���x+� C8��n'���0==LG�n�z���H��'��!��Փ|
[�í�dĴ	܅/�'�5����Z���n����|��\A��eO����Fo�	N�oEF����'vl?�c�mY5�<�\��iV-u�n�����ƮWDk.oCW����������b�������ɘ���󖰠-߼�-�#FB�-G�T��H%��bM@7���V/e\�1br�5k�@�#�m\�� _����$�����$	��g��X��;��r��f�\B� }�<|���<?{wC�+�;�v����}	ԅI�,`���O ���R�@���0����EZ��]�Mk㱆���[c��ZN�����'��n��Ϊ HhuVMOYhE�((������Q��jl���E�$Zu����Q��>�~Ц��.�	vX��j�l����5�y��E���P�-Rv��xx��ӫ��Z����<�n�X���}�jd�\�p���n��+N!�<����r�׈U�F�K��]��Wp�����Y��:�h<(-�><O�:I����'7���=����u�Әв$��]K97�'���I�$u��(:�[x���j�R�%9��y�V��bꖥn��^t��]�����,PM�\��R7 yӍ�bur}�\4�;��;����}r~��G����@��G��t��,P����ꖇ:��i ���p6��ͬ�	��i՟��������h��u���o�:Z���u���v��j�w���Ψ@��ˡyx�@���y��g/J�Y?_����n��`�s���Q�	��p��otk��v����u�A����-uf�6�\��P��A��,Ն᫯���v2�s��,i*	�$}�*P�:��C �umy/��
�㥯�nx��e�hy����VҚ�@�v�@l�s{
��lE��C��o��g8�Q�������/�yy�����˛ŸW[ ]:��v���n�l aN��J��Z�)�=���e���H��q��������?~�����b�Ce���!�	��p�S݈ī�2���\��ۥ5Y���A��oH�.�ω���d�5VxYQc���K��+��q	��ڊ'���
׍�V*>�\�>�[@6�}���˯/�����/zB^�n,�n��ȋXy G�@*@����Ç��_�      d	   p  x���K��6E��*���/A�3O*���ܖx�,uyاH����G��Q}p�xU}1=)v�_�Z������{h� �=��E	@^�r�� �%H�'�XR ��'��
�-@;��T+j ��W�Oj;�ξ���#�֢d�'9ɢ����5 ��� u7M�]�ʔ�y�.� y�aZ����^�a���A\�a��ܞ\��;�-h*�7+�Iu����r-�d<���-�{Hjg`�-�uM���6��s�E�ަ��H���P�U�[\�̶䁂@|
��蒚o�i�~���^��}�U�ɴ׶�m6플��?�w`��8�#rrGo)ű�~�Zq�Gt��D�G�<��8�#���k�=�nI;�
�H,�S���q�@������[���o�~�*�1PKs�&Rv��Ҧ�Vs�o�LG��@�85e37pG�;9�%��;0C����7E G��h�'�A�Kw4�tQ��l ����F/���c{����\�c��<�»��U�'�+�c� � J�<�Ю֥򘜠?�w�s�׆) ���'�:Զ.�^� y��AyX��1_����t��c�
� �ł�k�c?�ċ�p�Obu�_K�<^�Iu� ��4���<�Я'�ay\�<׹��ޓ>��A�x�d��tp��ñ�A�2�i�鵳��o��i���`�ǂ�i�tP����Ssڏ9��v̮>d��4�٬Pw-P騂<��/��>Mh�wTA����!T��f'y4t�h�ix��*�|A�0�$(��=��l��P#���T�� (��
Q=R�������[��P�9�H�I�PЇ�l>R[�E�q�/Иҁ�C!����lB�	�D�P肜A	��!��F�K�i�v> �ڡ��@�h���ў�ZN� �-��*H�c�g4쳹=G�H�난&�|�d����L��(�5���,�B����cE���Ɏ��Mj^(sa%I�난昃��!Pϩ�E}�9��̕}5�@�'�����cQ�g�{@�@����Qz��P����S����ݸ��̈��������;�;9M��x#�@҂<O&�����@/��� ��VJ�u��      e	   �   x�m�A�0��+��Dk�N�ܐ@\T�c���4E�u�>y=�h4>g411�h�6�@���i����D��ü�SQ-�!�����[�?6.�b���UY��5yp'\��``�oJR����e{�7����2�      f	     x�URA�� <�Ǭ l��HIQ	�@��T���b��T����؄�{�JA=�A��(�ΦA�ɯn��ʥ�^ȇ�s|y�\�X� �ʚQ��lҹ�w�����vwZ*�9��T`�*lE�dX�C�*I#�܍"E��Bt�Z� C\V`�5��[���Nژ�k�sF�#��gj�&���c!�K�6��Y�}q�9�C�[j�:�>�װ��#��ێx���+Zk[�0hK�6Das���F�u�~[�]�j��`�0ʉ�γ-��B�?���      g	      x������ � �      h	      x������ � �      i	   �   x�m�K
�0����*�@�}$�6S	��i'��H�o:�t�9�ՂHp�[Zt��-�e`J!&B�#��|���L�A�\��.#�K���K)p/O�ݞ&TE;Ս�qz��}*�E���?�@��.e�j1X�/�]v,Q��
{g��  Ao      j	      x������ � �     