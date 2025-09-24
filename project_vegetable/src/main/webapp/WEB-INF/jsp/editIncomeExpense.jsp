<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page import="java.util.*,org.itsci.vegetable.dao.*,org.itsci.vegetable.model.*,java.text.*" %>
	  <%

		SimpleDateFormat tf = new SimpleDateFormat("HH:mm");
		List<Transaction_details> list_edit  = (List<Transaction_details>) session.getAttribute("list_edit");
		DecimalFormat df = new DecimalFormat("###,###,###.00");
		
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
		%>
		

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>   
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Mitr&family=Roboto+Condensed:wght@300;400;700&display=swap" >
	<!-- css.gg -->
	<link href='https://css.gg/css' rel='stylesheet'>
	<!-- UNPKG -->
	<link href='https://unpkg.com/css.gg/icons/all.css' rel='stylesheet'>
	<!-- JSDelivr -->
	<link href='https://cdn.jsdelivr.net/npm/css.gg/icons/all.css' rel='stylesheet'>

    <title>แก้ไขรายรับรายจ่าย</title>
</head>
<body>
<jsp:include page="basic/header.jsp" /> 
    <div class="container" align="center">
        <h2>แก้ไขรายรับรายจ่าย</h2>
        <h3 style="color:#FFDD00;" class="mg-bt">" โครงการปลูกผักเเลกค่าเทอม "</h3>            
        <table class="table table-bordered" >
          <thead  align="center">
            <tr>
              <th>ลำดับ</th>
              <th>เวลาข้อมูล</th>
              <th>ชื่อสินค้า</th>
              <th>จำนวน</th>
              <th>ราคา</th>
              <th>รวม</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
          <%int num = 1;  for(Transaction_details td:list_edit)  {%>
            <tr>
              <td><%= num  %></td>
              <td><%= tf.format(td.getTransaction().getDate_time().getTime()) %></td>
              
               <% if(td.getType().equals("สินค้า")){%>
	              <td><%= td.getAssets().getProduct_name() %></td>
	              <td><%= td.getAmount() %><%= td.getAssets().getProduct_unit() %></td>
	               <td><%=td.getAssets().getAsset_price()%></td>
               <%}else if (td.getType().equals("อุปกรณ์")){%>
                  <td><%= td.getAssets().getEquipment_name() %></td>
	              <td><%= td.getAmount() %><%= td.getAssets().getEquipment_unit() %></td>
	               <td><%= td.getSum()/td.getAmount() %></td>
               <% } %>
              
              
             
              <td><%= df.format(td.getSum()) %></td>
              <td align="center">
              	<a href="edit_income_expense?tid=<%= td.getTransaction().getTransaction_id()%>&&asid=<%= td.getAssets().getAsset_id() %>&&tdid=<%= td.getTransaction_detail_id() %>">
				<button type="button" class="button-edit" role="button" >แก้ไข</button></a>
				<button type="button" class="button-remove" role="button"  data-toggle="modal" data-target="#exampleModal"  >ลบ&nbsp; &nbsp;	<i class="gg-trash"></i>
				</button>
				
								<!-- Modal -->
				<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLabel">แจ้งเตือน</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
				        <h5 class="text-danger">ต้องการลบใช่หรือไม่ ?</h5> 
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">ไม่ใช่</button>
				        <a href="delete_Colume_income_expense?tid=<%= td.getTransaction().getTransaction_id()%>&&date=<%= sdf2.format(td.getTransaction().getDate_time().getTime()) %>&&type=<%= td.getType() %>">
				        	<button name="btnAdd"  class="btn btn-primary">ใช่</button>
				        </a>
				      </div>
				    </div>
				  </div>
				</div>	
				</td>
            </tr>
            <%num++;} %>   
          </tbody>
        </table>
        <a href="goListall"><button type="button" class="button-back" role="button" >ย้อนกลับ 
				&nbsp; <i class="gg-push-left"></i></button></a>
    </div>
<jsp:include page="basic/footer.jsp" />
</body>
<style>
	body{
    font-family: 'Mitr', sans-serif;
    
}
*{
   margin: 0;
   padding: 0;
   box-sizing: border-box;
   font-family: 'Mitr', sans-serif;
}
.container{
	margin-top:180px;
	margin-bottom:150px;
}
.form-control{
    width:215px;
    margin: 5px;
}

.btn{
    width: 150px;
}
.table-bordered{
    width: 800px;
   
}
thead{
   background-color:#EEEEEE;
}
.custom-select{
    width: 215px;
    height: 58px;
    margin: 5px;
}
.p3{
    font-size: 20px;
}
.fit{
    margin-top: 50px;
}

.button-back {
  align-items: center;
  appearance: none;
  background-color:#388E3C;
  border-radius: 10px;
  border-style: none;
  box-shadow: rgba(0, 0, 0, .2) 0 3px 5px -1px,rgba(0, 0, 0, .14) 0 6px 10px 0,rgba(0, 0, 0, .12) 0 1px 18px 0;
  box-sizing: border-box;
  color: #fff;
  cursor: pointer;
  display: inline-flex;
  fill: currentcolor;
  font-size: 20px;
  font-weight: 500;
  height: 34px;
  justify-content: center;
  letter-spacing: .25px;
  line-height: normal;
  max-width: 100%;
  overflow: visible;
  padding: 2px 24px;
  position: relative;
  text-align: center;
  text-transform: none;
  transition: box-shadow 280ms cubic-bezier(.4, 0, .2, 1),opacity 15ms linear 30ms,transform 270ms cubic-bezier(0, 0, .2, 1) 0ms;
  user-select: none;
  -webkit-user-select: none;
  touch-action: manipulation;
  width: auto;
  will-change: transform,opacity;
  z-index: 0;
  margin-buttom:100px;
  margin-top:80px;
}

