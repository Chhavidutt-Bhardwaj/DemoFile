<%@page import="java.sql.*" errorPage="error.jsp"%>
<!DOCTYPE html>
<html >
<head>
  <meta charset="UTF-8">
  <title>SUN RISE ADMIN</title>
  
  
     
      <link rel="stylesheet" href="css/style.css">

  
</head>

<body>
  <div id="clouds">
	<div class="cloud x1"></div>
	<!-- Time for multiple clouds to dance around -->
	<div class="cloud x2"></div>
	<div class="cloud x3"></div>
	<div class="cloud x4"></div>
	<div class="cloud x5"></div>
</div>

 <div class="container">


      <div id="login">

        <form method="post" action="index.jsp">

          <fieldset class="clearfix">

            <p><span class="fontawesome-user"></span><input type="text"  name="user" value="Username" onBlur="if(this.value == '') this.value = 'Username'" onFocus="if(this.value == 'Username') this.value = ''" required></p> <!-- JS because of IE support; better: placeholder="Username" -->
            <p><span class="fontawesome-lock"></span><input type="password" name="pass"  value="Password" onBlur="if(this.value == '') this.value = 'Password'" onFocus="if(this.value == 'Password') this.value = ''" required></p> <!-- JS because of IE support; better: placeholder="Password" -->
            <p><input type="submit" name="submit"  value="Login"></p>

          </fieldset>

        </form>

       

      </div> <!-- end login -->

    </div>
    <div class="bottom">  <h3><a href="../index.jsp">SUN RISE HOMEPAGE</a></h3></div>
  
  
</body>
</html>

<%
    
   
   if(request.getParameter("submit")!=null) {
      // username and password sent from form 
      
      String myusername = request.getParameter("user");
      String mypassword = request.getParameter("pass"); 
      
	Connection c=(Connection)application.getAttribute("connection");	
      String q = "SELECT id FROM login WHERE username = ? and pass = ?";
	PreparedStatement ps=c.prepareStatement(q);
	ps.setString(1,myusername);
	ps.setString(2,mypassword);
	ResultSet rs=ps.executeQuery();
     
                      
      // If result matched myusername and mypassword, table row must be 1 row
		
      if(rs.next()) {
         session.setAttribute("user",myusername);
         
        response.sendRedirect("home.jsp");
      }else {%>
         <script>alert("Your Login Name or Password is invalid") </script> 
      <%}
   }
%>
