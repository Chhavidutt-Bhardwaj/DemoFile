<%@page import="java.sql.*" errorPage="error.jsp"%>
<%!
	String title,fname,lname,email,national,country,phone,room_type,bed_type,meal_type,cin_date,cout_date;
	int id,nroom,nodays;
	PreparedStatement ps;
	ResultSet rs;
%>
<html>
	<head>
		<meta charset="utf-8">
		<title>Details of Book key</title>
		
		<style>
		/* reset */

*
{
	border: 0;
	box-sizing: content-box;
	color: inherit;
	font-family: inherit;
	font-size: inherit;
	font-style: inherit;
	font-weight: inherit;
	line-height: inherit;
	list-style: none;
	margin: 0;
	padding: 0;
	text-decoration: none;
	vertical-align: top;
}

/* content editable */

*[contenteditable] { border-radius: 0.25em; min-width: 1em; outline: 0; }

*[contenteditable] { cursor: pointer; }

*[contenteditable]:hover, *[contenteditable]:focus, td:hover *[contenteditable], td:focus *[contenteditable], img.hover { background: #DEF; box-shadow: 0 0 1em 0.5em #DEF; }

span[contenteditable] { display: inline-block; }

/* heading */

h1 { font: bold 100% sans-serif; letter-spacing: 0.5em; text-align: center; text-transform: uppercase; }

/* table */

table { font-size: 75%; table-layout: fixed; width: 100%; }
table { border-collapse: separate; border-spacing: 2px; }
th, td { border-width: 1px; padding: 0.5em; position: relative; text-align: left; }
th, td { border-radius: 0.25em; border-style: solid; }
th { background: #EEE; border-color: #BBB; }
td { border-color: #DDD; }

/* page */

html { font: 16px/1 'Open Sans', sans-serif; overflow: auto; padding: 0.5in; }
html { background: #999; cursor: default; }

body { box-sizing: border-box; height: 11in; margin: 0 auto; overflow: hidden; padding: 0.5in; width: 8.5in; }
body { background: #FFF; border-radius: 1px; box-shadow: 0 0 1in -0.25in rgba(0, 0, 0, 0.5); }

/* header */

header { margin: 0 0 3em; }
header:after { clear: both; content: ""; display: table; }

header h1 { background: #000; border-radius: 0.25em; color: #FFF; margin: 0 0 1em; padding: 0.5em 0; }
header address { float: left; font-size: 75%; font-style: normal; line-height: 1.25; margin: 0 1em 1em 0; }
header address p { margin: 0 0 0.25em; }
header span, header img { display: block; float: right; }
header span { margin: 0 0 1em 1em; max-height: 25%; max-width: 60%; position: relative; }
header img { max-height: 100%; max-width: 100%; }
header input { cursor: pointer; -ms-filter:"progid:DXImageTransform.Microsoft.Alpha(Opacity=0)"; height: 100%; left: 0; opacity: 0; position: absolute; top: 0; width: 100%; }

/* article */

article, article address, table.meta, table.inventory { margin: 0 0 3em; }
article:after { clear: both; content: ""; display: table; }
article h1 { clip: rect(0 0 0 0); position: absolute; }

article address { float: left; font-size: 125%; font-weight: bold; }

/* table meta & balance */

table.meta, table.balance { float: right; width: 36%; }
table.meta:after, table.balance:after { clear: both; content: ""; display: table; }

/* table meta */

table.meta th { width: 40%; }
table.meta td { width: 60%; }

/* table items */

table.inventory { clear: both; width: 100%; }
table.inventory th { font-weight: bold; text-align: center; }

table.inventory td:nth-child(1) { width: 26%; }
table.inventory td:nth-child(2) { width: 38%; }
table.inventory td:nth-child(3) { text-align: right; width: 12%; }
table.inventory td:nth-child(4) { text-align: right; width: 12%; }
table.inventory td:nth-child(5) { text-align: right; width: 12%; }

/* table balance */

table.balance th, table.balance td { width: 50%; }
table.balance td { text-align: right; }

/* aside */

aside h1 { border: none; border-width: 0 0 1px; margin: 0 0 1em; }
aside h1 { border-color: #999; border-bottom-style: solid; }

/* javascript */

.add, .cut
{
	border-width: 1px;
	display: block;
	font-size: .8rem;
	padding: 0.25em 0.5em;	
	float: left;
	text-align: center;
	width: 0.6em;
}

.add, .cut
{
	background: #9AF;
	box-shadow: 0 1px 2px rgba(0,0,0,0.2);
	background-image: -moz-linear-gradient(#00ADEE 5%, #0078A5 100%);
	background-image: -webkit-linear-gradient(#00ADEE 5%, #0078A5 100%);
	border-radius: 0.5em;
	border-color: #0076A3;
	color: #FFF;
	cursor: pointer;
	font-weight: bold;
	text-shadow: 0 -1px 2px rgba(0,0,0,0.333);
}

.add { margin: -2.5em 0 0; }

.add:hover { background: #00ADEE; }

.cut { opacity: 0; position: absolute; top: 0; left: -1.5em; }
.cut { -webkit-transition: opacity 100ms ease-in; }

tr:hover .cut { opacity: 1; }

@media print {
	* { -webkit-print-color-adjust: exact; }
	html { background: none; padding: 0; }
	body { box-shadow: none; margin: 0; }
	span:empty { display: none; }
	.add, .cut { display: none; }
}

@page { margin: 0; }
		</style>
		
	</head>
	<body>
	
	
	
	
	<%
	Connection c=(Connection)application.getAttribute("connection");
	int pid = Integer.parseInt(request.getParameter("sid"));
	
	
	
	String q ="select * from roombook where id = "+pid;
	ps=c.prepareStatement(q);
	rs=ps.executeQuery();
	while(rs.next())
	{
		id = rs.getInt("id");
		title =  rs.getString("Title");
		fname = rs.getString("FName");
		lname = rs.getString("LName");
		email = rs.getString("Email");
		national = rs.getString("National");
		country = rs.getString("Country");
		phone = rs.getString("Phone");
		room_type = rs.getString("TRoom");
		bed_type = rs.getString("Bed");
		//$Noof_room = $row['Nroom'];
		meal_type = rs.getString("Meal");
		cin_date = rs.getString("cin");
		cout_date = rs.getString("cout");
		nodays = rs.getInt("nodays");
	
	}
	
									
	%>
		<header>
			<h1>Information of Guest</h1>
			<address >
				<p>SUN RISE HOTEL,</p>
				<p>New Kalmunani Road,<br>Mathura,<br>India.</p>
				<p>(+91) 95 222 44 554</p>
			</address>
			<span><img alt="" src="assets/img/sun.png"></span>
		</header>
		<article>
			<h1></h1>
			<address >
				
				<p><br></p>
				<p>Coustomer Name  : -  <%=title%> <%=fname%> <%=lname%><br></p>
			</address>
			<table class="meta">
				<tr>
					<th><span >Customer ID</span></th>
					<td><span ><%=id%></span></td>
				</tr>
				<tr>
					<th><span >Check in Date</span></th>
					<td><span ><%=cin_date%> </span></td>
				</tr>
				<tr>
					<th><span >Check out Date</span></th>
					<td><span ><%=cout_date%> </span></td>
				</tr>
				
			</table>
			<table >
					<tr> 
						<td>Customer phone : -  <%=phone%> </td>
						
						<td>Customer email : -  <%=email%> </td>
					</tr>
					<tr> 
						<td>Customer Country : -  <%=country%> </td>
						<td>Customer National : -  <%=national%> </td>
					</tr>
				</table>
				<br>
				<br>
			<table class="inventory">
				<thead>
					<tr>
						<th><span >Item</span></th>
						<th><span >No of Days</span></th>
						
					</tr>
				</thead>
				<tbody>
				
					<tr>
						<td><span ><%=room_type%></span></td>
						<td><span ><%=nodays%> </span></td>
						
					</tr>
					<tr>
						<td><span ><%=bed_type%>  Bed </span></td>
						<td><span ><%=nodays%></span></td>
						
					</tr>
					<tr>
						<td><span ><%=meal_type%>  </span></td>
						<td><span ><%=nodays%></span></td>
						
					</tr>
				</tbody>
			</table>
			
			
		</article>
		<aside>
			<h1><span >Contact us</span></h1>
			<div >
				<p align="center">Email :- info@sunrise.com || Web :- www.sunrise.com || Phone :- +91 95 222 44 554 </p>
			</div>
		</aside>
	</body>
</html>
