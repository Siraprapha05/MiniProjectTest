package org.itsci.vegetable.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import org.itsci.vegetable.model.Projects;

public class ProjectsManager {
	public List<Projects> getProjects() {
		List<Projects> pj = new Vector<>();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();
		try {
			Statement stmt = con.createStatement();
			String sql = "select project_id,cost_amount,name from projects";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				String project_id = rs.getString(1);
				double cost_amount = Double.parseDouble(rs.getString(2));
				String name = rs.getString(3);
			
					 Projects p = new Projects(project_id,name,cost_amount);
					 pj.add(p);
				 }
			con.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return pj;
	}
	

	public Projects getprojectName(String pid) {
	Projects p = new Projects();
		ConnectionDB condb = new ConnectionDB();
		Connection con = condb.getConnection();  
		try {
			Statement stmt = con.createStatement();
			String sql = "select name from projects where project_id = '"+pid+"';";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				String name = rs.getString(1);
				p.setName(name);
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return p;
	}
	
}
