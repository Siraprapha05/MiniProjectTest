package org.itsci.vegetable.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.TimeZone;

import org.itsci.vegetable.model.Member;
import org.itsci.vegetable.model.Member_shifts;
import org.itsci.vegetable.model.Projects;
import org.itsci.vegetable.model.Register;

public class RegisterManager {
	public Register getRegisterById(String rid) {
		Register rg = new Register();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();  
		try {
			Statement stmt = con.createStatement();
			String sql ="select * from register where register_id = '" + rid +"'";
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				String register_id = rs.getString(1);
				String register_date = rs.getString(2);
				String register_reson = rs.getString(3);
				int register_status = Integer.parseInt(rs.getString(4));
				String register_term = rs.getString(5);
				
				String member_id = rs.getString(6);
				
				MemberManager m = new MemberManager();
				Member mbid = new Member();
				mbid = m.getMember(member_id);
				
				String project_id  = rs.getString(7);
				Projects pjid = new Projects();
				pjid.setProject_id(project_id);
				
				Calendar rdate = Calendar.getInstance(); 
                String date[] = register_date.split("-");
                String date2[] = date[2].split(" ");
                rdate.set(Integer.parseInt(date[0]), Integer.parseInt(date[1])+1, Integer.parseInt(date2[0]));
                 
				 rg = new Register(register_id,register_reson,rdate,register_term,
							register_status, mbid,pjid);
			}
				 con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rg;
		
	}
	

