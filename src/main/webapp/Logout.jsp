<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="UTF-8">
			<!-- <title>Excel To HTML using codebeautify.org</title> -->
		</head>
		<body><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<head>
					<link rel="stylesheet" type="text/css" href="analytic.css">
						<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
							<title>99 Retail Street</title>
							<link rel="icon" href="src/logo.jpg" type="image/jpg">
  <%response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    %>
							</head>
							<body id="bid"><%
String username=(String)session.getAttribute("username");%><% 
if (session.getAttribute("username")!=null){
	
%><%@ include file="Header.html" %>
								<a href="Login.jsp">Logout</a>
								<div id="div3">
									<!--div3 starts here  -->
									<table id="table3">
										<tr id="tr3">
											<td id="td7"></td>
											<td id="td8"></td>
											<td id="td9"></td>
											<td id="td10"></td>
											<td id="td11"></td>
										</tr>
									</table>
								</div>
								<!--div3 ends here  -->
								<div>
									<table width="100%">
										<tr>
											<td width="20%"></td>
											<td width="20%">
												<div class="div3"><%--
													<a href="">
														<button style="width:90px;height:70px;background-color: blue;color: white;">Manufacturer Report</button>
													</a>
												</div>
											</td>
--%>
											<td width="20%">
												<div class="div3">
													<a href="showstore.jsp">
														<button style="width:100px;height:100px;background-color: blue;color: white;">Store Report</button>
													</a>
												</div>
											</td>
											<td width="20%">
												<div class="div3"><%--
													<a href="">
														<button style="width:70px;height:70px;background-color: blue;color: white;">Distributor Report</button>
													</a>
												</div>
											</td>
--%>
											<td width="20%"></td>
										</tr><%-- <% //out.println(session.getAttribute("abc")); %> --%>
									</table>
								</div>
								<div id="div4">
									<!--div4 starts here  -->
									<table id="table4">
										<tr id="tr4">
											<td id="td12">
												<iframe id="ifrm1"  frameborder="0" name="ck" ></iframe>
											</td>
										</tr>
									</table>
								</div>
								<!--div4 ends here  --><%@ include file="Footer.html" %><%}
else{ %>
								<h1>Please Login First  </h1>
								<br>
									<a href="Login.jsp">Click here to login</a>
								</div><%}%>
							</body>
						</body>
					</html>