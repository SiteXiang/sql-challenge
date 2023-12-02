
CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT NOT NULL,
    "dept_no" VARCHAR NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no", "dept_no"
     )
);


CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR NOT NULL,
    "emp_no" INT NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no", "emp_no"
     )
);


CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title" FOREIGN KEY("emp_title")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

select *
from departments

select *
from dept_emp

select *
from dept_manager

select *
from titles

select *
from employees

select *
from salaries


-- 1,List the employee number, last name, first name, sex, and salary of each employee.

SELECT
    e.emp_no,
    e.last_name,
    e.first_name,
    e.sex,
    s.salary
FROM
    employees e
JOIN
    salaries s ON e.emp_no = s.emp_no;
	
	
-- 2,List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT
    first_name,
    last_name,
    hire_date
FROM
    employees
WHERE
    EXTRACT(YEAR FROM hire_date) = 1986;


-- 3,List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT
    d.dept_no,
    d.dept_name,
    dm.emp_no,
    e.last_name,
    e.first_name
FROM
    departments d
JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
JOIN
    employees e ON dm.emp_no = e.emp_no;
	
	
-- 4,List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT
    e.emp_no,
    e.last_name,
    e.first_name,
    de.dept_no,
    d.dept_name
FROM
    employees e
JOIN
    dept_emp de ON e.emp_no = de.emp_no
JOIN
    departments d ON de.dept_no = d.dept_no;


-- 5,List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT
    first_name,
    last_name,
    sex
FROM
    employees
WHERE
    first_name = 'Hercules'
    AND last_name LIKE 'B%';
	
	
-- 6,List each employee in the Sales department, including their employee number, last name, and first name.

SELECT
    e.emp_no,
    e.last_name,
    e.first_name,
    d.dept_name
FROM
    employees e
JOIN
    dept_emp de ON e.emp_no = de.emp_no
JOIN
    departments d ON de.dept_no = d.dept_no
WHERE
    d.dept_name = 'Sales';


-- 7,List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT
    e.emp_no,
    e.last_name,
    e.first_name,
    d.dept_name
FROM
    employees e
JOIN
    dept_emp de ON e.emp_no = de.emp_no
JOIN
    departments d ON de.dept_no = d.dept_no
WHERE
    d.dept_name IN ('Sales', 'Development');


-- 8,List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT
    last_name,
    COUNT(last_name) AS frequency
FROM
    employees
GROUP BY
    last_name
ORDER BY
    frequency DESC, last_name;