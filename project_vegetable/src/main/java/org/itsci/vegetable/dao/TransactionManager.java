package org.itsci.vegetable.dao;

import java.sql.Connection;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.TimeZone;
import java.util.Vector;

import org.itsci.vegetable.model.Assets;
import org.itsci.vegetable.model.Member;
import org.itsci.vegetable.model.Projects;
import org.itsci.vegetable.model.Transaction;
import org.itsci.vegetable.model.Transaction_details;

public class TransactionManager {
	/*add income*/
	public int addincome_tsac_detail(Transaction_details td){
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			
	        
			Statement stmt = con.createStatement();
			String sql = "insert into transaction_details(transaction_detail_id,amount,sum,type,asset_id,transaction_id) "
					+ "values('"+td.getTransaction_detail_id()+"','"
								+td.getAmount()+"','"
								+td.getSum()+"','"
								+td.getType()+"','"
								+td.getAssets().getAsset_id()+"','"
								+td.getTransaction().getTransaction_id()+"');";
			int result = stmt.executeUpdate(sql);
			con.close();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	public int addincome_transaction(Transaction t){
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Calendar tsd = t.getDate_time();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        sdf.setTimeZone(TimeZone.getTimeZone("GMT+7"));
	        String  transacdate =  sdf.format(tsd.getTime());
	        
			Statement stmt = con.createStatement();
			String sql = "insert into transaction(transaction_id,date_time,term,total_price,member_id) "
					+ "values('"+t.getTransaction_id()+"','"
								+transacdate+"','"
								+t.getTerm()+"','"
								+t.getTotal_price()+"','"
								+t.getMember().getMember_id()+"');";
			int result = stmt.executeUpdate(sql);
			con.close();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public int addExpense_tsac_detail(Transaction_details td){
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			
	        
			Statement stmt = con.createStatement();
			String sql = "insert into transaction_details(transaction_detail_id,amount,sum,type,asset_id,transaction_id) "
					+ "values('"+td.getTransaction_detail_id()+"','"
								+td.getAmount()+"','"
								+td.getSum()+"','"
								+td.getType()+"','"
								+td.getAssets().getAsset_id()+"','"
								+td.getTransaction().getTransaction_id()+"');";
			int result = stmt.executeUpdate(sql);
			con.close();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	public int addExpense_transaction(Transaction t){
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Calendar tsd = t.getDate_time();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        sdf.setTimeZone(TimeZone.getTimeZone("GMT+7"));
	        String  transacdate =  sdf.format(tsd.getTime());
	        
			Statement stmt = con.createStatement();
			String sql = "insert into transaction(transaction_id,date_time,term,total_price,member_id) "
					+ "values('"+t.getTransaction_id()+"','"
								+transacdate+"','"
								+t.getTerm()+"','"
								+t.getTotal_price()+"','"
								+t.getMember().getMember_id()+"');";
			int result = stmt.executeUpdate(sql);
			con.close();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	
	public List<Assets> getAssets() {
		List<Assets> as = new Vector<>();
		Projects p = new Projects(); 
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Statement stmt = con.createStatement();
			String sql = "select * from assets  ";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int asset_id = rs.getInt(1);
				String asset_price = rs.getString(2);
				String equipment_name = rs.getString(3);
				String equipment_unit = rs.getString(4);
				String product_name = rs.getString(5);
				String product_unit = rs.getString(6);
				String project_id = rs.getString(7);
				
				p = projectID(project_id);
				Assets a = new Assets(asset_id,asset_price,equipment_name,equipment_unit,product_name,product_unit,p);
					 as.add(a);
				 }
			con.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return as;
	}

	public List<Transaction> list_transaction() {
		List<Transaction> ts = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Statement stmt = con.createStatement();
			ResultSet rs2 = stmt.executeQuery("select CURRENT_TIMESTAMP() ");
			while (rs2.next()) {
				String gg = rs2.getString(1);
				System.out.println(gg);
			}
			String sql = "select * from transaction where   DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL 543 year) < DATE_ADD(date_time,INTERVAL 24 HOUR) ";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int transaction_id = rs.getInt(1);
				
				String date_time = rs.getString(2);
				Calendar tdate = Calendar.getInstance(); 
                String date[] = date_time.split("-");
                String date2[] = date[2].split(" ");
                String date3[] = date2[1].split(":");
                
                tdate.set(Integer.parseInt(date[0]), Integer.parseInt(date[1])-1, Integer.parseInt(date2[0]),Integer.parseInt(date3[0]),Integer.parseInt(date3[1]));

				String term = rs.getString(3);
				Double total_price = rs.getDouble(4);
				
				String member_id = rs.getString(5); 
				
				MemberManager m = new MemberManager();
				Member mb = m.getMember(member_id);
				Transaction t = new Transaction(transaction_id,tdate,total_price,term,mb);
					ts.add(t);
				 }
			con.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return ts;
	}


	public Transaction transactionID(int tsid) {
		Transaction ts = new Transaction();
		
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Statement stmt = con.createStatement();
			TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
			String sql = "select * from transaction where transaction_id = "+ tsid  +" ";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int transaction_id = rs.getInt(1);
				
				String date_time = rs.getString(2);
					
				Calendar tdate = Calendar.getInstance(); 
                String date[] = date_time.split("-");
                String date2[] = date[2].split(" ");
                String date3[] = date2[1].split(":");
                
                System.out.println(date_time);
                
                tdate.set(Integer.parseInt(date[0]), Integer.parseInt(date[1])-1, Integer.parseInt(date2[0]),Integer.parseInt(date3[0]),Integer.parseInt(date3[1]));

                
                
				String term = rs.getString(3);
				Double total_price = rs.getDouble(4);
				
				String member_id = rs.getString(5); 
				
				MemberManager m = new MemberManager();
				Member mb = m.getMember(member_id);
				 ts = new Transaction(transaction_id,tdate,total_price,term,mb);	
				 }
			con.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
				
		return ts;
	}
	
	public Projects projectID(String pid) {
		Projects p = new Projects(); 
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Statement stmt = con.createStatement();
			String sql = "select * from projects where project_id = "+ pid +"";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				String project_id = rs.getString(1);
				double cost_amount = rs.getDouble(2);
				String name = rs.getString(3);
				
				p = new Projects(project_id,name,cost_amount);
					
				 }
			con.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return p;
	}
	
