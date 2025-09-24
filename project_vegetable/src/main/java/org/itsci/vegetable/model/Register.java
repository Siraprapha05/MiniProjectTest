package org.itsci.vegetable.model;

import java.util.Calendar;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="register")
public class Register {

@Id
@Column (name="register_id",nullable=false,length=11)
private String register_id;

@Column (name="register_reson",nullable=false,length=255)
private String register_reson;

@Column (name="register_date",nullable=false)
private Calendar register_date;

@Column (name="register_term",nullable=false,length=60)
private String register_term;

@Column (name="register_status",nullable=false)
private int register_status;

@ManyToOne(cascade = CascadeType.ALL)
@JoinColumn(name="member_id",nullable=false)
private Member member;

@ManyToOne(cascade = CascadeType.ALL)
@JoinColumn(name="project_id",nullable=false)
private Projects projects;

public Register() {
	super();
	// TODO Auto-generated constructor stub
}

public Register(String register_id, String register_reson, Calendar register_date, String register_term,
                int register_status, org.itsci.vegetable.model.Member member, org.itsci.vegetable.model.Projects projects) {
	super();
	this.register_id = register_id;
	this.register_reson = register_reson;
	this.register_date = register_date;
	this.register_term = register_term;
	this.register_status = register_status;
	this.member = member;
	this.projects = projects;
}

public String getRegister_id() {
	return register_id;
}

public void setRegister_id(String register_id) {
	this.register_id = register_id;
}

public String getRegister_reson() {
	return register_reson;
}

public void setRegister_reson(String register_reson) {
	this.register_reson = register_reson;
}

public Calendar getRegister_date() {
	return register_date;
}

public void setRegister_date(Calendar register_date) {
	this.register_date = register_date;
}

public String getRegister_term() {
	return register_term;
}

public void setRegister_term(String register_term) {
	this.register_term = register_term;
}

public int getRegister_status() {
	return register_status;
}

public void setRegister_status(int register_status) {
	this.register_status = register_status;
}

public Member getMember() {
	return member;
}

public void setMember(Member member) {
	this.member = member;
}

public Projects getProjects() {
	return projects;
}

public void setProjects(Projects projects) {
	this.projects = projects;
}


}
