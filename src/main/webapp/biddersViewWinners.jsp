<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
body {
	background-image: url('images/winner image.jpg');
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-size: cover; 
	background-position : center;
	display: flex;
	flex-direction: column;
	background-position: center;
	min-height: 100vh;
}

header {
	background-color: rgb(50, 50, 167);
	color: white;
	padding: 1px;
	text-align: center;
}

h1 {
	margin: 0;
	font-size: 24px;
	padding: -50px;
}

nav {
	background-color: rgb(50, 50, 167);
	color: white;
	padding: 8px;
	min-height: 7px;
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
	text-align: left;
	padding: 10px;
}
}
</style>
</head>
<body>
	<header>
		<h2>BidderBoy</h2>
		<h1>Winner</h1>
		<nav>
			<ul>
				<li><a href="biddersViewProducts.jsp" class="previous">&laquo;previous</a></li>
			</ul>
	</header>
	

		<section id="view-users">
			<table border="1">
				<thead>

					<th>Bidder Name</th>
					<th>Product Name</th>
					<th>Bid Amount</th>
					<th>Payment</th>
				</thead>
				<tbody>
					<%
					ServletContext servletContext = getServletContext();
					ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(servletContext);

					UserDAO userDao = (UserDAO) context.getBean("userDao");
					String productName = (String) request.getAttribute("productName");
					Users users = (Users) session.getAttribute("userid");

					List<Bidders> array = userDao.biddersViewWinners(productName);
					for (Bidders bidders : array) {
						int bidderId = users.getId();
						boolean isWinner = (users.getId() == bidders.getUserId());
						boolean isPaid = userDao.isPaid(bidderId, productName);

						if (isWinner) {
							if (isPaid) {
					%>
					<tr>

						<td><%=bidders.getBidderName()%></td>
						<td><%=bidders.getProductName()%></td>
						<td><%=bidders.getBidAmount()%></td>
						<td>

							<button id="payButton_<%=bidders.getBidderName()%>"
								onclick="showPaymentForm('<%=bidders.getBidderName()%>')">Pay</button>
						</td>
					</tr>
					<%
					} else {
					%>
					<tr>

						<td><%=bidders.getBidderName()%></td>
						<td><%=bidders.getProductName()%></td>
						<td><%=bidders.getBidAmount()%></td>
						<td>
					</tr>
					<%
					}
					%>
					<div id="paymentForm_<%=bidders.getBidderName()%>"
						class="form-container">
						<form id="payForm_<%=bidders.getBidderName()%>"
							action="/payment" method="post">
							<label for="accountNumber">Account Number:</label> <input
								type="text" id="accountNumber_<%=bidders.getBidderName()%>"
								name="accountNumber" placeholder="Enter the 16 digits number"
								pattern="[0-9]{16}" required> <label for="cvvNumber">CVV
								Number:</label> <input type="text"
								id="cvvNumber_<%=bidders.getBidderName()%>" name="cvvnumber"
								placeholder="Enter the 3 digits number" pattern="[0-9]{3}"
								required> <label for="expiryDate">Expiry Date:</label> <input
								type="text" id="expiryDate_<%=bidders.getBidderName()%>"
								name="expirydate" placeholder="YYYY/MM" required> <input
								type="hidden" id="bidderName_<%=bidders.getBidderName()%>"
								name="biddername" value="<%=bidders.getBidderName()%>">
							<input type="hidden"
								id="productName_<%=bidders.getProductName()%>"
								name="productname" value="<%=bidders.getProductName()%>">
							<label for="amount">Payable Amount:</label> <input type="text"
								id="amount" name="amount" value="<%=bidders.getBidAmount()%>"
								readonly> <input type="hidden" name="userId"
								value="<%=users.getId()%>">
							<button type="submit">Pay Now</button>
						</form>
					</div>
					<%
					} else {
					%>
					<tr>

						<td><%=bidders.getBidderName()%></td>
						<td><%=bidders.getProductName()%></td>
						<td><%=bidders.getBidAmount()%></td>

					</tr>
					<%
					}
					}
					%>
				</tbody>
			</table>
		</section>

		

		<script>
			function showPaymentForm(bidderName) {
				var paymentForm = document.getElementById('paymentForm_'
						+ bidderName);
				var payButton = document.getElementById('payButton_'
						+ bidderName);

				if (paymentForm.style.display === 'none'
						|| paymentForm.style.display === '') {
					paymentForm.style.display = 'block';
				} else {
					paymentForm.style.display = 'none';
				}

				payButton.style.display = 'none';
			}
		</script>
</body>
</html>
