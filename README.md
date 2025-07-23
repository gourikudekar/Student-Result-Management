#  Student Result Management System - SQL Project

##  Description

This SQL project simulates an academic result system with students, courses, semesters, grades, and GPA calculations. It enables storing, querying, and analyzing student performance over semesters.

##  Database Schema

- **Students**: Basic student information.
- **Courses**: Course code, name, and credits.
- **Semesters**: Academic terms (Fall, Spring, Summer).
- **Grades**: Marks and grade per course per student.

##  Features

- GPA calculation per semester and cumulative
- Pass/fail analysis by course and semester
- Top performers by semester and subject
- Students with no failures
- Trigger to auto-calculate GPA on grade insert
- Insights using window functions (RANK, DENSE_RANK)

##  Technologies Used

- MySQL
- Triggers
- Views & CTEs (Common Table Expressions)
- Window Functions
- Aggregation Logic

## How to Run
1. Import the `student result project.sql` file into MySQL Workbench or similar.
2. Execute all commands to set up tables, populate data, and create triggers.
3. Run provided queries for analytics and insights.

##  Author
Created by Gouri Kudekar.
