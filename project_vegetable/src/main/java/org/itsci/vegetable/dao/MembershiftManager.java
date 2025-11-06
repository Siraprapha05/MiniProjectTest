package org.itsci.vegetable.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import org.itsci.vegetable.model.Member_shifts;
import org.itsci.vegetable.model.Register;

public class MembershiftManager {
	public int insertShift(Member_shifts ms){
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		//register reg = new register();
		try {
			Date bd = ms.getDate();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat stf = new SimpleDateFormat("HH:mm");
	        //sdf.setTimeZone(TimeZone.getTimeZone("GMT+7"));
	        String  dateshift =  sdf.format(bd);
	        
	        Calendar st = ms.getStartTime();	
	        String  startTime =  stf.format(st.getTime());
	        
	        Calendar et = ms.getEndTime();
	        String  endTime =  stf.format(et.getTime());
	     
			Statement stmt = con.createStatement();
			String sql = "insert into member_shifts(member_shift_id,date,endTime,startTime,status,task_name,register_id)"
					+ "values('"+ms.getMember_shift_id()+"','"
								+dateshift+"','"
								+endTime+"','"
								+startTime+"','"
								+ms.getStatus()+"','"
								+ms.getTask_name()+"','"
								+ms.getRegister().getRegister_id()+"')";
			int result = stmt.executeUpdate(sql);
			con.close();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public int ApproveShift(Member_shifts ms){
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		
		try {	
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat stf = new SimpleDateFormat("HH:mm");
	        sdf.setTimeZone(TimeZone.getTimeZone("GMT+7"));

	        Calendar et = ms.getEndTime();
	        String  endTime =  stf.format(et.getTime());
	     
			Statement stmt = con.createStatement();
			String sql = "update member_shifts "
					+ "set status = "+ms.getStatus()+","
					+ "endTime = '"+endTime+"',"
					+ "task_name = '"+ms.getTask_name()+"' "
					+ "where member_shift_id = '"+ ms.getMember_shift_id()+"'" ;
			int result = stmt.executeUpdate(sql);
			con.close();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
    public List<Member_shifts> getListShifts(){
         List<Member_shifts> list = new ArrayList<>();
         ConnectionDB condb = new ConnectionDB();
         Connection con = condb.getConnection();
        try {
            Statement stmt = con.createStatement();
            
            String column = "member_shift_id,date,endTime,startTime,status,task_name,register_id";
            String sql = "select "+column+" from member_shifts order by status ";
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()) {
                String member_shift_id = rs.getString(1);  
                String date = rs.getString(2);
                String endTime  = rs.getString(3);
                String startTime = rs.getString(4);
                int status = rs.getInt(5);
                String task_name = rs.getString(6);
                String register_id = rs.getString(7);
                 
				Calendar sdate_cal = Calendar.getInstance();
                Calendar stime = Calendar.getInstance(); 
				Calendar etime = Calendar.getInstance();
				
				String date1[] = date.split("-");
				date1[2] = date1[2].split(" ")[0];
				sdate_cal.set(Integer.parseInt(date1[0]), Integer.parseInt(date1[1])-1, Integer.parseInt(date1[2]));
				Date sdate = sdate_cal.getTime(); // Convert Calendar to Date
				
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
						 
              Register reg = new Register();
              reg.setRegister_id(register_id);
                Member_shifts st = new Member_shifts(member_shift_id,task_name,sdate,stime,etime,status,reg);

                list.add(st);
            }

            con.close();
        }catch(SQLException e){
            e.printStackTrace();
        }

        return list;
    }
    
    public List<Member_shifts> SearchListShifts(String s){
        List<Member_shifts> list = new ArrayList<>();
        ConnectionDB condb = new ConnectionDB();
        Connection con = condb.getConnection();
       try {
           Statement stmt = con.createStatement();
           
           String column = "member_shift_id,date,endTime,startTime,status,task_name,register_id";
           String sql = "";
           if(s.equals("all")) {
               sql = "select "+column+" from member_shifts order by status "; 
           }else {
               sql = "select "+column+" from member_shifts where status = "+ s +" order by status "; 
           }
           ResultSet rs = stmt.executeQuery(sql);
           while(rs.next()) {
               String member_shift_id = rs.getString(1);  
               String date = rs.getString(2);
               String endTime  = rs.getString(3);
               String startTime = rs.getString(4);
               int status = rs.getInt(5);
               String task_name = rs.getString(6);
               String register_id = rs.getString(7);
                
				Calendar sdate_cal = Calendar.getInstance();
               Calendar stime = Calendar.getInstance(); 
				Calendar etime = Calendar.getInstance();
				
				String date1[] = date.split("-");
						sdate_cal.set(Integer.parseInt(date1[0]), Integer.parseInt(date1[1])-1, Integer.parseInt(date1[2]));
				Date sdate = sdate_cal.getTime(); // Convert Calendar to Date
				
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
						 
             Register reg = new Register();
             reg.setRegister_id(register_id);
               Member_shifts st = new Member_shifts(member_shift_id,task_name,sdate,stime,etime,status,reg);

               list.add(st);
           }

           con.close();
       }catch(SQLException e){
           e.printStackTrace();
       }

       return list;
   }
    
   
    public Member_shifts getMShifts_byRegis(String r){
         Member_shifts st = new Member_shifts();
         ConnectionDB condb = new ConnectionDB();
         Connection con = condb.getConnection();
        try {
            Statement stmt = con.createStatement();
            
            String column = "member_shift_id,date,endTime,startTime,status,task_name,register_id";
            String sql = "select "+column+" from member_shifts where register_id = '"+r+"'";
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()) {
                String member_shift_id = rs.getString(1);  
                String date = rs.getString(2);
                String endTime  = rs.getString(3);
                String startTime = rs.getString(4);
                int status = rs.getInt(5);
                String task_name = rs.getString(6);
                String register_id = rs.getString(7);
                 
 				Calendar sdate_cal = Calendar.getInstance();
                Calendar stime = Calendar.getInstance(); 
 				Calendar etime = Calendar.getInstance();
 				
 				String date1[] = date.split("-");
				sdate_cal.set(Integer.parseInt(date1[0]), Integer.parseInt(date1[1])-1, Integer.parseInt(date1[2]));
				Date sdate = sdate_cal.getTime(); // Convert Calendar to Date
		
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
              Register reg = new Register();
              reg.setRegister_id(register_id);
                st = new Member_shifts(member_shift_id,task_name,sdate,stime,etime,status,reg);

            }

            con.close();
        }catch(SQLException e){
            e.printStackTrace();
        }

        return st;


    }
}
