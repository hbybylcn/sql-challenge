DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS dept_emp;

CREATE TABLE employees(
	
	emp_no VARCHAR PRIMARY KEY NOT NULL,
	
	emp_title_id VARCHAR(20) NOT NULL,
	
	birth_date TIMESTAMP NOT NULL,
	
	first_name VARCHAR(50) NOT NULL,
	
	last_name VARCHAR(50) NOT NULL,
	
	sex VARCHAR(10) NOT NULL,
	
	hire_date TIMESTAMP NOT NULL

);


CREATE TABLE dept_manager(

	dept_no VARCHAR(20) NOT NULL,
	emp_no VARCHAR(25)  NOT NULL,

	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)

);

CREATE TABLE departments(
	
	dept_no VARCHAR(15) PRIMARY KEY NOT NULL,
	
	dept_name VARCHAR(50)
	
);

CREATE TABLE salaries(
 	emp_no VARCHAR(10) PRIMARY KEY NOT NULL,
	salary INTEGER NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE titles(
	title_id VARCHAR(50)  NOT NULL,
	
	title VARCHAR(200)


);

CREATE TABLE dept_emp(

	emp_no VARCHAR(10) NOT NULL,
	
	dept_no VARCHAR (25) NOT NULL,
	
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)


);



-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.


SELECT * FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;


--2. List first name, last name, and hire date for employees who were hired in 1986.

SELECT * FROM employees

WHERE hire_date BETWEEN '19860101' AND '19870101'


--3. List the manager of each department with the following information: \n
--department number, department name, the manager's employee number, last name, first name.



SELECT departments.dept_no,departments.dept_name,employees.emp_no,employees.first_name,employees.last_name FROM departments
JOIN dept_manager
ON dept_manager.dept_no=departments.dept_no
JOIN employees
ON employees.emp_no=dept_manager.emp_no;




--4. List the department of each employee with the following information:\n
--employee number, last name, first name, and department name.

SELECT employees.emp_no,employees.last_name,employees.first_name,departments.dept_name FROM dept_emp
JOIN departments

ON departments.dept_no=dept_emp.dept_no

JOIN employees
ON dept_emp.emp_no=employees.emp_no;


--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."


SELECT first_name,last_name,sex FROM employees

WHERE first_name='Hercules' AND last_name LIKE 'B%';


--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT employees.emp_no,employees.last_name,employees.first_name,departments.dept_name FROM dept_emp

JOIN departments

ON departments.dept_no=dept_emp.dept_no

JOIN employees
ON dept_emp.emp_no=employees.emp_no

WHERE departments.dept_name = 'Sales';


--7. List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.

SELECT employees.emp_no,employees.last_name,employees.first_name,departments.dept_name FROM dept_emp

JOIN departments

ON departments.dept_no=dept_emp.dept_no

JOIN employees
ON dept_emp.emp_no=employees.emp_no

WHERE departments.dept_name = 'Sales' OR departments.dept_name='Development'



--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.



SELECT last_name, COUNT(last_name) FROM employees
GROUP BY last_name
ORDER BY count DESC;





