package org.itsci.vegetable.model;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="member_shifts")
public class Member_shifts {
	
@Id
@Column (name="member_shift_id",nullable=false,length=11)
private String member_shift_id;

@Column (name="task_name",nullable=false,length=50)
private String task_name;

@Column (name="date",nullable=false)
@Temporal(TemporalType.DATE)
private Date date;

@Column (name="startTime",nullable=false)
@Temporal(TemporalType.TIME)
private Date startTime;

@Column (name="endTime",nullable=false)
@Temporal(TemporalType.TIME)
private Date endTime;

@Column (name="status",nullable=false)
private int status;

@ManyToOne(cascade = CascadeType.ALL)
@JoinColumn(name="register_id",nullable=false)
private Register register;

public Member_shifts() {
	super();
	// TODO Auto-generated constructor stub
}

public Member_shifts(String member_shift_id, String task_name, Date date, Date startTime, Date endTime,
		int status, org.itsci.vegetable.model.Register register) {
	super();
	this.member_shift_id = member_shift_id;
	this.task_name = task_name;
	this.date = date;
	this.startTime = startTime;
	this.endTime = endTime;
	this.status = status;
	this.register = register;
}
public Member_shifts(String member_shift_id, String task_name, Date endTime,int status) {
	super();
	this.member_shift_id = member_shift_id;
	this.task_name = task_name;
	this.endTime = endTime;
	this.status = status;

}
public String getMember_shift_id() {
	return member_shift_id;
}

public void setMember_shift_id(String member_shift_id) {
	this.member_shift_id = member_shift_id;
}

public String getTask_name() {
	return task_name;
}

public void setTask_name(String task_name) {
	this.task_name = task_name;
}

public Date getDate() {
	return date;
}

public void setDate(Date date) {
	this.date = date;
}

public Date getStartTime() {
	return startTime;
}

public void setStartTime(Date startTime) {
	this.startTime = startTime;
}

public Date getEndTime() {
	return endTime;
}

public void setEndTime(Date endTime) {
	this.endTime = endTime;
}

public int getStatus() {
	return status;
}

public void setStatus(int status) {
	this.status = status;
}

public Register getRegister() {
	return register;
}

public void setRegister(Register register) {
	this.register = register;
}



}
