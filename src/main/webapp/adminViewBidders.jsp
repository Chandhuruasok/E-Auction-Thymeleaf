<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.chainsys.eauction.model.Users"%>
<%@ page import="com.chainsys.eauction.model.Bidders"%>
<%@ page import="com.chainsys.eauction.dao.UserDAO"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Bidderyboy Auction Website</title>
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
	background-color:rgb(50, 50, 167);
	color: white;
	padding: 10px;
	text-align: center;
}

h1 {
	margin: 0;
	font-size: 24px;
	padding-top:-40px;
}

nav {
	background-color:rgb(50, 50, 167);
	color: white;
	padding:-10%;
	min-height: 10px;
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
	font-size: 16px;
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
	position: fixed;
	bottom: 0;
	width: 100%;
}
header h2 {
    color: white;
    text-align:left;
    padding-bottom:-20px;
}

</style>
</head>
<body>
	<header>
	<h2>BidderBoy</h2>
		<h1>Bidders</h1>
		
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
				List<Bidders> array = userDao.viewBidders(productName);
				for (Bidders bidders : array) {
				%>
				<tr>
					
					<td><%=bidders.getBidderName()%></td>
					<td><%=bidders.getProductName()%></td>
					<td><%=bidders.getBidAmount()%></td>
				</tr>
				<%
				Users users = (Users) session.getAttribute("userid");
				%>
				<%
				String userName = (String) session.getAttribute("username");
				%>
				<%
				}
				%>
			</tbody>
		</table>
	</section>
</body>
</html>