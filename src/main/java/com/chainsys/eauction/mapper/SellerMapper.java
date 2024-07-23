package com.chainsys.eauction.mapper;

import java.sql.Blob;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZonedDateTime;

import org.springframework.jdbc.core.RowMapper;

import com.chainsys.eauction.model.Sellers;

public class SellerMapper implements RowMapper<Sellers>{

	@Override
	public Sellers mapRow(ResultSet rs, int rowNum) throws SQLException {
		Sellers sellers=new Sellers();
		sellers.setSellerId(rs.getInt("id"));
		sellers.setSellerName(rs.getString("seller_name"));
		sellers.setProductId(rs.getInt("product_id"));
		sellers.setProductCategory(rs.getString("product_caterogy"));
		sellers.setProductName(rs.getString("product_name"));
		sellers.setImage(rs.getBytes("image"));
		
		sellers.setProductModel(rs.getString("product_model"));
		sellers.setProductCondition(rs.getString("product_condition"));
		sellers.setProductDescription(rs.getString("product_description"));
		sellers.setTerms(rs.getString("terms_and_conditions"));
		sellers.setBidStartAmount(rs.getString("bid_start_amount"));
		 Date startDate = rs.getDate("bid_start_date");
	        Date endDate = rs.getDate("bid_end_date");
	        
	        if (startDate != null) {
	            LocalDate localDate = startDate.toLocalDate();
	            sellers.setStartDate(localDate.atStartOfDay(ZoneId.systemDefault()).toLocalDateTime());
	        }
	        
	        if (endDate != null) {
	            LocalDate localDate = endDate.toLocalDate();
	            sellers.setEndDate(localDate.atStartOfDay(ZoneId.systemDefault()).toLocalDateTime());
	        }

		sellers.setIso(rs.getBytes("iso_certification"));
		
		return sellers;
	}

}