	public int insertRegister(Register rgt){
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Calendar rd = rgt.getRegister_date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        sdf.setTimeZone(TimeZone.getTimeZone("GMT+7"));
	        String  regdate =  sdf.format(rd.getTime());
	        
			Statement stmt = con.createStatement();
			String sql = "insert into register(register_id,member_id,project_id,register_reson,register_date,register_status,register_term) "
					+ "values('"+rgt.getRegister_id()+"','"
								+rgt.getMember().getMember_id()+"','"
								+rgt.getProjects().getProject_id()+"','"
								+rgt.getRegister_reson()+"','"
								+regdate+"','"
								+rgt.getRegister_status()+"','"
								+rgt.getRegister_term()+"');";
			int result = stmt.executeUpdate(sql);
			con.close();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public Register getRegister(String mid) {
		Register rg = new Register();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();  
		try {
			Statement stmt = con.createStatement();
			String sql ="select register_id,register_date,register_reson,register_status,register_term,member_id,project_id from register"
							+" where member_id = '"+mid+"'";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				String register_id = rs.getString(1);
				String register_date = rs.getString(2);
				String register_reson = rs.getString(3);
				int register_status = Integer.parseInt(rs.getString(4));
				String register_term = rs.getString(5);
				
				String member_id = rs.getString(6);
				Member mbid = new Member();
				mbid.setMember_id(member_id);
				
				String project_id  = rs.getString(7);
				Projects pjid = new Projects();
				pjid.setProject_id(project_id);
				
				Calendar rdate = Calendar.getInstance(); 
                String date[] = register_date.split("-");
                String date2[] = date[2].split(" ");
                rdate.set(Integer.parseInt(date[0]), Integer.parseInt(date[1])+1, Integer.parseInt(date2[0]));
				
				rg = new Register(register_id,register_reson,rdate,register_term,
							register_status, mbid,pjid);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return rg;
	}
	
	public Register getRegisterID(String mid) {
		Register rg = new Register();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();  
		try {
			Statement stmt = con.createStatement();
			String sql ="select register_id from register where member_id = '"+mid+"'";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				String register_id = rs.getString(1);
				rg.setRegister_id(register_id);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return rg;
	}
	
	public Member getstuCode(String rd) {
		Member m = new Member();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();  
		try {
			Statement stmt = con.createStatement();
			String sql ="select m.student_code,m.member_name,m.member_id from member m inner join register r on m.member_id = r.member_id inner join member_shifts s on r.register_id = s.register_id where s.register_id = '"+rd+"'";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				String stu_code = rs.getString(1);
				String member_name = rs.getString(2);
				String member_id = rs.getString(3);
				m.setStudent_code(stu_code);
				m.setMember_name(member_name);
				m.setMember_id(member_id);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return m;
	}
	
	public Member getMember_shift(String s) {
		Member m = new Member();
		Member_shifts shi = new Member_shifts();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();  
		try {
			Statement stmt = con.createStatement();
			String sql ="select m.student_code,m.member_name,m.member_id,s.date,s.startTime,s.endTime "
					+ "from member m inner join register r on m.member_id = r.member_id "
					+ "inner join member_shifts s on r.register_id = s.register_id where m.student_code  = '"+s+"'";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				String stu_code = rs.getString(1);
				String member_name = rs.getString(2);
				String member_id = rs.getString(3);
				String date = rs.getString(4);
				String startTime = rs.getString(5);
				String endTime = rs.getString(6);
				
					Calendar sdate = Calendar.getInstance();
					Calendar stime = Calendar.getInstance(); 
					Calendar etime = Calendar.getInstance();
							
							String date1[] = date.split("-");
							sdate.set(Integer.parseInt(date1[0]), Integer.parseInt(date1[1])-1, Integer.parseInt(date1[2]));
					
					String date4[] = endTime.split(":");
					int eth = Integer.parseInt( date4[0]);
					int etm = Integer.parseInt( date4[1]);
							 etime.set(Calendar.HOUR,eth);
							 etime.set(Calendar.MINUTE,etm);
							 
					String date5[] = startTime.split(":");
					int sth = Integer.parseInt( date5[0]);
					int stm = Integer.parseInt( date5[1]);
							 stime.set(Calendar.HOUR,sth);
							 stime.set(Calendar.MINUTE,stm);
							 
				m.setStudent_code(stu_code);
				m.setMember_name(member_name);
				m.setMember_id(member_id);
				//shi.getDate(sdate);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return m;
	}
	
	public List<Register> getMemberRequestProject() {
		List<Register> list = new ArrayList<>();
		String Status = "0";
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();  
		try {
			Statement stmt = con.createStatement();
			String sql ="select * from register where register_status = '" + Status +"'";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				String register_id = rs.getString(1);
				String register_date = rs.getString(2);
				String register_reson = rs.getString(3);
				int register_status = Integer.parseInt(rs.getString(4));
				String register_term = rs.getString(5);
				
				String member_id = rs.getString(6);
				
				MemberManager m = new MemberManager();
				Member mbid = new Member();
				mbid = m.getMember(member_id);
				
				String project_id  = rs.getString(7);
				Projects pjid = new Projects();
				pjid.setProject_id(project_id);
				
				Calendar rdate = Calendar.getInstance(); 
                String date[] = register_date.split("-");
                String date2[] = date[2].split(" ");
                rdate.set(Integer.parseInt(date[0]), Integer.parseInt(date[1])+1, Integer.parseInt(date2[0]));
                 
				Register rg = new Register(register_id,register_reson,rdate,register_term,
							register_status, mbid,pjid);
				//member m  = new member(member_id,0, member_name,student_faculty,null, student_major,student_code, "", "", "");
				list.add(rg);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}

    public Register getRequest(String r){
    	Register rg = new Register();
         ConnectionDB condb = new ConnectionDB();
         Connection con = condb.getConnection();
        try {
            Statement stmt = con.createStatement();
            
            String column = "r.register_id,r.register_reson,m.member_id,m.member_prefix,m.member_name,student_faculty,student_major";
            String sql = "select "+column+" from register r join member m where r.register_id = '"+r+"'";
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()) {
                String register_id = rs.getString(1);   
                String register_reson  = rs.getString(2); 
                String member_id = rs.getString(3);
                int member_prefix = rs.getInt(4);
                String member_name = rs.getString(5);
                String student_faculty =rs.getString(6);
                String student_major = rs.getString(7);
 
              Member m = new Member();
              m.setMember_id(member_id);
              m.setMember_prefix(member_prefix);
              m.setMember_name(member_name);
              m.setStudent_faculty(student_faculty);
              m.setStudent_major(student_major);
              
              rg.setMember(m);
              rg.setRegister_id(register_id);
              rg.setRegister_reson(register_reson);

            }

            con.close();
        }catch(SQLException e){
            e.printStackTrace();
        }

        return rg;


    }
    /*อนุมัติคำขอ*/
    public int approveReq(String rid) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Statement stmt = con.createStatement();
			String sql = "update register "
							+ "set register_status= 1  "
							+ " where register_id = '"+rid+"' ";
			int result = stmt.executeUpdate(sql);
			con.close();
			return result; 
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1; 
	}
    
    public int updateMember_status(String mid) {
  		ConnectionDB condb = new ConnectionDB();
  		Connection con = condb.getConnection();
  		try {
  			Statement stmt = con.createStatement();
  			String sql = "update member "
  							+ "set member_type='สมาชิก'  "
  							+ " where member_id = '"+mid+"' ";
  			int result = stmt.executeUpdate(sql);
  			con.close();
  			return result; 
  		} catch (SQLException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		}
  		return -1; 
  	}
    public int updateLogin_status(String mid) {
  		ConnectionDB condb = new ConnectionDB();
  		Connection con = condb.getConnection();
  		try {
  			Statement stmt = con.createStatement();
  			String sql = "update logins "
  							+ "set status = 1  "
  							+ " where member_id = '"+mid+"' ";
  			int result = stmt.executeUpdate(sql);
  			con.close();
  			return result; 
  		} catch (SQLException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		}
  		return -1; 
  	}
    /*ไม่อนุมัติคำขอ*/
    public int deleteLogin(String mid) {
  		ConnectionDB condb = new ConnectionDB();
  		Connection con = condb.getConnection();
  		try {
  			Statement stmt = con.createStatement();
  			String sql = "delete from logins where  member_id = '"+mid+"' ";
  			int result = stmt.executeUpdate(sql);
  			con.close();
  			return result; 
  		} catch (SQLException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		}
  		return -1;
  	}
    public int cancelApproveReq(String rid) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Statement stmt = con.createStatement();
			String sql = "delete from register where  register_id = '"+rid+"' ";
			int result = stmt.executeUpdate(sql);
			con.close();
			return result; 
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}
    public int deleteMember(String mid) {
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Statement stmt = con.createStatement();
			String sql = "delete from member where  member_id = '"+mid+"' ";
			int result = stmt.executeUpdate(sql);
			con.close();
			return result; 
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}
    public List<Member> getMember() {
		List<Member> list = new ArrayList<>();
		
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Statement stmt = con.createStatement();
			String sql = "select * from member where member_type in ('สมาชิก ','หัวหน้าโครงการ') "
					+ "";
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
				
                Member mb = new Member(member_id,member_prefix,member_name,member_phone,bdate,
							officer_position,student_code,student_major,student_faculty,member_type);
                list.add(mb);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
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
	/*กำหนดสิทธิ์*/
	 public int setMember_status(String mid,int status) {
	  		ConnectionDB condb = new ConnectionDB();
	  		Connection con = condb.getConnection();
	  		try {
	  			Statement stmt = con.createStatement();
	  			String member_type;
	  			
	  			if(status==1) {
	  				member_type="สมาชิก";
	  			}else {
	  				member_type="หัวหน้าโครงการ";
	  			}
	  			
	  			String sql = "update member "
	  							+ "set member_type='"+member_type+"'  "
	  							+ " where member_id = '"+mid+"' ";
	  			int result = stmt.executeUpdate(sql);
	  			con.close();
	  			return result; 
	  		} catch (SQLException e) {
	  			// TODO Auto-generated catch block
	  			e.printStackTrace();
	  		}
	  		return -1; 
	  	}
	 public int setRegister_status(String mid,int status) {
	  		ConnectionDB condb = new ConnectionDB();
	  		Connection con = condb.getConnection();
	  		try {
	  			Statement stmt = con.createStatement();
	
	  			String sql = "update register "
	  							+ "set register_status ="+status+" "
	  							+ " where member_id = '"+mid+"' ";
	  			int result = stmt.executeUpdate(sql);
	  			con.close();
	  			return result; 
	  		} catch (SQLException e) {
	  			// TODO Auto-generated catch block
	  			e.printStackTrace();
	  		}
	  		return -1; 
	  	}
	    public int setLogin_status(String mid,int status) {
	  		ConnectionDB condb = new ConnectionDB();
	  		Connection con = condb.getConnection();
	  		try {
	  			Statement stmt = con.createStatement();
	  			String sql = "update logins "
	  							+ "set status ="+status+"  "
	  							+ " where member_id = '"+mid+"' ";
	  			int result = stmt.executeUpdate(sql);
	  			con.close();
	  			return result; 
	  		} catch (SQLException e) {
	  			// TODO Auto-generated catch block
	  			e.printStackTrace();
	  		}
	  		return -1; 
	  	}
}
