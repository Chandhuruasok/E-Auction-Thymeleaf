<%@ page import="com.chainsys.eauction.model.Sellers" %>
<%@ page import="com.chainsys.eauction.dao.UserDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Base64" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bidderyboy Auction Website</title>
  <style>
  body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
    }
    header {
      background-color: rgb(50, 50, 167);
      color: white;
      font-size: 10px; 
      padding: 7px 0;
      text-align: center;
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1000;
    }
    nav {
      background-color: rgb(50, 50, 167);
      padding: 3px 7px;
    }
    nav ul {
      list-style-type: none;
      margin: 0;
      padding: 0;
      text-align: center;
    }
    nav ul li {
      display: inline-block;
      margin-right: 20px;
    }
    nav ul li a {
      color: white;
      text-decoration: none;
      font-size: 15px;
      padding: 10px 15px;
      display: inline-block;
    }
    section {
      padding-top: 100px;
      padding-left: 20px;
    }
    .card-container {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
      justify-content: center;
    }
    .card {
      border: 2px solid #ccc;
      border-radius: 5px;
      padding: 10px;
      margin: 20px;
      background-color: pink;
      width: 350px;
    }
    .card img {
      display: block;
      margin: auto;
      max-width: 80%;
      height: auto;
      border-radius: 4px;
    }
    table {
      border-collapse: collapse;
      width: 100%;
    }
    th, td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: left;
    }
    footer {
      background-color: green;
      color: white;
      padding: 10px 0;
      text-align: center;
      position: fixed;
      bottom: 0;
      width: 100%;
    }
    .card button {
      width: 100%;
      padding: 8px;
      margin-top: 10px;
    }
    .bid-form {
      margin-top: 10px;
    }
    .bid-form label {
      display: block;
      margin-bottom: 10px;
    }
    .bid-form input[type="number"] {
      width: calc(100% - 16px);
      padding: 8px;
      margin-bottom: 10px;
      box-sizing: border-box;
      border-radius: 4px;
      border: 1px solid #ccc;
    }
    .countdown {
      margin-top: 10px;
      font-weight: bold;
    }
    .no-products-found {
      display: none;
      text-align: center;
      margin-top: 20px;
      font-size: 18px;
      color: red;
      }
      nav ul li h2 {
    color: white;
    padding-left:-5%;
}
  </style>
</head>
<body>

  <header>
    <h1>Welcome!</h1>
    <nav>
      <ul>
        <li><h2>BidderBoy</h2></li>
        <li>
          <form id="searchForm" action="SearchServlet" method="get">
            <input id="searchInput" type="text" name="search" placeholder="Search Product Category...">
            <button type="submit">Search</button>
          </form>
        </li>
        <li><a href="homePage.jsp">Home</a></li>
      </ul>
    </nav>
  </header>

  <section id="view-users">
    <div class="card-container">
      <%  
        ServletContext servletContext = getServletContext();
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(servletContext);

        UserDAO userDAO = (UserDAO) context.getBean("userDao");
        
        List<Sellers> approvedProducts = userDAO.viewEndedAuctions();
        if (approvedProducts != null && !approvedProducts.isEmpty()) {
          for (Sellers seller : approvedProducts) {
            String base64Image = "";
            if (seller.getImage() != null && seller.getImage().length > 0) {
              base64Image = Base64.getEncoder().encodeToString(seller.getImage());
            }
      %>
            <div class="card">
              <img class="product-image" src="data:image/jpeg;base64,<%=base64Image%>" alt="Product Image">
              <p>Seller Name: <%= seller.getSellerName() %></p>
              <p>Product Category: <%= seller.getProductCategory() %></p>
              <p>Product Name: <%= seller.getProductName() %></p>
              <p>Product Model: <%= seller.getProductModel() %></p>
              <p>Product Condition: <%= seller.getProductCondition() %></p>
              <p>Product Description: <%= seller.getProductDescription() %></p>
              <p>Terms and Conditions: <%= seller.getTerms() %></p>
              <p>Bid Start Amount: <%= seller.getBidStartAmount() %></p>
              <p>Bid Start Date: <%= seller.getStartDate() %></p>
              
              
            </div>
          <% }
        } else { %>
          <p class="no-products-found">No live auctions found.</p>
        <% } %>
    </div>
  </section>

  

</body>
</html>
