<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ page import="java.util.*,org.itsci.vegetable.dao.*,org.itsci.vegetable.model.*,java.text.SimpleDateFormat" %>
	<%
	ProjectsManager pjm = new ProjectsManager();
	List<Projects> pj = pjm.getProjects();
	Register register = (Register) session.getAttribute("showReq");
	
	int resultApprove = 0;
	try{
		resultApprove= (int) request.getAttribute("resultApprove");
	}catch(Exception e){}
	
	int resultCancel = 0;
	try{
		resultCancel= (int) request.getAttribute("resultCancel");
	}catch(Exception e){}
 		
    %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"><link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Mitr&family=Roboto+Condensed:wght@300;400;700&display=swap" >
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>   
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-kQtW33rZJAHjgefvhyyzcGF3C5TFyBQBA13V1RKPf4uH+bwyzQxZ6CmMZHmNBEfJ" crossorigin="anonymous"></script>
    <title>รายละเอียดนักศึกษาที่ขอเข้าร่วมโครงการ</title>
    <link rel="stylesheet" href="css/approveReq.css">
</head>
<body>
<jsp:include page="basic/header.jsp" />    
<form class="fit" method="post" action="approveReq?id=<%= register.getRegister_id()  %>" >
    <div class="container" align="center">
        <h2 >รายละเอียดนักศึกษาที่ขอเข้าร่วมโครงการ</h2>
        <p>" โครงการปลูกผักเเลกค่าเทอม"</p> 

    <table>                
        <tr>
            <td>
                <div class="form-floating">
                    <input type="text" name="name" id="name" class="form-control registered" placeholder="ชื่อ-นามสกกุล" Onblur="from(fm1)" value="<%= register.getMember().getMember_name() %>" readonly>
                    <label for="floating">ชื่อ-นามสกุล</label>
                  </div>
            </td>
            <td>
                    <div class="form-floating">
                    <input type="text" name="major" id="major" class="form-control registered" value="<%= register.getMember().getStudent_major()  %>"  placeholder="สาขา" readonly>
                    <label for="floating">สาขา</label>
                </div>
            </td>
        </tr>
     
        <tr>
            <td colspan="2">
                <div class="form-floating" >
                <%for (int i = 0;i<pj.size();i++){ %>
	            <% if(pj.get(i).getProject_id().equals(register.getMember().getStudent_faculty())){ %>
	            	
	           
                    <input type="text" name="faculty" id="faculty" class="form-control registered" placeholder="สังกัดคณะ/โครงการ" value="<%=pj.get(i).getName() %>" readonly >
                    <label for="floating">สังกัดคณะ/โครงการ</label>
                <%}%>
	        	<%}%>
                  </div>
            </td>
            <td></td>
        </tr>
        <tr>
            <td  colspan="2">
                <div class="form-floating">  
                    <textarea name="reson" id="reson" class="form-control registered" placeholder="สังกัดคณะ/โครงการ" readonly ><%= register.getRegister_reson() %></textarea>
                    <label for="floating">เหตุผลขอเข้าร่วมโครงการ</label>
                  </div>
            </td>
        </tr>
        <tr align="center">
            <td>
                <button type="submit" class="btn btn-success" id="submit" name="submit">อนุมัติคำขอ</button>
            </td>
            <td>
            	<a href="cancelApproveReq?id=<%= register.getRegister_id()  %>" class=" btn btn-danger" >ไม่อนุมัติคำขอ</a>
            </td>
        </tr>
      
    </table>
</div>			
</form>
<jsp:include page="basic/footer.jsp" />
</body>
</html>