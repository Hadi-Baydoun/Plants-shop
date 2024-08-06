## Project Overview

This project is an ecommerce website focused on selling plants. It comprises a MySQL database and an Admin CMS to manage products along with the actual website. The backend is developed using ASP .NET MVC 8, while the frontend utilizes React.JS. The project folder contains three main projects:

1. **plantsshop.admin**: Admin Page
2. **PlantsShop.API**: APIs
3. **plantsshop.website**: Website

### Backend APIs

The backend APIs are documented using Swagger and feature four main HTTP methods:

1. `HttpGet`
2. `HttpPost`
3. `HttpPut`
4. `HttpDelete`

Each table in the database is associated with a model and a controller in the backend.

### Frontend

For the frontend, the following technologies are utilized:

- **React.JS**: For building user interfaces.
- **MUI library**: For UI components.
- **Axios**: For API handling.


## Setup And Running Instructions

To run the project locally, follow these steps:

1. **Download the Database**
   - Download the database.

2. **Install Node.js**
   - Ensure you have [Node.js](https://nodejs.org/) installed on your machine.

3. **Setup Projects in Visual Studio**
   - Open Visual Studio.
   - Navigate to the `plantsshop.admin` and `plantsshop.website` projects.
   - Open the terminal for each project and execute the following commands:

     ```sh
     npm i
     npm run build
     ```

4. **Set API Project as Startup**
   - Right-click on `PlantsShop.API`.
   - Select "Set as Startup Project".
   - Start the project. The Swagger page will open automatically.

5. **Serve the Website**
   - Open the terminal for the `plantsshop.website` project.
   - Execute the following commands:

     ```sh
     cd dist
     npx http-server -p 5173 --gzip
     ```


## Video Demonstrations
Website Walkthrough
Watch the video below for a complete walkthrough of the e-commerce website:


https://drive.google.com/file/d/1mhdeMn6Xe-6mPwAyTm1eO5tCe7jGZgF7/view?usp=sharing

In the website, customers can browse products by searching or filtering by category. To add a product to the wishlist or cart, customers need to log in or sign up

Admin Panel Walkthrough
Watch the video below for a complete walkthrough of the admin panel:

https://drive.google.com/file/d/1tmvr37R0erAO_A0PsJPTQT1pcNkp0P_0/view?usp=sharing

The admin panel is designed to facilitate adding, editing, and deleting products in the database. It can also be used to manage stock and products for the website.
