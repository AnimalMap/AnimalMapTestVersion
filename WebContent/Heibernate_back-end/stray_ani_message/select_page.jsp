<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>表格 Stray_Ani_message: Home</title>
	<!-- 共用HEAD -->
	<!-- BS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/Heibernate_back-end/css/calendar.css">
	<%@include file="/Heibernate_back-end/js/calendarcode.jsp"%>
</head>
<body bgcolor='white'>
<div id="popupcalendar" class="text"></div>
<table class="table"  border='1' cellpadding='5' cellspacing='0' width='400'>
  <tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
    <td>
    <h3>表格 Stray_Ani_message: Home</h3><font color=red>( MVC )</font>
    </td>
  </tr>
</table>
<hr>
<h2>社區流浪動物留言資料查詢:</h2>
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
  <li><a href='<%=request.getContextPath()%>/Heibernate_back-end/stray_ani_message/listAllStray_Ani_message.jsp'>List</a> all Stray_Ani_messages. </li> <br><br>
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Heibernate_back-end/stray_ani_message/stray_ani_message.do" >
        <b>輸入社區流浪動物留言編號 (如7001):</b>
        <input type="text" name="str_Ani_Mes_No">
        <input type="submit" value="送出">
        <input type="hidden" name="action" value="getOne_For_Display">
    </FORM>
  </li>
  <jsp:useBean id="stray_ani_messageSvc" scope="page" class="heibernate_com.stray_ani_message.model.Stray_Ani_messageService" />
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Heibernate_back-end/stray_ani_message/stray_ani_message.do" >
       <b>選擇社區流浪動物留言編號:</b>
       <select size="1" name="str_Ani_Mes_No">
         <c:forEach var="stray_ani_messageVO" items="${stray_ani_messageSvc.all}" > 
          <option value="${stray_ani_messageVO.str_Ani_Mes_No}">${stray_ani_messageVO.str_Ani_Mes_No}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="getOne_For_Display">
    </FORM>
  </li>
   <jsp:useBean id="stray_aniSvc" scope="page" class="heibernate_com.stray_ani.model.Stray_AniService" />
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Heibernate_back-end/stray_ani_message/stray_ani_message.do" >
     	<div class="form-group">
	       <b><font color=orange>選擇社區動物編號:</font></b>
	       <select size="1" name="stray_Ani_Id">
	         <c:forEach var="stray_aniVO" items="${stray_aniSvc.all}" > 
	          <option value="${stray_aniVO.stray_Ani_Id}">${stray_aniVO.stray_Ani_Id}
	         </c:forEach>   
	       </select>
	       <input type="submit" value="送出">
	       <input type="hidden" name="action" value="listStray_Ani_messages_ByStray_Ani_Id_A">
       	</div>
     </FORM>
  </li>
   <jsp:useBean id="memSvc" scope="page" class="heibernate_com.mem.model.MemService" />
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Heibernate_back-end/stray_ani_message/stray_ani_message.do" >
     	<div class="form-group">
	       <b><font color=orange>選擇發布者會員編號:</font></b>
	       <select size="1" name="mem_Id">
	         <c:forEach var="memVO" items="${memSvc.all}" > 
	          <option value="${memVO.mem_Id}">${memVO.mem_Id}
	         </c:forEach>   
	       </select>
	       <input type="submit" value="送出">
	       <input type="hidden" name="action" value="listStray_Ani_messages_ByMem_Id_A">
       	</div>
     </FORM>
  </li>
</ul>
<%-- 萬用複合查詢-以下欄位-可隨意增減 --%>
<ul>  
  <li>   
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Heibernate_back-end/stray_ani_message/stray_ani_message.do" name="form1">
      <b><font color=blue>萬用複合查詢:</font></b> <br>
       <b>選擇流浪動物留言編號編號:</b>
       <select size="1" name="str_Ani_Mes_No">
            <option value=""/>
         <c:forEach var="stray_ani_messageVO" items="${stray_ani_messageSvc.all}" > 
          <option value="${stray_ani_messageVO.str_Ani_Mes_No}">${stray_ani_messageVO.str_Ani_Mes_No}
         </c:forEach>   
       </select>   
       <br>  
       <b>選擇社區動物編號編號:</b>
       <select size="1" name="stray_Ani_Id">
         <c:forEach var="stray_AniVO" items="${stray_AniSvc.all}" > 
          <option value="${stray_AniVO.stray_Ani_Id}">${stray_AniVO.stray_Ani_Id}
         </c:forEach>   
       </select>
       <br> 
       <b>選擇發布者會員編號編號:</b>
       <select size="1" name="mem_Id">
         <c:forEach var="memVO" items="${memSvc.all}" > 
          <option value="${memVO.mem_Id}">${memVO.mem_Id}
         </c:forEach>   
       </select>
       <br> 
        <b>發布時間:</b>
        <input class="cal-TextBox" onFocus="this.blur()" size="9" readonly type="text" name="str_Ani_Mes_time" value="">
        <a class="so-BtnLink" href="javascript:calClick();return false;" 
        	onmouseover="calSwapImg('BTN_date', 'img_Date_OVER',true);" 
        	onmouseout="calSwapImg('BTN_date', 'img_Date_UP',true);" 
        	onclick="calSwapImg('BTN_date', 'img_Date_DOWN');showCalendar('form1','str_Ani_Mes_time','BTN_date');return false;"
        >
            <img align="middle" border="0" name="BTN_date"  src="<%=request.getContextPath()%>/Heibernate_back-end/images/btn_date_up.gif" width="22" height="17" alt="發布時間">
        </a>
        <br>
      <input type="submit" value="送出">
      <input type="hidden" name="action" value="list_ByCompositeQuery">
    </FORM>
  </li>
</ul>
<hr>
<!--  -->
<h3>社區流浪動物留言管理</h3>
<ul>
  <li><a href='<%=request.getContextPath()%>/Heibernate_back-end/stray_ani_message/addStray_Ani_message.jsp'>Add</a> a new Stray_Ani_message.</li>
</ul>
<!--  -->
	    <hr>
	    <h3><font color=orange>Stray_Ani管理</font></h3>
	    <ul>
	      <li><a href='<%=request.getContextPath()%>/Heibernate_back-end/stray_ani/listAllStray_Ani.jsp'>List</a> all Stray_Anis. </li>
	    </ul>
	    <hr>
	    <h3><font color=orange>Mem管理</font></h3>
	    <ul>
	      <li><a href='<%=request.getContextPath()%>/Heibernate_back-end/mem/listAllMem.jsp'>List</a> all Mems. </li>
	    </ul>
<!--  -->
</body>
</html>
