<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ page import="java.util.*,org.itsci.vegetable.dao.*,org.itsci.vegetable.model.*,java.text.SimpleDateFormat" %>
    <% ProjectsManager pjm = new ProjectsManager();
	List<Projects> pj = pjm.getProjects();
	Member member = (Member) session.getAttribute("showmember");
	
	RegisterManager rg = new RegisterManager();
	List<Member> m = rg.getMember();
	
	Boolean haveBoss= false;
	for(Member mm : m){
		if(mm.getMember_type().equals("หัวหน้าโครงการ")){
			haveBoss =true;
			break;
		}
	}
	
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Mitr&family=Roboto+Condensed:wght@300;400;700&display=swap" >
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>   
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-kQtW33rZJAHjgefvhyyzcGF3C5TFyBQBA13V1RKPf4uH+bwyzQxZ6CmMZHmNBEfJ" crossorigin="anonymous"></script>
    <title>รายละเอียดนักศึกษาโครงการ</title>
    <link rel="stylesheet" href="css/setPermissions.css">
</head>
<body>
<jsp:include page="basic/header.jsp" />
	<form class="fit" method="post" action="updateSetPermissions" >
	     <div class="container" align="center">
        <h2 >รายละเอียดนักศึกษาที่ขอเข้าร่วมโครงการ</h2>
        <p>" โครงการปลูกผักเเลกค่าเทอม"</p> 
        
	    <table>                
	        <tr>
	            <td>
	                <div class="form-floating">
	                <input type="hidden" name="member_id" id="member_id" value="<%= member.getMember_id() %>">
	                    <input type="text" name="name" id="name" class="form-control registered" placeholder="ชื่อ-นามสกกุล"  value="<%= member.getMember_name() %>" readonly>
	                    <label for="floating">ชื่อ-นามสกุล</label>
	                  </div>
	            </td>
	            <td>
	                    <div class="form-floating">
	                    <input type="text" name="major" id="major" class="form-control registered" value="<%= member.getStudent_major() %>"  placeholder="สาขา" readonly>
	                    <label for="floating">สาขา</label>
	                </div>
	            </td>
	        </tr>
	     
	        <tr>
	            <td colspan="2">
	                <div class="form-floating" >
	                  <%for (int i = 0;i<pj.size();i++){ %>
	            	  <% if(pj.get(i).getProject_id().equals(member.getStudent_faculty())){ %>
	                    <input type="text" name="faculty" id="faculty" class="form-control registered" placeholder="สังกัดคณะ/โครงการ" value="<%=pj.get(i).getName() %>" readonly >
	                    <label for="floating">สังกัดคณะ/โครงการ</label>
		              <%}%>
		        	  <%}%>
	                  </div>
	            </td>
	            <td></td>
	        </tr>
	        <tr>
	            <td >
	                <div class="form-floating">  
	                    <input type="text" name="phone" id="phone" class="form-control registered" placeholder="เบอร์โทรศัพท์" value="<%= member.getMember_phone() %>" readonly >
	                    <label for="floating">เบอร์โทรศัพท์</label>
	                  </div>
	            </td>
	            <td>
	            <% if(member.getMember_type().equals("หัวหน้าโครงการ") || haveBoss==false ){ %>
	                <select name="setpermission" id="setpermission" class="custom-select" style="height:58px;">
	                    <option value="1" <% if(member.getMember_type().equals("สมาชิก") ){ %> selected <%} %> >สมาชิก</option>
	                    <option value="2" <% if(member.getMember_type().equals("หัวหน้าโครงการ") ){ %> selected <%} %> >หัวหน้าโครงการ</option>
	                </select>
	             <%}else  {%>
	             	 <input type="text" name="setpermission" id="setpermission" class="form-control registered"value="<%= member.getMember_type() %>" readonly >
	             
	             <% } %>
	            </td>
	        </tr>
	  
	    </table> 
	    <% if(member.getMember_type().equals("หัวหน้าโครงการ") || haveBoss==false ){ %>
	        <button type="submit" class="btn btn-success" id="submit" name="submit">ยืนยัน</button>
	    <% } %>
	</div>			
	</form>
 
<jsp:include page="basic/footer.jsp" />
</body>
</html>