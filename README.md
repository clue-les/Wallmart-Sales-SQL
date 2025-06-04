# 🛒 Walmart Sales Analysis Project

## 🧾 Overview
This project focuses on analyzing sales data from a Walmart store using SQL. The dataset includes customer details, sales metrics, and product information.  
The main objective is to draw business insights through structured queries—covering **sales trends**, **customer behavior**, **product performance**, and **branch-wise revenue**—all using **MySQL**.

---

## 📑 Table of Contents
- [Technologies Used](#technologies-used)  
- [Dataset](#dataset)  
- [Data Preparation Steps](#data-preparation-steps)  
- [Key Insights](#key-insights)  
- [Conclusion](#conclusion)  

---

## 🛠 Technologies Used
- **SQL**: For querying and analyzing data  
- **MySQL**: To execute all SQL queries and manage the database  

---

## 📂 Dataset
The dataset used is a **Walmart sales CSV file**, containing detailed information on transactions.  
**Key columns include:**
- Invoice ID  
- Branch, City  
- Customer Type, Gender  
- Product Line, Unit Price, Quantity  
- Total, COGS, Tax, Gross Income, Gross Margin %  
- Date, Time, Payment, Rating  

---

## 🧹 Data Preparation Steps

### ✅ 1. Create Database and Table
- A database named `walmartSales` was created.  
- A structured `sales` table was defined with appropriate data types.

### ✅ 2. Load Data
- The CSV file was imported using `LOAD DATA INFILE` method.  
- Date was converted to **YYYY-MM-DD** format for MySQL compatibility.

### ✅ 3. Add Derived Columns
- `time_of_day`: Categorized as Morning, Afternoon, or Evening based on transaction time  
- `day_name`: Extracted weekday from the `date` column  
- `month_name`: Extracted month from the `date` column  

### ✅ 4. Perform Analysis
- Business insights were drawn using SQL queries including:
  - Branch and city performance
  - Product line trends
  - Customer type and gender patterns
  - Revenue and rating by time, day, and payment method  

---

## 📊 Key Insights
- **Top-selling product lines** and **best-performing branches** were identified.
- Customer behavior showed clear patterns by **gender**, **payment method**, and **time of day**.
- **Sunday** saw the highest number of sales in specific branches.
- **Top invoices** by gross income were extracted.
- **Monthly** and **daily trends** in revenue and customer satisfaction were revealed.

---

## ✅ Conclusion
This project demonstrates how **SQL** can be effectively used to extract actionable insights from retail data.  
From **time-based trends** to **branch-wise revenue patterns**, this analysis provides valuable insights to guide **retail strategy and business decisions**.

