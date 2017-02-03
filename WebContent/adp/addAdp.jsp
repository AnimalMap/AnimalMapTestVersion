<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.adp.model.*"%>
<%
AdpVO adpVO = (AdpVO) request.getAttribute("adpVO");
%>

<html>
<head>
<title>領養活動新增 - addAdp.jsp</title></head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/calendar.css">
<%@include file="/js/calendarcode.jsp"%>

<div id="popupcalendar" class="text"></div>

<body bgcolor='white'>

<table border='1' cellpadding='5' cellspacing='0' width='800'>
	<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
		<td>
		<h3>領養活動新增 - addAdp.jsp</h3>
		</td>
		<td>
		   <a href="<%=request.getContextPath()%>/adp/select_page.jsp"><img src="<%=request.getContextPath()%>/images/tomcat.gif" width="100" height="100" border="1">回首頁</a>
	    </td>
	</tr>
</table>

<h3>領養活動:</h3>
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

<FORM METHOD="post" ACTION="adp.do" name="form1">
<table border="0">
	<tr>
		<td>發布會員編號:</td>
		<td><input type="TEXT" name="mem_Id" size="45"
			value="<%= (adpVO==null)? "1" : adpVO.getMem_Id()%>" /></td>
	</tr>
	<tr>
		<td>領養活動標題:</td>
		<td><input type="TEXT" name="adp_title" size="45"
			value="<%= (adpVO==null)? "1" : adpVO.getAdp_title()%>" /></td>
	</tr>
	<tr>
		<td>領養活動內容:</td>
		<td><input type="TEXT" name="adp_adp_content" size="45"
			value="<%= (adpVO==null)? "1" : adpVO.getAdp_adp_content()%>" /></td>
	</tr>
	<tr>
		<%java.sql.Date date_adp_start_date = new java.sql.Date(System.currentTimeMillis());%>
		<td>領養活動發布時間:</td>
		<td bgcolor="#CCCCFF">
		    <input class="cal-TextBox"
			onFocus="this.blur()" size="9" readonly type="text" name="adp_start_date" value="<%= (adpVO==null)? date_adp_start_date : adpVO.getAdp_start_date()%>">
			<a class="so-BtnLink"
			href="javascript:calClick();return false;"
			onmouseover="calSwapImg('BTN_date', 'img_Date_OVER',true);"
			onmouseout="calSwapImg('BTN_date', 'img_Date_UP',true);"
			onclick="calSwapImg('BTN_date', 'img_Date_DOWN');showCalendar('form1','adp_start_date','BTN_date');return false;">
		    <img align="middle" border="0" name="BTN_date"	src="<%=request.getContextPath()%>/images/btn_date_up.gif" width="22" height="17" alt="領養活動發布時間"></a>
		</td>
	</tr>
	<tr>
		<%java.sql.Date date_adp_end_date = new java.sql.Date(System.currentTimeMillis());%>
		<td>領養活動到期時間:</td>
		<td bgcolor="#CCCCFF">
		    <input class="cal-TextBox"
			onFocus="this.blur()" size="9" readonly type="text" name="adp_end_date" value="<%= (adpVO==null)? date_adp_end_date : adpVO.getAdp_end_date()%>">
			<a class="so-BtnLink"
			href="javascript:calClick();return false;"
			onmouseover="calSwapImg('BTN_date', 'img_Date_OVER',true);"
			onmouseout="calSwapImg('BTN_date', 'img_Date_UP',true);"
			onclick="calSwapImg('BTN_date', 'img_Date_DOWN');showCalendar('form1','adp_end_date','BTN_date');return false;">
		    <img align="middle" border="0" name="BTN_date"	src="<%=request.getContextPath()%>/images/btn_date_up.gif" width="22" height="17" alt="領養活動到期時間"></a>
		</td>
	</tr>
	<tr>
		<%java.sql.Date date_adp_upDate = new java.sql.Date(System.currentTimeMillis());%>
		<td>領養活動更新時間:</td>
		<td bgcolor="#CCCCFF">
		    <input class="cal-TextBox"
			onFocus="this.blur()" size="9" readonly type="text" name="adp_upDate" value="<%= (adpVO==null)? date_adp_upDate : adpVO.getAdp_upDate()%>">
			<a class="so-BtnLink"
			href="javascript:calClick();return false;"
			onmouseover="calSwapImg('BTN_date', 'img_Date_OVER',true);"
			onmouseout="calSwapImg('BTN_date', 'img_Date_UP',true);"
			onclick="calSwapImg('BTN_date', 'img_Date_DOWN');showCalendar('form1','adp_upDate','BTN_date');return false;">
		    <img align="middle" border="0" name="BTN_date"	src="<%=request.getContextPath()%>/images/btn_date_up.gif" width="22" height="17" alt="領養活動更新時間"></a>
		</td>
	</tr>
	<tr>
		<td>縣市:</td>
		<td><input type="TEXT" name="adp_city" size="45"
			value="<%= (adpVO==null)? "1" : adpVO.getAdp_city()%>" /></td>
	</tr>
	<tr>
		<td>鄉鎮市區:</td>
		<td><input type="TEXT" name="adp_town" size="45"
			value="<%= (adpVO==null)? "1" : adpVO.getAdp_town()%>" /></td>
	</tr>
	<tr>
		<td>道路街名村里:</td>
		<td><input type="TEXT" name="adp_road" size="45"
			value="<%= (adpVO==null)? "1" : adpVO.getAdp_road()%>" /></td>
	</tr>
	<tr>
		<td>領養活動經度座標:</td>
		<td><input type="TEXT" name="adp_lon" size="45"
			value="<%= (adpVO==null)? "1" : adpVO.getAdp_lon()%>" /></td>
	</tr>
	<tr>
		<td>緯度座標緯度座標:</td>
		<td><input type="TEXT" name="adp_lat" size="45"
			value="<%= (adpVO==null)? "1" : adpVO.getAdp_lat()%>" /></td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
</body>

</html>
