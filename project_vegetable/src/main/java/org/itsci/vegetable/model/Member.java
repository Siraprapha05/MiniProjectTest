package org.itsci.vegetable.model;

import java.util.Calendar;
import javax.persistence.*;

@Entity
@Table(name= "member")
public class Member {
	@Id
	@Column(name="member_id",nullable=false,length=11)
	private String member_id;
	
	@Column(name="member_prefix",nullable=false)
	private int member_prefix;
	
	@Column(name="member_name",nullable=false,length=80)
	private String member_name;
	
	@Column(name="member_phone",nullable=false,length=10)
	private String member_phone;
	
	@Column(name="member_birthday",nullable=false)
	private Calendar member_birthday;
	
	@Column(name="officer_position",nullable=true)
	private String officer_position;
	
	@Column(name="student_code",length=10)
	private String student_code;
	
	@Column(name="student_major",length=100)
	private String student_major;
	
	@Column(name="student_faculty",length=100)
	private String student_faculty;
	
	@Column(name="member_type",length=100)
	private String member_type;
	
	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Member(String member_id, int member_prefix, String member_name, String member_phone, Calendar member_birthday,
				  String officer_position, String student_code, String student_major, String student_faculty,
				  String member_type) {
		super();
		this.member_id = member_id;
		this.member_prefix = member_prefix;
		this.member_name = member_name;
		this.member_phone = member_phone;
		this.member_birthday = member_birthday;
		this.officer_position = officer_position;
		this.student_code = student_code;
		this.student_major = student_major;
		this.student_faculty = student_faculty;
		this.member_type = member_type;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public int getMember_prefix() {
		return member_prefix;
	}

	public void setMember_prefix(int member_prefix) {
		this.member_prefix = member_prefix;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_phone() {
		return member_phone;
	}

	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}

	public Calendar getMember_birthday() {
		return member_birthday;
	}

	public void setMember_birthday(Calendar member_birthday) {
		this.member_birthday = member_birthday;
	}

	public String getOfficer_position() {
		return officer_position;
	}

	public void setOfficer_position(String officer_position) {
		this.officer_position = officer_position;
	}

	public String getStudent_code() {
		return student_code;
	}

	public void setStudent_code(String student_code) {
		this.student_code = student_code;
	}

	public String getStudent_major() {
		return student_major;
	}

	public void setStudent_major(String student_major) {
		this.student_major = student_major;
	}

	public String getStudent_faculty() {
		return student_faculty;
	}

	public void setStudent_faculty(String student_faculty) {
		this.student_faculty = student_faculty;
	}

	public String getMember_type() {
		return member_type;
	}

	public void setMember_type(String member_type) {
		this.member_type = member_type;
	}
	

	
	
}
