<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.stray_ani_message.model.*"%>
<%
Stray_Ani_messageVO stray_ani_messageVO = (Stray_Ani_messageVO) request.getAttribute("stray_ani_messageVO");
%>

<html>
<head>
<title>社區流浪動物留言新增 - addStray_Ani_message.jsp</title></head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/calendar.css">
<%@include file="/js/calendarcode.jsp"%>

<div id="popupcalendar" class="text"></div>

<body bgcolor='white'>

<table border='1' cellpadding='5' cellspacing='0' width='800'>
	<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
		<td>
		<h3>社區流浪動物留言新增 - addStray_Ani_message.jsp</h3>
		</td>
		<td>
		   <a href="<%=request.getContextPath()%>/stray_ani_message/select_page.jsp"><img src="<%=request.getContextPath()%>/images/tomcat.gif" width="100" height="100" border="1">回首頁</a>
	    </td>
	</tr>
</table>

<h3>社區流浪動物留言:</h3>
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

<FORM METHOD="post" ACTION="stray_ani_message.do" name="form1">
<table border="0">
	<tr>
		<td>社區動物編號:</td>
		<td><input type="TEXT" name="stray_Ani_Id" size="45"
			value="<%= (stray_ani_messageVO==null)? "1" : stray_ani_messageVO.getStray_Ani_Id()%>" /></td>
	</tr>
	<tr>
		<td>發布者會員編號:</td>
		<td><input type="TEXT" name="mem_Id" size="45"
			value="<%= (stray_ani_messageVO==null)? "1" : stray_ani_messageVO.getMem_Id()%>" /></td>
	</tr>
	<tr>
		<%java.sql.Date date_str_Ani_Mes_time = new java.sql.Date(System.currentTimeMillis());%>
		<td>發布時間:</td>
		<td bgcolor="#CCCCFF">
		    <input class="cal-TextBox"
			onFocus="this.blur()" size="9" readonly type="text" name="str_Ani_Mes_time" value="<%= (stray_ani_messageVO==null)? date_str_Ani_Mes_time : stray_ani_messageVO.getStr_Ani_Mes_time()%>">
			<a class="so-BtnLink"
			href="javascript:calClick();return false;"
			onmouseover="calSwapImg('BTN_date', 'img_Date_OVER',true);"
			onmouseout="calSwapImg('BTN_date', 'img_Date_UP',true);"
			onclick="calSwapImg('BTN_date', 'img_Date_DOWN');showCalendar('form1','str_Ani_Mes_time','BTN_date');return false;">
		    <img align="middle" border="0" name="BTN_date"	src="<%=request.getContextPath()%>/images/btn_date_up.gif" width="22" height="17" alt="發布時間"></a>
		</td>
	</tr>
	<tr>
		<td>流浪動物留言:</td>
		<td><input type="TEXT" name="str_Ani_Mes" size="45"
			value="<%= (stray_ani_messageVO==null)? "1" : stray_ani_messageVO.getStr_Ani_Mes()%>" /></td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
</body>

</html>
