
<%@page import="java.sql.*" errorPage="error.jsp"%>
<%!
	PreparedStatement ps;
%>
<%
	Connection c=(Connection)application.getAttribute("connection");
%>
<%
String eid=request.getParameter("eid");
int id = Integer.parseInt(eid);
if(eid==null)
{%>
	<script>alert("Sorry ! Wrong Entry") </script>

<%
	response.sendRedirect("messages.jsp");
}

else{
String view="DELETE FROM contact WHERE id ="+id;
ps=c.prepareStatement(view);
int i=ps.executeUpdate();
	if(i>0)
	{%>
		<script>alert("News Letter Subscriber Removed") </script>
<%	
response.sendRedirect("messages.jsp");
}


}


%>