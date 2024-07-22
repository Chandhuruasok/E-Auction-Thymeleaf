<!DOCTYPE html>
<html lang="${langAttribute}">
<head>
<meta charset="ISO-8859-1">
<title>Bidderboy Auction Website</title>
<style>
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
}

nav {
    background-color: rgb(50, 50, 167);
    overflow: hidden;
    top: 0;
    width: 100%;
    position: fixed;
}

nav ul {
    list-style-type: none;
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

body {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    background-image: url('images/auction.jpg'); 
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    padding-top: 50px;
}

.container {
    background-color: rgba(255, 255, 255, 0.8);
    padding: 20px;
    max-width: 400px;
    width: 100%;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 5px;
    margin: auto;
}

.registration-form h2 {
    text-align: center;
    margin-bottom: 20px;
}

.registration-form p {
    margin-bottom: 10px;
    font-size: 14px;
    line-height: 1.4;
}

.form-group {
    margin-bottom: 15px;
}

.form-group label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
}

.form-group input[type="radio"] {
    display: none;
}

.form-group label.radio-label {
    display: inline-block;
    vertical-align: middle;
    cursor: pointer;
    margin-right: 20px;
}

.form-group input[type="radio"] + .radio-label:before {
    content: "";
    display: inline-block;
    width: 20px;
    height: 20px;
    border-radius: 50%;
    border: 1px solid #ccc;
    margin-right: 10px;
    vertical-align: middle;
}

.form-group input[type="radio"]:checked + .radio-label:before {
    background-color: rgb(50, 50, 167);
}

.form-group label.radio-label span {
    vertical-align: middle;
}

.form-group input,
.form-group select {
    width: calc(100% - 20px);
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 3px;
}

button {
    width: 100%;
    padding-bottom: 20px;
    border: none;
    background-color: rgb(50, 50, 167);
    color: white;
    font-size: 18px;
    cursor: pointer;
    border-radius: 3px;
    margin-top: 5px;
}

button:hover {
    background-color: black;
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
        <li><a href="about.jsp">About</a></li>
    </ul>
</nav>
<a href="homePage.jsp" class="previous">&laquo;previous</a>
<div class="container">
<% if (request.getAttribute("error") != null) { %>
        <div class="error-message"><%= request.getAttribute("error") %></div>
        <% } %>
    <form action="/register" method="post" class="registration-form">
        <h2>Registration Form</h2>
        <div class="form-group">
            <label for="role">Role</label><br>
            <input type="radio" id="seller" name="role" value="seller" onclick="updateEmailPlaceholder()"> 
            <label class="radio-label" for="seller"><span>Seller</span></label>
            <input type="radio" id="bidder" name="role" value="bidder" onclick="updateEmailPlaceholder()"> 
            <label class="radio-label" for="bidder"><span>Bidder</span></label>
        </div>
        <div class="form-group">
            <label for="email">Email</label> 
            <input type="email" id="email" name="email" required onKeyPress="handleKeyPress(event)" onKeyDown="handleKeyDown(event)" onKeyUp="handleKeyUp(event)">
        </div>
        <div class="form-group">
            <label for="name">User Name</label> 
            <input type="text" id="name" name="name"  required >
        </div>
        <div class="form-group">
            <label for="phonenumber">Phone Number</label> 
            <input type="tel" id="phonenumber" name="phonenumber" pattern="[0-9]{10}" required >
        </div>
        <div class="form-group">
            <label for="password">Password</label> 
            <input type="password" id="password" name="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#&]).{5,}" required >
        </div>
        <div class="form-group">
            <label for="confirmpassword">Confirm Password</label> 
            <input type="password" id="confirmpassword" name="confirmpassword"  pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#&]).{5,}" required>
        </div>

        <button type="submit">Register</button>
        <input type="hidden" name="action" value="register"> 
        <input type="hidden" name="register">
    </form>
</div>
<script>
    function updateEmailPlaceholder() {
        var emailField = document.getElementById("email");
        var sellerRadio = document.getElementById("seller");
        var bidderRadio = document.getElementById("bidder");

        if (sellerRadio.checked) {
            emailField.placeholder = "Enter your email (@seller.com)";
        } else if (bidderRadio.checked) {
            emailField.placeholder = "Enter your email (@gmail.com)";
        }
    }
    function handleKeyPress(event) {
        console.log('Key pressed:', event.key);
        
    }

    function handleKeyDown(event) {
        console.log('Key down:', event.key);
        
    }

    function handleKeyUp(event) {
        console.log('Key up:', event.key);
        
    }
</script>
</body>
</html>
