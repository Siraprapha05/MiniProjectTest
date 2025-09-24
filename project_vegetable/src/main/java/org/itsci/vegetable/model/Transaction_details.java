package org.itsci.vegetable.model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="transaction_details")

public class Transaction_details {
@Id
private int transaction_detail_id;

@Column (name="type",nullable=false,length=50)
private String type;

@Column (name="amount",nullable=false)
private int amount;

@Column (name="sum",nullable=false)
private double sum;

@ManyToOne(cascade = CascadeType.ALL)
@JoinColumn(name="transaction_id",nullable=false)
private Transaction transaction;

@ManyToOne(cascade = CascadeType.ALL)
@JoinColumn(name="asset_id",nullable=false)
private Assets assets;

 
public Transaction_details() {
	super();
	// TODO Auto-generated constructor stub
}

public Transaction_details(int transaction_detail_id, String type, int amount, double sum, org.itsci.vegetable.model.Transaction transaction,
		org.itsci.vegetable.model.Assets assets) {
	super();
	this.transaction_detail_id = transaction_detail_id;
	this.type = type;
	this.amount = amount;
	this.sum = sum;
	this.transaction = transaction;
	this.assets = assets;
}


public int getTransaction_detail_id() {
	return transaction_detail_id;
}


public void setTransaction_detail_id(int transaction_detail_id) {
	this.transaction_detail_id = transaction_detail_id;
}


public String getType() {
	return type;
}


public void setType(String type) {
	this.type = type;
}


public int getAmount() {
	return amount;
}


public void setAmount(int amount) {
	this.amount = amount;
}


public double getSum() {
	return sum;
}


public void setSum(double sum) {
	this.sum = sum;
}


public Transaction getTransaction() {
	return transaction;
}


public void setTransaction(Transaction transaction) {
	this.transaction = transaction;
}


public Assets getAssets() {
	return assets;
}


public void setAssets(Assets assets) {
	this.assets = assets;
}


}
