package org.itsci.vegetable.model;



import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table (name="logins")
public class Logins {
	@Id
	@Column(name="email",nullable=false,length=50)
	private String email;
	
	@Column(name="password",nullable=false,length=20)
	private String password;
	
	@Column(name="status",nullable=false)
	private int status;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name="member_id",nullable=false)
	private Member member;
	
	public Logins() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Logins(String email, String password, int status, org.itsci.vegetable.model.Member member) {
		super();
		this.email = email;
		this.password = password;
		this.status = status;
		this.member = member;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	

}