<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//Get방식은 request의 파라미터값이 모두 String타입으로 바뀌어 있음
String orgProductName = request.getParameter("orgProductNames");
String productName = request.getParameter("productNames");
String orgProduct = request.getParameter("orgProducts");
String product = request.getParameter("products");
System.out.println("orgProductName=" + orgProductName);
System.out.println("productName=" + productName);
System.out.println("orgProducts=" + orgProduct);
System.out.println("product=" + product);

String[] orgProductNames = orgProductName.split(",");
String[] productNames = productName.split(",");
String[] orgProducts = orgProduct.split(",");
String[] products = product.split(",");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>test03Ok.jsp</title>
    <%@ include file="/include/bs4.jsp" %>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style></style>
    <script>
    	'use strict';
    </script>
</head>
<body>
<p><br></p>
<div class="container">
	<table cellpadding="10px">
		<tr>
			<td width="500px" valign="top">
				<table id='tblOrgProduct' align="center" width="500px">
					<caption>원본 상품 목록</caption>
					<tr height="50px">
						<th><div class="col" align="center">상품명</div></th>
						<th><div class="col" align="center">상품가격</div></th>
					</tr>
<% 	int idx = -1;
	for (String orgProductNM : orgProductNames) { 
		idx++;
%>
					<tr>
						<td><div class="col"><%=orgProductNM%></div></td>
						<td><div class="col"></div><%=orgProducts[idx]%></div></td>
					</tr>
<% 	} %>
				</table>
			</td>
			<td width="50px">
				<div align="center" class="col"> >> </div>
			</td>
			<td width="500px">
				<table align="center" width="500px">
					<caption>정렬된 상품 목록</caption>
					<tr height="50px">
						<th><div class="col" align="center">상품명</div></th>
						<th><div class="col" align="center">상품가격</div></th>
					</tr>
<% 	idx = -1;
	for (String productNM : productNames) { 
		idx++;
%>
					<tr>
						<td><label class="col"><%=productNM%></label></td>
						<td><input type="number" name="productPrice" value="<%=products[idx]%>" class="form-control" disabled/></td>
					</tr>
<% 	} 
%>
				</table>			
			</td>
		</tr>
	</table>
</div>
<br><br><br>
<div align="center" class="container">
	<a href="test03.jsp" class="col"><h2><< 뒤로가기</h2></a>
</div>
</body>
</html>