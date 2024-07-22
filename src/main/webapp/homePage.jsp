<!DOCTYPE html>
<html lang="${langAttribute}">
<head>
<meta charset="ISO-8859-1">
<title>Bidderboy Auction Website</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-image: url('images/auction image.jpg'); 
    background-size: cover;
    background-repeat: no-repeat;
}

.container {
    background-color: rgba(255, 255, 255, 0.8);
    padding: 5px;
    width: 200px;
    margin: 30px auto;
    border-radius: 5px;
    box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
}

nav {
    
    overflow: hidden;
    padding-top:-20px;
    
}

nav ul {
    list-style-type: none;
    margin: 4px;
    padding: 2;
    display: flex;
}

nav ul li {
    flex: 1;
}

nav ul li a {
    display: block;
    color: white;
    text-align: center;
    padding-top: 30px;
    text-decoration: none;
}

nav ul li a:hover {
    background-color: #111;
}

#content {
    padding: 20px;
}

nav ul li h2 {
    color: white;
    padding-left:75px;
}

h1, h2 {
    color: white;
}

p, ul, ol {
    line-height: 3; 
    color:white;
}

ul {
    list-style-type: disc;
    margin-left: 20px;
}

ol {
    list-style-type: decimal;
    margin-left: 20px;
}

nav ul li img {
    height: 35px;
    width: 35px;
    
    padding-left:-10px;
    padding-top:40px;
}

.foot {
    background-color: rgb(50, 50, 167);
    position: fixed;
    bottom: 0;
    width: 100%;
    padding-bottom:-5px;
}

.foot p {
    padding-bottom: -2px;
    text-align: center;
    color: white;
}

</style>
</head>
<body>
<nav>
    <ul>
    
        <li><h2>BidderBoy</h2></li>
        <li><img src="images/auction logo.jpg" alt="logo"></li>
        <li><a href="login.jsp">Login</a></li>
        <li><a href="about.jsp"><i class="fas fa-info-circle"></i> About</a></li>
        <li><a href="liveAuctions.jsp">Live Auctions</a></li>
        <li><a href="endedAuctions.jsp">Ended Auctions</a></li>
        <li><a href="upComingAuctions.jsp">UpComing Auctions</a></li>
    </ul>
</nav>
<div id="content">
    <h1>Welcome to Bidderboy</h1>
    
</div>
<div class="foot">
    <footer>
        <p>&copy;2024 e-Auction. All rights reserved.</p>
    </footer>
</div>
</body>
</html>
