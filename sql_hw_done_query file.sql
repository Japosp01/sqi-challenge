-- 1. List the following details of each employee: 
---   employee number, last name, first name, gender, and salary.

SELECT 
employees.emp_no AS "Employee No.", 
employees.last_name AS "Last Name", 
employees.first_name AS "First Name", 
employees.gender AS "Gender", 
salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;
--above works
-- 2. List employees who were hired in 1986.

SELECT 
emp_no AS "Employee No.", 
first_name AS "First Name", 
last_name  AS "Last Name", 
hire_date  AS "Hire Date"
FROM employees
WHERE (hire_date) > '01-01-1986';

--above works

-- 3. List the manager of each department with the following information:
--    department number, department name, the manager's employee number, 
--    last name, first name, and start and end employment dates.
--    By 'start and end employment dates', it is assumed that what is meant
--    is the start and end of the position as manager.

SELECT 
departments.dept_no    AS "Department No.",
departments.dept_name  AS "Department Name", 
employees.emp_no       AS "Employee No.", 
employees.last_name    AS "Last Name", 
employees.first_name   AS "First Name",
dept_manager.from_date AS "Start Date", 
dept_manager.to_date   AS "End Date"
FROM dept_manager
INNER JOIN departments
ON dept_manager.dept_no=departments.dept_no
INNER JOIN employees
ON employees.emp_no = dept_manager.emp_no;
--above works

-- Make the end date more meaningful ...

UPDATE depman
SET    "End Date" = 'ongoing ..'
WHERE  "End Date" = '9999-01-01';

-- Re-order so that data is displayed chronologically for
-- each department.

SELECT * FROM depman
ORDER BY "Department No.", "Start Date";

SELECT * FROM depman;

-- 4. List the department of each employee with the following information: 
--    employee number, last name, first name, and department name.
--    Note that some employees have been in more than one department.

SELECT 
employees.emp_no AS "Employee No.", 
employees.last_name AS "Last Name", 
employees.first_name AS "First Name",
departments.dept_name AS "Department"
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments
ON dept_emp.dept_no = departments.dept_no;
--above works

-- 5. List all employees whose first name is "Hercules" and 
--    whose last names begin with "B."

SELECT 
first_name AS "First Name",
last_name AS "Last Name"
FROM employees
WHERE first_name = 'Hercules' AND UPPER(SUBSTRING(last_name,1,1)) ='B'
--above works

-- 6. List all employees in the Sales department, including their 
--    employee number, last name, first name, and department name.

SELECT 
employees.emp_no AS "Employee No.", 
employees.last_name AS "Last Name", 
employees.first_name AS "First Name",
sales_emps.dept_name AS "Department Name"
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN (
	SELECT * FROM departments
	WHERE dept_name = 'Sales'
) AS sales_emps
ON dept_emp.dept_no = sales_emps.dept_no;
--above works

-- 7. List all employees in the Sales and Development departments, 
--    including their employee number, last name, first name, and 
--    department name.

SELECT 
employees.emp_no AS "Employee No.", 
employees.last_name AS "Last Name", 
employees.first_name AS "First Name",
sales_emps.dept_name AS "Department Name"
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN (
	SELECT * FROM departments
	WHERE dept_name = 'Sales' OR dept_name = 'Development'
) AS sales_emps
ON dept_emp.dept_no = sales_emps.dept_no;

--above works

-- 8. In descending order, list the frequency count of employee 
--    last names, i.e., how many employees share each last name.

SELECT last_name AS "Last name", COUNT(*)
FROM employees
GROUP BY last_name
ORDER BY COUNT(*) DESC;

--check, works
