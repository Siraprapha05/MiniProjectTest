<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page import="java.util.*,org.itsci.vegetable.dao.*,org.itsci.vegetable.model.*,java.text.*" %>
    <% 
	    MemberManager mbm = new MemberManager();
		Logins log = new Logins();
		Member mb = new Member();	
		try{
				log = (Logins)session.getAttribute("login");
				mb = mbm.getMember(log.getMember().getMember_id());		
		}catch (Exception e) {	
			
		} 
	
		Transaction_details td = (Transaction_details)session.getAttribute("tran_de_id");
		SimpleDateFormat tf = new SimpleDateFormat("HH:mm");
		DecimalFormat df = new DecimalFormat("###,###,###.00");
		%>
		 <%
	    TransactionManager tm = new TransactionManager(); 
	    List<Assets> as = tm.getAssets();
	    List<Transaction> ts; 
	    ts = tm.list_transaction();
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
    <title>แก้ไขรายการ</title>
   	<script type="text/javascript">
		function autoPrice(){
			var product_name = document.getElementById("equipment_name").value;
			var asset_price = document.getElementById("asset_price").innerHTML;
			console.log(product_name);
			 <% for(int i=0;i<as.size();i++){%>
				if( product_name == <%= as.get(i).getAsset_id() %>)	{	
					document.getElementById("equipment_unit").value = "<%= as.get(i).getEquipment_unit() %>";
				}else{
					asset_price = 0 ;
				}		 
			 <%}%>
		}
		
		function calTotalprice(){
			var amount = document.getElementById("amount").value;
			var asset_price = document.getElementById("asset_price").innerHTML;
			console.log(equipment_name);
			document.getElementById("sum").value = amount*document.getElementById("asset_price").value;	
			
		}

	</script>
</head>
<body>
<jsp:include page="basic/header.jsp" /> 
    <div align="center" class="container">
    <form class="fit" method="post" action="edit_expense">  
   	<input type="hidden" value="<%= td.getTransaction().getTransaction_id() %>"name="tid" >  
   	<input type="hidden" value="<%= td.getTransaction_detail_id() %>"name="tdid">     
   	<input type="hidden" value="<%= td.getType() %>"name="type">     
   	
        <table>  
            <tr>
                <td colspan="2">
                    <p class="p3" align="center">แก้ไขรายละเอียดข้อมูล</p>
                </td>
            </tr>              
            <tr>
                <td>
                    <div class="form-floating">  
                            <input type="text" name="equipment_name" id="equipment_name" class="form-control registered" value="<%= td.getAssets().getEquipment_name() %>"  placeholder="ชื่ออุปกรณ์" style="width: 215px;" readonly>
                            <label for="floating">ชื่ออุปกรณ์</label>             
                      </div>
                </td>
                <td>
                     <div class="form-floating">
                        <input type="text" name="asset_price" id="asset_price" class="form-control registered" value="<%= td.getSum()/td.getAmount() %>"  placeholder="ราคา" style="width: 215px;"  onkeyup="calTotalprice()">
                        <label for="floating">ราคา</label>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-floating" >
                        <input type="text" name="amount" id="amount" class="form-control registered" placeholder="จำนวน" value="<%= td.getAmount() %>" onkeyup="calTotalprice()" >
                        <label for="floating">จำนวน</label>
                    </div>
                </td>
                <td>
                    <div class="form-floating" >
                        <input type="text" name="sum" id="sum" class="form-control registered" placeholder="รวม" value="<%= td.getSum() %>" readonly>
                        <label for="floating">รวม</label>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-floating">
                        <input type="text" name="sum" id="sum" class="form-control registered" placeholder="หน่วย" value="<%= td.getAssets().getEquipment_unit() %>" readonly >
                        <label for="floating">หน่วย</label>            
                      </div>
                </td>
                <td>
                    <div class="form-floating" >
                        <input type="text" name="name" id="name" class="form-control registered" placeholder="ผู้บันทึก" value="<%= td.getTransaction().getMember().getMember_name() %>" readonly >
                        <label for="floating">ผู้บันทึก</label>
                    </div>
                </td>
            </tr>
            <tr align="center"> 
                <td>
                    <button type="submit" class="btn btn-success"  name="submit">บันทึกข้อมูล</button>
                </td> 
                <td>
                    <button type="reset" name="reset" class="btn btn-danger" >ยกเลิก</button>
                </td>
            </tr> 
        </table>   
        </form>
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
	margin-top: 100px;
}
.form-control{
    width:215px;
    margin: 5px;
}

.btn{
    width: 150px;
}
.fit {
    background-color: #f5f4f4;
    border-radius: 2px;
    margin-left: 369px;
    margin-right: 367px;
    margin-top: 150px;
    margin-bottom: 150px;
    padding: 54px;
    padding-top: 49px;
    display: flex;
    justify-items: center;
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

.p3{
    font-size: 30px;
}
</style>
</html>