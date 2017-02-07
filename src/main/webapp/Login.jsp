<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.DateFormat" %>
<%@page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="analytic.css">
        <link rel="icon" href="src/logo.jpg" type="image/jpg">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%
            if (session.getAttribute("username") != null) {
                session.invalidate();
                /* request.getSession().setAttribute("user", null); */
                response.sendRedirect("Login.jsp");
            } else {
        %>
        <%response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
        %>
        <title>User Login</title>
    </head>
    <body id="bid">
        <%@ include file="Header.html" %>
        <%
            /* Declaring Variables for storing values from text box in User Login section*/
            String StoreId = ((String) request.getParameter("strid"));
            session.setAttribute("storid", StoreId);
        //out.println(StoreId);
            String Password = ((String) request.getParameter("pswd"));
        //out.println("Password");(String)
        %>
        <script type="text/javascript" src="JS/DisableBack.js"></script>
        <form name="login" id="login" method="post">

            <div id="div5">
                <center>
                    <table id="table6" >
                        <tr id="tr6">
                            <td id="td14"></td>
                            <td id="td15"></td>
                            <td id="ALH1"><h2><u>User Login</u></h2></td>
                            <td id="td16"></td>
                            <td id="ALH2"><h4>
                                    <%
                                        Date date = new Date();
                                        DateFormat df = new SimpleDateFormat("dd-MM-yyyy ");
                                        df.setTimeZone(TimeZone.getDefault());
                                        out.println(df.format(date));
                                    %>
                                </h4>
                            </td>
                        </tr>
                    </table>
                </center>
            </div>
            <div>
                <table id="table7">
                    <tr id="tr7">
                        <td id="td17"><label for="usrnm" > UserName</label></td>
                        <td id="td18"><input id="stridbx" type="text" placeholder="Username" name="strid" autofocus required></td>
                    </tr>
                    <tr>
                        <td id="td19"><label for="pswd">Password</label></td>
                        <td id="td20"><input id="pswdbx" type="password" name="pswd"  placeholder="Enter Password" required min=></td>
                    </tr>
                    <tr id="tr8">
                        <td id="td21"></td>
                        <td id="td22"><input type="submit" name="btn" value="SUBMIT" align="middle">
                            <%
                                if (request.getParameter("btn") != null) {
                                    String username = (String) request.getParameter("strid");
                                    String password = (String) request.getParameter("pswd");
                                    request.getSession().setAttribute("usnm", username);
                                    request.getSession().setAttribute("pswd", password);
                                    String usrid = (String) session.getAttribute("usnm");
                                    String psword = (String) session.getAttribute("pswd");
                                    try {

                                        String l = ((String) request.getParameter("strid"));
                                        Class.forName("com.ibm.db2.jcc.DB2Driver");
                                        Connection con = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                                        Statement stmt = con.createStatement();
                                        ResultSet RS = stmt.executeQuery("select Name,Password,role from retail_registration where Name='" + username + "' and Password='" + password + "'");
                                        if (RS.next()) {
                                            String name = RS.getString(1);
                                            String pasw = RS.getString(2);
                                            String role = RS.getString(3);
                                            if (name.matches("hemas") && pasw.matches("hemas@123")) {
                            %>
                            <script>
                                window.location.href = "storevaluelist.jsp";

                            </script>

                            <%
                            } else if (name.matches("1472222821") && pasw.matches("npp")) {
                            %>
                            <script>
                                window.location.href = "PiersonsStore.jsp";
                            </script>
                            <%
                        } else if (role.matches("admin")) {%>
                            <script>
                                window.location.href = "AdminStore.jsp";

                            </script>
                            <%
        } else {%>
                            <script>
                                window.location.href = "storevaluelist.jsp";

                            </script>
                            <%}
                                        }
                                        con.close();

                                    } catch (Exception e) {
                                        System.out.println(e);

                                    }

                                }
                            %>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="div6"> <!--div6 starts here  -->
                <table id="table8">
                    <tr id="tr9">
                        <td id="td23">
                            <iframe id="ifrm2"  frameborder="0" name="ck" ></iframe>
                        </td>
                    </tr>
                </table>
            </div> <!--div6 ends here  -->
        </form>
        <%@ include file="Footer.html" %>
    </body>
    <%}%>
</html>