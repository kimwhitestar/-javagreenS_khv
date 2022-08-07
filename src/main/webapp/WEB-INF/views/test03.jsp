<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>test03.jsp</title>
    <%@ include file="/include/bs4.jsp" %>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
    .question {
    	margin-left: 400px;
    }
    </style>
    <script>
	'use strict';
	let orgProducts = [];
	let products = []; //product price의 Number타입 배열 
	let orgProductNames = [];
	let productNames = []; //product name의 문자타입 배열
	
	//window.onload()와 같음
	$(document).ready(function(){
		//문제2) 문장 위치 변경
		$('#question').addClass("question");

		//Number타입의 productPrice의 값을 가져와서 products배열 만들기 
		$('#productsDiv input[name="productPrice"]').each((idx, product) => {
			console.log($(product).val());
			products.push(Number($(product).val()));
			orgProducts.push(Number($(product).val()));
			//console.log(products.pop());
		});
		//product name의 값을 가져와서 productName배열 만들기 
		$('#productsDiv label[name="productName"]').each((idx, name) => {
			console.log($(name).text());
			productNames.push($(name).text());
			orgProductNames.push($(name).text());
			//console.log(productNames.pop());
		});
		//productPrice를 val()로 받아 배열로 저장하려고 하면, 
		//productPrice의 첫번째 값을 가져온 값의 숫자가 1자씩 분할되어 배열로 저장됨ㅜㅜ
		//그냥 위와 같이 productPrice를 each()로 돌린 값을 새로운 배열에 추가하기로 함ㅜㅜ
		//let product = $('#productsDiv input[name="productPrice"]').val();//2500000 
		//console.log("받은 상품가격 : " + product);
		// console.log("상품목록갯수:"+products.length);
		// console.log('products[0]='+products[0]);//2
		// console.log('products[1]='+products[1]);//5
		// console.log('products[2]='+products[2]);//0
		// $.each([ 52, 97 ], function( index, value ) {
  		// 	alert( index + ": " + value );
		// });
		
		$('#productsDiv input[name="btnAsending"]').click(function(){
			//Selected Sort 알고리즘 오름차순정렬
			let temp = 0, tempName = '';
 			$.each(products, function(i, price){
				if (i < products.length-1) {
		 			$.each(products, function(j, price){
						if (j >= (i+1)) {
							//앞의 값이 뒤의 값보다 크면 서로 교체
							if (products[i] > products[j]) {
								temp = products[i];
								products[i] = products[j];
								products[j] = temp;

								tempName = productNames[i];
								productNames[i] = productNames[j];
								productNames[j] = tempName;
							}
						}
					});
				}
			});
 			//오름차순 정렬된 products배열 consol log출력확인
 			$.each(products, function(idx, price){
				console.log(price);
			});
 			form.action = 'test03Ok.jsp?orgProducts='+orgProducts+'&products='+products+'&orgProductNames='+orgProductNames+'&productNames='+productNames;
			form.submit();
 			//Array.sort(); //오름차순
			// let idx = "";
			// $.each(products.sort(), function(i, price){
			// 	idx += ',' + i;
			// 	console.log(price);//Number타입의 배열인데도,숫자의 앞자리만으로 비교되어,정렬이 틀림
			// });
			// console.log('idx='+idx); //idx=0,1,2,3,4,5
			//productNames
			//products.sort()를 사용하면 producsts배열이 이미 sorted되어 이전idx의 변화를 알 수 없음ㅜㅜ
			//그냥 selection sort 알고리즘을 사용하기로 함
		});

		$('#productsDiv input[name="btnDesending"]').click(function(){
			//Selected Sort 알고리즘 내림차순정렬
			let temp = 0, tempName = '';
 			$.each(products, function(i, price){
				if (i < products.length-1) {
		 			$.each(products, function(j, price){
						if (j >= (i+1)) {
							//앞의 값이 뒤의 값보다 작으면 서로 교체
							if (products[i] < products[j]) {
								temp = products[i];
								products[i] = products[j];
								products[j] = temp;

								tempName = productNames[i];
								productNames[i] = productNames[j];
								productNames[j] = tempName;
							}
						}
					});
				}
			});
 			//내림차순 정렬된 products배열 consol log출력확인
 			$.each(products, function(idx, price){
				console.log(price);
			});
			form.action = 'test03Ok.jsp?orgProducts='+orgProducts+'&products='+products+'&orgProductNames='+orgProductNames+'&productNames='+productNames;
			form.submit();
			//console.log( $(products).toArray().reverse());
			//products.reverse(); //내림차순
			// let idx = '';
			// $.each(products.reverse(), function(i, price){
			// 	idx += ',' + i;
			// 	console.log(price);//Number타입의 배열인데도,숫자의 앞자리만으로 비교되어,정렬이 틀림
			// });
			// console.log('idx='+idx); //idx=0,1,2,3,4,5
			//productNames
 			//products.reverse()를 사용하면 producsts배열이 이미 sorted되어 이전idx의 변화를 알 수 없음ㅜㅜ
			//그냥 selection sort 알고리즘을 사용하기로 함
		});

/* 		function check() {
			$.isNumeric(); //이미 Number()함수로 products배열의 값을 숫자타입으로 바꿔서 생략함
		}
 */
		//콤마 추가
        // function numberWithCommas(num) {
        // 	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        // }
	});
    </script>