	public Assets assetID(int as) {
		Assets a = new Assets();
		Projects p = new Projects(); 
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Statement stmt = con.createStatement();
			String sql = "select * from assets where asset_id = "+ as +"";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int asset_id = rs.getInt(1);
				String asset_price = rs.getString(2);
				String equipment_name = rs.getString(3);
				String equipment_unit = rs.getString(4);
				String product_name = rs.getString(5);
				String product_unit = rs.getString(6);
				String project_id = rs.getString(7);
				
				p = projectID(project_id);
				a = new Assets(asset_id,asset_price,equipment_name,equipment_unit,product_name,product_unit,p);
					
				 }
			con.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return a;
	}
	
	public List<Transaction_details> list_transaction_details(int tid) {
		List<Transaction_details> tsd = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Statement stmt = con.createStatement();
			String sql = "select * from transaction_details where transaction_id = "+ tid +"";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int transaction_detail_id = rs.getInt(1);
				int amount = rs.getInt(2);
				double sum = rs.getDouble(3);
				String type = rs.getString(4);
				int asset_id = rs.getInt(5);
				int transaction_id = rs.getInt(6);
				
				Assets as = assetID(asset_id);
				Transaction ts = transactionID(transaction_id);
	
				Transaction_details t = new Transaction_details(transaction_detail_id,type,amount,sum,ts,as);
					tsd.add(t);
				 }
			con.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return tsd;
	}
	public Transaction_details transaction_details_id(int tdid,int tid) {
		 Transaction_details t = new Transaction_details();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Statement stmt = con.createStatement();
			String sql = "select * from transaction_details where transaction_detail_id = "+ tdid +" and transaction_id = "+tid+"";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int transaction_detail_id = rs.getInt(1);
				int amount = rs.getInt(2);
				double sum = rs.getDouble(3);
				String type = rs.getString(4);
				int asset_id = rs.getInt(5);
				int transaction_id = rs.getInt(6);
				
				Assets as = assetID(asset_id);
				Transaction ts = transactionID(transaction_id);
	
				 t = new Transaction_details(transaction_detail_id,type,amount,sum,ts,as);
					
				 }
			con.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return t;
	}
	
	/*public List<Transaction_details> list_income_expense() {
		List<Transaction_details> tsd = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Statement stmt = con.createStatement();
			TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
			String sql = "select * from transaction_details";
			
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int transaction_detail_id = rs.getInt(1);
				int amount = rs.getInt(2);
				double sum = rs.getDouble(3);
				String type = rs.getString(4);
				int asset_id = rs.getInt(5);
				int transaction_id = rs.getInt(6);
				
				Assets as = assetID(asset_id);
				Transaction ts = transactionID(transaction_id);
				
				SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
				System.out.println( sdf.format(ts.getDate_time().getTime()));
	
				Transaction_details t = new Transaction_details(transaction_detail_id,type,amount,sum,ts,as);
					tsd.add(t);
					
				 }
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(tsd.get(0).getTransaction().getTotal_price());
		return tsd;
	}*/
	
	public List<Transaction_details> transaction_by_search(String t,String d,String term,String year) {
		List<Transaction_details> td = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		
		try {
			Statement stmt = con.createStatement();
			String sql = "";
			if(t.equals("1")&& !d.equals("")) {
				 sql = "select td.transaction_detail_id,td.amount,td.sum,td.type,td.asset_id,td.transaction_id,sum(td.sum) "
						+ " from transaction_details td inner join transaction t on t.transaction_id = td.transaction_id   "
						+ "where CAST(t.date_time AS date) = '"+d+"' and year(t.date_time) = '"+year+"' and t.term = "+term+" group by CAST(t.date_time AS date);";
			}else if(!t.equals("1")&& d.equals("")){
				 sql = "select td.transaction_detail_id,td.amount,td.sum,td.type,td.asset_id,td.transaction_id,sum(td.sum) "
							+ " from transaction_details td inner join transaction t on t.transaction_id = td.transaction_id   "
							+ "where td.type = '"+t+"' and year(t.date_time) = '"+year+"' and t.term = "+term+" group by CAST(t.date_time AS date);";
			}else if(t.equals("1")&& d.equals("")){
				 sql = "select td.transaction_detail_id,td.amount,td.sum,td.type,td.asset_id,td.transaction_id,sum(td.sum) "
						+ " from transaction_details td inner join transaction t on t.transaction_id = td.transaction_id   "
						+ "where and year(t.date_time) = '"+year+"' and t.term = "+term+" group by CAST(t.date_time AS date);";
			}else {
				 sql = "select td.transaction_detail_id,td.amount,td.sum,td.type,td.asset_id,td.transaction_id,sum(td.sum) "
						+ " from transaction_details td inner join transaction t on t.transaction_id = td.transaction_id   "
						+ "where CAST(t.date_time AS date) = '"+d+"' and year(t.date_time) = '"+year+"' and t.term = "+term+" and td.type = '"+t+"' group by CAST(t.date_time AS date);";
			}
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int transaction_detail_id = rs.getInt(1);
				int amount = rs.getInt(2);
				double sum = rs.getDouble(3);
				String type = rs.getString(4);
				int asset_id = rs.getInt(5);
				int transaction_id = rs.getInt(6);
				double total_indate = rs.getDouble(7);
				
				Assets as = assetID(asset_id);
				Transaction ts = transactionID(transaction_id);
				ts.setTotal_price(total_indate);
				SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
				
	
				Transaction_details tds = new Transaction_details(transaction_detail_id,type,amount,sum,ts,as);
					td.add(tds);
					
				 }
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		return td;
	}
	

	public List<Transaction_details> transaction_details_by_search(String t,String d,String term,String year) {
		List<Transaction_details> td = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		
		try {
			Statement stmt = con.createStatement();
			String sql = "select * from transaction_details td inner join transaction t on t.transaction_id = td.transaction_id   "
					+ "where CAST(t.date_time AS date) = '"+d+"' and year(t.date_time) = '"+year+"' and t.term = "+term+" and td.type = '"+t+"';";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int transaction_detail_id = rs.getInt(1);
				int amount = rs.getInt(2);
				double sum = rs.getDouble(3);
				String type = rs.getString(4);
				int asset_id = rs.getInt(5);
				int transaction_id = rs.getInt(6);
				double total_indate = rs.getDouble(7);
				
				Assets as = assetID(asset_id);
				Transaction ts = transactionID(transaction_id);
				ts.setTotal_price(total_indate);
				SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
				
	
				Transaction_details tds = new Transaction_details(transaction_detail_id,type,amount,sum,ts,as);
					td.add(tds);
					
				 }
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		return td;
	}
	public List<Transaction_details> Alltransaction_by_search(String t, String y) {
		List<Transaction_details> td = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		
		try {
			Statement stmt = con.createStatement();
			String sql = "select td.transaction_detail_id,td.amount,td.sum,td.type,td.asset_id,td.transaction_id,sum(td.sum)"
					+ " from transaction_details td inner join transaction t on t.transaction_id = td.transaction_id   "
					+ "where YEAR(t.date_time) = '"+y+"' and t.term = "+ t +" "
					+ "group by CAST(t.date_time AS date);";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int transaction_detail_id = rs.getInt(1);
				int amount = rs.getInt(2);
				double sum = rs.getDouble(3);
				String type = rs.getString(4);
				int asset_id = rs.getInt(5);
				int transaction_id = rs.getInt(6);
				double total_indate = rs.getDouble(7);
				
				Assets as = assetID(asset_id);
				Transaction ts = transactionID(transaction_id);
				ts.setTotal_price(total_indate);
				SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
				
	
				Transaction_details tds = new Transaction_details(transaction_detail_id,type,amount,sum,ts,as);
					td.add(tds);
					
				 }
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		return td;
	}
	

	public List<Transaction_details> Alltransaction_details_by_search(String d,String term,String year) {
		List<Transaction_details> td = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		System.out.println("วันที่ :" +d);	
		try {
			Statement stmt = con.createStatement();
			String sql = "select * from transaction_details td inner join transaction t on t.transaction_id = td.transaction_id "
					+ "where CAST(t.date_time AS date) = '"+d+"' and year(t.date_time) = '"+year+"' and t.term = "+term+"  ;";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int transaction_detail_id = rs.getInt(1);
				int amount = rs.getInt(2);
				double sum = rs.getDouble(3);
				String type = rs.getString(4);
				int asset_id = rs.getInt(5);
				int transaction_id = rs.getInt(6);
			
				
				Assets as = assetID(asset_id);
				Transaction ts = transactionID(transaction_id);
				SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
				
	
				Transaction_details tds = new Transaction_details(transaction_detail_id,type,amount,sum,ts,as);
					td.add(tds);
					
				 }
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		return td;
	}
	/*list edit*/
	public List<Transaction_details> transaction_details_by_date(String t,String d) {
		List<Transaction_details> td = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		
		try {
			Statement stmt = con.createStatement();
			String sql = "select td.transaction_detail_id,td.amount,td.sum,td.type,td.asset_id,td.transaction_id,t.date_time  from transaction_details td "
					+ "inner join transaction t on t.transaction_id = td.transaction_id where CAST(t.date_time AS date) = '"+d+"' and td.type='"+t+"'";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int transaction_detail_id = rs.getInt(1);
				int amount = rs.getInt(2);
				double sum = rs.getDouble(3);
				String type = rs.getString(4);
				int asset_id = rs.getInt(5);
				int transaction_id = rs.getInt(6);
				
								
				Assets as = assetID(asset_id);
				Transaction ts = transactionID(transaction_id);
				SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
				
	
				Transaction_details tds = new Transaction_details(transaction_detail_id,type,amount,sum,ts,as);
					td.add(tds);
					
				 }
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		return td;
	}
	  public int editIncome(Transaction_details td) {
		  	
	        ConnectionDB condb = new ConnectionDB();
	        Connection con = condb.getConnection();
	        try {
	            Statement stmt = con.createStatement();
	            String sql = "update transaction_details set amount="+ td.getAmount()
	            		+ ",sum="+ td.getSum()
	            		+ " where transaction_detail_id = " + td.getTransaction_detail_id() 
	            		+ " and transaction_id = "+td.getTransaction().getTransaction_id()+";";
	            
	            String sql2 = "update transaction set total_price ="+ td.getSum()
	            		+ " where transaction_id = " + td.getTransaction().getTransaction_id()+";";
         
	            int result = stmt.executeUpdate(sql);
	            int result2 = stmt.executeUpdate(sql2);
	            con.close();
	            return result;
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return -1;
	    }
	  public int editExpense(Transaction_details td) {
		  	
	        ConnectionDB condb = new ConnectionDB();
	        Connection con = condb.getConnection();
	        try {
	            Statement stmt = con.createStatement();
	            String sql = "update transaction_details set amount="+ td.getAmount()
	            		+ ",sum="+ td.getSum()
	            		+ " where transaction_detail_id = " + td.getTransaction_detail_id() 
	            		+ " and transaction_id = "+td.getTransaction().getTransaction_id()+";";
	            
	            String sql2 = "update transaction set total_price ="+ td.getSum()
	            		+ " where transaction_id = " + td.getTransaction().getTransaction_id()+";";
       
	            int result = stmt.executeUpdate(sql);
	            int result2 = stmt.executeUpdate(sql2);
	            con.close();
	            return result;
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return -1;
	    }
	  
	  /*ลบข้อมูลทั้งหมด*/
	    public int delete_income_expense(String date) {
	  		ConnectionDB condb = new ConnectionDB();
	  		Connection con = condb.getConnection();
	  		try {
	  			Statement stmt = con.createStatement();
	  			String sql = "delete  t,td from transaction_details td  join transaction t on td.transaction_id=t.transaction_id"
	  					+ " where cast(t.date_time as Date) ='"+date+"' ; ";
	  			int result = stmt.executeUpdate(sql);
	  			con.close();
	  			return result; 
	  		} catch (SQLException e) {
	  			// TODO Auto-generated catch block
	  			e.printStackTrace();
	  		}
	  		return -1;
	  	}
	    /*ลบข้อมูลทีละเเถว*/
	    public int delete_column_income_expense(String tid) {
	  		ConnectionDB condb = new ConnectionDB();
	  		Connection con = condb.getConnection();
	  		try {
	  			Statement stmt = con.createStatement();
	  			String sql = "delete  t,td from transaction_details td  join transaction t on td.transaction_id=t.transaction_id"
	  					+ " where t.transaction_id ='"+tid+"' ; ";
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
