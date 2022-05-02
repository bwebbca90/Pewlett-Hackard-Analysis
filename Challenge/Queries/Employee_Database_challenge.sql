-- Combine employees with titles 
SELECT emp.emp_no,
    emp.first_name,
    emp.last_name,
    tit.title,
    tit.from_date,
    tit.to_date
INTO retirement_titles
FROM employees AS emp
INNER JOIN titles AS tit
    ON (tit.emp_no = emp.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (retit.emp_no) retit.emp_no, 
    retit.from_date,
	retit.first_name,
	retit.last_name,
	retit.title
INTO unique_titles
FROM retirement_titles as retit
WHERE (retit.to_date = '9999-01-01') 
ORDER BY retit.emp_no ASC, retit.to_date DESC;

-- Find count of unique titles retiring
SELECT COUNT(ut.title)
INTO retiring_titles
FROM unique_titles as ut 
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

-- Mentorship eligibility
SELECT DISTINCT ON(emp.emp_no)
	emp.emp_no,
	emp.first_name,
	emp.last_name,
	emp.birth_date,
	dep.from_date,
	dep.to_date,
	tit.title
INTO mentorship_elibility
FROM employees AS emp
INNER JOIN dept_emp AS dep
	ON (emp.emp_no = dep.emp_no)
INNER JOIN titles AS tit
	ON(emp.emp_no = tit.emp_no)
WHERE (dep.to_date = '9999-01-01')
	AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp.emp_no ASC;