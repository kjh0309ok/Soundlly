<%@ page contentType="text/html; charset=utf-8" pageEncoding = "utf-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
   <meta http-equiv="content-Type" content="text/html" charset="utf-8"/>
   <link rel="stylesheet" type="text/css" href="vcen5.css">
   <title>프로젝트 출력</title>
<%
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;

   try{
      Class.forName("oracle.jdbc.driver.OracleDriver");
   }catch(ClassNotFoundException cnfe){
      cnfe.printStackTrace();
      System.out.println("드라이버 로딩 실패");

   }try{
      String jdbcUrl = "jdbc:oracl:thin:@localhost:1521:orcl";
      String userId = "class_a";
      String userPass = "delab";
      conn = DriverManager.getConnection(jdbcUrl, userId, userPass);
   %>
</head>
<body class="vertical-container">
   <div class="projectForm">
   <table width="600" border="2" style="float: center">

      <tr align="center">
         <th colspan="7">총 프로젝트 관리</th>
      </tr>
      <tr align="center">
         <th width="100">Project_Number</th>
         <th width="100">Project_Name</th>
         <th width="100">Project_Startdate</th>
         <th width="100">Project_Enddate</th>
         <th width="100">Project_Order</th>
         <th width="100">Number_of_Person</th>
      </tr>
   <%
      String sql = "SELECT * FROM PROJECT ORDER BY PROJECT_NUMBER";
      pstmt = conn.prepareStatement(sql);
      rs = pstmt.executeQuery();

      while(rs.next()){
         request.setCharacterEncoding("utf-8");
         int project_number = rs.getInt("project_number");
         String project_name = rs.getString("project_name");
         Date project_startdate = rs.getDate("project_startdate");
         Date project_enddate = rs.getDate("project_enddate");
         String project_order = rs.getString("project_order");
         int number_of_person = rs.getInt("number_of_person");
      %>
      <tr align="center">
          <form name="Modify_Project" action="Modify_Project.jsp" method="post" >
         <td width="100"><input type="text" name="project_number" value=<%=project_number%>></td>
         <td width="100"><input type="text" name="project_name" value=<%=project_name%>></td>
         <td width="100"><input type="text" name="project_startdate" value=<%=project_startdate%>></td>
         <td width="100"><input type="text" name="project_enddate" value=<%=project_enddate%>></td>
         <td width="100"><input type="text" name="project_order" value=<%=project_order%>></td>
         <td width="100"><input type="text" name="number_of_person" value=<%=number_of_person%>></td>
         <td width="100"><input type="submit" value="Modify"></td>
         </form>
      </tr>
      <%
      }
   }catch(Exception e){
      e.printStackTrace();
   }finally{
      if(rs != null){
         rs.close();
      }
      if(pstmt != null){
         pstmt.close();
      }
   }
%>
   <button onclick="location.href='manage_2_add1.jsp'" class="insertBtn" >프로젝트 추가</button>
   <button onclick="location.href='manage.jsp'" class="backBtn" >뒤로가기</button>
   </table>
   </div>
</body>
</html>
