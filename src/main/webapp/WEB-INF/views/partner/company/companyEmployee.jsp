<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%
request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/style.css" />

<script type="text/javascript" charset="utf8"
	src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.js"></script>
	<link rel="stylesheet" type="text/css"
          href="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.10.24/b-1.7.0/b-html5-1.7.0/b-print-1.7.0/datatables.min.css"/>
    <script type="text/javascript"
            src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
    <script type="text/javascript"
            src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
    <script type="text/javascript"
            src="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.10.24/b-1.7.0/b-html5-1.7.0/b-print-1.7.0/datatables.min.js"></script>

<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.css">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
	crossorigin="anonymous">

<style>
.container {
	font-family: 'Noto Sans KR', sans-serif;
	display: flex;
	flex-wrap: wrap;
	width: 80%;
	justify-content: space-around;
	flex-direction: column;
	margin-left: 15%;
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
</style>
<!--   $('#myTable tfoot th').each( function () {
              var title = $(this).text();
              $(this).html( '<input type="text" placeholder="'+title+'" />' );
          } );
       
       var table = $('#myTable').DataTable({
          
         initComplete: function () {
               // Apply the search
               this.api().columns().every( function () {
                   var that = this;
    
                   $( 'input', this.footer() ).on( 'keyup change clear', function () {
                       if ( that.search() !== this.value ) {
                           that
                               .search( this.value )
                               .draw();
                       }
                   } );
               } );
           },  -->
<script type="text/javascript">
	$(document).ready(function() {
		$('#myTable').DataTable({

			dom : 'lBfrtip',
			buttons : ['excel'],
			
			language : {
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
				search : '',
				sSearchPlaceholder : '?????? ??????',

			}

		});
	});
</script>

</head>
<body>
	<div class="container">

		<div class="pageIntro">?????? ?????? ??????</div>
		<table id="myTable" class="table_" style="border-bottom: 1px solid #96988f;">
			<thead>
				<tr>
					<td><b>??????</b></td>
					<td><b>????????????</b></td>
					<td><b>?????????</b></td>
					<td><b>????????????</b></td>
					<td><b>????????????</b></td>
					<td><b>????????????</b></td>
					<td><b>?????????</b></td>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="eList" items="${companyEmployeeList}">
					<tr class="item">
						<td>${eList.memberVO.userName}</td>
						<td>${eList.memberVO.toCharBirth}</td>
						<td>${eList.syllabusVO.syllabusName}</td>
						<td>${eList.syllabusVO.syllabusTotalTime}</td>
						<td>${eList.courseVO.courseStart}</td>
						<td>${eList.courseVO.courseEnd}</td>
						<c:choose>
							<c:when test="${eList.courseTake_CompleteDate == null}">
								<td style="color: red;">?????????</td>
							</c:when>
							<c:otherwise>
								<td>${eList.courseTake_CompleteDate}</td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</tbody>
			<!-- <tfoot>
				<tr>
					<th>??????</th>
					<th>?????????</th>
					<th>?????????</th>
					<th>?????? ???</th>
					<th>??????</th>
					<th>??????</th>
					<th>?????????</th>
				</tr>
			</tfoot> -->
		</table>
	</div>





</body>
</html>