<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%
request.setCharacterEncoding("UTF-8");
%>

<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">


<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/style.css" />

<script type="text/javascript" charset="utf8"
	src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.10.24/b-1.7.0/b-html5-1.7.0/b-print-1.7.0/datatables.min.css" />

<script type="text/javascript"
	src="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.10.24/b-1.7.0/b-html5-1.7.0/b-print-1.7.0/datatables.min.js"></script>


<script>
   function deleteCheck(){
      var url = "${contextPath}/notice/deleteNotice.do";
      var cnt = $("input[name='ab']:checked").length;
      var valueArr = new Array();
      $("input[name='ab']:checked").each(function(i){
         valueArr.push($(this).val());
      });
      $.ajax({
         url : url,
         type : 'POST',
         traditional : true,
         data : {
            valueArr : valueArr
         },
         success : function(data){
            console.log("success");
            window.location.reload();
            /*$("#container").load("${contextPath}/syllabus/syllabusList.do");*/
         },
         error : function(data) { 
               console.log("fail");
               console.log(${noticeList});
           }
      });
   };
</script>
<script type="text/javascript">
$(document).ready(function(){
   
   $.extend( $.fn.dataTable.defaults, {
       ordering:  false
   } );

   $('#myTable').DataTable({
     
         
      language: {
         info : '',
         sInfoFiltered : '',
         infoEmpty : '',
         emptyTable : '???????????? ????????????.',
         thousands : ',',
         lengthMenu : '_MENU_ ?????? ??????',
         loadingRecords : '???????????? ???????????? ???',
         processing : '?????? ???',
         zeroRecords : '?????? ?????? ??????',
         paginate : {
            first : '??????',
            last : '???',
            next : '??????',
            previous : '??????'
         },
         search: '',
         sSearchPlaceholder: '?????? ??????',
      
      }
   
   
   });
});
</script>

<title>???????????? ??????</title>

<style>
a:link, a:visited, a:hover {
	color: black;
	text-decoration: none;
}

.bg-primary {
	background-color: white !important;
}

.dataTables_wrapper {
	margin-top: 30px;
	display: inline-block;
	width: 100%;
}

table.dataTable thead th, table.dataTable thead td {
	padding: 10px 18px;
	border-bottom: 1px solid #96988f;
	background-color: #f8f8f8;
}

table.dataTable td {
	border-top: 1px solid lightgrey;
}

.sub_visual {
	font-family: 'Noto Sans KR', sans-serif;
	width: 100%;
	background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
		url("${pageContext.request.contextPath}/resources/image/sub_visual/courseApply.jpg");
	border: 0;
	font-size: 32px;
	font-weight: 500;
	height: 190px;
	padding-top: 69px;
	background-position: 50% 64%;
	background-size: cover;
	background-repeat: no-repeat;
}

.fas {
	margin-left: 10px;
}

.container {
	min-height: 811px;
}
</style>
</head>

<body>

	<div class="sub_visual">
		<span style="color: white;">????????????</span>
	</div>

	<div class="container">
		<div class="lnb">
			<ul>
				<li><a href="${contextPath}/main.do">???</a></li>
				<li style="color: grey; font-weight: bold;">???</li>
				<li class="on"><a
					href="${contextPath}/notice/listNoticeUser.do">???????????? </a></li>
			</ul>
		</div>

		<!-- <div class="pageIntro">????????????</div> -->

		<div>
			<table id="myTable">
				<thead>
					<tr>
						<th>??????</th>
						<th>??????</th>
						<th>?????????</th>
						<th>?????????</th>
						<th>??????</th>
					</tr>
				</thead>
				<tbody>

					<c:forEach var="noticeFixList" items="${noticeFixList}">

						<tr>
							<td style="color: red; font-weight: bold">${noticeFixList.notice_category}</td>

							<td class="name" style="text-align: left;"><a
								href="${contextPath}/notice/readNoticeUser.do?notice_no=${noticeFixList.notice_no}">
									${noticeFixList.notice_title}</a> <c:if
									test="${noticeFixList.nt_file_size gt 0}">
									<i class="fas fa-file-alt"></i>
								</c:if> <c:if test="${noticeFixList.notice_date>=nowday}">
									<span
										style="color: darkred; margin-right: 10px; font-size: 12px;">[new]</span>
									<!--   <img
                              src="${pageContext.request.contextPath}/resources/image/icon/new.png"
                              width="30px" height="30px"> -->
								</c:if></td>


							<td>${noticeFixList.notice_adminID}</td>
							<td>${noticeFixList.notice_date}</td>
							<td>${noticeFixList.notice_hit}</td>
						</tr>
					</c:forEach>



					<c:forEach var="noticeListUser" items="${noticeListUser}">

						<tr>
							<td>${noticeListUser.notice_category}</td>
							<td class="name" style="text-align: left;"><a
								href="${contextPath}/notice/readNoticeUser.do?notice_no=${noticeListUser.notice_no}">
									${noticeListUser.notice_title}</a> <c:if
									test="${noticeListUser.nt_file_size gt 0}">
									<i class="fas fa-file-alt"></i>
								</c:if> <c:if test="${noticeListUser.notice_date>=nowday}">
									<span
										style="color: darkred; margin-right: 10px; font-size: 12px;">new</span>
									<!--   <img
                              src="${pageContext.request.contextPath}/resources/image/icon/new.png"
                              width="30px" height="30px"> -->
								</c:if></td>

							<td>${noticeListUser.notice_adminID}</td>
							<td>${noticeListUser.notice_date}</td>
							<td>${noticeListUser.notice_hit}</td>
						</tr>
					</c:forEach>



				</tbody>


			</table>
		</div>

		<div style="height: 120px;"></div>

	</div>
</body>
</html>