</head>
<body>
<p><br></p>
<div id="question" class="container">
<pre>
문제2) 폼을 통해서 상품명과 상품 가격을 6개를 입력받아, 가격순으로 오름차순/내림차순 정렬처리 후 출력
- 서블릿 없이 Jsp화면만으로 구현하기

구현 파일 : jsp
파일명 : test03Ok.jsp
폼태그 내용은 미리 value값에 저장시켜놓는다
버튼 : '오름차순'/'내림차순'/'돌아가기'
출력시에는 원본자료와 정렬된 자료를 모두 출력
완성 후 화면을 예쁘게 꾸며보세요(bs4사용)
</pre>
</div>
<div id="productsDiv" align="center" class="container"><br>
	<form name="form" method="post">
		<table width="500px">
			<tr height="50px">
				<th><div class="col" align="center">상품명</div></th>
				<th><div class="col" align="center">상품가격</div></th>
			</tr>
			<tr>
				<td><label for="productPrice1" name="productName" class="col">냉장고</label></td>
				<td><input type="number" name="productPrice" id="productPrice1" value="2500000" class="form-control"/></td>
			</tr>
			<tr>
				<td><label for="productPrice2" name="productName" class="col">TV</label></td>
				<td><input type="number" name="productPrice" id="productPrice2" value="102000" class="form-control"/></td>
			</tr>
			<tr>
				<td><label for="productPrice3" name="productName" class="col">전기포트</label></td>
				<td><input type="number" name="productPrice" id="productPrice3" value="50000" class="form-control"/></td>
			</tr>
			<tr>
				<td><label for="productPrice4" name="productName" class="col">선풍기</label></td>
				<td><input type="number" name="productPrice" id="productPrice4" value="100000" class="form-control"/></td>
			</tr>
			<tr>
				<td><label for="productPrice5" name="productName" class="col">헤어드라이어</label></td>
				<td><input type="number" name="productPrice" id="productPrice5" value="80000" class="form-control"/></td>
			</tr>
			<tr>
				<td><label for="productPrice6" name="productName" class="col">전자랜지</label></td>
				<td><input type="number" name="productPrice" id="productPrice6" value="500000" class="form-control"/></td>
			</tr>
			<tr height="100px">
				<td colspan="2" align="center">
					<input type="button" name="btnAsending" value="오름차순" class="btn btn-success m-2"/>
					<input type="button" name="btnDesending" value="내림차순" class="btn btn-success m-2"/>
					<input type="button" value=돌아가기 class="btn btn-success m-2" onclick="location.href='<%=request.getContextPath()%>/';" />
				</td>
			</tr>
		</table>
	</form>
</div>
</div>
</body>
</html>