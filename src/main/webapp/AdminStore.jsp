<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="com.itextpdf.text.Chunk"%>
<%@ page language="java" import="java.sql.*" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import=" com.sendgrid.*" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.lang.Object" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import=" java.io.FileOutputStream" %>
<%@ page import=" java.io.BufferedReader" %>
<%@ page import=" java.io.DataOutputStream" %>
<%@ page import=" java.io.InputStreamReader" %>
<%@ page import=" java.net.HttpURLConnection" %>
<%@ page import="  java.net.URL" %>
<%@ page import="  java.io.File" %>
<%@ page import="  com.itextpdf.text.Font" %>
<%@ page import=" com.itextpdf.text.Font.FontFamily" %>
<%@ page import="com.itextpdf.text.BaseColor" %>
<%@ page import=" com.itextpdf.text.Document" %>
<%@ page import="com.itextpdf.text.Element" %>
<%@ page import=" com.itextpdf.text.PageSize" %>
<%@ page import=" com.itextpdf.text.Paragraph" %>
<%@ page import=" com.itextpdf.text.Phrase" %>
<%@ page import=" com.itextpdf.text.pdf.PdfPCell" %>
<%@ page import=" com.itextpdf.text.pdf.PdfPTable" %>
<%@ page import=" com.itextpdf.text.pdf.PdfWriter" %>
<%@ page import=" java.io.IOException" %>
<%@ page import="org.openstack4j.api.OSClient"%>
<%@ page import="org.openstack4j.openstack.OSFactory"%>
<%@ page import="org.openstack4j.model.storage.object.SwiftAccount"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.openstack4j.model.common.Identifier"%>
<%@ page import="org.openstack4j.api.storage.ObjectStorageService"%>
<%@ page import="org.openstack4j.model.storage.object.SwiftObject"%>
<%@ page import="org.openstack4j.api.storage.ObjectStorageService"%>
<%@ page import="org.openstack4j.model.common.DLPayload"%>
<%@ page import="org.openstack4j.model.storage.object.SwiftContainer"%>
<%@ page import="org.openstack4j.model.storage.object.SwiftObject"%>
<%@ page import="org.openstack4j.model.common.Payloads"%>
<%@ page import="javax.servlet.http.Part"%>
<%@ page import="org.openstack4j.model.common.Payload"%>
<%@ page import="java.util.*"%>
<%@ page import="org.openstack4j.model.storage.object.SwiftContainer"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.itextpdf.text.Image"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFCell"%>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFRow"%>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFFont" %>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCell" %>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCellStyle" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <script>
            function cal() {

                if (document.getElementById("datepicker1")) {

                    var startDate = document.getElementById("datepicker").value;
                    var endDate = document.getElementById("datepicker1").value;

                    if ((Date.parse(startDate) > Date.parse(endDate))) {
                        alert("End date should be greater than Start date");
                        document.getElementById("datepicker1").value = "";
                    }
                }
            }
        </script>
        <script>
            function cal2() {

                if (document.getElementById("datepicker")) {

                    var startDate = document.getElementById("datepicker").value;
                    var endDate = document.getElementById("datepicker1").value;
                    var current_date = new Date();
                    var selDate = Date.parse(dateText);
                    if (selDate > current_date) {
                        alert("Please select Today date or less than today date.");
                        document.getElementById("datepicker").value = "";
                    }
                }
            }

        </script>

        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <link rel="stylesheet" href="runnable.css" />
        <script>
            $(document).ready(
                    function () {
                        $('#datepicker1').datepicker({
                            dateFormat: 'yy-mm-dd',
                            yearRange: "2016:2020",
                            onSelect: function (dateText, inst) {
                                $(this).val(dateText);
                                $(this).change();

                                var current_date = new Date();

                                var selDate = Date.parse(dateText);

                                if (selDate > current_date) {

                                    alert("Please select Today date or less than today date.");
                                    $('#datepicker1').val('');
                                    $(inst).datepicker('show');
                                }
                            }
                        });
                    }

            );
        </script>


        <style>
            ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }
            ul li {
                display: block;
                position: relative;
                float: left;
                background: #1bc2a2; /* This color is for main menu item list */
            }

            #report li {background: #E91E63;
            }
            li ul { display: none; }
            ul li a {
                display: block;
                padding: 5px;
                text-decoration: none;
                white-space: nowrap;
                color: #fff;
            }
            ul li a:hover { background: #2c3e50; }
            li:hover > ul {
                display: block;
                position: absolute;
            }
            li:hover li { float: none; }
            li:hover li a:hover { background: orange; }
            .main-navigation li ul li { border-top: 0; }
            ul ul ul {
                left: 100%;
                top: 0;
            }
            ul:before,
            ul:after {
                content: " "; /* 1 */
                display: table; /* 2 */
            }
            ul:after { clear: both; }
            tr:nth-child(even) {background: #C5CAE9}
            tr:nth-child(odd) {background: #00BCD4}
            .pg-normal { 
                color: #000000; 
                font-size: 15px; 
                cursor: pointer; 
                background: #FF6600; 
                padding: 2px 4px 2px 4px; 
            }

            .pg-selected { 
                color: #fff; 
                font-size: 15px; 
                background: #FF6600; 
                padding: 2px 4px 2px 4px; 
            </style>
            <script type="text/javascript">

                function Pager(tableName, itemsPerPage) {

                    this.tableName = tableName;

                    this.itemsPerPage = itemsPerPage;

                    this.currentPage = 1;

                    this.pages = 0;

                    this.inited = false;

                    this.showRecords = function (from, to) {

                        var rows = document.getElementById(tableName).rows;

                        // i starts from 1 to skip table header row

                        for (var i = 1; i < rows.length; i++) {

                            if (i < from || i > to)
                                rows[i].style.display = 'none';

                            else
                                rows[i].style.display = '';

                        }

                    }

                    this.showPage = function (pageNumber) {

                        if (!this.inited) {

                            alert("not inited");

                            return;

                        }

                        var oldPageAnchor = document.getElementById('pg' + this.currentPage);

                        oldPageAnchor.className = 'pg-normal';

                        this.currentPage = pageNumber;

                        var newPageAnchor = document.getElementById('pg' + this.currentPage);

                        newPageAnchor.className = 'pg-selected';

                        var from = (pageNumber - 1) * itemsPerPage + 1;

                        var to = from + itemsPerPage - 1;

                        this.showRecords(from, to);

                    }

                    this.prev = function () {

                        if (this.currentPage > 1)
                            this.showPage(this.currentPage - 1);

                    }

                    this.next = function () {

                        if (this.currentPage < this.pages) {

                            this.showPage(this.currentPage + 1);

                        }

                    }

                    this.init = function () {

                        var rows = document.getElementById(tableName).rows;

                        var records = (rows.length - 1);

                        this.pages = Math.ceil(records / itemsPerPage);

                        this.inited = true;

                    }

                    this.showPageNav = function (pagerName, positionId) {

                        if (!this.inited) {

                            alert("not inited");

                            return;

                        }

                        var element = document.getElementById(positionId);

                        var pagerHtml = '<span onclick="' + pagerName + '.prev();" class="pg-normal">PREV </span> ';

                        for (var page = 1; page <= this.pages; page++)
                            pagerHtml += '<style id="pg' + page + '" class="pg-normal;"></style> ';

                        pagerHtml += '<span onclick="' + pagerName + '.next();" class="pg-normal"> NEXT</span>';

                        element.innerHTML = pagerHtml;

                    }

                }
            </script>
            <script type="text/javascript" src="JS/DisableBack.js"></script>
            <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
            <title>Admin Sales Daily </title>

        </head>
        <head> <meta http-equiv="refresh" content="60"></head>
        <body>
            <form action="AdminStore.jsp" method="post" id="myForm">
                <%@ include file="Header.html" %>
                <%!  String mailid;%>
                <%    String usrid = (String) session.getAttribute("usnm");
                    String psword = (String) session.getAttribute("pswd");
                    try {
                        Class.forName("com.ibm.db2.jcc.DB2Driver");
                        Connection con1 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                        Statement stm = con1.createStatement();
                        ResultSet RS = stm.executeQuery("select EMAIL from retail_registration where Name='" + usrid + "' and Password='" + psword + "'");
                        while (RS.next()) {
                            mailid = (RS.getString(1));

                        }
                    } catch (Exception e) {
                        out.println(e);
                    } %>
                <table align="right">
                    <tr>
                        <td>
                            <button>
                                <a href="Login.jsp" style="text-decoration: none">Logout</a>
                                </button>
                            </td>
                        </tr>
                    </table><br>
                    <%                        if ((request.getParameter("month") != null)) {
                            if (request.getParameter("month").equals("current")) {

                    %>
                    <table style="white-space: nowrap;" border="1" align="center" id="tablepaging"  width="20%">
                    <tr class="even">
                        <td>
                            <input type="radio" name="month" value="current" onclick="this.form.submit()"checked  />Current Month
                            <input type="radio" name="month" value="previous" onclick="this.form.submit()"  />Previous Month
                        </td>
                    </tr>
                </table>

                <%  String V_Curr = "";
                    String V_First = "";
                    String dateselect = "";
                    String monthselect = "";
                    String yearselect = "";
                    int V_Count = 0;
                    float V_Sum = 0;
                    float V_Sum_Mon = 0;
                    String V_Sum_Array[] = new String[100];
                    String V_Sum_Mon_Array[] = new String[100];
                    Class.forName("com.ibm.db2.jcc.DB2Driver");
                    Connection con1 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                    Statement stm = con1.createStatement();
                    Statement stm1 = con1.createStatement();
                    Statement stmt = con1.createStatement();
                    ResultSet RSDate = stmt.executeQuery("select first_day(current_date),MONTHNAME (current_date), current_date,year(current_date) FROM sysibm.sysdummy1");
                    while (RSDate.next()) {
                        V_First = RSDate.getString(1);
                        monthselect = RSDate.getString(2);
                        V_Curr = RSDate.getString(3);
                        yearselect = RSDate.getString(4);
                    }
                    ResultSet RS = stm.executeQuery(" select thirdset.thirdstoreid,thirdset.thirdstorename,"
                            + "COALESCE(firstset.DailySales,0),COALESCE(firstset.TodayBillNos,0),"
                            + "COALESCE(round((firstset.dailysales/firstset.todaybillnos),2),0) "
                            + "as Avg,COALESCE( secondset.MonthlySales,0),"
                            + "COALESCE(secondset.MonthlyBillNos,0),"
                            + "COALESCE(round((secondset.monthlysales/secondset.monthlybillnos),2),0) "
                            + "as monthlyavg from (select retail_store.store_id as firststoreid,"
                            + "retail_store.Str_nm as storename,sum(retail_str_sales_master.Grand_total) "
                            + "as DailySales, count(retail_str_sales_master.tri_id) "
                            + "as TodayBillNos from retail_store,"
                            + "retail_str_sales_master "
                            + "where retail_store.Store_id = retail_str_sales_master.Store_id "
                            + "and retail_str_sales_master.Sale_date LIKE CURRENT_DATE "
                            + "group by retail_store.Store_id,retail_store.Str_nm ) "
                            + "as firstset full outer join (select retail_store.store_id "
                            + "as secstoreid,retail_store.Str_nm "
                            + "as secondstorename,sum(retail_str_sales_master.Grand_total) "
                            + "as MonthlySales, count(retail_str_sales_master.tri_id) "
                            + "as MonthlyBillNos from retail_store,retail_str_sales_master "
                            + "where retail_store.Store_id = retail_str_sales_master.Store_id "
                            + "and retail_str_sales_master.Sale_date "
                            + "Between '" + V_First + "' "
                            + "and '" + V_Curr + "' "
                            + "group by retail_store.Store_id,retail_store.Str_nm) "
                            + "as secondset on firstset.firststoreid = secondSet.secstoreid "
                            + "full outer join (select retail_store.store_id "
                            + "as thirdstoreid,retail_store.Str_nm as thirdstorename,"
                            + "sum(retail_str_sales_master.Grand_total) as "
                            + "MonthlySales,count(retail_str_sales_master.tri_id) as "
                            + "MonthlyBillNos from retail_store,retail_str_sales_master "
                            + "where retail_store.Store_id = retail_str_sales_master.Store_id "
                            + "and retail_str_sales_master.Sale_date between '2016-10-01' "
                            + "and CURRENT_DATE group by retail_store.Store_id,retail_store.Str_nm) "
                            + "as thirdset on thirdset.thirdstoreid = secondset.secstoreid  ");
                    ResultSet RS1 = stm1.executeQuery("  select thirdset.thirdstoreid,thirdset.thirdstorename,"
                            + "COALESCE(firstset.DailySales,0),COALESCE(firstset.TodayBillNos,0),"
                            + "COALESCE(round((firstset.dailysales/firstset.todaybillnos),2),0) "
                            + "as Avg,COALESCE( secondset.MonthlySales,0),"
                            + "COALESCE(secondset.MonthlyBillNos,0),"
                            + "COALESCE(round((secondset.monthlysales/secondset.monthlybillnos),2),0) "
                            + "as monthlyavg from (select retail_store.store_id as firststoreid,"
                            + "retail_store.Str_nm as storename,sum(retail_str_sales_master.Grand_total) "
                            + "as DailySales, count(retail_str_sales_master.tri_id) "
                            + "as TodayBillNos from retail_store,"
                            + "retail_str_sales_master "
                            + "where retail_store.Store_id = retail_str_sales_master.Store_id "
                            + "and retail_str_sales_master.Sale_date LIKE CURRENT_DATE "
                            + "group by retail_store.Store_id,retail_store.Str_nm ) "
                            + "as firstset full outer join (select retail_store.store_id "
                            + "as secstoreid,retail_store.Str_nm "
                            + "as secondstorename,sum(retail_str_sales_master.Grand_total) "
                            + "as MonthlySales, count(retail_str_sales_master.tri_id) "
                            + "as MonthlyBillNos from retail_store,retail_str_sales_master "
                            + "where retail_store.Store_id = retail_str_sales_master.Store_id "
                            + "and retail_str_sales_master.Sale_date "
                            + "Between '" + V_First + "' "
                            + "and '" + V_Curr + "' "
                            + "group by retail_store.Store_id,retail_store.Str_nm) "
                            + "as secondset on firstset.firststoreid = secondSet.secstoreid "
                            + "full outer join (select retail_store.store_id "
                            + "as thirdstoreid,retail_store.Str_nm as thirdstorename,"
                            + "sum(retail_str_sales_master.Grand_total) as "
                            + "MonthlySales,count(retail_str_sales_master.tri_id) as "
                            + "MonthlyBillNos from retail_store,retail_str_sales_master "
                            + "where retail_store.Store_id = retail_str_sales_master.Store_id "
                            + "and retail_str_sales_master.Sale_date between '2016-10-01' "
                            + "and CURRENT_DATE group by retail_store.Store_id,retail_store.Str_nm) "
                            + "as thirdset on thirdset.thirdstoreid = secondset.secstoreid  ");
                    while (RS1.next()) {
                        V_Sum_Array[V_Count] = RS1.getString(3);
                        V_Sum_Mon_Array[V_Count] = RS1.getString(6);
                        V_Count++;
                    }
                    for (int m = 0; m < V_Count; m++) {
                        V_Sum = V_Sum + Float.parseFloat(V_Sum_Array[m]);
                        V_Sum_Mon = V_Sum_Mon + Float.parseFloat(V_Sum_Mon_Array[m]);
                    }
                %><br>
                <table style="white-space: nowrap;" border="1" align="center" id="tablepaging">
                    <tr class="even">
                        <th >Store Id</th>
                        <th >Store Name</th>
                        <th >Sales Value On <%=V_Curr%></th>
                        <th >Bills On <%=V_Curr%></th>
                        <th >Avg Sales On <%=V_Curr%></th>
                        <th >Sales in <%=monthselect%></th>
                        <th>Bills in <%=monthselect%> </th>
                        <th >Avg Sales in <%=monthselect%></th>
                    </tr>

                    <%
                        Document d = new Document(PageSize.A4);
                         OutputStream file = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.pdf");
                        //OutputStream file = new FileOutputStream("PDF/Report.pdf");
                        PdfWriter.getInstance(d, file);
                        d.open();
                           Image image1 = Image.getInstance("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/src/logo.jpg");
                        //Image image1 = Image.getInstance("src/logo.jpg");
                        image1.setAlignment(Element.ALIGN_LEFT);
                        d.add(image1);
                        float[] columnWidths = new float[]{40f, 40f, 40f, 40f, 40f, 40f, 40f, 40f};
                        PdfPTable table = new PdfPTable(columnWidths);
                        table.setWidths(columnWidths);
                        table.setWidthPercentage(90f);
                        PdfPCell cell = new PdfPCell();
                        table.addCell("    Store Id");
                        table.addCell("    Store Name");
                        table.addCell("Sales Value On " + V_Curr +"");
                        table.addCell("Bills On " + V_Curr +"");
                        table.addCell("Avg Sales On " + V_Curr +"");
                        table.addCell("Sales in " + monthselect + "");
                        table.addCell("No of Bills in " + monthselect + "");
                        table.addCell("Avg Sales in " + monthselect + " ");
 FileOutputStream fileOut = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.xls");
                       // FileOutputStream fileOut = new FileOutputStream("PDF/Report.xls");
                        HSSFWorkbook workbook = new HSSFWorkbook();
                        HSSFSheet sheet = workbook.createSheet("New Sheet");
                        HSSFRow row = sheet.createRow((short) 0);
                        HSSFFont font = workbook.createFont();
                        font.setColor(HSSFFont.COLOR_RED);
                        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                        HSSFCell cell1 = row.createCell((short) 0);
                        cell1.setCellType(HSSFCell.CELL_TYPE_STRING);
                        cell1.setCellValue(" Store Id");
                        HSSFCell cell2 = row.createCell((short) 1);
                        cell2.setCellType(HSSFCell.CELL_TYPE_STRING);
                        cell2.setCellValue("Store Name");
                        HSSFCell cell3 = row.createCell((short) 2);
                        cell3.setCellType(HSSFCell.CELL_TYPE_STRING);
                        cell3.setCellValue("Sales Value On " + V_Curr +"");
                        HSSFCell cell4 = row.createCell((short) 3);
                        cell4.setCellType(HSSFCell.CELL_TYPE_STRING);
                        cell4.setCellValue("Bills On " + V_Curr +"");
                        HSSFCell cell5 = row.createCell((short) 4);
                        cell5.setCellType(HSSFCell.CELL_TYPE_STRING);
                        cell5.setCellValue("Avg Sales On " + V_Curr +"");
                        HSSFCell cell6 = row.createCell((short) 5);
                        cell6.setCellType(HSSFCell.CELL_TYPE_STRING);
                        cell6.setCellValue("Sales in " + monthselect + "");
                        HSSFCell cell7 = row.createCell((short) 6);
                        cell7.setCellType(HSSFCell.CELL_TYPE_STRING);
                        cell7.setCellValue("No of Bills in " + monthselect + "");
                        HSSFCell cell8 = row.createCell((short) 7);
                        cell8.setCellType(HSSFCell.CELL_TYPE_STRING);
                        cell8.setCellValue("Avg Sales in " + monthselect + " ");
                        int b = 1;
                        while (RS.next()) {
                    %>
                    <tr class="odd">
                        <td align="left"><a href="AdminReport.jsp?Value1=<%=RS.getString(1)%>&Value2=<%=RS.getString(2)%>" style="color :#00FFF" style="text-decoration:none"><%=RS.getString(1)%></a></td>
                            <TD align="left"><%=(RS.getString(2))%></td>
                            <TD align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=(RS.getString(3))%>" /> </td>
                            <TD align="right"><%=(RS.getString(4))%></td>
                            <TD align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=(RS.getString(5))%>" /> </td>
                            <TD align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=(RS.getString(6))%>" /> </td>
                            <TD align="right"><%=(RS.getString(7))%></td>
                            <TD align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=(RS.getString(8))%>" /> </td>
                        </tr>
                        <%
                                cell = new PdfPCell(new Phrase(RS.getString(1)));
                                table.addCell(cell);
                                cell = new PdfPCell(new Phrase(RS.getString(2)));
                                table.addCell(cell);
                                cell = new PdfPCell(new Phrase(RS.getString(3)));
                                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                table.addCell(cell);
                                cell = new PdfPCell(new Phrase(RS.getString(4)));
                                table.addCell(cell);
                                cell = new PdfPCell(new Phrase(RS.getString(5)));
                                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                table.addCell(cell);
                                cell = new PdfPCell(new Phrase(RS.getString(6)));
                                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                table.addCell(cell);
                                cell = new PdfPCell(new Phrase(RS.getString(7)));
                                table.addCell(cell);
                                cell = new PdfPCell(new Phrase(RS.getString(8)));
                                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                table.addCell(cell);

                                row = sheet.createRow(b);
                                row.createCell((short) 0).setCellValue(RS.getString(1));
                                row.createCell((short) 1).setCellValue(RS.getString(2));
                                row.createCell((short) 2).setCellValue(RS.getString(3));
                                row.createCell((short) 3).setCellValue(RS.getString(4));
                                row.createCell((short) 4).setCellValue(RS.getString(5));
                                row.createCell((short) 5).setCellValue(RS.getString(6));
                                row.createCell((short) 6).setCellValue(RS.getString(7));
                                row.createCell((short) 7).setCellValue(RS.getString(8));
                                b++;
                            }
                            d.add(table);
                            d.close();
                            workbook.write(fileOut);
                            fileOut.close();
                        %>
                    </table>
                    <%    DecimalFormat df = new DecimalFormat("##,###.##");
                        df.setMaximumFractionDigits(2);%>
                    <center><div style="color: darkred;"><h3><b><%
                        out.println("Daily Sales Across All Stores (In LKR) :-");
                        out.println(df.format(V_Sum));
                        out.println("  ,   Monthly Sales Across All Stores (In LKR):- ");
                        out.println(df.format(V_Sum_Mon));  %></b></h3></div>
                    <center>
                        <input  name="mail"  type="submit"  value="Email As PDF"> 
                        <input  name="mailXls"   type="submit"  value="Email As XLS"> 
                    </center>
                    <div id="pageNavPosition" style="padding-top: 20px" align="center">
                        </div>
                        <% } else if (request.getParameter("month").equals("previous")) {
                        %>
                        <table style="white-space: nowrap;" border="1" align="center" id="tablepaging" width="20%">
                        <tr class="even">
                            <td>
                                <input type="radio" name="month" value="current" onclick="this.form.submit()"  />Current Month
                                <input type="radio" name="month" value="previous" onclick="this.form.submit()" checked />Previous Month
                            </td>
                        </tr>
                    </table>
                    <%
                        String V_Curr = "";
                        String V_First = "";
                        String dateselect = "";
                        String monthselect = "";
                        String yearselect = "";
                        String V_Pev_first = "";
                        String V_Pev_last = "";
                        String V_Pev_mon_name = "";
                        int V_Count = 0;
                        double V_Sum = 0;
                        float V_Sum_Mon = 0;
                        String V_Sum_Array[] = new String[10000];
                        String V_Sum_Mon_Array[] = new String[10000];
                        Class.forName("com.ibm.db2.jcc.DB2Driver");
                        Connection con1 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                        Statement stm = con1.createStatement();
                        Statement stm1 = con1.createStatement();
                        Statement stmt = con1.createStatement();
                        ResultSet RSDate = stmt.executeQuery("select first_day(current_date),MONTHNAME (current_date), current_date,year(current_date),( current_date + 1 days - day(current_date) days - 1 MONTH ), ( current date - DAY(CURRENT_DATE )),monthname(( current_date + 1 days - day(current_date) days - 1 MONTH ))  FROM sysibm.sysdummy1");
                        while (RSDate.next()) {
                            V_First = RSDate.getString(1);
                            monthselect = RSDate.getString(2);
                            V_Curr = RSDate.getString(3);
                            yearselect = RSDate.getString(4);
                            V_Pev_first = RSDate.getString(5);
                            V_Pev_last = RSDate.getString(6);
                            V_Pev_mon_name = RSDate.getString(7);
                        }
                        ResultSet RS = stm.executeQuery("select thirdset.thirdstoreid,thirdset.thirdstorename,COALESCE( secondset.MonthlySales,0),COALESCE(secondset.MonthlyBillNos,0),COALESCE(round((secondset.monthlysales/secondset.monthlybillnos),2),0) as monthlyavg from (select retail_store.store_id as firststoreid, retail_store.Str_nm as storename,sum(retail_str_sales_master.Grand_total) as DailySales, count(retail_str_sales_master.tri_id) as TodayBillNos from retail_store,retail_str_sales_master where retail_store.Store_id = retail_str_sales_master.Store_id  and retail_str_sales_master.Sale_date LIKE CURRENT_DATE group by retail_store.Store_id,retail_store.Str_nm ) as firstset full outer join (select retail_store.store_id as secstoreid,retail_store.Str_nm as secondstorename,sum(retail_str_sales_master.Grand_total) as MonthlySales, count(retail_str_sales_master.tri_id) as MonthlyBillNos from retail_store,retail_str_sales_master where retail_store.Store_id = retail_str_sales_master.Store_id and retail_str_sales_master.Sale_date Between '2017-01-01' and '2017-01-31' group by retail_store.Store_id,retail_store.Str_nm) as secondset on firstset.firststoreid = secondSet.secstoreid full outer join (select retail_store.store_id  as thirdstoreid,retail_store.Str_nm as thirdstorename, sum(retail_str_sales_master.Grand_total) as MonthlySales,count(retail_str_sales_master.tri_id) as  MonthlyBillNos from retail_store,retail_str_sales_master where retail_store.Store_id = retail_str_sales_master.Store_id  and retail_str_sales_master.Sale_date between '2016-10-01' and CURRENT_DATE group by retail_store.Store_id,retail_store.Str_nm) as thirdset on thirdset.thirdstoreid = secondset.secstoreid  ");
                        ResultSet RS1 = stm1.executeQuery("select thirdset.thirdstoreid,thirdset.thirdstorename,COALESCE( secondset.MonthlySales,0),COALESCE(secondset.MonthlyBillNos,0),COALESCE(round((secondset.monthlysales/secondset.monthlybillnos),2),0) as monthlyavg from (select retail_store.store_id as firststoreid, retail_store.Str_nm as storename,sum(retail_str_sales_master.Grand_total) as DailySales, count(retail_str_sales_master.tri_id) as TodayBillNos from retail_store,retail_str_sales_master where retail_store.Store_id = retail_str_sales_master.Store_id  and retail_str_sales_master.Sale_date LIKE CURRENT_DATE group by retail_store.Store_id,retail_store.Str_nm ) as firstset full outer join (select retail_store.store_id as secstoreid,retail_store.Str_nm as secondstorename,sum(retail_str_sales_master.Grand_total) as MonthlySales, count(retail_str_sales_master.tri_id) as MonthlyBillNos from retail_store,retail_str_sales_master where retail_store.Store_id = retail_str_sales_master.Store_id and retail_str_sales_master.Sale_date Between '2017-01-01' and '2017-01-31' group by retail_store.Store_id,retail_store.Str_nm) as secondset on firstset.firststoreid = secondSet.secstoreid full outer join (select retail_store.store_id  as thirdstoreid,retail_store.Str_nm as thirdstorename, sum(retail_str_sales_master.Grand_total) as MonthlySales,count(retail_str_sales_master.tri_id) as  MonthlyBillNos from retail_store,retail_str_sales_master where retail_store.Store_id = retail_str_sales_master.Store_id  and retail_str_sales_master.Sale_date between '2016-10-01' and CURRENT_DATE group by retail_store.Store_id,retail_store.Str_nm) as thirdset on thirdset.thirdstoreid = secondset.secstoreid ");
                        while (RS1.next()) {
                            V_Sum_Array[V_Count] = RS1.getString(3);
                            V_Sum_Mon_Array[V_Count] = RS1.getString(5);
                            V_Count++;
                        }
                        for (int m = 0; m < V_Count; m++) {
                            V_Sum = V_Sum + Double.parseDouble(V_Sum_Array[m]);

                            V_Sum_Mon = V_Sum_Mon + Float.parseFloat(V_Sum_Mon_Array[m]);
                        }
                    %>
                    <br>
                    <table style="white-space: nowrap;" border="1" align="center" id="tablepaging">
                        <tr class="even">
                            <th >Store Id</th>
                            <th >Store Name</th>
                            <th >Sales in <%=V_Pev_mon_name%></th>
                            <th>Bills in <%=V_Pev_mon_name%> </th>
                            <th >Avg Sales in <%=V_Pev_mon_name%></th>
                        </tr>
                        <%
                            Document d = new Document(PageSize.A4);
                             OutputStream file = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.pdf");
                            //OutputStream file = new FileOutputStream("PDF/Report.pdf");
                            PdfWriter.getInstance(d, file);
                            d.open();
                            Image image1 = Image.getInstance("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/src/logo.jpg");
                            //Image image1 = Image.getInstance("src/logo.jpg");
                            image1.setAlignment(Element.ALIGN_LEFT);
                            d.add(image1);
                            float[] columnWidths = new float[]{40f, 40f, 40f, 40f, 40f};
                            PdfPTable table = new PdfPTable(columnWidths);
                            table.setWidths(columnWidths);
                            table.setWidthPercentage(90f);
                            PdfPCell cell = new PdfPCell();
                            table.addCell("    Store Id");
                            table.addCell("    Store Name");
                            table.addCell("Sales in " + V_Pev_mon_name + "");
                            table.addCell("No of Bills in " + V_Pev_mon_name + "");
                            table.addCell("Avg Sales in " + V_Pev_mon_name + " ");
FileOutputStream fileOut = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.xls");
                           // FileOutputStream fileOut = new FileOutputStream("PDF/Report.xls");
                            HSSFWorkbook workbook = new HSSFWorkbook();
                            HSSFSheet sheet = workbook.createSheet("New Sheet");
                            HSSFRow row = sheet.createRow((short) 0);
                            HSSFFont font = workbook.createFont();
                            font.setColor(HSSFFont.COLOR_RED);
                            font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                            HSSFCell cell1 = row.createCell((short) 0);
                            cell1.setCellType(HSSFCell.CELL_TYPE_STRING);
                            cell1.setCellValue(" Store Id");
                            HSSFCell cell2 = row.createCell((short) 1);
                            cell2.setCellType(HSSFCell.CELL_TYPE_STRING);
                            cell2.setCellValue("Store Name");
                            HSSFCell cell3 = row.createCell((short) 2);
                            cell3.setCellType(HSSFCell.CELL_TYPE_STRING);
                            cell3.setCellValue("Sales in " + V_Pev_mon_name + " ");
                            HSSFCell cell4 = row.createCell((short) 3);
                            cell4.setCellType(HSSFCell.CELL_TYPE_STRING);
                            cell4.setCellValue("No of Bills in " + V_Pev_mon_name + "");
                            HSSFCell cell5 = row.createCell((short) 4);
                            cell5.setCellType(HSSFCell.CELL_TYPE_STRING);
                            cell5.setCellValue("Avg Sales in " + V_Pev_mon_name + " ");
                            int b = 1;
                            while (RS.next()) {
                        %>
                        <tr class="odd">
                            <td align="left"><a href="AdminReport.jsp?Value1=<%=RS.getString(1)%>&Value2=<%=RS.getString(2)%>" style="color :#00FFF" style="text-decoration:none"><%=RS.getString(1)%></a></td>
                                <TD align="left"><%=(RS.getString(2))%></td>
                                <TD align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=(RS.getString(3))%>" /> </td>
                                <TD align="right"><%=(RS.getString(4))%></td>
                                <TD align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=(RS.getString(5))%>" /> </td>
                            </tr>
                            <%
                                    cell = new PdfPCell(new Phrase(RS.getString(1)));
                                    table.addCell(cell);
                                    cell = new PdfPCell(new Phrase(RS.getString(2)));
                                    table.addCell(cell);
                                    cell = new PdfPCell(new Phrase(RS.getString(3)));
                                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                    table.addCell(cell);
                                    cell = new PdfPCell(new Phrase(RS.getString(4)));
                                    table.addCell(cell);
                                    cell = new PdfPCell(new Phrase(RS.getString(5)));
                                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                    table.addCell(cell);

                                    row = sheet.createRow(b);
                                    row.createCell((short) 0).setCellValue(RS.getString(1));
                                    row.createCell((short) 1).setCellValue(RS.getString(2));
                                    row.createCell((short) 2).setCellValue(RS.getString(3));
                                    row.createCell((short) 3).setCellValue(RS.getString(4));
                                    row.createCell((short) 4).setCellValue(RS.getString(5));
                                    b++;
                                }
                                d.add(table);
                                d.close();
                                workbook.write(fileOut);
                                fileOut.close();
                            %>
                        </table>
                        <%    DecimalFormat df = new DecimalFormat("##,###.##");
                            df.setMaximumFractionDigits(2);%>
                        <center><div style="color: darkred;"><h3><b><%
                            out.println(V_Pev_mon_name + " Sales Across All Stores (In LKR) :-");
                            out.println(df.format(V_Sum));
                                    %></b></h3></div>
                        <center>
                            <input  name="mail"  type="submit"  value="Email As PDF"> 
                            <input  name="mailXls"   type="submit"  value="Email As XLS"> 
                        </center>
                        <div id="pageNavPosition" style="padding-top: 20px" align="center">
                            </div>

                            <% }

                            } else {
                            %>
                            <table style="white-space: nowrap;" border="1" align="center" id="tablepaging"  width="20%">
                            <tr class="even">
                                <td>
                                    <input type="radio" name="month" value="current" onclick="this.form.submit()"checked  />Current Month
                                    <input type="radio" name="month" value="previous" onclick="this.form.submit()"  />Previous Month
                                </td>
                            </tr>
                        </table>

                        <%
                            String V_Curr = "";
                            String V_First = "";
                            String dateselect = "";
                            String monthselect = "";
                            String yearselect = "";
                            int V_Count = 0;
                            float V_Sum = 0;
                            float V_Sum_Mon = 0;
                            String V_Sum_Array[] = new String[100];
                            String V_Sum_Mon_Array[] = new String[100];
                            Class.forName("com.ibm.db2.jcc.DB2Driver");
                            Connection con1 = DriverManager.getConnection("jdbc:db2://awh-yp-small03.services.dal.bluemix.net:50000/BLUDB:user=dash107813;password=MxX8ewhhVg7f;");
                            Statement stm = con1.createStatement();
                            Statement stm1 = con1.createStatement();
                            Statement stmt = con1.createStatement();

                            ResultSet RSDate = stmt.executeQuery("select first_day(current_date),MONTHNAME (current_date), current_date,year(current_date) FROM sysibm.sysdummy1");
                            while (RSDate.next()) {
                                V_First = RSDate.getString(1);
                                monthselect = RSDate.getString(2);
                                V_Curr = RSDate.getString(3);
                                yearselect = RSDate.getString(4);
                            }
                            ResultSet RS = stm.executeQuery(" select thirdset.thirdstoreid,thirdset.thirdstorename,"
                                    + "COALESCE(firstset.DailySales,0),COALESCE(firstset.TodayBillNos,0),"
                                    + "COALESCE(round((firstset.dailysales/firstset.todaybillnos),2),0) "
                                    + "as Avg,COALESCE( secondset.MonthlySales,0),"
                                    + "COALESCE(secondset.MonthlyBillNos,0),"
                                    + "COALESCE(round((secondset.monthlysales/secondset.monthlybillnos),2),0) "
                                    + "as monthlyavg from (select retail_store.store_id as firststoreid,"
                                    + "retail_store.Str_nm as storename,sum(retail_str_sales_master.Grand_total) "
                                    + "as DailySales, count(retail_str_sales_master.tri_id) "
                                    + "as TodayBillNos from retail_store,"
                                    + "retail_str_sales_master "
                                    + "where retail_store.Store_id = retail_str_sales_master.Store_id "
                                    + "and retail_str_sales_master.Sale_date LIKE CURRENT_DATE "
                                    + "group by retail_store.Store_id,retail_store.Str_nm ) "
                                    + "as firstset full outer join (select retail_store.store_id "
                                    + "as secstoreid,retail_store.Str_nm "
                                    + "as secondstorename,sum(retail_str_sales_master.Grand_total) "
                                    + "as MonthlySales, count(retail_str_sales_master.tri_id) "
                                    + "as MonthlyBillNos from retail_store,retail_str_sales_master "
                                    + "where retail_store.Store_id = retail_str_sales_master.Store_id "
                                    + "and retail_str_sales_master.Sale_date "
                                    + "Between '" + V_First + "' "
                                    + "and '" + V_Curr + "' "
                                    + "group by retail_store.Store_id,retail_store.Str_nm) "
                                    + "as secondset on firstset.firststoreid = secondSet.secstoreid "
                                    + "full outer join (select retail_store.store_id "
                                    + "as thirdstoreid,retail_store.Str_nm as thirdstorename,"
                                    + "sum(retail_str_sales_master.Grand_total) as "
                                    + "MonthlySales,count(retail_str_sales_master.tri_id) as "
                                    + "MonthlyBillNos from retail_store,retail_str_sales_master "
                                    + "where retail_store.Store_id = retail_str_sales_master.Store_id "
                                    + "and retail_str_sales_master.Sale_date between '2016-10-01' "
                                    + "and CURRENT_DATE group by retail_store.Store_id,retail_store.Str_nm) "
                                    + "as thirdset on thirdset.thirdstoreid = secondset.secstoreid  ");
                            ResultSet RS1 = stm1.executeQuery("  select thirdset.thirdstoreid,thirdset.thirdstorename,"
                                    + "COALESCE(firstset.DailySales,0),COALESCE(firstset.TodayBillNos,0),"
                                    + "COALESCE(round((firstset.dailysales/firstset.todaybillnos),2),0) "
                                    + "as Avg,COALESCE( secondset.MonthlySales,0),"
                                    + "COALESCE(secondset.MonthlyBillNos,0),"
                                    + "COALESCE(round((secondset.monthlysales/secondset.monthlybillnos),2),0) "
                                    + "as monthlyavg from (select retail_store.store_id as firststoreid,"
                                    + "retail_store.Str_nm as storename,sum(retail_str_sales_master.Grand_total) "
                                    + "as DailySales, count(retail_str_sales_master.tri_id) "
                                    + "as TodayBillNos from retail_store,"
                                    + "retail_str_sales_master "
                                    + "where retail_store.Store_id = retail_str_sales_master.Store_id "
                                    + "and retail_str_sales_master.Sale_date LIKE CURRENT_DATE "
                                    + "group by retail_store.Store_id,retail_store.Str_nm ) "
                                    + "as firstset full outer join (select retail_store.store_id "
                                    + "as secstoreid,retail_store.Str_nm "
                                    + "as secondstorename,sum(retail_str_sales_master.Grand_total) "
                                    + "as MonthlySales, count(retail_str_sales_master.tri_id) "
                                    + "as MonthlyBillNos from retail_store,retail_str_sales_master "
                                    + "where retail_store.Store_id = retail_str_sales_master.Store_id "
                                    + "and retail_str_sales_master.Sale_date "
                                    + "Between '" + V_First + "' "
                                    + "and '" + V_Curr + "' "
                                    + "group by retail_store.Store_id,retail_store.Str_nm) "
                                    + "as secondset on firstset.firststoreid = secondSet.secstoreid "
                                    + "full outer join (select retail_store.store_id "
                                    + "as thirdstoreid,retail_store.Str_nm as thirdstorename,"
                                    + "sum(retail_str_sales_master.Grand_total) as "
                                    + "MonthlySales,count(retail_str_sales_master.tri_id) as "
                                    + "MonthlyBillNos from retail_store,retail_str_sales_master "
                                    + "where retail_store.Store_id = retail_str_sales_master.Store_id "
                                    + "and retail_str_sales_master.Sale_date between '2016-10-01' "
                                    + "and CURRENT_DATE group by retail_store.Store_id,retail_store.Str_nm) "
                                    + "as thirdset on thirdset.thirdstoreid = secondset.secstoreid  ");

                            //                   
                            while (RS1.next()) {
                                V_Sum_Array[V_Count] = RS1.getString(3);
                                V_Sum_Mon_Array[V_Count] = RS1.getString(6);
                                V_Count++;
                            }
                            for (int m = 0; m < V_Count; m++) {
                                V_Sum = V_Sum + Float.parseFloat(V_Sum_Array[m]);
                                V_Sum_Mon = V_Sum_Mon + Float.parseFloat(V_Sum_Mon_Array[m]);
                            }
                            //      out.println(V_Sum);
%>

                        <br>
                        <table style="white-space: nowrap;" border="1" align="center" id="tablepaging">
                            <tr class="even">
                                <th >Store Id</th>
                                <th >Store Name</th>
                                <th >Sales Value On <%=V_Curr%></th>
                                <th >Bills On <%=V_Curr%></th>
                                <th >Avg Sales On <%=V_Curr%></th>
                                <th >Sales in <%=monthselect%></th>
                                <th>Bills in <%=monthselect%> </th>
                                <th >Avg Sales in <%=monthselect%></th>
                            </tr>

                            <%
                                Document d = new Document(PageSize.A4);
                                OutputStream file = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.pdf");
                              //  OutputStream file = new FileOutputStream("PDF/Report.pdf");
                                PdfWriter.getInstance(d, file);
                                d.open();
                                Image image1 = Image.getInstance("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/src/logo.jpg");
                                //Image image1 = Image.getInstance("src/logo.jpg");
                                image1.setAlignment(Element.ALIGN_LEFT);
                                d.add(image1);
                                float[] columnWidths = new float[]{40f, 40f, 40f, 40f, 40f, 40f, 40f, 40f};
                                PdfPTable table = new PdfPTable(columnWidths);
                                table.setWidths(columnWidths);
                                table.setWidthPercentage(90f);
                                PdfPCell cell = new PdfPCell();
                                table.addCell("    Store Id");
                                table.addCell("    Store Name");
                                table.addCell("Sales Value On " + V_Curr +"");
                                table.addCell("Bills On" + V_Curr +"");
                                table.addCell("Avg Sales On" + V_Curr +"");
                                table.addCell("Sales in " + monthselect + "");
                                table.addCell("No of Bills in " + monthselect + "");
                                table.addCell("Avg Sales in " + monthselect + "");
                                  FileOutputStream fileOut = new FileOutputStream("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.xls");
                                //FileOutputStream fileOut = new FileOutputStream("PDF/Report.xls");
                                HSSFWorkbook workbook = new HSSFWorkbook();
                                HSSFSheet sheet = workbook.createSheet("New Sheet");
                                HSSFRow row = sheet.createRow((short) 0);
                                HSSFFont font = workbook.createFont();
                                font.setColor(HSSFFont.COLOR_RED);
                                font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                                HSSFCell cell1 = row.createCell((short) 0);
                                cell1.setCellType(HSSFCell.CELL_TYPE_STRING);
                                cell1.setCellValue(" Store Id");
                                HSSFCell cell2 = row.createCell((short) 1);
                                cell2.setCellType(HSSFCell.CELL_TYPE_STRING);
                                cell2.setCellValue("Store Name");
                                HSSFCell cell3 = row.createCell((short) 2);
                                cell3.setCellType(HSSFCell.CELL_TYPE_STRING);
                                cell3.setCellValue("Sales Value On " + V_Curr +"");
                                HSSFCell cell4 = row.createCell((short) 3);
                                cell4.setCellType(HSSFCell.CELL_TYPE_STRING);
                                cell4.setCellValue("Bills On " + V_Curr +"");
                                HSSFCell cell5 = row.createCell((short) 4);
                                cell5.setCellType(HSSFCell.CELL_TYPE_STRING);
                                cell5.setCellValue("Avg Sales On " + V_Curr +" ");
                                HSSFCell cell6 = row.createCell((short) 5);
                                cell6.setCellType(HSSFCell.CELL_TYPE_STRING);
                                cell6.setCellValue("Sales in " + monthselect + "");
                                HSSFCell cell7 = row.createCell((short) 6);
                                cell7.setCellType(HSSFCell.CELL_TYPE_STRING);
                                cell7.setCellValue("No of Bills in " + monthselect + "");
                                HSSFCell cell8 = row.createCell((short) 7);
                                cell8.setCellType(HSSFCell.CELL_TYPE_STRING);
                                cell8.setCellValue("Avg Sales in " + monthselect + " ");
                                int b = 1;
                                while (RS.next()) {
                            %>
                            <tr class="odd">
                                <td align="left"><a href="AdminReport.jsp?Value1=<%=RS.getString(1)%>&Value2=<%=RS.getString(2)%>" style="color :#00FFF" style="text-decoration:none"><%=RS.getString(1)%></a></td>
                                    <TD align="left"><%=(RS.getString(2))%></td>
                                    <TD align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=(RS.getString(3))%>" /> </td>
                                    <TD align="right"><%=(RS.getString(4))%></td>
                                    <TD align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=(RS.getString(5))%>" /> </td>
                                    <TD align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=(RS.getString(6))%>" /> </td>
                                    <TD align="right"><%=(RS.getString(7))%></td>
                                    <TD align="right"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2"  groupingUsed="true" value="<%=(RS.getString(8))%>" /> </td>

                                </tr>
                                <%
                                        cell = new PdfPCell(new Phrase(RS.getString(1)));
                                        table.addCell(cell);
                                        cell = new PdfPCell(new Phrase(RS.getString(2)));
                                        table.addCell(cell);
                                        cell = new PdfPCell(new Phrase(RS.getString(3)));
                                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                        table.addCell(cell);
                                        cell = new PdfPCell(new Phrase(RS.getString(4)));
                                        table.addCell(cell);
                                        cell = new PdfPCell(new Phrase(RS.getString(5)));
                                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                        table.addCell(cell);
                                        cell = new PdfPCell(new Phrase(RS.getString(6)));
                                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                        table.addCell(cell);
                                        cell = new PdfPCell(new Phrase(RS.getString(7)));
                                        table.addCell(cell);
                                        cell = new PdfPCell(new Phrase(RS.getString(8)));
                                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                                        table.addCell(cell);

                                        row = sheet.createRow(b);
                                        row.createCell((short) 0).setCellValue(RS.getString(1));
                                        row.createCell((short) 1).setCellValue(RS.getString(2));
                                        row.createCell((short) 2).setCellValue(RS.getString(3));
                                        row.createCell((short) 3).setCellValue(RS.getString(4));
                                        row.createCell((short) 4).setCellValue(RS.getString(5));
                                        row.createCell((short) 5).setCellValue(RS.getString(6));
                                        row.createCell((short) 6).setCellValue(RS.getString(7));
                                        row.createCell((short) 7).setCellValue(RS.getString(8));
                                        b++;
                                    }
                                    d.add(table);
                                    d.close();
                                    workbook.write(fileOut);
                                    fileOut.close(); %>
                            </table>
                            <%    DecimalFormat df = new DecimalFormat("##,###.##");
                                df.setMaximumFractionDigits(2);%>
                            <center><div style="color: darkred;"><h3><b><%
                                out.println("Daily Sales Across All Stores (In LKR) :-");
                                out.println(df.format(V_Sum));
                                out.println("  ,   Monthly Sales Across All Stores (In LKR):- ");
                                out.println(df.format(V_Sum_Mon));  %></b></h3></div>
                            <center>
                                <input  name="mail"  type="submit"  value="Email As PDF"> 
                                <input  name="mailXls"   type="submit"  value="Email As XLS"> 
                            </center>
                            <div id="pageNavPosition" style="padding-top: 20px" align="center">
                                </div>
                                <%
                                    }
                                    if ((request.getParameter("mail") != null)) {
                                %>

                                <%
                                        SendGrid sendgrid = new SendGrid("alokjay2805@gmail.com", "keyway12");
                                        SendGrid.Email email = new SendGrid.Email();
                                        //email.addAttachment("Report.pdf", new File("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.pdf"));
                                        email.addAttachment("Report.pdf", new File("PDF/Report.pdf"));
                                        email.addTo(mailid);
                                        email.setFrom("no-reply@99Retail.com");
                                        email.setFromName("99 Retail Solutions Pvt Ltd");
                                        email.setSubject("Reports");
                                        email.setHtml("<html><body><table<tr><td>Dear ,</td></tr><br><tr><td></td> </tr><br><tr> <td>Regards,</td></tr><br><tr><td></td></tr></table></body><html>");
                                        String content = "Please find the attachment";
                                        email.setHtml(content);
                                        email.setHtml(content);

                                        try {
                                            SendGrid.Response response1 = sendgrid.send(email);

                                        } catch (SendGridException e) {

                                            e.printStackTrace();
                                        }
                                    }
                                %>
                                <%
                                    if ((request.getParameter("mailXls") != null)) {
                                        SendGrid sendgrid = new SendGrid("alokjay2805@gmail.com", "keyway12");
                                        SendGrid.Email email = new SendGrid.Email();
                                        // email.addAttachment("Report.xls", new File("/home/rspl-laxmeechandola/NetBeansProjects/99AR_dashdb/web/PDF/Report.xls"));
                                        email.addAttachment("Report.xls", new File("PDF/Report.xls"));
                                        email.addTo(mailid);
                                        email.setFrom("no-reply@99Retail.com");
                                        email.setFromName("99 Retail Solutions Pvt Ltd");
                                        email.setSubject("Reports");
                                        email.setHtml("<html><body><table<tr><td>Dear ,</td></tr><br><tr><td></td> </tr><br><tr> <td>Regards,</td></tr><br><tr><td></td></tr></table></body><html>");
                                        String content = "Please find the attachment";
                                        email.setHtml(content);
                                        email.setHtml(content);
                                        try {
                                            SendGrid.Response response1 = sendgrid.send(email);

                                        } catch (SendGridException e) {

                                            e.printStackTrace();
                                        }

                                    }%>
                                <script type="text/javascript">
                                    var pager = new Pager('tablepaging', 10);
                                    pager.init();
                                    pager.showPageNav('pager', 'pageNavPosition');
                                    pager.showPage(1);
                                </script>
                                <%--
                                <%@ include file="Footer.html" %>
                                --%>
                                </form>

                                </body>
                                </html>	