 <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.second_prodmsg.model.*"%>
<%
    Second_ProdMsgVO second_prodmsgVO = (Second_ProdMsgVO) request.getAttribute("second_prodmsgVO"); //Second_ProdMsgServlet.java (Concroller), 存入req的second_prodmsgVO物件 (包括幫忙取出的second_prodmsgVO, 也包括輸入資料錯誤時的second_prodmsgVO物件)
%>

<!--  -->

<html>
<head>
<title>二手商品留言資料修改 - update_second_prodmsg_input.jsp</title></head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<%@include file="/js/calendarcode.jsp"%>
<div id="popupcalendar" class="text"></div>

<body bgcolor='white'>

<table border='1' cellpadding='5' cellspacing='0' width='800'>
    <tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
        <td>
        <h3>二手商品留言資料 - ListOneSecond_ProdMsg.jsp</h3>
        <a href="<%=request.getContextPath()%>/second_prodmsg/select_page.jsp"><img src="<%=request.getContextPath()%>/images/back1.gif" width="100" height="32" border="0">回首頁</a>
        </td>
    </tr>
</table>

<h3>資料修改:</h3>
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
    <font color='red'>請修正以下錯誤:
    <ul>
        <c:forEach var="message" items="${errorMsgs}">
            <li>${message}</li>
        </c:forEach>
    </ul>
    </font>
</c:if>

<FORM METHOD="post" ACTION="second_prodmsg.do" name="form1">
    <table border="0">

    <!--  -->
        <tr>
        <td>二手商品留言編號編號:<font color=red><b>*</b></font></td>
        <td><%=second_prodmsgVO.getSecond_ProdMsg_Id()%></td>
    </tr>
    <tr>
        <td>二手商品編號:</td>
        <td><input type="TEXT" name="second_Prod_Id" size="45" value="<%=second_prodmsgVO.getSecond_Prod_Id()%>" /></td>
    </tr>
    <tr>
        <td>留言會員編號:</td>
        <td><input type="TEXT" name="mem_Id" size="45" value="<%=second_prodmsgVO.getMem_Id()%>" /></td>
    </tr>
    <tr>
        <td>二手商品留言:</td>
        <td><input type="TEXT" name="second_ProdMsg_Msg" size="45" value="<%=second_prodmsgVO.getSecond_ProdMsg_Msg()%>" /></td>
    </tr>
	<tr>
		<td>留言發布日期:</td>
		<td bgcolor="#CCCCFF">
		    <input class="cal-TextBox"
			onFocus="this.blur()" size="9" readonly type="text" name="second_ProdMsg_DATE" value="<%=second_prodmsgVO.getSecond_ProdMsg_DATE()%>">
			<a class="so-BtnLink"
			href="javascript:calClick();return false;"
			onmouseover="calSwapImg('BTN_date', 'img_Date_OVER',true);"
			onmouseout="calSwapImg('BTN_date', 'img_Date_UP',true);"
			onclick="calSwapImg('BTN_date', 'img_Date_DOWN');showCalendar('form1','second_ProdMsg_DATE','BTN_date');return false;">
		    <img align="middle" border="0" name="BTN_date"	src="<%=request.getContextPath()%>/images/btn_date_up.gif" width="22" height="17" alt="留言發布日期"></a>
		</td>
	</tr>
	<tr>
		<td>留言更新日期:</td>
		<td bgcolor="#CCCCFF">
		    <input class="cal-TextBox"
			onFocus="this.blur()" size="9" readonly type="text" name="second_ProdMsg_adp_upDate" value="<%=second_prodmsgVO.getSecond_ProdMsg_adp_upDate()%>">
			<a class="so-BtnLink"
			href="javascript:calClick();return false;"
			onmouseover="calSwapImg('BTN_date', 'img_Date_OVER',true);"
			onmouseout="calSwapImg('BTN_date', 'img_Date_UP',true);"
			onclick="calSwapImg('BTN_date', 'img_Date_DOWN');showCalendar('form1','second_ProdMsg_adp_upDate','BTN_date');return false;">
		    <img align="middle" border="0" name="BTN_date"	src="<%=request.getContextPath()%>/images/btn_date_up.gif" width="22" height="17" alt="留言更新日期"></a>
		</td>
	</tr>


    <!--  -->
    </table>
    <br>
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="second_ProdMsg_Id" value="<%=second_prodmsgVO.getSecond_ProdMsg_Id()%>">
    <input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"><!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
    <input type="hidden" name="whichPage" value="<%=request.getParameter("whichPage")%>">  <!--用於:istAllSecond_ProdMsg.jsp 與 複合查詢 listSecond_ProdMsgs_ByCompositeQuery.jsp-->
    <input type="submit" value="送出修改">
</FORM>

<br>送出修改的來源網頁路徑:<br><b>
   <font color=blue>request.getParameter("requestURL"):</font> <%= request.getParameter("requestURL")%><br>
</body>
</html>
