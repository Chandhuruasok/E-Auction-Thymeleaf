<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="${langAttribute}">
<head>
<meta charset="ISO-8859-1">
<title>Bidderboy Auction Website</title>
<style >
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
}

nav {
    background-color: rgb(50, 50, 167);
    overflow: hidden;
}

nav ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    display: flex;
}

nav ul li {
    flex: 1;
}

nav ul li a {
    display: block;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}

nav ul li a:hover {
    background-color: #111;
}

#content {
    padding: 20px;
}

h1, h2 {
    color: #333;
}

p, ul, ol {
    line-height: 1.6;
}

ul {
    list-style-type: disc;
    margin-left: 20px;
}

ol {
    list-style-type: decimal;
    margin-left: 20px;
}

form {
    margin-top: 20px;
}

form label {
    display: block;
    margin-top: 10px;
}

form input {
    width: 100%;
    padding: 8px;
    margin-top: 5px;
}

form button {
    margin-top: 10px;
    padding: 10px;
    background-color: #333;
    color: white;
    border: none;
    cursor: pointer;
}

form button:hover {
    background-color: #555;
}
.foot
{
background-color:rgb(50, 50, 167);
position:fixed;
bottom:0;

width:100%;
}
.foot p
{
padding-bottom:0px;
text-align:center;
color:white;
}
nav ul li h2 {
    color: white;
}
</style>
</head>
<body>
<nav>
        <ul>
        	<li><h2>BidderBoy</h2></li>
            <li><a href="homePage.jsp">Home</a></li>
            <li><a href="login.jsp">Login</a></li>
            
        </ul>
    </nav>
    <div id="content">
        <h1>About Bidderboy </h1>
        <p>Bidderboy Auction is a leading online auction marketplace founded in 2023 with the mission of providing a secure and efficient platform for buyers and sellers to trade a diverse range of products.</p>
        <h2>Our Mission</h2>
        <p>At Bidderboy Auction, we aim to connect people around the world through our innovative auction platform, offering an array of items from collectibles and antiques to electronics and vehicles. Our goal is to create a trusted environment where users can confidently buy and sell goods.</p>
        <h2>Our Values</h2>
        <ul>
            <li><strong>Trust:</strong> We prioritize the safety and security of our users through robust verification and payment processes.</li>
            <li><strong>Integrity:</strong> We operate with honesty and transparency in all our dealings.</li>
            <li><strong>Innovation:</strong> We continually evolve our platform to provide the best possible experience for our users.</li>
            <li><strong>Community:</strong> We foster a supportive community of buyers and sellers who share our passion for auctions.</li>
        </ul>
        <h2>Contact Us</h2>
        <p>We'd love to hear from you! If you have any questions, suggestions, or need support, please contact us at:</p>
        <ul>
            <li>Email: support@bidderboy-auction.com</li>
            <li>Phone: +91-9876543210</li>
            <li>Address:  123 Under bridge, Kalavasal,Madurai</li>
        </ul>
    </div>
    <div class="foot">
<footer>
<p>&copy;2024 e-Auction.All rights reserved.</p>
</footer>
</div>
</body>
</html>