<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page import="org.itsci.vegetable.model.*,org.itsci.vegetable.dao.*,java.util.*"  %>
    <%
	Logins log = null;//new Logins();
    String err_login = null;
    
	try{
			log = (Logins)session.getAttribute("login");
			err_login = (String) request.getAttribute("result");			
	}catch (Exception e) {	
		
	}

	
	String resultAddshift = null;
	try{
		resultAddshift = (String) request.getAttribute("resultAddshift");
	}catch(Exception e){
	
	}
    %>
    
<!DOCTYPE html>
<html>
<head>
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>   
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Mitr&family=Roboto+Condensed:wght@300;400;700&display=swap" >
    
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">
	<meta charset="UTF-8">
	<script>
		 
		 <%if( resultAddshift != null) {%>
		 $(document).ready(function(){
			  alert('บันทึกการทำงานสำเร็จ รอการอนุมัติ');
		
  		});  
	 <%}%>
		 
		 
	</script>
<title>โครงการปลูกผักเเลกค่าเทอม</title>			
</head>

<body>
<jsp:include page="basic/header.jsp" />
  <div class="slide">
        <img src="img/img2.jpg" >
    </div>
        <div>
            <p align="center" class="p1">
                “ปลูกผักแลกค่าเทอม”<br>
                เป็นโครงการยุทธศาสตร์หนึ่งของมหาวิทยาลัยแม่โจ้<br> ในการผลิตบัณฑิตนักปฏิบัติ ในการนำความรู้<br> ภาคทฤษฎีมาทำการผลิต
                พืช ผัก ผลไม้ ไข่ เนื้อสัตว์ ปลา <br>โดยมีอาจารย์ที่ปรึกษา/นักวิชาการทำหน้าที่พี่เลี้ยง <br>นำเทคนิค องค์ความรู้ มาสอนแนะแก่นักศึกษา</p>
        </div> 
           <div class="paragraph">
            <div class="p2">
                <div class="pr1"><p class="pobj" style="font-size: 30px;"><b>วัตถุประสงค์</b><img src="img/idea.png" class="img4"></p></div>
                <div class="pr2">
                    <p>- เพื่อให้นักศึกษาได้เรียนรู้เทคนิคทางการเกษตรจาก<br>การปฏิบัติงานจริงนอกห้องเรียน รวมทั้งมีรายได้</p>
                    <p>- เพื่อช่วยแบ่งเบาภาระของผู้ปกครองในการลงทะเบียนเรียน<br>ขณะที่ทางคณะและสำนักได้บูรณาการการเรียนการสอน</p>
                    <p>- เพื่อการสร้างบัณฑิตที่มีทักษะ ความรู้ ความสามารถ<br> ทั้งยังเป็นผู้ประกอบการเพื่อสังคม</p>
                </div>
            </div>
            <div class="set-img3">
                <img src="img/img3.jpg" class="img3">
            </div>
        </div> 
        <div align="center" class="content1">
            <div  class="pr3">
                <h2 class="pro">ผลิตภัณฑ์โครงการ <img src="img/vegetable.png" class="img5"></h2>
            </div>
            <div class="ppd1">
                <img src="img/product1.jpg" class="pd1">  
           
                <img src="img/product2.jpg" class="pd2">  
                <br>
                <img src="img/product3.jpg" class="pd3">  
            
                <img src="img/product4.jpg" class="pd4">  
            </div>
            <div class="proall"><h2>สินค้าอื่น ๆ อีกมากมาย</h2></div>
        </div> 
<jsp:include page="basic/footer.jsp" />
</body>
<style>
@charset "UTF-8";
/*-------------------------------slide------------------------------------*/
.slide{
  margin: auto;
  overflow: hidden;
  margin-top: 80px;
  height: 550px;
  width: 100%;
  padding: auto;
}

.slide img{
  width: 100%;
}
/*-----------------------------------p1------------------------------------*/
.p1{
  letter-spacing: 5px;
  font-size: 20px;
  margin-top: 30px;
}
.paragraph{
  background-color: #DCEDC8;
  width: 100%;
  height: 370px;
  margin-top: 39px;
  display: flex;
  justify-content: center;
  overflow: hidden;
}
.p2{
  font-size: 20px;
  float: left;
  margin: 40px;

}
.set-img3{
  float: left;
}
.img3{
  height: 280px;
  width: 450px;
  margin: 40px;
  margin-left: 60px;
 
}
.img4{
  height: 45px;
  width: 45px;
  margin-left: 5px;
}
.pr1{
  background-color: white;
  height: 60px;
  border-radius: 25px;
}
.pobj{
  margin-left: 145px;
  padding: 6px;
}
.pr2{
  margin-top: 30px;
}
.pd1{
  width: 400px;
  height: 400px;
  margin: 40px;
  border-radius: 10px;
}
.pd2{
  width: 400px;
  height: 400px;
  margin: 40px;
  border-radius: 10px;
  
}
.pd3{
  width: 400px;
  height: 400px;
  margin: 40px;
  border-radius: 10px;
}
.pd4{
  width: 400px;
  height: 400px;
  margin: 40px;
  border-radius: 10px;
}
.content1{
  margin-top: 50px;
}
.img5{
  width: 60px;
  height: 60px;
  margin: 7px;
}
.pr3{
  background-color: rgb(255, 237, 98);
  height: 78px;
  border-radius: 25px;
  width: 500px;
 
}
.pro{
  margin-top: 10px;
}
.proall{
	margin-bottom:50px;
}
</style>
</html>