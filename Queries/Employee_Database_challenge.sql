-- Creating new table Retirement Titles
SELECT employees.emp_no,
	employees.first_name,
	employees.last_name,
	titles.title,
	titles.from_date,
	titles.to_date
INTO retirement_title
FROM employees
LEFT JOIN titles
ON employees.emp_no = titles.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31');

SELECT * FROM retirement_title

--Creating Unique title Table
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_title
FROM retirement_title
ORDER BY emp_no;

SELECT * FROM unique_title
DROP TABLE unique_title

-- Creating Retiring Title table 
SELECT COUNT(title), title
INTO retiring_title
FROM unique_title
GROUP BY title
ORDER BY count(title) DESC;

SELECT * FROM retiring_title
DROP TABLE retiring_title

--Creating Mentorship Eligibility table
SELECT DISTINCT ON (emp_no) employees.emp_no,
	employees.first_name,
	employees.last_name,
	employees.birth_date,
	dept_emp.from_date,
	dept_emp.to_date,
	titles.title
INTO mentorship_eligibility
FROM employees
INNER JOIN dept_emp
ON (employees.emp_no = dept_emp.emp_no)
INNER JOIN titles
ON (employees.emp_no = titles.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (dept_emp.to_date > '1999-01-01' )
ORDER BY emp_no;

SELECT * FROM mentorship_eligibility
DROP TABLE mentorship_eligibility

