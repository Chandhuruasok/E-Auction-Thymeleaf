<%@ page import="com.chainsys.eauction.model.Sellers" %>
<%@ page import="com.chainsys.eauction.dao.UserDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Base64" %> 
<%@ page  import="org.springframework.context.ApplicationContext"%> 
<%@ page  import="org.springframework.web.context.WebApplicationContext"%>
<%@ page  import="org.springframework.web.context.support.WebApplicationContextUtils"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard - Bidderyboy Auction Website</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f0f0f0;
      display: flex;
      flex-direction: column;
    }
    header {
      background-color: rgb(50, 50, 167);
      color: white;
      padding: 7px;
      text-align: center;
    }
    h1 {
      margin: 0;
      font-size: 24px;
      margin-top:10px;
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
      margin-bottom: 5px;
    }
    nav ul li a {
      color: white;
      text-decoration: none;
      font-size: 15px;
      padding:5px;
     
    }
    nav ul li a:hover
    {
       background-color:black;
    }
    
    section {
      padding: 20px;
      flex-grow: 1;
    }
    table {
      border-collapse: collapse;
      width: 100%;
      background-color: white;
      border-radius: 5px;
      overflow: hidden;
    }
    th, td {
      border: 1px solid #ddd;
      padding: 10px;
      text-align: left;
    }
    .product-image {
      max-width: 100px;
      max-height: 100px;
      object-fit: contain;
      
    }
    
    footer {
      background-color: #333;
      color: white;
      padding: 10px;
      text-align: center;
      position:fixed;
      bottom:0;
      width:100%;
    }
    
header h2 {
    color: white;
    padding-top:2px;
    text-align:left;
    padding:10px;
}
img.product-image:hover
{
transform:scale(3);
}
button
{
background-color:red;
color:white;
border-radius:5px;
}
button:hover
{
color:black;
}
  </style>
</head>
<body>
  <header>
  	<h2>BidderBoy</h2>
    <h1>Admin Dashboard</h1>
    <nav>
      <ul>
        
        <li><a href="/viewapprovedproducts">View Approved Products</a></li>
        
      </ul>
    </nav>
  </header>
  <section id="view-users">
    <table border="1">
      <thead>
        <th>Seller ID</th>
        <th>Seller Name</th>
        <th>Product ID</th>
        <th>Product Category</th>
        <th>Product Name</th>
        <th>Product Image</th>
        <th>Product Model</th>
        <th>Product Condition</th>
        <th>Product Description</th>
        <th>Terms and Conditions</th>
        <th>Bid Start Amount</th>
        <th>Bid Start Date</th>
        
        <th>ISO Certificate</th>
        <th>Action</th>
        <th>Approval</th>
      </thead>
      <tbody>
        <% 
        
        ServletContext servletContext = getServletContext();
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(servletContext);

        UserDAO userDao = (UserDAO) context.getBean("userDao");
        List<Sellers> array = userDao.adminViewSellerProduct();
        for (Sellers sellers : array) {
          String base64Image = "";
          String base64Image1 = "";
          if (sellers.getImage() != null && sellers.getIso() != null) {
            base64Image = Base64.getEncoder().encodeToString(sellers.getImage());
            base64Image1 = Base64.getEncoder().encodeToString(sellers.getIso());
          }
        %>
        <tr>
          <td><%=sellers.getSellerId() %></td>
          <td><%=sellers.getSellerName() %></td>
          <td><%=sellers.getProductId() %></td>
          <td><%= sellers.getProductCategory() %></td>
          <td><%=sellers.getProductName() %></td>
          <td><img class="product-image" src="data:image/jpeg;base64,<%=base64Image%>" alt=""></td>
          <td><%= sellers.getProductModel() %></td>
          <td><%= sellers.getProductCondition() %></td>
          <td><%= sellers.getProductDescription() %></td> 
          <td><%= sellers.getTerms() %></td>  
          <td><%= sellers.getBidStartAmount() %></td>  
          <td><%= sellers.getStartDate() %></td> 
           
          <td><img class="product-image" src="data:image/jpeg;base64,<%=base64Image1%>" alt=""></td> 
          <td>
            <form action="/rejectsellerproducts" method="post">
              <input type="hidden" name="action" value="delete">
              <input type="hidden" name="deleteproductid" value="<%= sellers.getProductId() %>">
              <button type="submit" title="delete">Reject</button>
            </form>
          </td>
          <td>
            <form action="/approvesellerproducts" method="post">
              <input type="hidden" name="approveproductid" value="<%= sellers.getProductId() %>">
              <button type="submit" title="approve">Approve</button>
            </form>
            
          </td>
        </tr>
        <% 
        }
        %>
      </tbody>
    </table>
  </section>
  <a href="login.jsp" class="previous">&laquo;previous</a>
</body>
</html>






 