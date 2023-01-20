<%@page import="java.sql.*" errorPage="error.jsp"%>
<%!
	PreparedStatement ps;
	ResultSet rs;
%>
<%
	Connection c=(Connection)application.getAttribute("connection");
%>
<%

int eid = Integer.parseInt(request.getParameter("eid"));
String approval ="Allowed";
String napproval="Not Allowed";
String app="";
String view="select * from contact where id = "+eid;
ps=c.prepareStatement(view);
rs=ps.executeQuery();
while (rs.next())
{
	int id=rs.getInt("id");
	app =rs.getString("approval");
}

if(app.equalsIgnoreCase("Not Allowed"))
{
	String sql ="UPDATE contact SET approval= '"+approval+"' WHERE id = "+eid;
	ps=c.prepareStatement(sql);
	int i=ps.executeUpdate();
	if(i>0)
	{%>
		<script>alert("Newsletter sent") </script>
	<%
		response.sendRedirect("messages.jsp");
	}
}
else {
String sql ="UPDATE contact SET approval= '"+napproval+"' WHERE id ="+eid;
	ps=c.prepareStatement(sql);
	int i=ps.executeUpdate();
	if(i>0)
	{%>
		<script>alert("Newsletter sent") </script>
	<%
	response.sendRedirect("messages.jsp");
	}



}
%>