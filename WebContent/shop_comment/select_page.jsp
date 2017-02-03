<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>表格 Shop_comment: Home</title></head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/calendar.css">
<%@include file="/js/calendarcode.jsp"%>
<div id="popupcalendar" class="text"></div>
<body bgcolor='white'>

<table border='1' cellpadding='5' cellspacing='0' width='400'>
  <tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
    <td><h3>表格 Shop_comment: Home</h3><font color=red>( MVC )</font></td>
  </tr>
</table>

<p>This is the Home page for Shop_comment: Home</p>

<hr>

<h3>商家留言資料查詢:</h3>
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
  <li><a href='<%=request.getContextPath()%>/shop_comment/listAllShop_comment.jsp'>List</a> all Shop_comments. </li> <br><br>
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/shop_comment/shop_comment.do" >
        <b>輸入商家留言編號 (如7001):</b>
        <input type="text" name="shopComm_Id">
        <input type="submit" value="送出">
        <input type="hidden" name="action" value="getOne_For_Display">
    </FORM>
  </li>

  <jsp:useBean id="shop_commentSvc" scope="page" class="com.shop_comment.model.Shop_commentService" />

  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/shop_comment/shop_comment.do" >
       <b>選擇商家留言編號:</b>
       <select size="1" name="shopComm_Id">
         <c:forEach var="shop_commentVO" items="${shop_commentSvc.all}" > 
          <option value="${shop_commentVO.shopComm_Id}">${shop_commentVO.shopComm_Id}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="getOne_For_Display">
    </FORM>
  </li>

</ul>

<hr>

<!--  -->
<h3>商家留言管理</h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/shop_comment/addShop_comment.jsp'>Add</a> a new Shop_comment.</li>
</ul>

<!--  -->

</body>

</html>
