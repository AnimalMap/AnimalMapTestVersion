<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>表格 AdpPhotos: Home</title>
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
    <h3>表格 AdpPhotos: Home</h3><font color=red>( MVC )</font>
    </td>
  </tr>
</table>
<hr>
<h2>領養活動相簿資料查詢:</h2>
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
  <li><a href='<%=request.getContextPath()%>/Heibernate_back-end/adpphotos/listAllAdpPhotos.jsp'>List</a> all AdpPhotoss. </li> <br><br>
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Heibernate_back-end/adpphotos/adpphotos.do" >
        <b>輸入領養活動相簿編號 (如7001):</b>
        <input type="text" name="adpPhotos_Id">
        <input type="submit" value="送出">
        <input type="hidden" name="action" value="getOne_For_Display">
    </FORM>
  </li>
  <jsp:useBean id="adpphotosSvc" scope="page" class="heibernate_com.adpphotos.model.AdpPhotosService" />
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Heibernate_back-end/adpphotos/adpphotos.do" >
       <b>選擇領養活動相簿編號:</b>
       <select size="1" name="adpPhotos_Id">
         <c:forEach var="adpphotosVO" items="${adpphotosSvc.all}" > 
          <option value="${adpphotosVO.adpPhotos_Id}">${adpphotosVO.adpPhotos_Id}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="getOne_For_Display">
    </FORM>
  </li>
   <jsp:useBean id="adpSvc" scope="page" class="heibernate_com.adp.model.AdpService" />
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Heibernate_back-end/adpphotos/adpphotos.do" >
     	<div class="form-group">
	       <b><font color=orange>選擇領養活動編號:</font></b>
	       <select size="1" name="adp_Id">
	         <c:forEach var="adpVO" items="${adpSvc.all}" > 
	          <option value="${adpVO.adp_Id}">${adpVO.adp_Id}
	         </c:forEach>   
	       </select>
	       <input type="submit" value="送出">
	       <input type="hidden" name="action" value="listAdpPhotoss_ByAdp_Id_A">
       	</div>
     </FORM>
  </li>
</ul>
<%-- 萬用複合查詢-以下欄位-可隨意增減 --%>
<ul>  
  <li>   
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Heibernate_back-end/adpphotos/adpphotos.do" name="form1">
      <b><font color=blue>萬用複合查詢:</font></b> <br>
       <b>選擇領養活動相簿編號編號:</b>
       <select size="1" name="adpPhotos_Id">
            <option value=""/>
         <c:forEach var="adpphotosVO" items="${adpphotosSvc.all}" > 
          <option value="${adpphotosVO.adpPhotos_Id}">${adpphotosVO.adpPhotos_Id}
         </c:forEach>   
       </select>   
       <br>  
       <b>選擇領養活動編號編號:</b>
       <select size="1" name="adp_Id">
         <c:forEach var="adpVO" items="${adpSvc.all}" > 
          <option value="${adpVO.adp_Id}">${adpVO.adp_Id}
         </c:forEach>   
       </select>
       <br> 
      <input type="submit" value="送出">
      <input type="hidden" name="action" value="list_ByCompositeQuery">
    </FORM>
  </li>
</ul>
<hr>
<!--  -->
<h3>領養活動相簿管理</h3>
<ul>
  <li><a href='<%=request.getContextPath()%>/Heibernate_back-end/adpphotos/addAdpPhotos.jsp'>Add</a> a new AdpPhotos.</li>
</ul>
<!--  -->
	    <hr>
	    <h3><font color=orange>Adp管理</font></h3>
	    <ul>
	      <li><a href='<%=request.getContextPath()%>/Heibernate_back-end/adp/listAllAdp.jsp'>List</a> all Adps. </li>
	    </ul>
<!--  -->
</body>
</html>
