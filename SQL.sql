--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.5

-- Started on 2022-08-26 18:09:43

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 212 (class 1259 OID 16405)
-- Name: directors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directors (
    directorid integer NOT NULL,
    name character varying(50) NOT NULL,
    bio character varying(1000),
    birthyear date,
    deathyear date
);


ALTER TABLE public.directors OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16404)
-- Name: directors_directorid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directors_directorid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directors_directorid_seq OWNER TO postgres;

--
-- TOC entry 3357 (class 0 OID 0)
-- Dependencies: 211
-- Name: directors_directorid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directors_directorid_seq OWNED BY public.directors.directorid;


--
-- TOC entry 210 (class 1259 OID 16396)
-- Name: genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genres (
    genreid integer NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(1000)
);


ALTER TABLE public.genres OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16395)
-- Name: genres_genreid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genres_genreid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.genres_genreid_seq OWNER TO postgres;

--
-- TOC entry 3358 (class 0 OID 0)
-- Dependencies: 209
-- Name: genres_genreid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genres_genreid_seq OWNED BY public.genres.genreid;


--
-- TOC entry 214 (class 1259 OID 16504)
-- Name: movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies (
    movieid integer NOT NULL,
    title character varying(50) NOT NULL,
    description character varying(1000),
    directorid integer NOT NULL,
    genreid integer NOT NULL,
    imageurl character varying(300),
    featured boolean
);


ALTER TABLE public.movies OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16503)
-- Name: movies_movieid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movies_movieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movies_movieid_seq OWNER TO postgres;

--
-- TOC entry 3359 (class 0 OID 0)
-- Dependencies: 213
-- Name: movies_movieid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movies_movieid_seq OWNED BY public.movies.movieid;


--
-- TOC entry 218 (class 1259 OID 16530)
-- Name: user_movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_movies (
    usermovieid integer NOT NULL,
    userid integer,
    movieid integer
);


ALTER TABLE public.user_movies OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16529)
-- Name: user_movies_usermovieid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_movies_usermovieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_movies_usermovieid_seq OWNER TO postgres;

--
-- TOC entry 3360 (class 0 OID 0)
-- Dependencies: 217
-- Name: user_movies_usermovieid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_movies_usermovieid_seq OWNED BY public.user_movies.usermovieid;


--
-- TOC entry 216 (class 1259 OID 16523)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    userid integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    birth_date date
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16522)
-- Name: users_userid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_userid_seq OWNER TO postgres;

--
-- TOC entry 3361 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_userid_seq OWNED BY public.users.userid;


--
-- TOC entry 3185 (class 2604 OID 16408)
-- Name: directors directorid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directors ALTER COLUMN directorid SET DEFAULT nextval('public.directors_directorid_seq'::regclass);


--
-- TOC entry 3184 (class 2604 OID 16399)
-- Name: genres genreid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres ALTER COLUMN genreid SET DEFAULT nextval('public.genres_genreid_seq'::regclass);


--
-- TOC entry 3186 (class 2604 OID 16507)
-- Name: movies movieid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies ALTER COLUMN movieid SET DEFAULT nextval('public.movies_movieid_seq'::regclass);


--
-- TOC entry 3188 (class 2604 OID 16533)
-- Name: user_movies usermovieid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_movies ALTER COLUMN usermovieid SET DEFAULT nextval('public.user_movies_usermovieid_seq'::regclass);


--
-- TOC entry 3187 (class 2604 OID 16526)
-- Name: users userid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN userid SET DEFAULT nextval('public.users_userid_seq'::regclass);


