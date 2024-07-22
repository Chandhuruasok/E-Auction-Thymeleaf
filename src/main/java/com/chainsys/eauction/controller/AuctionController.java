package com.chainsys.eauction.controller;

import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.chainsys.eauction.dao.UserDAO;
import com.chainsys.eauction.model.Sellers;
import com.chainsys.eauction.model.Users;
import com.chainsys.eauction.validation.Validation;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class AuctionController {
	@Autowired
	UserDAO userDao;
	@Autowired
	Validation validation;

	@RequestMapping("/")
	public String homePage() {
		return "homePage";
	}

	@GetMapping("/login")
	public String login() {
		return "login";
	}

	@GetMapping("/register")
	public String register() {
		return "register";
	}

	@GetMapping("/about")
	public String about() {
		return "about";
	}

	@GetMapping("/homePage")
	public String home() {
		return "homePage";
	}
	
	@PostMapping("/register")
	public String register(@RequestParam("email") String email, @RequestParam("name") String name,
			@RequestParam("phonenumber") String phoneNumber, @RequestParam("password") String password, Model model) {
		if (!validation.validateEmail(email)) {
			model.addAttribute("error", "Invalid email format");
			return "register";
		}

		if (!validation.validateUsername(name)) {
			model.addAttribute("error", "Invalid username format");
			return "register";

		}

		if (!validation.validateMobile(phoneNumber)) {
			model.addAttribute("error", "Invalid mobile number");
			return "register";
		}
		if (!validation.validatePassword(password)) {
			model.addAttribute("error", "Password format wrong");
			return "register";
		}

		Users users = new Users();
		users.setEmail(email);
		users.setName(name);
		users.setPhoneNumber(phoneNumber);
		users.setPassword(password);

		if (userDao.register(users)) {

			return "homePage";
		}
		return "login";

	}

	@PostMapping("/login")
	public String login(@RequestParam("email") String email, @RequestParam("username") String name,
			@RequestParam("password") String password, HttpSession session, Model model) {
		if (!validation.validateEmail(email)) {
			model.addAttribute("error", "Invalid email format");
			return "login";
		}

		if (!validation.validateUsername(name)) {
			model.addAttribute("error", "Invalid username format");
			return "login";

		}

		if (!validation.validatePassword(password)) {
			model.addAttribute("error", "Password format wrong");
			return "login";
		}
		Users user = new Users();
		user.setEmail(email);
		user.setName(name);
		user.setPassword(password);

		if (userDao.login(user)) {
			Users userId = userDao.getUserId(email);
			session.setAttribute("userid", userId);
			session.setAttribute("username", userId.getName());

			if (email.endsWith("@bidderboy.com")) {
				List<Sellers> viewSellerProducts = null;
				viewSellerProducts = userDao.adminViewSellerProduct();
				for (Sellers sellers : viewSellerProducts) {
	                String base64 = Base64.getEncoder().encodeToString(sellers.getImage());
	                sellers.setBase64(base64);
	                String base64Image = Base64.getEncoder().encodeToString(sellers.getIso());
	                sellers.setBase64Image(base64Image);
	            }
				model.addAttribute("viewSellerProducts", viewSellerProducts);
				return "admin";
			} else if (email.endsWith("@seller.com")) {
				return "sellerProducts";
			} else if (email.endsWith("@gmail.com")) {
				List<Sellers>approvedProducts=null;
				approvedProducts=userDao.bidderViewApprovedProducts();
				for (Sellers sellers : approvedProducts) {
	                String base64 = Base64.getEncoder().encodeToString(sellers.getImage());
	                sellers.setBase64(base64);
	               
	            }
				model.addAttribute("approvedProducts",approvedProducts);
				return "biddersViewProducts";
			}
		}

		return "register";

	}

	@GetMapping("logout")
	public String logoutUser(HttpSession session, HttpServletRequest request) {
		session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}

		return "login";

	}
}