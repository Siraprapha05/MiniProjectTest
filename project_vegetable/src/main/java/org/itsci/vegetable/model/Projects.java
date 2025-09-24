package org.itsci.vegetable.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="projects")
public class Projects {
	
@Id
@Column (name="project_id",nullable=false,length=11)
private String project_id;

@Column (name="name",nullable=false,length=50)
private String name;

@Column (name="cost_amount",nullable=false)
private double cost_amount;

public Projects() {
	super();
	// TODO Auto-generated constructor stub
}

public Projects(String project_id, String name, double cost_amount) {
	super();
	this.project_id = project_id;
	this.name = name;
	this.cost_amount = cost_amount;
}

public String getProject_id() {
	return project_id;
}

public void setProject_id(String project_id) {
	this.project_id = project_id;
}

public String getName() {
	return name;
}

public void setName(String name) {
	this.name = name;
}

public double getCost_amount() {
	return cost_amount;
}

public void setCost_amount(double cost_amount) {
	this.cost_amount = cost_amount;
}


}
