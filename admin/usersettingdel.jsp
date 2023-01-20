
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
		String newsql ="DELETE FROM login WHERE id ="+id;
		ps=c.prepareStatement(newsql);
		int i=ps.executeUpdate();
	if(i>0)
	{%>
		<script language="javascript" type="text/javascript"> alert("Admin name and password Deleted") </script>
							
				
	<%}
		response.sendRedirect("usersetting.jsp");
		
	%>