--
-- TOC entry 3345 (class 0 OID 16405)
-- Dependencies: 212
-- Data for Name: directors; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (1, 'Tim Burton', 'Timothy Walter Burton was born in Burbank, California, to Jean Rae (Erickson), who owned a cat-themed gift shop, and William Reed Burton, who worked for the Burbank Park and Recreation Department. He spent most of his childhood as a recluse, drawing cartoons, and watching old movies.', '1958-01-01', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (2, 'Michael Patrick King', 'Michael Patrick King was born on September 14, 1954 in Scranton, Pennsylvania, USA. He is a producer and writer, known for Sex and the City 2 (2010), Sex and the City (1998) and Sex and the City (2008).', '1954-09-14', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (3, 'Tim Burton', 'Timothy Walter Burton was born in Burbank, California, to Jean Rae (Erickson), who owned a cat-themed gift shop, and William Reed Burton, who worked for the Burbank Park and Recreation Department. He spent most of his childhood as a recluse, drawing cartoons, and watching old movies.', '1958-01-01', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (4, 'Michael Patrick King', 'Michael Patrick King was born on September 14, 1954 in Scranton, Pennsylvania, USA. He is a producer and writer, known for Sex and the City 2 (2010), Sex and the City (1998) and Sex and the City (2008).', '1954-09-14', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (5, 'Nick Cassavetes', 'Nick Cassavetes was born in New York City, the son of actress Gena Rowlands and Greek-American actor and film director John Cassavetes. As a child, he appeared in two of his father''s films: Husbands (1970) and A Woman Under the Influence (1974).', '1959-05-21', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (6, 'Jim Henson', 'Jim Henson never thought that he would make a name of himself in puppetry; it was merely a way of getting himself on television. The vehicle that achieved it was Sam and Friends (1955), a late-night puppet show that was on after the 11:00 news in Washington DC. It proved to be very popular and inspired Jim to continue using puppets for his work. He made many commercials, developing the signature humor that Henson Productions is known for.', '1936-09-24', '1990-05-06');
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (7, 'John Pasquin', 'John Pasquin was born on June 8, 1945. He is a director and producer, known for The Santa Clause (1994), Miss Congeniality 2: Armed & Fabulous (2005) and Home Improvement (1991). He has been married to JoBeth Williams since March 14, 1982. They have two children.', '1945-06-08', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (8, 'Christopher Nolan', 'Best known for his cerebral, often nonlinear, storytelling, acclaimed writer-director Christopher Nolan was born on July 30, 1970, in London, England. Over the course of 15 years of filmmaking, Nolan has gone from low-budget independent films to working on some of the biggest blockbusters ever made.', '1970-07-30', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (9, 'Rob Reiner', 'Robert Reiner was born in New York City, to Estelle Reiner (née Lebost) and Emmy-winning actor, comedian, writer, and producer Carl Reiner. As a child, his father was his role model, as Carl Reiner created and starred in The Dick Van Dyke Show. Estelle was also an inspiration for him to become a director;', '1947-03-06', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (10, 'Martin Charles Scorsese', 'Martin Charles Scorsese was born on November 17, 1942 in Queens, New York City, to Catherine Scorsese (née Cappa) and Charles Scorsese, who both worked in Manhattan''s garment district, and whose families both came from Palermo, Sicily. ', '1942-11-17', NULL);
INSERT INTO public.directors (directorid, name, bio, birthyear, deathyear) VALUES (11, 'Alan Metter', 'Metter grew up in the Boston area, lived in the Hollywood Hills for most of his adult life, and moved to South Florida in 2009. Alan began his creative life at Doyle Dane Bernbach (DDB), the legendary advertising agency.', '1942-12-19', '2020-06-07');


--
-- TOC entry 3343 (class 0 OID 16396)
-- Dependencies: 210
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.genres (genreid, name, description) VALUES (12, 'Romance', 'The aim of the genre is simple, showcasing a love story where two people overcome adversity to obtain their happily ever after.');
INSERT INTO public.genres (genreid, name, description) VALUES (13, 'Thriller', 'Thriller film, also known as suspense film or suspense thriller, is a broad film genre that involves excitement and suspense in the audience.');
INSERT INTO public.genres (genreid, name, description) VALUES (14, 'Drama', 'The drama genre features stories with high stakes and a lot of conflicts. They''re plot-driven and demand that every character and scene move the story forward. Dramas follow a clearly defined narrative plot structure, portraying real-life scenarios or extreme situations with emotionally-driven characters.');
INSERT INTO public.genres (genreid, name, description) VALUES (15, 'Comedy', 'Comedy is a genre of fiction that consists of discourses or works intended to be humorous or amusing by inducing laughter, especially in theatre, film, stand-up comedy, television, radio, books, or any other entertainment medium.');
INSERT INTO public.genres (genreid, name, description) VALUES (16, 'Fantasy', 'Fantasy is a genre of speculative fiction involving magical elements, typically set in a fictional universe and sometimes inspired by mythology and folklore. Its roots are in oral traditions, which then became fantasy literature and drama');
INSERT INTO public.genres (genreid, name, description) VALUES (18, 'Action', 'Action film is a film genre in which the protagonist is thrust into a series of events that typically involve violence and physical feats. The genre tends to feature a mostly resourceful hero struggling against incredible odds, which include life-threatening situations, a dangerous villain, or a pursuit which usually concludes in victory for the hero.');


--
-- TOC entry 3347 (class 0 OID 16504)
-- Dependencies: 214
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (3, 'Stand By Me', 'After the death of one of his friends, a writer recounts a childhood journey with his friends to find the body of a missing boy.', 9, 14, 'https://en.wikipedia.org/wiki/Stand_by_Me_%28film%29', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (4, 'Goodfellas', 'The story of Henry Hill and his life in the mob, covering his relationship with his wife Karen Hill and his mob partners Jimmy Conway and Tommy DeVito in the Italian-American crime syndicate.', 10, 14, 'https://en.wikipedia.org/wiki/File:Goodfellas.jpg', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (5, 'Edward Scissorhands', 'An artificial man, who was incompletely constructed and has scissors for hands, leads a solitary life. Then one day, a suburban lady meets him and introduces him to her world.', 1, 14, 'https://upload.wikimedia.org/wikipedia/en/3/3b/Edwardscissorhandsposter.JPG', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (6, 'Girls Just Want to Have Fun', 'Janey is new in town and soon meets Lynne, who shares her passion for dancing in general and Dance TV in particular.', 11, 12, 'https://en.wikipedia.org/wiki/File:Girls_just_want_to_have_fun.jpg', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (7, 'Sex and the City', 'A New York City writer on sex and love is finally getting married to her Mr. Big. But her three best girlfriends must console her after one of them inadvertently leads Mr. Big to jilt her.', 2, 12, 'https://en.wikipedia.org/wiki/File:Sex_and_the_City_The_Movie.jpg', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (8, 'The Notebook', 'A poor yet passionate young man (Ryan Gosling) falls in love with a rich young woman (Rachel McAdams), giving her a sense of freedom, but they are soon separated because of their social differences.', 5, 12, 'https://upload.wikimedia.org/wikipedia/en/8/86/Posternotebook.jpg', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (9, 'Beetlejuice', 'The Spirits of a deceased couple are harassed by an unbearable family that has moved into their home and hire a malicious spirit to drive them out.', 1, 15, 'https://en.wikipedia.org/wiki/Beetlejuice#/media/File:Beetlejuice_(1988_film_poster).png', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (10, 'Labyrinth', 'Sixteen-year-old Sarah is given thirteen hours to solve a labyrinth and rescue her baby brother Toby when her wish for him to be taken away is granted by the Goblin King Jareth.', 6, 16, 'https://upload.wikimedia.org/wikipedia/en/6/6b/Labyrinth_ver2.jpg', true);
INSERT INTO public.movies (movieid, title, description, directorid, genreid, imageurl, featured) VALUES (11, 'The Santa Clause', 'When a man inadvertently makes Santa fall off his roof on Christmas Eve, he finds himself magically recruited to take his place.', 7, 15, 'https://upload.wikimedia.org/wikipedia/en/8/86/The_Santa_Clause.jpg', true);


--
-- TOC entry 3351 (class 0 OID 16530)
-- Dependencies: 218
-- Data for Name: user_movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_movies (usermovieid, userid, movieid) VALUES (1, 3, 10);
INSERT INTO public.user_movies (usermovieid, userid, movieid) VALUES (2, 4, 8);
INSERT INTO public.user_movies (usermovieid, userid, movieid) VALUES (3, 5, 11);


--
-- TOC entry 3349 (class 0 OID 16523)
-- Dependencies: 216
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (userid, username, password, email, birth_date) VALUES (3, 'Ashli', 'acv1234', 'ashli@gmail.com', '1992-03-30');
INSERT INTO public.users (userid, username, password, email, birth_date) VALUES (4, 'Ally', 'bb4321', 'ally@gmail.com', '1987-08-04');
INSERT INTO public.users (userid, username, password, email, birth_date) VALUES (5, 'Katia', 'ks1117', 'katia@gmail.com', '1991-11-17');


--
-- TOC entry 3362 (class 0 OID 0)
-- Dependencies: 211
-- Name: directors_directorid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directors_directorid_seq', 11, true);


--
-- TOC entry 3363 (class 0 OID 0)
-- Dependencies: 209
-- Name: genres_genreid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genres_genreid_seq', 18, true);


--
-- TOC entry 3364 (class 0 OID 0)
-- Dependencies: 213
-- Name: movies_movieid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movies_movieid_seq', 12, true);


--
-- TOC entry 3365 (class 0 OID 0)
-- Dependencies: 217
-- Name: user_movies_usermovieid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_movies_usermovieid_seq', 3, true);


--
-- TOC entry 3366 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_userid_seq', 5, true);


--
-- TOC entry 3192 (class 2606 OID 16412)
-- Name: directors directors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directors
    ADD CONSTRAINT directors_pkey PRIMARY KEY (directorid);


--
-- TOC entry 3190 (class 2606 OID 16403)
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (genreid);


--
-- TOC entry 3194 (class 2606 OID 16511)
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (movieid);


--
-- TOC entry 3198 (class 2606 OID 16535)
-- Name: user_movies user_movies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_movies
    ADD CONSTRAINT user_movies_pkey PRIMARY KEY (usermovieid);


--
-- TOC entry 3196 (class 2606 OID 16528)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- TOC entry 3200 (class 2606 OID 16517)
-- Name: movies directorkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT directorkey FOREIGN KEY (directorid) REFERENCES public.directors(directorid);


--
-- TOC entry 3199 (class 2606 OID 16512)
-- Name: movies genrekey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT genrekey FOREIGN KEY (genreid) REFERENCES public.genres(genreid);


--
-- TOC entry 3202 (class 2606 OID 16541)
-- Name: user_movies moviekey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_movies
    ADD CONSTRAINT moviekey FOREIGN KEY (movieid) REFERENCES public.movies(movieid);


--
-- TOC entry 3201 (class 2606 OID 16536)
-- Name: user_movies userkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_movies
    ADD CONSTRAINT userkey FOREIGN KEY (userid) REFERENCES public.users(userid);


-- Completed on 2022-08-26 18:09:43

--
-- PostgreSQL database dump complete
--

