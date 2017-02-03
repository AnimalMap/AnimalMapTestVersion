<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>表格 Adopt_Ani_sponsor: Home</title></head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/calendar.css">
<%@include file="/js/calendarcode.jsp"%>
<div id="popupcalendar" class="text"></div>
<body bgcolor='white'>

<table border='1' cellpadding='5' cellspacing='0' width='400'>
  <tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
    <td><h3>表格 Adopt_Ani_sponsor: Home</h3><font color=red>( MVC )</font></td>
  </tr>
</table>

<p>This is the Home page for Adopt_Ani_sponsor: Home</p>

<hr>

<h3>送養動物贊助資料查詢:</h3>
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

<!--  -->
<ul>
  <li><a href='<%=request.getContextPath()%>/adopt_ani_sponsor/listAllAdopt_Ani_sponsor.jsp'>List</a> all Adopt_Ani_sponsors. </li> <br><br>
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/adopt_ani_sponsor/adopt_ani_sponsor.do" >
        <b>輸入送養動物贊助編號 (如7001):</b>
        <input type="text" name="ado_Ani_Spo_No">
        <input type="submit" value="送出">
        <input type="hidden" name="action" value="getOne_For_Display">
    </FORM>
  </li>

  <jsp:useBean id="adopt_ani_sponsorSvc" scope="page" class="com.adopt_ani_sponsor.model.Adopt_Ani_sponsorService" />

  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/adopt_ani_sponsor/adopt_ani_sponsor.do" >
       <b>選擇送養動物贊助編號:</b>
       <select size="1" name="ado_Ani_Spo_No">
         <c:forEach var="adopt_ani_sponsorVO" items="${adopt_ani_sponsorSvc.all}" > 
          <option value="${adopt_ani_sponsorVO.ado_Ani_Spo_No}">${adopt_ani_sponsorVO.ado_Ani_Spo_No}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="getOne_For_Display">
    </FORM>
  </li>

</ul>

<hr>

<!--  -->
<h3>送養動物贊助管理</h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/adopt_ani_sponsor/addAdopt_Ani_sponsor.jsp'>Add</a> a new Adopt_Ani_sponsor.</li>
</ul>

<!--  -->

</body>

</html>