.button-back:hover {
  background: #F6F9FE;
  color: #174ea6;
}

.button-back:active {
  box-shadow: 0 4px 4px 0 rgb(60 64 67 / 30%), 0 8px 12px 6px rgb(60 64 67 / 15%);
  outline: none;
}

.button-back:focus {
  outline: none;
  border: 2px solid #4285f4;
}

.button-back:not(:disabled) {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}

.button-back:not(:disabled):hover {
  box-shadow: rgba(60, 64, 67, .3) 0 2px 3px 0, rgba(60, 64, 67, .15) 0 6px 10px 4px;
}

.button-back:not(:disabled):focus {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}

.button-back:not(:disabled):active {
  box-shadow: rgba(60, 64, 67, .3) 0 4px 4px 0, rgba(60, 64, 67, .15) 0 8px 12px 6px;
}

.button-back:disabled {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}

/*button-edit*/
.button-edit {
  align-items: center;
  appearance: none;
  background-color:#FFCA28;
  border-radius: 24px;
  border-style: none;
  box-shadow: rgba(0, 0, 0, .2) 0 3px 5px -1px,rgba(0, 0, 0, .14) 0 6px 10px 0,rgba(0, 0, 0, .12) 0 1px 18px 0;
  box-sizing: border-box;
  color: #fff;
  cursor: pointer;
  display: inline-flex;
  fill: currentcolor;
  font-size: 14px;
  font-weight: 500;
  height: 34px;
  justify-content: center;
  letter-spacing: .25px;
  line-height: normal;
  max-width: 100%;
  overflow: visible;
  padding: 2px 24px;
  position: relative;
  text-align: center;
  text-transform: none;
  transition: box-shadow 280ms cubic-bezier(.4, 0, .2, 1),opacity 15ms linear 30ms,transform 270ms cubic-bezier(0, 0, .2, 1) 0ms;
  user-select: none;
  -webkit-user-select: none;
  touch-action: manipulation;
  width: auto;
  will-change: transform,opacity;
  z-index: 0;
}

.button-edit:hover {
  background: #F6F9FE;
  color: #174ea6;
}

.button-edit:active {
  box-shadow: 0 4px 4px 0 rgb(60 64 67 / 30%), 0 8px 12px 6px rgb(60 64 67 / 15%);
  outline: none;
}

.button-edit:focus {
  outline: none;
  border: 2px solid #4285f4;
}

.button-edit:not(:disabled) {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}

.button-edit:not(:disabled):hover {
  box-shadow: rgba(60, 64, 67, .3) 0 2px 3px 0, rgba(60, 64, 67, .15) 0 6px 10px 4px;
}

.button-edit:not(:disabled):focus {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}

.button-edit:not(:disabled):active {
  box-shadow: rgba(60, 64, 67, .3) 0 4px 4px 0, rgba(60, 64, 67, .15) 0 8px 12px 6px;
}

.button-edit:disabled {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}
/**/
.button-remove {
  align-items: center;
  appearance: none;
  background-color: #dc3545;
  border-radius: 24px;
  border-style: none;
  box-shadow: rgba(0, 0, 0, .2) 0 3px 5px -1px,rgba(0, 0, 0, .14) 0 6px 10px 0,rgba(0, 0, 0, .12) 0 1px 18px 0;
  box-sizing: border-box;
  color: #fff;
  cursor: pointer;
  display: inline-flex;
  fill: currentcolor;
  font-size: 14px;
  font-weight: 500;
  height: 34px;
  justify-content: center;
  letter-spacing: .25px;
  line-height: normal;
  max-width: 100%;
  overflow: visible;
  padding: 2px 24px;
  position: relative;
  text-align: center;
  text-transform: none;
  transition: box-shadow 280ms cubic-bezier(.4, 0, .2, 1),opacity 15ms linear 30ms,transform 270ms cubic-bezier(0, 0, .2, 1) 0ms;
  user-select: none;
  -webkit-user-select: none;
  touch-action: manipulation;
  width: auto;
  will-change: transform,opacity;
  z-index: 0;
}

.button-edit:hover {
  background: #F6F9FE;
  color: #174ea6;
}

.button-edit:active {
  box-shadow: 0 4px 4px 0 rgb(60 64 67 / 30%), 0 8px 12px 6px rgb(60 64 67 / 15%);
  outline: none;
}

.button-edit:focus {
  outline: none;
  border: 2px solid #4285f4;
}

.button-edit:not(:disabled) {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}

.button-edit:not(:disabled):hover {
  box-shadow: rgba(60, 64, 67, .3) 0 2px 3px 0, rgba(60, 64, 67, .15) 0 6px 10px 4px;
}

.button-edit:not(:disabled):focus {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}

.button-edit:not(:disabled):active {
  box-shadow: rgba(60, 64, 67, .3) 0 4px 4px 0, rgba(60, 64, 67, .15) 0 8px 12px 6px;
}

.button-edit:disabled {
  box-shadow: rgba(60, 64, 67, .3) 0 1px 3px 0, rgba(60, 64, 67, .15) 0 4px 8px 3px;
}
</style>
</html>