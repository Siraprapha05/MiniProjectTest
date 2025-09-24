<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page import="org.itsci.vegetable.model.*,org.itsci.vegetable.dao.*,java.util.*,java.text.SimpleDateFormat"  %>
    <%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    sdf.setTimeZone(TimeZone.getTimeZone("UTC+7"));
    MemberManager mbm = new MemberManager();
    Logins log = null;
	Member mb = null;
	
	try{
		if(session.getAttribute("login")!=null){
		log = (Logins)session.getAttribute("login");
		mb = mbm.getMember(log.getMember().getMember_id());	
		
		session.setAttribute("login", log);	
		}
	}catch (Exception e) {	
	}
	
	
	
    
    /*
	Logins log = new Logins();
	Member mb = new Member();
	String member_type = null;
	try{
			log = (Logins)session.getAttribute("login");
			mb = mbm.getMember(log.getMember().getMember_id());		
	}catch (Exception e) {	
			session.setAttribute("login", log);
	}
	*/
	

    %>
<!DOCTYPE html>
<html>
<head>
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Mitr&family=Roboto+Condensed:wght@300;400;700&display=swap" >
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js"></script> 
   	<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- css.gg -->
<link href='https://css.gg/css' rel='stylesheet'>

<!-- UNPKG -->
<link href='https://unpkg.com/css.gg/icons/all.css' rel='stylesheet'>

<!-- JSDelivr -->
<link href='https://cdn.jsdelivr.net/npm/css.gg/icons/all.css' rel='stylesheet'>
   
    <!--  link rel="stylesheet" href="css/header.css">-->
    <link rel="stylesheet" href="css/content.css">
    <link rel="stylesheet" href="css/footer.css">
<meta charset="UTF-8">
<title>โครงการปลูกผักแลกค่าเทอม</title>
</head>
<body>
   <header class="header_page">
        <div class="logo_main">
            <img src="img/logo.png" class="logo_img">
        </div>
        <div class="web_name">
            <p class="wn1">โครงการปลูกผักแลกค่าเทอม</p>
            <p class="wn2">Maejo University</p>
        </div>
        
         <% if(log != null){ %>
         <%if(log.getStatus()==1){ %>
	        <!-- nav member -->
	        <nav class="nav_bar">
	            <ul>
	                <li><a href="goHomepage">หน้าแรก</a></li>
	                <li><a href="goAddshift">บันทึกเวลาทำงาน</a></li>
	                <li><a href="goReportSummary">ผลประกอบการ</a></li>
	                <li><a href="goReportStudentEarn">สถิติการทำงาน</a></li>
	                
	                <li class="dropdown">
	                	<i class="gg-user"></i>
	                	  <%=mb.getMember_name() %>		 
	                	<ul class="dropdown-content">
		                	<li><a href="goViewprofile" style="color:black;">ข้อมูลส่วนตัว</a></li>	                    		                    
			                <li><a href="dologout" style="color:red;">ออกจากระบบ<i class="gg-log-out"></i></a></li>
			            </ul>
			        </li>
	            </ul>
	        </nav>
	        		<%}else if(log.getStatus()==2){ %>
	        <!-- nav shief -->
	         <nav class="nav_bar">
	            <ul>
	                <li><a href="goHomepage">หน้าแรก</a></li>
	               
                    <li class="dropdown">
		                <a href="goListall">รายรับรายจ่ายของโครงการ</a>
		                <ul class="dropdown-content">
			                <li><a href="goaddIncome" style="color:black;">บันทึกรายรับ</a></li>
			                <li><a href="goaddExpense" style="color:black;">บันทึกรายจ่าย</a></li>
			            </ul>
			        </li>
		            <li><a href="goAddshift">บันทึกเวลาการทำงาน</a></li>
		            <li><a href="golistShift">รายชื่อสมาชิกโครงการ</a></li>
		            <li><a href="goReportSummary">ผลประกอบการ</a></li>
		            <li><a href="goReportStudentEarn">สถิติการทำงาน</a></li>
		            <li class="dropdown">
	                	<i class="gg-user"></i>
	                	  <%=mb.getMember_name() %>		 
	                	<ul class="dropdown-content">
		                	<li><a href="goViewprofile" style="color:black;">ข้อมูลส่วนตัว</a></li>	                    		                    
			                <li><a href="dologout" style="color:red;">ออกจากระบบ<i class="gg-log-out"></i></a></li>
			            </ul>
			        </li>
	            </ul>
	        </nav>
	        		<%}else if(log.getStatus()==3){ %>
	          <!-- nav officer -->
	         <nav class="nav_bar">
	            <ul>
	                <li><a href="goHomepage">หน้าแรก</a></li>
	                <li><a href="golistRegisterReq">คำขอเข้าร่วมโครงการ</a></li>
	                <li class="dropdown">
	                	<a>ข้อมูลโครงการ</a>
	                	<ul class="dropdown-content">
	                		<li><a href="golistMember" style="color:black;">รายชื่อนักศึกษาโครงการ</a></li>
			                <li><a href="goReportStudentEarn" style="color:black;">รายได้ของนักศึกษา</a></li>
			                <li><a href="goReportSummary" style="color:black;">รายงานผลประการ</a></li>
			            </ul>
			        </li>
			         <li class="dropdown">
	                	<i class="gg-user"></i>
	                	  <%=mb.getMember_name() %>		 
	                	<ul class="dropdown-content">                  		                    
			                <li><a href="dologout" style="color:red;">ออกจากระบบ<i class="gg-log-out"></i></a></li>
			            </ul>
			        </li>
	            </ul>
	        </nav>
	       	<%}%>
	      	<%}else{%>
	        <!-- not login nav user -->
	      
		        <nav class="nav_bar" >
		            <ul>
		                <li><a href="goHomepage">หน้าแรก</a></li>
		                <li><a href="goRegister">ลงทะเบียน</a></li>    
		                <li><a href="goLogin">เข้าสู่ระบบ</a></li>
		            </ul>
		        </nav>  
		    <%}%>
		        
    </header>	 	
