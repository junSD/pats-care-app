SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: add_permissions(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_permissions() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    insert into el_users_perm_group (el_users_id, permissions_id)
      values (new.id, '1'), (new.id, '2');
    return new;
  end;
$$;


ALTER FUNCTION public.add_permissions() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: el_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.el_permissions (
    id integer NOT NULL,
    profile character varying
);


ALTER TABLE public.el_permissions OWNER TO postgres;

--
-- Name: el_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.el_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.el_permissions_id_seq OWNER TO postgres;

--
-- Name: el_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.el_permissions_id_seq OWNED BY public.el_permissions.id;


--
-- Name: el_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.el_users (
    id integer NOT NULL,
    email character varying(355) NOT NULL,
    password character varying(355) NOT NULL,
    firstname character varying(50) DEFAULT NULL::character varying,
    lastname character varying(50) DEFAULT NULL::character varying,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    last_login timestamp with time zone
);


ALTER TABLE public.el_users OWNER TO postgres;

--
-- Name: el_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.el_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.el_users_id_seq OWNER TO postgres;

--
-- Name: el_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.el_users_id_seq OWNED BY public.el_users.id;


--
-- Name: el_users_perm_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.el_users_perm_group (
    el_users_id integer,
    permissions_id integer
);


ALTER TABLE public.el_users_perm_group OWNER TO postgres;

--
-- Name: el_users_with_permissions; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.el_users_with_permissions AS
SELECT
    NULL::integer AS id,
    NULL::character varying[] AS array_agg,
    NULL::character varying(50) AS firstname,
    NULL::character varying(50) AS lastname,
    NULL::character varying(355) AS email,
    NULL::timestamp with time zone AS created_on,
    NULL::timestamp with time zone AS last_login;


ALTER TABLE public.el_users_with_permissions OWNER TO postgres;

--
-- Name: el_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.el_permissions ALTER COLUMN id SET DEFAULT nextval('public.el_permissions_id_seq'::regclass);


--
-- Name: el_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.el_users ALTER COLUMN id SET DEFAULT nextval('public.el_users_id_seq'::regclass);


--
-- Data for Name: el_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.el_permissions (id, profile) VALUES (1, 'view');
INSERT INTO public.el_permissions (id, profile) VALUES (2, 'update');
INSERT INTO public.el_permissions (id, profile) VALUES (3, 'delete');
INSERT INTO public.el_permissions (id, profile) VALUES (4, 'create');


--
-- Data for Name: el_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (2, 'fas@gmail.net', '444', 'fas', 'saf', '2018-08-08 14:33:07.718787+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (5, 'got@gmail.com', '555', 'got', 'tog', '2018-08-08 18:43:24.988105+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (6, 'gwt@gmail.com', '555', 'gwt', 'twg', '2018-08-08 18:47:36.66427+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (7, 'twt@gmail.com', '555', 'twt', 'twg', '2018-08-08 18:49:12.745235+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (8, 'qwt@gmail.com', '555', 'qwt', 'qwg', '2018-08-08 18:50:38.880281+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (10, 'gst@gmail.com', '555', 'qst', 'qsg', '2018-08-08 18:57:23.278803+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (11, 'yst@gmail.com', '555', 'qst', 'qsg', '2018-08-08 18:58:38.145304+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (12, 'yttt@gmail.com', '555', 'qst', 'qsg', '2018-08-08 19:03:47.658909+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (9, 'darttdsds454545d@gmail.net', '333', 'dar', 'rad', '2018-08-08 18:55:26.598915+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (14, 'yttfftyyy@gmail.com', '$2b$10$x/eEVAy8ZGn2c85COw.8q.PENQePRUu4Q7519TSeA6/flnFoJbJx2', 'qst', 'qsg', '2018-08-09 02:09:22.938946+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (15, 'yttfftyyy33@gmail.com', '$2b$10$vHiPfCShgHof7S1KXS6OL.nPh6LkxPm.c1pOTYTzaa0fyXhIkaRn2', 'qst', 'qsg', '2018-08-10 15:50:25.749871+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (16, '3434234324yttfftyyy33@gmail.com', '$2b$10$dMJSHlC/v70GMseIRoddKu1L3HGxnpCCgPpLga2yIvm4tK4TGK2gC', 'qst', 'qsg', '2018-08-10 20:00:28.809485+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (17, '343423erer4yttfftyyy33@gmail.com', '$2b$10$VsqtPRbaitCsi3f.0/xNbe9Jc9o.tG/14eX5r4IKfbNsbYQ3LUHEq', 'qst', 'qsg', '2018-08-10 20:09:36.042821+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (18, '343423ertyt4yttfftyyy33@gmail.com', '$2b$10$DvOLwyvjzS1mhmBfuiLtMeSz2Pym24CvgOYH0iUn813S07AN1yx5e', 'qst', 'qsg', '2018-08-10 20:10:09.06715+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (20, 'dar4@gmail.net', '$2b$10$qklkepHQ.UpsHyxmClYz7urRQas7k05Myd0N6bk58/qGU6ylHGh06', 'dar', 'rad', '2018-08-13 15:29:54.899966+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (21, 'dar444@gmail.net', '$2b$10$fm40QlAVzkC.5GfcFDpFb.oAJ9HrYpIlvht7kO9zE76FyRYJVUzaK', NULL, NULL, '2018-08-13 21:00:10.945751+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (22, 'ererer@gmail.com', '$2b$10$0MtnRwvFWdH1qUgZjTNRW.HUmmezxxsEYNqTSV1pU9ixiI/r7985.', NULL, NULL, '2018-08-15 03:56:24.15086+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (24, 'ytyt@gmail.com', '$2b$10$GI/WKRo81zIzF4CT.8GHU.h3zWw6CUwnVq4z1jAeMOeZwEWOunfTy', NULL, NULL, '2018-08-15 03:59:10.248566+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (25, 'ytyta@gmail.com', '$2b$10$vsCuWt8PrrfcFpAlHV46pemklAkv1fjg6Ck/xaWN4A2w.FTnlltJy', NULL, NULL, '2018-08-15 04:42:56.996026+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (27, 'ytytauy@gmail.com', '$2b$10$LwuoOqXnVX6SnweAFhzyz.n0zqoF./FmO2PwokuztdNqG8i2pDUpa', NULL, NULL, '2018-08-15 05:09:17.631281+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (28, 'ytytauy45@gmail.com', '$2b$10$vLnaa6mgYFUjtuxXToGCf.RWcPxVipKB2N6U35mtu0PEWe6p6zsky', NULL, NULL, '2018-08-15 14:13:05.453057+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (29, 'ytyt90@gmail.com', '$2b$10$ybR.ZhR/Y1je5mYhlvfFguf4ufYdpAXGD1xRQp4yuQSz408j4rr.e', NULL, NULL, '2018-08-15 18:33:32.978151+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (30, 'ytyt901@gmail.com', '$2b$10$mTNuAWYvuz6ngi4DlM1Nh.cWAO2if99sr3K3ZV2CBbHqmR38oBM0W', NULL, NULL, '2018-08-15 19:15:17.85907+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (31, 'ytyt902@gmail.com', '$2b$10$d1OzrVTbCoAxDUCQo.j6qOsQQ5XU7jwxrmswsXHU0QGDBtrXtHFXu', NULL, NULL, '2018-08-15 19:46:33.894257+03', '2018-08-15 18:10:24+03');
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (32, 'ytyt903@gmail.com', '$2b$10$6GpR6TckEqpaJpHU4AC2POn19ucRH0bwkk24zYG4Ax2VilFnl9/jW', NULL, NULL, '2018-08-15 18:13:56.470629+03', '2018-08-15 18:14:04+03');
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (33, 'ytyt904@gmail.com', '$2b$10$3x0EbwNQd6haUTmh4OY2F.cTA7Pkzv0zklke0ovwBl6qa.oU6g6.y', NULL, NULL, '2018-08-15 18:36:24.101871+03', '2018-08-15 18:36:30+03');
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (34, '11@gf.com', '22', NULL, NULL, '2018-08-16 12:54:45.836303+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (35, '12@gf.com', '22', NULL, NULL, '2018-08-16 13:51:01.483614+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (36, 'ytyt905@gmail.com', '$2b$10$by5uucTga3bHRiCkPFMPbuqwMqltN1QnZky3UdDXqMJaQm0tsBd1K', NULL, NULL, '2018-08-16 14:50:50.999864+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (37, 'ytyt906@gmail.com', '$2b$10$Exuo7V6CLnNImuOpdagHKOfFKUiMXLFnCw9CtTdtUei5ClDiIvTVK', NULL, NULL, '2018-08-16 14:51:45.669131+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (38, 'ytyt907@gmail.com', '$2b$10$xCOpSA3yixVAbqPv20U7Fu31/mxs6bFRYXMS1EGtya14n1MQf4E9u', 'ererer', 'ererer', '2018-08-16 14:53:43.748632+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (39, 'ytyt908@gmail.com', '$2b$10$QKIU7VFswGZXjErh4nUYrO2gEFgTb5CuI4xo9h5432GUSQHjcFfvm', 'ererer1', 'ererer1', '2018-08-16 16:25:31.330262+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (40, 'ytyt909@gmail.com', '$2b$10$6xDU95Pi3/5FI4.WfZbOBeZHSwwSyFO9VDyA4eNzPQ3vmuvzli6oi', 'ererer1', 'ererer1', '2018-08-16 16:29:15.258641+03', '2018-08-16 16:29:15+03');
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (42, 'ytyt910@gmail.com', '$2b$10$5DpGtm8HtDkNF02tyFFl6.3JC./1udh4jz6hCCi3.F.jQjtK2/jj6', 'ererer1', 'ererer1', '2018-08-16 17:18:54.920015+03', '2018-08-16 17:18:55+03');
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (43, 'ytyt911@gmail.com', '$2b$10$OpjhS75Pt0ie5bJKlFlYTumwWKpIgD2Pg6c9OY3vVvGohOalk3tEu', 'ererer1', 'ererer1', '2018-08-16 17:20:17.99057+03', '2018-08-16 17:20:18+03');
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (45, 'ytyt912@gmail.com', '$2b$10$cKxW2bf1ylxJXYvcO7Qdd.5.jEoE3TWxz3NG1UGA4Z9B0v77VOgAm', 'ererer1', 'ererer1', '2018-08-16 17:22:33.43808+03', '2018-08-16 17:22:33+03');
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (46, 'ytyt913@gmail.com', '$2b$10$BDgQY3flGJwt4CDZC/T5ZeG9ttH7j7n2KTT7eKSwiX.TmmtXhbCTS', 'ererer1', 'ererer1', '2018-08-16 17:59:00.869362+03', '2018-08-16 17:59:00+03');
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (47, 'ytyt914@gmail.com', '$2b$10$Sc6L9xEHtF0V1BTYg54fk.SxCXBAE9lAFcSN3OM1mlicQFWecx94y', 'ererer1', 'ererer1', '2018-08-16 18:19:31.469776+03', '2018-08-16 18:19:31+03');
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (57, 'ytyt922@gmail.com', '$2b$10$c1Q/QhZTWaAYj2IwurLCQ.98f65z7M2gdSo8zWlAuL7UU3RDFD5sm', 'qq', 'qq', '2018-08-20 12:27:19.213648+03', '2018-08-20 12:27:19+03');
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (48, 'ytyt915@gmail.com', '$2b$10$lsvnFe3VLcp11IBsdvSufOwTsnzxFDWGl.daNkcI9ioY.WqkeY0DG', 'ererer1', 'ererer1', '2018-08-16 18:27:05.356096+03', '2018-08-16 18:49:40+03');
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (49, 'ytyt916@gmail.com', '$2b$10$FB5ITovZQyxilcCTRV0Ihu/QntJCUfKvXyYrxnStPQu1Sna1BJ10a', 'ererer1', 'ererer1', '2018-08-16 19:03:50.756666+03', '2018-08-16 19:03:50+03');
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (52, 'er@er.com.ua', '$2b$10$UIGBaE.UZOHUM4NSpEA92OHzBwKg6/QTH4ZJTpHu1XPUZaTpQX4li', NULL, NULL, '2018-08-17 13:36:24.493422+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (50, 'ytyt917@gmail.com', '$2b$10$WJosoJlHuJNYfsDTav/3jeJvQRdPt65bhVUk7AGqK9bmy9R89b/qq', 'ererer1', 'ererer1', '2018-08-16 23:17:30.374754+03', '2018-08-16 23:19:22+03');
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (53, 'er53@er.com.ua', '$2b$10$U0.bRskLQCq268t0zsRPx.8x1bEy3f1j4rCSRevamiFT01PnGYYvO', NULL, NULL, '2018-08-17 14:13:32.965299+03', NULL);
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (54, 'ytyt919@gmail.com', '$2b$10$2pHUWsz4/UhbqU9TKDTp/uym/7Hr.Vv2f.JHxbXhhM5bspNnur7Cy', 'ererer1', 'ererer1', '2018-08-17 15:41:27.491669+03', '2018-08-20 21:06:08+03');
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (51, 'ytyt918@gmail.com', '$2b$10$HnemdUoRziYoimKVpO7U/e9fO5RcEOvRPVJ4IEwVF2vGhclLlW/4u', 'ererer1', 'ererer1', '2018-08-17 00:32:26.708296+03', '2018-08-17 15:20:21+03');
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (58, 'ytyt923@gmail.com', '$2b$10$ugbA7v/Z1aYvb6ZQy/T5lutADTMnCAfG5VrGQsGDhVtQrRlcitIv6', 'qq', 'qq', '2018-08-20 12:51:19.606537+03', '2018-08-22 15:39:19+03');
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (55, 'ytyt920@gmail.com', '$2b$10$LmGTUXVEAprXtHydXyCT1OWec3p1Z16oTPWzUIpBPBoiwjtO5n4z.', 'qqqq', 'qqqq', '2018-08-17 18:26:07.215537+03', '2018-08-17 18:26:08+03');
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (56, 'ytyt921@gmail.com', '$2b$10$mpoxeY7sUGVV7bfxRNi.I.WQ4YiJLfTdWDogoVVmUOUJZej2Oy/ci', 'qq', 'qq', '2018-08-19 16:41:41.973776+03', '2018-08-19 16:41:42+03');
INSERT INTO public.el_users (id, email, password, firstname, lastname, created_on, last_login) VALUES (59, 'ytyt924@gmail.com', '$2b$10$VWnePcmOoGj.K6GhldGR/.ymOZyMxoBDWrPG7mqOB7jpgks2ZM4YK', 'qq', 'qq', '2018-08-20 21:00:50.143469+03', '2018-08-20 21:20:46+03');


--
-- Data for Name: el_users_perm_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (14, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (14, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (35, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (35, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (36, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (36, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (37, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (37, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (38, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (38, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (39, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (39, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (40, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (40, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (42, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (42, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (43, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (43, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (45, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (45, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (46, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (46, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (47, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (47, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (48, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (48, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (49, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (49, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (50, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (50, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (51, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (51, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (52, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (52, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (53, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (53, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (54, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (54, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (55, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (55, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (56, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (56, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (57, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (57, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (58, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (58, 2);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (59, 1);
INSERT INTO public.el_users_perm_group (el_users_id, permissions_id) VALUES (59, 2);


--
-- Name: el_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.el_permissions_id_seq', 4, true);


--
-- Name: el_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.el_users_id_seq', 59, true);


--
-- Name: el_permissions el_permissions_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.el_permissions
    ADD CONSTRAINT el_permissions_id_pk PRIMARY KEY (id);


--
-- Name: el_users el_users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.el_users
    ADD CONSTRAINT el_users_email_key UNIQUE (email);


--
-- Name: el_users_perm_group el_users_perm_group_el_users_id_permissions_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.el_users_perm_group
    ADD CONSTRAINT el_users_perm_group_el_users_id_permissions_id_key UNIQUE (el_users_id, permissions_id);


--
-- Name: el_users el_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.el_users
    ADD CONSTRAINT el_users_pkey PRIMARY KEY (id);


--
-- Name: el_users_with_permissions _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE OR REPLACE VIEW public.el_users_with_permissions AS
 SELECT el_users.id,
    array_agg(permission.profile) AS array_agg,
    el_users.firstname,
    el_users.lastname,
    el_users.email,
    el_users.created_on,
    el_users.last_login
   FROM ((public.el_users
     LEFT JOIN public.el_users_perm_group eupg ON ((el_users.id = eupg.el_users_id)))
     LEFT JOIN public.el_permissions permission ON ((eupg.permissions_id = permission.id)))
  GROUP BY el_users.id;


--
-- Name: el_users add_permissions; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER add_permissions AFTER INSERT ON public.el_users FOR EACH ROW EXECUTE PROCEDURE public.add_permissions();


--
-- Name: el_users_perm_group el_users_perm_group_el_permissions(id)__fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.el_users_perm_group
    ADD CONSTRAINT "el_users_perm_group_el_permissions(id)__fk" FOREIGN KEY (permissions_id) REFERENCES public.el_permissions(id);


--
-- Name: el_users_perm_group el_users_perm_group_el_users(id)__fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.el_users_perm_group
    ADD CONSTRAINT "el_users_perm_group_el_users(id)__fk" FOREIGN KEY (el_users_id) REFERENCES public.el_users(id);


--
-- PostgreSQL database dump complete
--

