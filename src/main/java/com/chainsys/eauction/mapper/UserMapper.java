package com.chainsys.eauction.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.chainsys.eauction.model.Users;

public class UserMapper implements RowMapper<Users> {

	@Override
	public Users mapRow(ResultSet rs, int rowNum) throws SQLException {
		Users userDetails=new Users();
		userDetails.setId(rs.getInt("id"));
		userDetails.setEmail(rs.getString("email"));
		userDetails.setName(rs.getString("user_name"));
		return userDetails;
	}

}