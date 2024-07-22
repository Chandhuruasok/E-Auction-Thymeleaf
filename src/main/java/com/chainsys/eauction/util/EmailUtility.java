package com.chainsys.eauction.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailUtility {
	 @Autowired
	 private JavaMailSender mailSender;
	 public void sendEmail(String mail, String subject, String body) {
	        SimpleMailMessage message = new SimpleMailMessage();
	        message.setTo(mail);
	        message.setSubject(subject);
	        message.setText(body);
	        message.setFrom("chandhuruasok27@gmail.com");

	        mailSender.send(message);
	    }
}
