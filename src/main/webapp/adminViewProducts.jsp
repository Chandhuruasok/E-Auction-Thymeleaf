<%@ page import="java.util.Base64" %>
<%@ page import="com.chainsys.eauction.model.Sellers" %>
<%@ page import="com.chainsys.eauction.dao.UserDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>

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
      padding: 10px;
      text-align: center;
    }

    h1 {
      margin: 0;
      font-size: 22px;
padding-top:-40px;
    }

    nav {
      background-color: rgb(50, 50, 167);
      color: white;
      padding: 10px;
      min-height: 10px;
    }

    nav ul {
      list-style-type: none;
      padding: 0;
      margin: 0;
    }

    nav ul li {
      margin-bottom: 10px;
    }

    nav ul li a {
      color: white;
      text-decoration: none;
      font-size: 15px;
    }

    section {
      padding-top: 20px;
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
      padding-bottom: 1px;
      text-align: center;
      position: fixed;
      bottom: 0;
      width: 100%;
    }

    .countdown {
      margin-top: 10px;
      font-weight: bold;
    }
    header h2 {
    color: white;
    padding-top:2px;
    text-align:left;
    padding:4px;
}
  </style>
</head>
<body>
<% 
if(session == null){
response.sendRedirect("login.jsp");
}
  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
response.setHeader("Pragma", "no-cache"); 
response.setHeader("Expires", "0");
%>
  <header>
    <h2>BidderBoy</h2>
    <h1>Welcome!</h1>
    <nav>
      <ul>
         <li><a href="login.jsp" class="previous">&laquo;previous</a></li>
        <li>
          <form id="searchForm" action="SearchServlet" method="get">
            <input id="searchInput" type="text" name="search" placeholder="Search Product Category...">
            <button type="submit">Search</button>
          </form>
        </li>
        <% if(session.getAttribute("userid")!=null)
       {
    	   %>
    	   
    	   <li><a href="logout">Logout</a></li>
			<% } %>
      </ul>
    </nav>
  </header>
  <section id="view-users">
    <div class="card-container">
      <% 
      ServletContext servletContext = getServletContext();
      ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(servletContext);

      UserDAO userDAO = (UserDAO) context.getBean("userDao");
      List<Sellers> approvedProducts = (List<Sellers>) request.getAttribute("approvedProducts");
      if (approvedProducts != null && !approvedProducts.isEmpty()) {
        for (Sellers seller : approvedProducts) {
          String base64Image = "";
          if (seller.getImage() != null && seller.getImage().length > 0) {
            base64Image = Base64.getEncoder().encodeToString(seller.getImage());
          }
          
          
          SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
          String startDateString = sdf.format(seller.getStartDate());
          
          
          Calendar calendar = Calendar.getInstance();
          calendar.setTime(seller.getStartDate());
          calendar.add(Calendar.DATE, 1);
          String endDateString = sdf.format(calendar.getTime());
          
          
          String currentDateString = sdf.format(new Date());
          boolean isAuctionOngoing = endDateString.compareTo(currentDateString) > 0;
      %>
      <div class="card">
        <img class="product-image" src="data:image/jpeg;base64,<%= base64Image %>" alt="">
        <p>Name: <%= seller.getSellerName() %></p>
        <p>Product Category: <%= seller.getProductCategory() %></p>
        <p>Product Name: <%= seller.getProductName() %></p>
        <p>Product Model: <%= seller.getProductModel() %></p>
        <p>Product Condition: <%= seller.getProductCondition() %></p>
        <p>Product Description: <%= seller.getProductDescription() %></p>
        <p>Terms and Condition: <%= seller.getTerms() %></p>
        <p>Bid Start Amount: <%= seller.getBidStartAmount() %></p>
        <p>Bid Start Date: <%= startDateString %></p>
        <p>Bid End Date: <%= endDateString %></p>
        
        <% if (isAuctionOngoing) { %>
          <form action="/viewbidders" method="post">
            <input type="hidden" name="productname" value="<%= seller.getProductName() %>">
            <button type="submit">View Bidders</button>
          </form>
        <% } else { %>
          <p>Auction ended</p>
          <form action="/viewbidders" method="post">
            <input type="hidden" name="productname" value="<%= seller.getProductName() %>">
            <button type="submit">View Bidders</button>
          </form>
        <% } %>
        
        <form action="/adminViewWinners" method="post">
          <input type="hidden" name="productname" value="<%= seller.getProductName() %>">
          <button type="submit" <%= isAuctionOngoing ? "disabled" : "" %>>View Winners</button>
        </form>
      </div>
      <% 
        }
      } else { %>
        <p>No properties have been approved yet.</p>
      <% } %>
    </div>
  </section>

  <script>
    document.addEventListener('DOMContentLoaded', function () {
      const searchInput = document.getElementById('searchInput');
      searchInput.addEventListener('input', function () {
        const searchValue = searchInput.value.toLowerCase();
        const cards = document.querySelectorAll('.card');
        cards.forEach(card => {
          const productCategory = card.querySelector('p:nth-of-type(2)').textContent.toLowerCase();
          if (productCategory.includes(searchValue)) {
            card.style.display = '';
          } else {
            card.style.display = 'none';
          }
        });
      });
    });
  </script>
</body>
</html>
