
LAB | My SQL Select

======================

CHALLENGE 1 - Hay que unir tres tablas, dado que nos dicen que el total de rows debe ser igual al de la tabla titleauthor (25 rows), se debe hacer un inner join. 
==============
SELECT 
	titleauthor.au_id AS 'AUTHOR ID',
    authors.au_lname AS 'LAST NAME',
    authors.au_fname AS 'FIRST NAME', 
    titles.title AS TITLE,
    publishers.pub_name AS PUBLISHER
FROM titleauthor
	INNER JOIN authors ON titleauthor.au_id = authors.au_id
	INNER JOIN titles ON titleauthor.title_id = titles.title_id
	INNER JOIN publishers ON titles.pub_id = publishers.pub_id


CHALLENGE 2 - 
=============
SELECT 
	titleauthor.au_id AS 'AUTHOR ID',
    authors.au_lname AS 'LAST NAME',
    authors.au_fname AS 'FIRST NAME', 
    publishers.pub_name AS PUBLISHER,
    COUNT(titles.title) AS 'TITLE COUNT'
FROM titleauthor
	INNER JOIN authors ON titleauthor.au_id = authors.au_id
	INNER JOIN titles ON titleauthor.title_id = titles.title_id
	INNER JOIN publishers ON titles.pub_id = publishers.pub_id

GROUP BY titles.title


CHALLENGE 3: NO FUNCIONA, DA ERROR
============
SELECT 
	titleauthor.au_id AS 'AUTHOR ID',
    authors.au_lname AS 'LAST NAME',
    authors.au_fname AS 'FINAL NAME',
    sales.qty AS 'TOTAL'

FROM titleauthor
	INNER JOIN authors ON titleauthor.au_id = authors.au_id
    INNER JOIN sales ON titleauthor.title_id = sales.title_id

ORDER BY TOTAL DESC

LIMIT 3;






