/* CHALLENGE 1 Most Profiting Authors
==================*/

/* STEP1*/

SELECT titleauthor.title_id AS TITLEID, 
	   titleauthor.au_id AS AUTHORID,
       titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS TOTAL_ROYALTY

FROM titleauthor
	INNER JOIN titles ON titleauthor.title_id = titles.title_id
    INNER JOIN sales ON titleauthor.title_id = sales.title_id;


/* STEP2*/

SELECT TITLEID, AUTHORID, SUM(TOTAL_ROYALTY)

FROM (
SELECT titleauthor.title_id AS TITLEID, 
	   titleauthor.au_id AS AUTHORID,
       titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS TOTAL_ROYALTY

FROM titleauthor
	INNER JOIN titles ON titleauthor.title_id = titles.title_id
    INNER JOIN sales ON titleauthor.title_id = sales.title_id
    

)summary

GROUP BY TITLEID, AUTHORID;



/* STEP3*/

SELECT AUTHORID, SUM(SUMROYALTY + titles.advance) AS PROFIT

FROM (

SELECT TITLEID, AUTHORID, SUM(TOTAL_ROYALTY) AS SUMROYALTY

FROM (
SELECT titleauthor.title_id AS TITLEID, 
	   titleauthor.au_id AS AUTHORID,
       titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS TOTAL_ROYALTY

FROM titleauthor
	INNER JOIN titles ON titleauthor.title_id = titles.title_id
    INNER JOIN sales ON titleauthor.title_id = sales.title_id
    

)summary

GROUP BY TITLEID, AUTHORID

)summary2 

INNER JOIN titles ON summary2.TITLEID = titles.title_id

GROUP BY AUTHORID

ORDER BY PROFIT DESC;

/* CHALLENGE 2 Alternative solution
==================*/

/* STEP1*/

CREATE TEMPORARY TABLE summary_royalty

SELECT titleauthor.title_id AS TITLEID, 
	   titleauthor.au_id AS AUTHORID,
       titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS TOTAL_ROYALTY

FROM titleauthor
	INNER JOIN titles ON titleauthor.title_id = titles.title_id
    INNER JOIN sales ON titleauthor.title_id = sales.title_id;


/* STEP2*/

CREATE TEMPORARY TABLE summary_royalty2

SELECT TITLEID, AUTHORID, SUM(TOTAL_ROYALTY) AS SUMROYALTY

FROM summary_royalty

GROUP BY TITLEID, AUTHORID;

/* STEP3*/

SELECT AUTHORID, SUM(SUMROYALTY + titles.advance) AS PROFIT

FROM summary_royalty2

INNER JOIN titles ON summary_royalty2.TITLEID = titles.title_id

GROUP BY AUTHORID

ORDER BY PROFIT DESC;


/* CHALLENGE 3 Crear tabla permanente
==================*/

CREATE TABLE most_profiting_authors

SELECT AUTHORID, SUM(SUMROYALTY + titles.advance) AS PROFIT

FROM (

SELECT TITLEID, AUTHORID, SUM(TOTAL_ROYALTY) AS SUMROYALTY

FROM (
SELECT titleauthor.title_id AS TITLEID, 
	   titleauthor.au_id AS AUTHORID,
       titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS TOTAL_ROYALTY

FROM titleauthor
	INNER JOIN titles ON titleauthor.title_id = titles.title_id
    INNER JOIN sales ON titleauthor.title_id = sales.title_id
    

)summary

GROUP BY TITLEID, AUTHORID

)summary2 

INNER JOIN titles ON summary2.TITLEID = titles.title_id

GROUP BY AUTHORID

ORDER BY PROFIT DESC;
