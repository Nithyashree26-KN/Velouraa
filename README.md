# Velouraa — Premium Food Delivery Web Application

Velouraa is a robust, full-stack food delivery web application that connects users with local culinary options. It is designed using a clean Model-View-Controller (MVC) architecture, utilizing a Java J2EE Servlet backend and an interactive JSP-based frontend.

---

## 🚀 Features

- **Dynamic Theme Toggle**: Instantly switch between light and dark modes on the home page.
- **Zomato-style UI**: Elegant, responsive grid displaying handpicked restaurants with pricing, cuisines, ratings, and delivery times.
- **Interactive Search & Filter**: Real-time JavaScript filtering for restaurant searches and category-based navigation (e.g., Biryani, Pizza, Burger, Sushi).
- **Favorites Filter**: A live bookmarking system (heart icon) that lets you filter your dashboard to view only saved restaurants.
- **Interactive Backend Cart**: Unified, servlet-driven shopping cart that keeps tracks of items, quantities, and totals across the database.
- **Secure Authentication**: User sign-up, login, and session-preserving checkout flows.
- **Order Processing**: Auto-populated checkout and order confirmation alerts.

---

## 🛠️ Technology Stack

- **Backend**: Java (J2EE), Servlets, JSP (JavaServer Pages)
- **Database**: MySQL (using JDBC Connector-J 9.2.0)
- **Frontend**: HTML5, Vanilla CSS3 (Custom design variables, flexbox, grid, keyframe animations), JavaScript (ES6+, LocalStorage, DOM manipulation)
- **IDE & Server**: Eclipse Dynamic Web Project with Apache Tomcat 9.0+

---

## 📂 Project Directory Structure

```text
Velouraa/
├── src/main/java/                 # Java Backend Sources
│   └── com/tap/
│       ├── DAO/                   # Data Access Object Interfaces
│       ├── DAOImpl/               # Database Queries & Logic Implementations
│       ├── model/                 # Entity classes (User, Restaurant, Menu, CartItem, etc.)
│       └── servlet/               # MVC Controllers handling HTTP Requests
├── src/main/webapp/               # Web Assets & Views
│   ├── WEB-INF/                   # Deployment descriptor (web.xml) and library files
│   │   ├── lib/
│   │   │   └── mysql-connector-j-9.2.0.jar
│   │   └── web.xml
│   ├── images/                    # Local asset images for restaurants
│   ├── cart.jsp                   # Cart View
│   ├── checkout.jsp               # Checkout Details & Payment Page
│   ├── login.jsp / login.html     # User Sign In
│   ├── menu.jsp                   # Dynamic Restaurant Menu View
│   └── restaurant.jsp             # Main Dashboard View (Home page)
├── .project / .classpath          # Eclipse configuration files
└── README.md                      # Project documentation
```

---

## ⚙️ Setup & Installation Instructions

Follow these steps to run Velouraa on your local machine:

### 1. Prerequisites
- **Java SE Development Kit (JDK 8 or higher)** installed.
- **Apache Tomcat Server (v9.0 or higher)** downloaded and configured.
- **MySQL Database Server** installed and running.
- **Eclipse IDE for Enterprise Java Developers** (or IntelliJ IDEA Ultimate).

### 2. Database Setup
1. Open your MySQL client (Command Line, Workbench, or phpMyAdmin).
2. Create a database named `savora`:
   ```sql
   CREATE DATABASE savora;
   USE savora;
   ```
3. Import your tables and initial data. Make sure the database credentials in `com/tap/utility/DBConnection.java` match your MySQL setup:
   - **URL**: `jdbc:mysql://localhost:3306/savora`
   - **Username**: `root`
   - **Password**: `root` (change this to your actual password if different).

### 3. Importing Project into Eclipse
1. Open Eclipse.
2. Select **File -> Import... -> General -> Existing Projects into Workspace**.
3. Choose the root directory of this project (`Velouraa`) and click **Finish**.

### 4. Running the Application
1. Right-click on the project in the Project Explorer.
2. Click **Run As -> Run on Server**.
3. Select your configured **Apache Tomcat** server and click **Finish**.
4. Access the web app in your browser at `http://localhost:8080/Velouraa/home` (or whatever your configured context path is).

---

## 📝 Authors & Project Demo

This project was built for a university dynamic web application demonstration.
- **Developer**: Nithyashree Hegde KN
- **Repository**: [https://github.com/Nithyashree26-KN/Velouraa](https://github.com/Nithyashree26-KN/Velouraa)
