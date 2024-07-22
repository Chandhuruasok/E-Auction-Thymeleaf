<%@ page import="com.chainsys.eauction.model.Sellers" %>
<%@ page import="com.chainsys.eauction.model.Users" %>
<%@ page import="com.chainsys.eauction.dao.UserDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
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
      padding: 1px 3px;
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
      padding-top: 5px 6px;
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
      background-color: rgb(50, 50, 167);
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
    nav ul li h1,h2 {
      color: white;
      padding-top:3px;
    }
  </style>
</head>
<body>

<header>
  
  <h1>Welcome Bidders!</h1>
  <nav>
    <ul>
    <li><a href="login.jsp" class="previous">&laquo;previous</a></li>
      <li>
        <form id="searchForm" action="SearchServlet" method="get">
          <input id="searchInput" type="text" name="search" placeholder="Search Product Category...">
          <button type="submit">Search</button>
        </form>
      </li>
     
    	   <li><a href="logout">Logout</a></li>
			
    </ul>
  </nav>
</header>

<section id="view-users">
  <div class="card-container">
    <%  
    ServletContext servletContext = getServletContext();
    ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(servletContext );

    UserDAO userDAO = (UserDAO) context.getBean("userDao");
    
    List<Sellers> approvedProducts = userDAO.bidderViewApprovedProducts();
    if (approvedProducts != null && !approvedProducts.isEmpty()) {
      for (Sellers sellers : approvedProducts) {
        String base64Image = "";
        if (sellers.getImage() != null && sellers.getImage().length > 0) {
          base64Image = Base64.getEncoder().encodeToString(sellers.getImage());
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String startDateString = sdf.format(sellers.getStartDate());
        
        
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(sellers.getStartDate());
        calendar.add(Calendar.DATE, 1);
        String endDateString = sdf.format(calendar.getTime());
        
        
        String currentDateString = sdf.format(new Date());
        boolean isAuctionOngoing = endDateString.compareTo(currentDateString) > 0;
        
        
    %>
    <div class="card" id="card_<%= sellers.getProductId() %>">
      <img class="product-image" src="data:image/jpeg;base64,<%=base64Image%>" alt="">
      <p>Seller Name: <%= sellers.getSellerName() %></p>
      <p>Product Category: <%= sellers.getProductCategory() %></p>
      <p>Product Name: <%= sellers.getProductName() %></p>
      <p>Product Model: <%= sellers.getProductModel() %></p>
      <p>Product Condition: <%= sellers.getProductCondition() %></p>
      <p>Product Description: <%= sellers.getProductDescription() %></p>
      <p>Terms and Condition: <%= sellers.getTerms() %></p>
      <p>Bid Start Amount: <%= sellers.getBidStartAmount() %></p>
      <p>Bid Start Date: <%= sellers.getStartDate() %></p>
      <p>Auction End Date: <%= endDateString %></p>
     
      <div class="countdown" id="countdown_<%= sellers.getProductId() %>"></div>
      <% 
      Users user = (Users) session.getAttribute("userid");
        
      if (isAuctionOngoing) { 
      %>
      <button type="button" onclick="toggleBidForm('<%= sellers.getProductName() %>')" title="bid">Bid Now</button>
      <form id="bidForm_<%= sellers.getProductName() %>" class="bid-form" style="display: none;" action="/insertbidamount" method="post" onsubmit="return validateBidAmount('<%= sellers.getBidStartAmount() %>')">
        <input type="hidden" name="userId" value="<%= user.getId() %>">
        <input type="hidden" name="biddername" value="<%= user.getName() %>">
        <input type="hidden" name="productname" value="<%= sellers.getProductName() %>">
        <label for="bidAmount_<%= sellers.getProductName() %>">Enter Bid Amount:</label>
        <input type="number" id="bidAmount_<%= sellers.getProductName() %>" name="bidAmount" required value="<%= sellers.getBidStartAmount() %>" min="<%= sellers.getBidStartAmount() %>">
        <button type="submit">Submit Bid</button>
      </form>
      <form action="/viewbiddersDetails" method="post">
        <input type="hidden" name="productname" value="<%= sellers.getProductName() %>">
        <button type="submit">View Bidders</button>
      </form>
      <% } else { %>
      <p>Auction ended</p>
      <button type="button" disabled>Bid Now</button>
      <form action="/viewbiddersDetails" method="post">
        <input type="hidden" name="productname" value="<%= sellers.getProductName() %>">
        <button type="submit">View Bidders</button>
      </form>
      <% } %>
      <form action="/winners" method="post">
        <input type="hidden" name="productname" value="<%= sellers.getProductName() %>">
        <button type="submit" <%= isAuctionOngoing ? "disabled" : "" %>>View Winners</button>
      </form>
    </div>
   
    <%                
      } 
    } else { 
    %>
    <p>No properties have been approved yet.</p>
    <% 
      } 
    %>
  </div>
  <p id="noProductsFoundMessage" class="no-products-found">No products found.</p>
</section>

<script>
  document.addEventListener('DOMContentLoaded', function () {
    const searchInput = document.getElementById('searchInput');
    const noProductsFoundMessage = document.getElementById('noProductsFoundMessage');

    searchInput.addEventListener('input', function () {
      const searchValue = searchInput.value.toLowerCase();
      const cards = document.querySelectorAll('.card');
      let visibleCardCount = 0;

      cards.forEach(card => {
        const productCategory = card.querySelector('p:nth-of-type(2)').textContent.toLowerCase();
        if (productCategory.includes(searchValue)) {
          card.style.display = '';
          visibleCardCount++;
        } else {
          card.style.display = 'none';
        }
      });

      if (visibleCardCount === 0) {
        noProductsFoundMessage.style.display = 'block';
      } else {
        noProductsFoundMessage.style.display = 'none';
      }
    });
  });
  
  function toggleBidForm(productName) {
    var bidForm = document.getElementById("bidForm_" + productName);
    if (bidForm.style.display === "none" || bidForm.style.display === "") {
      bidForm.style.display = "block";
    } else {
      bidForm.style.display = "none";
    }
  }

  function validateBidAmount(startingBid) {
    var bidAmountInput = document.getElementById('bidAmount_' + productName);
    var bidAmount = parseFloat(bidAmountInput.value);
    var startingBidValue = parseFloat(startingBid);

    if (bidAmount < startingBidValue) {
      alert('Bid amount cannot be less than the starting bid amount: ' + startingBidValue);
      return false;
    }
    return true;
  }
</script>

</body>
</html>
