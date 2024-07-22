<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.chainsys.eauction.model.Users"%>
<%@ page import="com.chainsys.eauction.model.Bidders"%>
<%@ page import="com.chainsys.eauction.dao.UserDAO"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bidderyboy Auction Website - View Winners</title>
    <style>
        /* Your CSS styles */
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
padding: -10%;
min-height: 5px;
}

nav ul {
list-style-type: none;
padding: 0;
margin: 0;
}

nav ul li {
margin-bottom: 1px;
}

nav ul li a {
color: white;
text-decoration: none;
font-size: 15px;
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



.form-container {
display: none;
background-color: #f9f9f9;
padding: 20px;
border-radius: 5px;
margin-top: 10px;
}

.form-container input {
width: calc(100% - 16px);
padding: 8px;
margin-bottom: 10px;
box-sizing: border-box;
border-radius: 4px;
border: 1px solid #ccc;
}

.form-container button {
width: 100%;
padding: 8px;
margin-top: 10px;
}
header h2 {
    color: white;
    text-align:left;
    padding:10px;
}
    </style>
</head>
<body>
    <header>
    <h2>BidderBoy</h2>
        <h1>Winner</h1>
        
    </header>
    
    <section id="view-users">
        <table border="1">
            <thead>
                
                <th>Bidder Name</th>
                <th>Product Name</th>
                <th>Bid Amount</th>
                
            </thead>
            <tbody>
                <% 
                ServletContext servletContext = getServletContext();
				ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(servletContext);

				UserDAO userDao = (UserDAO) context.getBean("userDao");
				String productName = (String) request.getAttribute("productName");                   
				List<Bidders> array = userDao.biddersViewWinners(productName);
                    for (Bidders bidders : array) {
                %>
                
                <tr>
                	
                    <td><%= bidders.getBidderName() %></td>
                    <td><%= bidders.getProductName() %></td>
                    <td><%= bidders.getBidAmount() %></td>
                    
                </tr>
                <%} %>
                </tbody>
                </table>
                </section>
                
                
</body>
</html>
