<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%
request.setCharacterEncoding("UTF-8");
%>


<html>
<head>
<meta charset=UTF-8">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/style.css" />
	
<script type="text/javascript" charset="utf8"
	src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.js"></script>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
	crossorigin="anonymous">

<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.10.24/b-1.7.0/b-html5-1.7.0/b-print-1.7.0/datatables.min.css" />
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
<script type="text/javascript"
	src="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.10.24/b-1.7.0/b-html5-1.7.0/b-print-1.7.0/datatables.min.js"></script>


<style>
a:link, a:visited, a:hover {
	color: black;
	text-decoration: none;
}

.container {
	font-family: 'Noto Sans KR', sans-serif;
	margin-left: 15%;
}

button {
	float: right;
	margin-right: 10px;
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

</head>
<script type="text/javascript">
$(document).ready(function(){
   $('#myTable').DataTable({
      
      dom : 'lBfrtip',
      buttons: ['excel'],

      
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
<script type="text/javascript">
   function checkSelectAll(checkbox)  {
      const selectall 
        = document.querySelector('input[name="check-all"]');
      if(checkbox.checked == false)  {
        selectall.checked = false;
      }
    }

    function selectAll(selectAll)  {
      const checkboxes 
         = document.getElementsByName('ab');
      
      checkboxes.forEach((checkbox) => {
        checkbox.checked = selectAll.checked
      })
    }
</script>
<script type="text/javascript">
	function filter(){
	
	    var value = document.getElementById("value").value.toUpperCase();
	    var item = document.getElementsByClassName("item");
	    
	    for(var i=0;i<item.length;i++){
	    	var name = item[i].getElementsByClassName("name");
	    	if(name[0].innerText.toUpperCase().indexOf(value) > -1){
	    		item[i].style.display="table-row";
			}else{
				item[i].style.display="none";
			}
	    }	
	} 
</script>
<script type="text/javascript">
	function filterDate(){
		
		var value = document.getElementById("date").value /* 2021-04  */
		console.log(value);
	    var item = document.getElementsByClassName("item");
	    for(var i=0;i<item.length;i++){
	    	var date = item[i].getElementsByClassName("date");
	    	
	    	if(date[0].innerText.toUpperCase().indexOf(value) > -1){
	    		item[i].style.display="table-row";
			}else{
				item[i].style.display="none";
			}
	    }	
	} 
</script>
<script type="text/javascript">
	function enter(){
	    /* ???????????? ????????? 13?????????. */
		if(event.keyCode == 13){
			filter()  /* ????????? ????????? */
		}
	}
</script>
<script type="text/javascript">
	/* ??????picker, ??????????????? ????????????[ex)2021/4], format: "mm/yyyy" ??? ?????? ???????????? */ 
	$(document).ready(function() {
		$('#sandbox-container input').datepicker({
			format : "yyyy-mm",
			startView : 1,
			minViewMode : 1,
			language : "ko",
			keyboardNavigation : false,
			forceParse : false,
			autoclose : true
		});
	});
</script>
<script>
	function closeCheck(){
		/*if (${isLogOn == true}){*/
			var url = "${contextPath}/course/closeCheck.do";
			var cnt = $("input[name='ab']:checked").length;
			var valueArr = new Array();
			$("input[name='ab']:checked").each(function(i){
				valueArr.push($(this).val());
			});
			if(cnt==0){
				Swal.fire("????????? ????????? ????????????.","","warning");
			}
			else{	
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
						
					},
					error : function(data) { 
			            console.log("fail");
			        }
				})
			}
		/*}
		else{
			alert("????????? ??? ??????????????????.");
		}*/
	};
</script>
<script>
	function openCheck(){
		/*if (${isLogOn == true}){*/
			var url = "${contextPath}/course/openCheck.do";
			var cnt = $("input[name='ab']:checked").length;
			var valueArr = new Array();
			$("input[name='ab']:checked").each(function(i){
				valueArr.push($(this).val());
			});
			
			if(cnt==0){
				Swal.fire("????????? ????????? ????????????.","","warning");
			}
			else{
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
						
					},
					error : function(data) { 
			            console.log("fail");
			        }
				})
			}
		/*}
		else{
			alert("????????? ??? ??????????????????.");
		}*/
	};	
</script>
<script>
	function deleteCheck(){
		
		/*if (${isLogOn == true}){*/
			var url = "${contextPath}/course/deleteCheck.do";
			var cnt = $("input[name='ab']:checked").length;
			var valueArr = new Array();
			$("input[name='ab']:checked").each(function(i){
				valueArr.push($(this).val());
			});
			if (cnt==0){
				Swal.fire("????????? ?????????????????? ????????????.","","warning");
			}else{
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
						Swal.fire("????????? ?????????????????? ???????????? ????????? ????????????.","","error");
						console.log("fail");
			        }
				})
			}
		/*}
		else{
			alert("????????? ??? ??????????????????.");
		}*/
	};		
</script>
<script>
function register(){
	location.href='${contextPath}/course/courseRegister.do'
	/*if (${isLogOn == true}){
		location.href='${contextPath}/course/courseRegister.do'
	}
	else{
		alert("????????? ??? ??????????????????.");
	}*/
};
</script>

<body>

	<div class="container">

	<div class="pageIntro">????????????</div>

		<table  id="myTable" class="table_">
			<thead>
				<tr align="center">
					<td><input type="checkbox" name="check-all"
						onclick='selectAll(this)' /></td>
					<td><b>??????</b></td>
					<td><b>?????????</b></td>
					<td><b>????????????</b></td>
					<td><b>?????????</b></td>
					<td><b>????????????</b></td>
					<td><b>????????????</b></td>
					<td><b>??????</b></td>
				</tr>
			</thead>

			<tbody id="ajaxTable">
				<c:forEach var="courseVO" items="${courseList}">
					<tr class="item">
						<td><input type="checkbox" name="ab"
							value="${courseVO.courseID}" onclick='checkSelectAll(this)' /></td>
						<td>${courseVO.courseID}</td>
						<td class="name"><a
							href="${contextPath}/course/selectCourse.do?courseID=${courseVO.courseID}">[${courseVO.syllabusVO.syllabusCategory1}
								> ${courseVO.syllabusVO.syllabusCategory2}]
								${courseVO.syllabusVO.syllabusName}</a></td>
						<td>${courseVO.coursePeopleMax}</td>
						<td>${courseVO.courseFee}</td>
						<td>${courseVO.courseApplyStart}~${courseVO.courseApplyEnd}</td>
						<td class="date">${courseVO.courseStart}~${courseVO.courseEnd}</td>
						<td>${courseVO.courseState}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<div style="margin-top: 50px;">
			<button class="btn btn-outline-danger" type="button"
				onClick="closeCheck();">???????????? ????????????</button>
			<button class="btn btn-outline-danger" type="button"
				onClick="openCheck();">???????????? ?????????</button>
			<button class="btn btn-outline-danger" onClick="register()">????????????
				??????</button>
		</div>
	</div>
</body>
</html>