package org.itsci.vegetable.dao;

import org.itsci.vegetable.model.Logins;
import org.itsci.vegetable.model.Member;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.TimeZone;


public class MemberManager {

	public int insertLogins(Logins log, Member mb){
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Statement stmt = con.createStatement();
			String sql = "insert into logins(email,password,status,member_id) "
						+ "values('"+log.getEmail()+"','"
									+log.getPassword()+"',"
									+log.getStatus()+",'"
									+mb.getMember_id()+"')";
			int result = stmt.executeUpdate(sql);
			con.close();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public int insertMembers(Member mb){
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Calendar bd = mb.getMember_birthday();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        sdf.setTimeZone(TimeZone.getTimeZone("GMT+7"));
	        String  birth =  sdf.format(bd.getTime());
	        
			Statement stmt = con.createStatement();
			String sql = "insert into member(member_id,member_prefix,member_name,member_phone,member_birthday,student_code,student_major,student_faculty,member_type) "
					+ "values('"+mb.getMember_id()+"','"
								+mb.getMember_prefix()+"','"
								+mb.getMember_name()+"','"
								+mb.getMember_phone()+"','"
								+birth+"','"
								+mb.getStudent_code()+"','"
								+mb.getStudent_major()+"','"
								+mb.getStudent_faculty()+"','"
								+mb.getMember_type()+ "')";
			int result = stmt.executeUpdate(sql);
			con.close();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return -1;
	}

	public int countAllMember(){
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		int count = 0;
		try {
	        
			Statement stmt = con.createStatement();
			String sql = "SELECT count (*) FROM member";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				 count = rs.getInt(0);
				
			}
			con.close();
			return count;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	public Member getallmember() {
		Member mb = new Member();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Statement stmt = con.createStatement();
			String sql = "select member_id,member_birthday,member_name,member_phone,member_prefix,member_type,officer_position"
					+",student_code,student_faculty,student_major from member";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				String member_id = rs.getString(1);
				String member_birthday = rs.getString(2);
				String member_name = rs.getString(3);
				String member_phone = rs.getString(4);
				int member_prefix = rs.getInt(5);
				String member_type  = rs.getString(6);
				String officer_position = rs.getString(7);
				String student_code = rs.getString(8);
				String student_faculty = rs.getString(9);
				String student_major = rs.getString(10);
		
				
				Calendar bdate = Calendar.getInstance(); 
                String date[] = member_birthday.split("-");
                String date2[] = date[2].split(" ");
                bdate.set(Integer.parseInt(date[0]), Integer.parseInt(date[1])+1, Integer.parseInt(date2[0]));
				
				 mb = new Member(member_id,member_prefix,member_name,member_phone,bdate,
							officer_position,student_code,student_major,student_faculty,member_type);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return mb;
	}
	
	public Member getMember(String mid) {
		Member mb = new Member();
		
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();  
		try {
			Statement stmt = con.createStatement();
			String sql = "select member_id,member_birthday,member_name,member_phone,member_prefix,member_type,officer_position"
							+",student_code,student_faculty,student_major from member where member_id = '"+mid+"'";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				String member_id = rs.getString(1);
				String member_birthday = rs.getString(2);
				String member_name = rs.getString(3);
				String member_phone = rs.getString(4);
				int member_prefix = rs.getInt(5);
				
				String member_type  = rs.getString(6);
				String officer_position = rs.getString(7);
				String student_code = rs.getString(8);
				String student_faculty = rs.getString(9);
				String student_major = rs.getString(10);
		
				
				Calendar bdate = Calendar.getInstance(); 
                String date[] = member_birthday.split("-");
                String date2[] = date[2].split(" ");
                bdate.set(Integer.parseInt(date[0]), Integer.parseInt(date[1])+1, Integer.parseInt(date2[0]));
				
				 mb = new Member(member_id,member_prefix,member_name,member_phone,bdate,
							officer_position,student_code,student_major,student_faculty,member_type);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return mb;
	}
	  public int editProfile(Member emb) {
		  	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        sdf.setTimeZone(TimeZone.getTimeZone("GMT+7"));
	        ConnectionDB condb = new ConnectionDB();
	        Connection con = condb.getConnection();
	        try {
	            Statement stmt = con.createStatement();
	            String sql = "update member set member_prefix = '"+ emb.getMember_prefix()          		
	            		+ "',member_name='"+ emb.getMember_name()
	            		+ "',member_phone='"+ emb.getMember_phone()
	            		+ "',member_birthday='"+ sdf.format(emb.getMember_birthday().getTime())
	            		+ "',officer_position='"+ emb.getOfficer_position()
	            		+ "',student_code='"+ emb.getStudent_code()
	            		+ "',student_major='"+emb.getStudent_major()
	            		+ "',student_faculty='"+ emb.getStudent_faculty()
	            		+ "',member_type='"+ emb.getMember_type()	
	            		+ "' where member_id = '" + emb.getMember_id() + "'";
	            int result = stmt.executeUpdate(sql);
	            con.close();
	            return result;
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return -1;
	    }

public List<Member> getListmember() {
	List<Member> list = new ArrayList<>();
	ConnectionDB condb = new ConnectionDB();
	Connection con = condb.getConnection();
	try {
		Statement stmt = con.createStatement();
		String sql = "select member_id,member_birthday,member_name,member_phone,member_prefix,member_type,officer_position"
				+",student_code,student_faculty,student_major from member";
		ResultSet rs = stmt.executeQuery(sql);
		while (rs.next()) {
			String member_id = rs.getString(1);
			String member_birthday = rs.getString(2);
			String member_name = rs.getString(3);
			String member_phone = rs.getString(4);
			int member_prefix = rs.getInt(5);
			String member_type  = rs.getString(6);
			String officer_position = rs.getString(7);
			String student_code = rs.getString(8);
			String student_faculty = rs.getString(9);
			String student_major = rs.getString(10);
	
			
			Calendar bdate = Calendar.getInstance(); 
            String date[] = member_birthday.split("-");
            String date2[] = date[2].split(" ");
            bdate.set(Integer.parseInt(date[0]), Integer.parseInt(date[1])+1, Integer.parseInt(date2[0]));
			
           Member m  = new Member(member_id,member_prefix,member_name,member_phone,bdate,
						officer_position,student_code,student_major,student_faculty,member_type);
			 
           list.add(m);
		}
		con.close();
	} catch (SQLException e) {
		e.printStackTrace();
	}
	return list;
	
}
}