</body>
<style>

@charset "UTF-8";
*{
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Mitr', sans-serif;
}
.content{
  padding:0 20px 0 20px;
}
/* --------------------- Header --------------------------*/

.header_page {
    position: fixed;
    top: 0;
    left: 0;
  margin: 0;
  padding: 5px;
  width: 100%;
  max-height: 100px;
  background-color: #00ae3b;
  display: flex;
 
}

.logo_main {
  margin: 5px;
  width: -webkit-fit-content;
  width: -moz-fit-content;
  width: fit-content;
  float: left;
}

.logo_img {
  height: 80px;
}

.web_name {
  margin-top: 10px;
  
}

.web_name p {
  margin: 0;
}

p.wn1 {
  color: #fff; 
  font-size: 24px;
}

p.wn2 {
  color: #fff; 
  font-size: 20px;
}

.nav_bar{
    margin: auto;
    margin-top: 30px;
    margin-right: 70px;
}
.gg-user{
	margin:5px;
	margin-top:-1px;
}
.gg-log-out{
	margin-top:-20px;
	margin-left:100px;
}
.nav_bar ul li{
    text-decoration: none;
    display: flex;
    margin-right: 10px;
    float: left;
}

.nav_bar a{
    float: right;

}
a{
    text-decoration: none;
}
a:hover{
  text-decoration: none;
  color: white;
}

.dropbtn {
  background-color: #b3edb9;
  color: white;
  margin-top: 13px;
  padding: 16px;
  font-size: 16px;
  border: none;
  cursor: pointer;
}

.dropdown {
  position: relative;
  display: inline-block;
  color: white;
  
}

ul .dropdown-content {
  display: none;
  position: absolute; 
  background-color: #b3edb9;
  min-width: 160px;
  border-radius: 4px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
  margin-top: 25px;
}

.dropdown-content a {
  color: rgb(255, 255, 255);
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

ul .dropdown-content a:hover {
    background-color: #b3edb9; 
}

.dropdown:hover .dropdown-content {
  	display: block;
    border-radius: 4px;
}

.dropdown:hover .dropbtn {
  background-color: #00ae3b;

}
</style>
</html>