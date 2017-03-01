<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="heibernate_com.adopt_ani.model.*"%>
<%
Adopt_AniVO adopt_aniVO = (Adopt_AniVO) request.getAttribute("adopt_aniVO");
%>
<html>
<head>
<title>送養動物新增 - addAdopt_Ani.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/Heibernate_back-end/css/calendar.css">
<%@include file="/Heibernate_back-end/js/calendarcode.jsp"%>
	<!-- 共用HEAD -->
	<!-- BS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery.js"></script>
</head>
<body bgcolor='white'>
<!--  -->
<div id="popupcalendar" class="text"></div>
<table border='1' cellpadding='5' cellspacing='0' width='800'>
	<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
		<td>
		<h3>送養動物新增 - addAdopt_Ani.jsp</h3>
		</td>
		<td>
		   <a href="<%=request.getContextPath()%>/Heibernate_back-end/adopt_ani/select_page.jsp"><img src="<%=request.getContextPath()%>/images/tomcat.gif" width="100" height="100" border="1">回首頁</a>
	    </td>
	</tr>
</table>
<h3>送養動物:</h3>
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
<FORM METHOD="post" ACTION="adopt_ani.do" name="form1">
<table border="0">
	<jsp:useBean id="memSvc" scope="page" class="heibernate_com.mem.model.MemService" />
	<tr>
		<td>發布者會員編號:<font color=red><b>*</b></font></td>
		<td><select size="1" name="mem_Id">
			<c:forEach var="memVO" items="${memSvc.all}">
				<option value="${memVO.mem_Id}" ${(adopt_aniVO.memVO.mem_Id==memVO.mem_Id)? 'selected':'' } >${memVO.mem_Id}
			</c:forEach>
		</select></td>
	</tr>
	<tr>
		<td>送養動物名字:</td>
		<td><input type="TEXT" name="adopt_Ani_name" size="45"
			value="<%= (adopt_aniVO==null)? "1" : adopt_aniVO.getAdopt_Ani_name()%>" /></td>
	</tr>	
	<tr>
		<td>送養動物動物種類:</td>
		<td><input type="TEXT" name="adopt_Ani_type" size="45"
			value="<%= (adopt_aniVO==null)? "1" : adopt_aniVO.getAdopt_Ani_type()%>" /></td>
	</tr>	
	<tr>
		<td>送養動物性別:</td>
		<td><input type="TEXT" name="adopt_Ani_gender" size="45"
			value="<%= (adopt_aniVO==null)? "1" : adopt_aniVO.getAdopt_Ani_gender()%>" /></td>
	</tr>	
	<tr>
		<td>送養動物健康狀況:</td>
		<td><input type="TEXT" name="adopt_Ani_heal" size="45"
			value="<%= (adopt_aniVO==null)? "1" : adopt_aniVO.getAdopt_Ani_heal()%>" /></td>
	</tr>	
	<tr>
		<td>送養動物疫苗接踵:</td>
		<td><input type="TEXT" name="adopt_Ani_Vac" size="45"
			value="<%= (adopt_aniVO==null)? "1" : adopt_aniVO.getAdopt_Ani_Vac()%>" /></td>
	</tr>	
	<tr>
		<td>送養動物毛色:</td>
		<td><input type="TEXT" name="adopt_Ani_color" size="45"
			value="<%= (adopt_aniVO==null)? "1" : adopt_aniVO.getAdopt_Ani_color()%>" /></td>
	</tr>	
	<tr>
		<td>送養動物體型:</td>
		<td><input type="TEXT" name="adopt_Ani_body" size="45"
			value="<%= (adopt_aniVO==null)? "1" : adopt_aniVO.getAdopt_Ani_body()%>" /></td>
	</tr>	
	<tr>
		<td>送養動物年齡:</td>
		<td><input type="TEXT" name="adopt_Ani_age" size="45"
			value="<%= (adopt_aniVO==null)? "1" : adopt_aniVO.getAdopt_Ani_age()%>" /></td>
	</tr>	
	<tr>
		<td>送養動物節育:</td>
		<td><input type="TEXT" name="adopt_Ani_Neu" size="45"
			value="<%= (adopt_aniVO==null)? "1" : adopt_aniVO.getAdopt_Ani_Neu()%>" /></td>
	</tr>	
	<tr>
		<td>送養動物晶片編號:</td>
		<td><input type="TEXT" name="adopt_Ani_chip" size="45"
			value="<%= (adopt_aniVO==null)? "1" : adopt_aniVO.getAdopt_Ani_chip()%>" /></td>
	</tr>	
	<tr>
		<%java.sql.Timestamp date_adopt_Ani_date = new java.sql.Timestamp(System.currentTimeMillis());%>
		<td>送養時間:</td>
		<td bgcolor="#CCCCFF">
		    <input class="cal-TextBox"
			onFocus="this.blur()" size="9" readonly type="text" name="adopt_Ani_date" value="<%= (adopt_aniVO==null)? date_adopt_Ani_date : adopt_aniVO.getAdopt_Ani_date()%>">
			<a class="so-BtnLink"
			href="javascript:calClick();return false;"
			onmouseover="calSwapImg('BTN_date', 'img_Date_OVER',true);"
			onmouseout="calSwapImg('BTN_date', 'img_Date_UP',true);"
			onclick="calSwapImg('BTN_date', 'img_Date_DOWN');showCalendar('form1','adopt_Ani_date','BTN_date');return false;">
		    <img align="middle" border="0" name="BTN_date"	src="/Excel2MVC/Heibernate_back-end/images/btn_date_up.gif" width="22" height="17" alt="送養時間"></a>
		</td>
	</tr>
	<tr>
		<td>送養動物物件狀態:</td>
		<td><input type="TEXT" name="adopt_Ani_status" size="45"
			value="<%= (adopt_aniVO==null)? "1" : adopt_aniVO.getAdopt_Ani_status()%>" /></td>
	</tr>	
	<tr>
		<%java.sql.Timestamp date_adopt_Ani_CreDate = new java.sql.Timestamp(System.currentTimeMillis());%>
		<td>送養動物建立時間:</td>
		<td bgcolor="#CCCCFF">
		    <input class="cal-TextBox"
			onFocus="this.blur()" size="9" readonly type="text" name="adopt_Ani_CreDate" value="<%= (adopt_aniVO==null)? date_adopt_Ani_CreDate : adopt_aniVO.getAdopt_Ani_CreDate()%>">
			<a class="so-BtnLink"
			href="javascript:calClick();return false;"
			onmouseover="calSwapImg('BTN_date', 'img_Date_OVER',true);"
			onmouseout="calSwapImg('BTN_date', 'img_Date_UP',true);"
			onclick="calSwapImg('BTN_date', 'img_Date_DOWN');showCalendar('form1','adopt_Ani_CreDate','BTN_date');return false;">
		    <img align="middle" border="0" name="BTN_date"	src="/Excel2MVC/Heibernate_back-end/images/btn_date_up.gif" width="22" height="17" alt="送養動物建立時間"></a>
		</td>
	</tr>
	<tr>
		<td>送養地點經度:</td>
		<td><input type="TEXT" name="adopt_Ani_FinLat" size="45"
			value="<%= (adopt_aniVO==null)? "1" : adopt_aniVO.getAdopt_Ani_FinLat()%>" /></td>
	</tr>	
	<tr>
		<td>送養地點緯度:</td>
		<td><input type="TEXT" name="adopt_Ani_FinLon" size="45"
			value="<%= (adopt_aniVO==null)? "1" : adopt_aniVO.getAdopt_Ani_FinLon()%>" /></td>
	</tr>	
	<tr>
		<td>縣/市:</td>
		<td><input type="TEXT" name="adopt_Ani_city" size="45"
			value="<%= (adopt_aniVO==null)? "1" : adopt_aniVO.getAdopt_Ani_city()%>" /></td>
	</tr>	
	<tr>
		<td>鄉鎮市區:</td>
		<td><input type="TEXT" name="adopt_Ani_town" size="45"
			value="<%= (adopt_aniVO==null)? "1" : adopt_aniVO.getAdopt_Ani_town()%>" /></td>
	</tr>	
	<tr>
		<td>道路街名村里:</td>
		<td><input type="TEXT" name="adopt_Ani_road" size="45"
			value="<%= (adopt_aniVO==null)? "1" : adopt_aniVO.getAdopt_Ani_road()%>" /></td>
	</tr>	
	<tr>
		<td>喜歡數:</td>
		<td><input type="TEXT" name="adopt_Ani_like" size="45"
			value="<%= (adopt_aniVO==null)? "1" : adopt_aniVO.getAdopt_Ani_like()%>" /></td>
	</tr>	
</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
</body>
</html>
