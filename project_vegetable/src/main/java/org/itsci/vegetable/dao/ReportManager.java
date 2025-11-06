package org.itsci.vegetable.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Vector;

import org.itsci.vegetable.model.Assets;
import org.itsci.vegetable.model.Member;
import org.itsci.vegetable.model.Member_shifts;
import org.itsci.vegetable.model.Register;
import org.itsci.vegetable.model.Transaction;
import org.itsci.vegetable.model.Transaction_details;

public class ReportManager {
	public List<Member_shifts> getAllWorkStatistics() {
		List<Member_shifts> list = new ArrayList<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Statement stmt = con.createStatement();
			String sql = "select m.student_code,m.member_name,m.student_major , SEC_TO_TIME(SUM(TIME_TO_SEC(ms.endTime) - TIME_TO_SEC(ms.startTime)))as sumtime from member_shifts ms inner join register r on r.register_id = ms.register_id inner join "
					+ "member m on m.member_id = r.member_id  group by m.student_code, m.member_name, m.student_major ;";

			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {

				String student_code = rs.getString(1);
				String member_name = rs.getString(2);
				String student_major = rs.getString(3);
				String endTime = rs.getString(4);

				Calendar etime = Calendar.getInstance();

				String date4[] = endTime.split(":");
				int eth = Integer.parseInt(date4[0]);
				int etm = Integer.parseInt(date4[1]);
				etime.set(Calendar.HOUR, eth);
				etime.set(Calendar.MINUTE, etm);
				Date endTimeDate = etime.getTime(); // Convert Calendar to Date

				Member m = new Member();
				m.setStudent_code(student_code);
				m.setMember_name(member_name);
				m.setStudent_major(student_major);
				Register r = new Register();
				r.setMember(m);

				Member_shifts ms = new Member_shifts();
				ms.setEndTime(endTimeDate);
				ms.setRegister(r);
				list.add(ms);
			}

			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public Member_shifts getStatistics(String s_code, int term, int year) {
		Member_shifts ms = new Member_shifts();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Statement stmt = con.createStatement();
			String sql;

			if (term == 1) {
				sql = "select m.student_code,m.member_name,m.student_major , SEC_TO_TIME(SUM(TIME_TO_SEC(ms.endTime) - TIME_TO_SEC(ms.startTime)))as sumtime from member_shifts ms inner join register r on r.register_id = ms.register_id inner join "
						+ "member m on m.member_id = r.member_id where m.student_code = '" + s_code
						+ "' and  date(ms.date) between '" + year + "-07-01' and '" + year
						+ "-10-31' group by m.student_code, m.member_name, m.student_major ;";
			} else {
				sql = "select m.student_code,m.member_name,m.student_major , SEC_TO_TIME(SUM(TIME_TO_SEC(ms.endTime) - TIME_TO_SEC(ms.startTime)))as sumtime from member_shifts ms inner join register r on r.register_id = ms.register_id inner join "
						+ "member m on m.member_id = r.member_id where m.student_code = '" + s_code
						+ "' and date(ms.date) between '" + year + "-11-01' and '" + (year + 1)
						+ "-03-31' group by m.student_code, m.member_name, m.student_major ;";
			}
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {

				String student_code = rs.getString(1);
				String member_name = rs.getString(2);
				String student_major = rs.getString(3);
				String endTime = rs.getString(4);

				Calendar etime = Calendar.getInstance();

				String date4[] = endTime.split(":");
				int eth = Integer.parseInt(date4[0]);
				int etm = Integer.parseInt(date4[1]);
				etime.set(Calendar.HOUR, eth);
				etime.set(Calendar.MINUTE, etm);
				Date endTimeDate = etime.getTime(); // Convert Calendar to Date

				Member m = new Member();
				m.setStudent_code(student_code);
				m.setMember_name(member_name);
				m.setStudent_major(student_major);
				Register r = new Register();
				r.setMember(m);

				ms.setEndTime(endTimeDate);
				ms.setRegister(r);
				return ms;
			}

			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<Member_shifts> search_WorkStatistics(int term, int year) {
		List<Member_shifts> list = new ArrayList<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Statement stmt = con.createStatement();
			String sql;
			if (term == 1) {
				sql = "select m.student_code,m.member_name,m.student_major , SEC_TO_TIME(SUM(TIME_TO_SEC(ms.endTime) - TIME_TO_SEC(ms.startTime)))as sumtime from member_shifts ms inner join register r on r.register_id = ms.register_id inner join "
						+ "member m on m.member_id = r.member_id where date(ms.date) between '" + year + "-07-01' and '" + year
						+ "-10-31' group by m.student_code, m.member_name, m.student_major ;";
			} else {
				sql = "select m.student_code,m.member_name,m.student_major , SEC_TO_TIME(SUM(TIME_TO_SEC(ms.endTime) - TIME_TO_SEC(ms.startTime)))as sumtime from member_shifts ms inner join register r on r.register_id = ms.register_id inner join "
						+ "member m on m.member_id = r.member_id where date(ms.date) between '" + year + "-11-01' and '"
						+ (year + 1) + "-03-31' group by m.student_code, m.member_name, m.student_major ;";
			}

			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {

				String student_code = rs.getString(1);
				String member_name = rs.getString(2);
				String student_major = rs.getString(3);
				String endTime = rs.getString(4);

				Calendar etime = Calendar.getInstance();

				String date4[] = endTime.split(":");
				int eth = Integer.parseInt(date4[0]);
				int etm = Integer.parseInt(date4[1]);
				etime.set(Calendar.HOUR, eth);
				etime.set(Calendar.MINUTE, etm);
				Date endTimeDate = etime.getTime(); // Convert Calendar to Date

				Member m = new Member();
				m.setStudent_code(student_code);
				m.setMember_name(member_name);
				m.setStudent_major(student_major);
				Register r = new Register();
				r.setMember(m);

				Member_shifts ms = new Member_shifts();
				ms.setEndTime(endTimeDate);
				ms.setRegister(r);
				list.add(ms);
			}

			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	/*
	 * public Member_shifts getWorkStatisticsByID(String sid){
	 * ConnectionDB condb = new ConnectionDB();
	 * Connection con = condb.getConnection();
	 * try {
	 * Statement stmt = con.createStatement();
	 * String sql =
	 * "select m.student_code, SEC_TO_TIME(SUM(TIME_TO_SEC(ms.endTime) - TIME_TO_SEC(ms.startTime)))as sumtime from member_shifts ms inner join register r on r.register_id = ms.register_id inner join "
	 * + "member m on m.member_id = r.member_id  where m.student_code '"+ sid
	 * +"' group by m.student_code ;";
	 * ResultSet rs = stmt.executeQuery(sql);
	 * while(rs.next()) {
	 * 
	 * String student_code = rs.getString(1);
	 * String member_name = rs.getString(2);
	 * String student_major = rs.getString(3);
	 * String endTime = rs.getString(4);
	 * 
	 * Calendar etime = Calendar.getInstance();
	 * 
	 * 
	 * String date4[] = endTime.split(":");
	 * int eth = Integer.parseInt( date4[0]);
	 * int etm = Integer.parseInt( date4[1]);
	 * etime.set(Calendar.HOUR,eth);
	 * etime.set(Calendar.MINUTE,etm);
	 * Member m = new Member();
	 * m.setStudent_code(student_code);
	 * m.setMember_name(member_name);
	 * m.setStudent_major(student_major);
	 * Register r = new Register();
	 * r.setMember(m);
	 * 
	 * Member_shifts ms = new Member_shifts();
	 * ms.setEndTime(etime);
	 * ms.setRegister(r);
	 * 
	 * 
	 * list.add(ms);
	 * }
	 * 
	 * con.close();
	 * }catch(SQLException e){
	 * e.printStackTrace();
	 * }
	 * return list;
	 * }
	 */
	public List<Transaction_details> list_Alltransaction_details() {
		List<Transaction_details> tsd = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Statement stmt = con.createStatement();
			String sql = "select * from transaction_details";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int transaction_detail_id = rs.getInt(1);
				int amount = rs.getInt(2);
				double sum = rs.getDouble(3);
				String type = rs.getString(4);
				int asset_id = rs.getInt(5);
				int transaction_id = rs.getInt(6);

				TransactionManager tm = new TransactionManager();

				Assets as = tm.assetID(asset_id);
				Transaction ts = tm.transactionID(transaction_id);

				Transaction_details t = new Transaction_details(transaction_detail_id, type, amount, sum, ts, as);
				tsd.add(t);
			}
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return tsd;
	}

	public List<Transaction_details> report_summary_by_search(String t, String ds, String de, String term, String year) {
		List<Transaction_details> tds = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		String sql = "";
		try {
			Statement stmt = con.createStatement();
			if (t.equals("1") && (ds.equals("") && (de.equals("")) && term.equals(""))) {
				sql = "select * from transaction_details;";
			} else if (t.equals("1") && (!ds.equals("") && (de.equals("")) && term.equals(""))) {
				sql = "select * from transaction_details where transaction_id in (select transaction_id from transaction where date(date_time) = '"
						+ ds + "');";
			} else if (t.equals("1") && (!ds.equals("") && (!de.equals("")) && term.equals(""))) {
				sql = "select * from transaction_details where transaction_id in (select transaction_id from transaction where date(date_time) between '"
						+ ds + "' and '" + de + "');";

			} else if (t.equals("1") && (ds.equals("") && (de.equals("")) && !term.equals(""))) {
				sql = "select * from transaction_details where transaction_id in (select transaction_id from transaction where year(date_time) = '"
						+ year + "' and term = " + term + ");";
			} else if (t.equals("1") && (!ds.equals("") && (de.equals("")) && !term.equals(""))) {
				sql = "select * from transaction_details where transaction_id in (select transaction_id from transaction where date(date_time) = '"
						+ ds + "' and year(date_time) = '" + year + "' and term = " + term + ");";
			} else if (t.equals("1") && (!ds.equals("") && (!de.equals("")) && !term.equals(""))) {
				sql = "select * from transaction_details where transaction_id in (select transaction_id from transaction where date(date_time) between '"
						+ ds + "' and '" + de + "' and year(date_time) = '" + year + "' and term = " + term + ");";

			} else if (!t.equals("1") && (ds.equals("") && (de.equals("")) && term.equals(""))) {
				sql = "select * from transaction_details where type = '" + t + "';";
			} else if (!t.equals("1") && (!ds.equals("") && (de.equals("")) && term.equals(""))) {
				sql = "select * from transaction_details where type='" + t
						+ "' and  transaction_id in (select transaction_id from transaction where date(date_time) = '" + ds + "');";
			} else if (!t.equals("1") && (!ds.equals("") && (!de.equals("")) && term.equals(""))) {
				sql = "select * from transaction_details where type='" + t
						+ "' and transaction_id in (select transaction_id from transaction where date(date_time) between '" + ds
						+ "' and '" + de + "');";

			} else if (!t.equals("1") && (ds.equals("") && (de.equals("")) && !term.equals(""))) {
				sql = "select * from transaction_details where type='" + t
						+ "' and transaction_id in (select transaction_id from transaction where year(date_time) = '" + year
						+ "' and term = " + term + ");";
			} else if (!t.equals("1") && (!ds.equals("") && (de.equals("")) && !term.equals(""))) {
				sql = "select * from transaction_details where type='" + t
						+ "' and  transaction_id in (select transaction_id from transaction where date(date_time) = '" + ds
						+ "' and year(date_time) = '" + year + "' and term = " + term + ");";
			} else if (!t.equals("1") && (!ds.equals("") && (!de.equals("")) && !term.equals(""))) {
				sql = "select * from transaction_details where type='" + t
						+ "' and transaction_id in (select transaction_id from transaction where date(date_time) between '" + ds
						+ "' and '" + de + "' and year(date_time) = '" + year + "' and term = " + term + ");";
			}

			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int transaction_detail_id = rs.getInt(1);
				int amount = rs.getInt(2);
				double sum = rs.getDouble(3);
				String type = rs.getString(4);
				int asset_id = rs.getInt(5);
				int transaction_id = rs.getInt(6);

				TransactionManager tm = new TransactionManager();
				Assets as = tm.assetID(asset_id);
				Transaction ts = tm.transactionID(transaction_id);

				Transaction_details td = new Transaction_details(transaction_detail_id, type, amount, sum, ts, as);
				tds.add(td);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return tds;
	}

	public List<Transaction_details> report_student_earn_by_search(int term, int year) {
		List<Transaction_details> tds = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		String sql = "";
		try {
			Statement stmt = con.createStatement();
			if (term == 0 || year == 0) {
				sql = "select * from transaction_details;";
			} else {
				sql = "select * from transaction_details "
						+ "where transaction_id "
						+ "in (select transaction_id from transaction "
						+ "where term = " + term + " and year(date_time) = '" + year + "');";
			}
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int transaction_detail_id = rs.getInt(1);
				int amount = rs.getInt(2);
				double sum = rs.getDouble(3);
				String type = rs.getString(4);
				int asset_id = rs.getInt(5);
				int transaction_id = rs.getInt(6);

				TransactionManager tm = new TransactionManager();

				Assets as = tm.assetID(asset_id);
				Transaction ts = tm.transactionID(transaction_id);

				Transaction_details t = new Transaction_details(transaction_detail_id, type, amount, sum, ts, as);
				tds.add(t);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return tds;
	}

	public List<String> options_term_year() {
		List<String> term_year = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Statement stmt = con.createStatement();
			String sql = "select term,year(date_time) "
					+ "from transaction "
					+ "group by term,year(date_time) order by year(date_time) desc;";

			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				int y = rs.getInt(1);
				int t = rs.getInt(2);
				term_year.add(y + "-" + t);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return term_year;
	}
}
