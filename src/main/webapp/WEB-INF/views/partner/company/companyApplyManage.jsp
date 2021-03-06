<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/style.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/modal.css" />

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
	crossorigin="anonymous">

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</head>
<style>

.flex-box {
	display: flex;
	justify-content: space-evenly;
}

.flex-col {
	display: flex;
	flex-direction: column;
}

#resumeTable {
	color: black;
	font-family: 'Noto Sans KR', sans-serif;
	width: 600px;
	margin-right: 40px;
}

#resumeTable th {
	text-align: center;
	background-color: #eee;
}

#resumeTable td {
	padding: 5px;
}

.d_divider {
	border-left: 3px solid green;
	height: 500px;
}

.c_content {
	float: left;
	width: 770px;
	word-break: keep-all;
	word-wrap: break-word;
}

.c_context {
	width: 990px;
	word-break: keep-all;
	word-wrap: break-word;
}

.s_str {
	float: left;
	width: 200px;
}

.r_row {
	clear: left;
}

.c_containerItem {
	margin-top: 100px;
	clear: left;
	border-bottom: 1px solid black;
}

#resCarr>th {
	colspan: 2;
}

.container {
	font-family: 'Noto Sans KR', sans-serif;
	display: flex;
	flex-wrap: wrap;
	width: 80%;
	justify-content: space-around;
	flex-direction: column;
	padding-bottom: 200px;
	margin-left: 15%;
}

</style>
<script>
$(document).ready(function () {
    let activeTab = sessionStorage.getItem('activeTab');
    // get Tab value
    $('#myTab a[href="'+activeTab+'"]').trigger('click');
    $(".next").click(function(){
       
      $( '.modal-body' ).animate( { scrollTop : 0 }, 1000 );
   current_fs = $(this).parent();
    next_fs = $(this).parent().next();
    
    //Add Class Active
    $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");

    //show the next fieldset
    next_fs.show();
    //hide the current fieldset with style
    current_fs.animate({opacity: 0}, {
    step: function(now) {
    // for making fielset appear animation
    opacity = 1 - now;

    current_fs.css({
    'display': 'none',
    'position': 'relative'
    });
    next_fs.css({'opacity': opacity});
    },
    duration: 600
    });
    });

    $(".previous").click(function(){
   
    $( '.modal-body' ).animate( { scrollTop : 0 }, 1000 );
       
    current_fs = $(this).parent();
    previous_fs = $(this).parent().prev();

    //Remove class active
    $("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");

    //show the previous fieldset
    previous_fs.show();

    //hide the current fieldset with style
    current_fs.animate({opacity: 0}, {
    step: function(now) {
    // for making fielset appear animation
    opacity = 1 - now;

    current_fs.css({
    'display': 'none',
    'position': 'relative'
    });
    previous_fs.css({'opacity': opacity});
    },
    duration: 600
    });
    });

    $('.radio-group .radio').click(function(){
    $(this).parent().find('.radio').removeClass('selected');
    $(this).addClass('selected');
    });

    $("#reset").click(function(){
       location.reload();
   });
})
// reloading
function getResumeInfo(resumeID, resumeUser, userName, resumePic) {
   
   $.ajax({            // get Resumes
        method: "GET",
        url: "${contextPath}/resume/resumeInfo.do?resumeID="+resumeID+"&resumeUser="+resumeUser,
        success: (resp) => {   // when success
           console.log(resp);
           var now = new Date();   //get current Date
           var year = now.getFullYear();   // get Current Year
           var yyyy=resp.resume.memberVO.birth.substr(0,4);
           var mm = resp.resume.memberVO.birth.substr(4,2);
           var dd = resp.resume.memberVO.birth.substr(6,2);
           var age = year-parseInt(yyyy)+1;
           var phone1 = resp.resume.memberVO.userPhoneNumber.substr(0,3);
           var phone2 = resp.resume.memberVO.userPhoneNumber.substr(3,4);
           var phone3 = resp.resume.memberVO.userPhoneNumber.substr(7,4);
        
           
           $("#modal_title").text(userName+"??? ?????????");
            $("#resName").text(resp.resume.memberVO.userName);
            if(resumePic != "") {
                $("#resPic").attr('src', '${pageContext.request.contextPath}/resources/image/resume/'+resumePic)
                } else if(resumePic == "") {
                $("#resPic").attr('src', '${pageContext.request.contextPath}/resources/image/resume/img.jpg')
                }
            $("#resEngName").text(resp.resume.resumeForeign);
            $("#resAge").text(age);
            $("#resGender").text(resp.resume.memberVO.userGender);
            $("#resBirth").text(yyyy+"??? "+mm+"??? "+dd+"???");
            $("#resAddress").text(resp.resume.memberVO.userAddress1+" "+resp.resume.memberVO.userAddress2);
            $("#resPhone").text(phone1+"-"+phone2+"-"+phone3);
            $("#resEmail").text(resp.resume.memberVO.userEmail);
            $("#resLastEdu").text(resp.resume.resumeLastEdu+"("+resp.resume.resumeSchool+")");
            $("#resMajor").text(resp.resume.memberVO.userMajor);
            $("#resGrade").text(resp.resume.resumeGrade);
            
            $("#resCtx1").html(resp.resume.resumeContext1);
            $("#resCtx2").html(resp.resume.resumeContext2);
            $("#resCtx3").html(resp.resume.resumeContext3);
            $("#resCtx4").html(resp.resume.resumeContext4);
            
            if(resp.resume.resumeContext5 == null){
               $("#resCtx5").html("");
            } else{
               $("#resCtx5").html(resp.resume.resumeContext5);
            }
            
            
            if (resp.certificate != null) {
                for(i=0; i<resp.certificate.length; i++) { // when Certificate is Exist
                   var certificate_list = "";
                   if(resp.certificate[i].certificateDate != null) {
                   var c_yyyy=resp.certificate[i].certificateDate.substr(0,4);
                   var c_mm = resp.certificate[i].certificateDate.substr(4,2);
                   var c_dd = resp.certificate[i].certificateDate.substr(6,2);
                   
                   
                   certificate_list += "<tr>";
                   certificate_list += "<td>"+resp.certificate[i].certificateName+"</td>";
                   certificate_list += "<td>"+resp.certificate[i].certificateEnforcement+"</td>";
                   certificate_list += "<td>"+c_yyyy+"??? "+c_mm+"??? "+c_dd+"???"+"</td>";
                   certificate_list += "</tr>";
                   }
                   
                   $("#resCert").append(certificate_list);
                 }
               }
             
                
                 if (resp.foreign != null) {
                    for(i=0; i<resp.foreign.length; i++) { // when Foreign Certificate is exist
                       var foreign_list = "";
                       if(resp.foreign[i].foreignDate != null) {
                       var f_yyyy=resp.foreign[i].foreignDate.substr(0,4);
                       var f_mm = resp.foreign[i].foreignDate.substr(4,2);
                       var f_dd = resp.foreign[i].foreignDate.substr(6,2);
                       
                       
                       foreign_list += "<tr>";
                       foreign_list += "<td>"+resp.foreign[i].foreignCriteria+"</td>";
                       foreign_list += "<td>"+resp.foreign[i].foreignName+"</td>";
                       foreign_list += "<td>"+resp.foreign[i].foreignScore+"</td>";
                       foreign_list += "<td>"+f_yyyy+"??? "+f_mm+"??? "+f_dd+"??? "+"</td>";
                       foreign_list += "</tr>";
                       }
                       
                       $("#resFor").append(foreign_list);
                     }    
                }
                
                 if (resp.career != null) {
                     for(i=0; i<resp.career.length; i++) { // when career is Exist
                        var career_list = "";
                        if (resp.career[i].careerEnddate != null) {
                            var caEnd_yyyy=resp.career[i].careerEnddate.substr(0,4);
                            var caEnd_mm = resp.career[i].careerEnddate.substr(4,2);
                            var caEnd_dd = resp.career[i].careerEnddate.substr(6,2);
                            }
                         if(resp.career[i].careerStartdate != null) {
                        var caStart_yyyy=resp.career[i].careerStartdate.substr(0,4);
                        var caStart_mm = resp.career[i].careerStartdate.substr(4,2);
                        var caStart_dd = resp.career[i].careerStartdate.substr(6,2);
                         
                        
                        
                        if(resp.career[i].careerCheck == "C"){
                           
                            career_list += "<tr>";
                            career_list += "<th>"+"?????????"+"</th>";
                            career_list += "<th>"+resp.career[i].careerCenter+"</th>";
                            career_list += "</tr>";
                            career_list += "<tr>";
                            career_list += "<td>"+"????????????"+"</td>";
                            if (caEnd_yyyy != null) {
                               career_list += "<td>"+caStart_yyyy+"."+caStart_mm+"."+caStart_dd+" ~ "+caEnd_yyyy+"."+caEnd_mm+"."+caEnd_dd+"</td>";
                            } else {
                              career_list += "<td>"+caStart_yyyy+"."+caStart_mm+"."+caStart_dd+" ~ ?????????</td>";
                            }
                            career_list += "</tr>";
                            career_list += "<tr>";
                            career_list += "<td>"+"??????"+"</td>";
                            career_list += "<td>"+resp.career[i].careerPosition+"</td>";
                            career_list += "</tr>";
                            career_list += "<tr>";
                            career_list += "<td>"+"????????????"+"</td>";
                            career_list += "<td>"+resp.career[i].careerType+"</td>";
                            career_list += "</tr>";
                            $("#resCarr_C").append(career_list);
                         } else if(resp.career[i].careerCheck == "E") {
                            career_list += "<tr>";
                            career_list += "<th>"+"?????? ??????"+"</th>";
                            career_list += "<th>"+resp.career[i].careerCenter+"</th>";
                            career_list += "</tr>";
                            career_list += "<tr>";
                            career_list += "<td>"+"?????? ??????"+"</td>";
                            career_list += "<td>"+caStart_yyyy+"."+caStart_mm+"."+caStart_dd+" ~ "+caEnd_yyyy+"."+caEnd_mm+"."+caEnd_dd+"</td>";
                            career_list += "</tr>";
                            career_list += "<tr>";
                            career_list += "<td>"+"?????? ??????"+"</td>";
                            career_list += "<td>"+resp.career[i].careerHour+"</td>";
                            career_list += "</tr>";
                            career_list += "<tr>";
                            career_list += "<td>"+"??????"+"</td>";
                            if(resp.career[i].careerOther == null){
                               career_list += "<td>"+" "+"</td>";
                            }
                            else{
                               career_list += "<td>"+resp.career[i].careerOther+"</td>";
                            }
                            
                            career_list += "</tr>";
                            $("#resCarr_E").append(career_list);
                         }
                       }
                     }
                 }
                 if (resp.project != null) {
                     for(i=0; i<resp.project.length; i++) { // when project is Exist
                        var project_list = "";
                         if(resp.project[i].projectEnforcement != null) {
                        
                        project_list += "<tr>";
                        project_list += "<th style="+"width:108px"+">"+"?????????"+"</th>";
                        project_list += "<th>"+resp.project[i].projectEnforcement+"</th>";
                        project_list += "</tr>";
                        project_list += "<tr>";
                        project_list += "<td>"+"???????????? ???"+"</td>";
                        project_list += "<td>"+resp.project[i].projectName+"</td>";
                        project_list += "</tr>";
                        project_list += "<tr>";
                        project_list += "<td>"+"???????????? ??? ????????????"+"</td>";
                        project_list += "<td>"+resp.project[i].projectDev+"</td>";
                        project_list += "</tr>";
                        project_list += "<tr>";
                        project_list += "<td>"+"???????????? ??????"+"</td>";
                        project_list += "<td>"+resp.project[i].projectContent+"</td>";
                        project_list += "</tr>";
                        project_list += "<tr>";
                        project_list += "<td>"+"????????? ??????"+"</td>";
                        project_list += "<td>"+resp.project[i].projectRole+"</td>";
                        project_list += "</tr>";
                        project_list += "<tr>";
                        project_list += "<td>"+"????????????"+"</td>";
                        project_list += "<td>"+resp.project[i].projectURL+"</td>";
                        project_list += "</tr>";
                        
                        $("#resPro").append(project_list);
                         }
                      }    
                 }
            
        },
        error: (err) => {
            console.log("err: "+err);
    }
    })
   
  }
  
function tabtab(h) {
    sessionStorage.setItem('activeTab', h);
    console.log('href   yyyy' + h);
}


        
        function tabtab(h) {
            sessionStorage.setItem('activeTab', h);
            console.log('href   yyyy' + h);
        }


        // Check Pass Or Fail 
        function chk_passOrFail(userID, userName, partnerID) {
               Swal.fire({
                   title:userName+'('+userID+')',
                 icon:'warning',
                   confirmButtonText: `??????`,
                   confirmButtonColor: '#3085d6',
                   showCloseButton: true,
                   showCancelButton: true,
                   cancelButtonText: `?????????`,
                   cancelButtonColor: '#d33',
                   }).then((res) => {
                   if(res.isConfirmed){
                      
                   Swal.fire({               /* update operation start */
                           title:'?????? ??????',
                           text: '???????????? ???????????????????',
                           showCancelButton: true,
                           showCloseButton: true,
                           icon:"success",
                           confirmButtonColor: '#3085d6',
                           cancelButtonColor: '#d33',
                      cancelButtonText: '??????',
                           confirmButtonText: '??????'
                         }).then((result) => {
                           /* Read more about isConfirmed, isDenied below */
                           if (result.isConfirmed) {
                              $.ajax({            //check update to pass
                                       method: "POST",
                                       url: "${contextPath}/partner/company/manageApply.do",
                                       data: {
                                        partnerApplyUserID    : userID,
                                          partnerApplyPartnerID : partnerID,
                                         partnerApplyState : '??????'
                                       },
                                       success: (resp) => {   // update to pass and reloading
                                        location.reload();        
                                       },
                                       error: (data) => {
                                           console.log("????????? ?????? ??????:"+data);
                                        }
                                   }) 
                           } else{
                               return;     /* cancel operation */
                           }
                         })
                   
                   } else if( res.dismiss ==='cancel'){
                    Swal.fire({               /* check update to fail */
                      title:'????????? ??????',
                      text: '????????? ?????????????????????????',
                      showCloseButton: true,
                      showCancelButton: true,
                      icon:"error",
                      confirmButtonColor: '#d33',
                      cancelButtonColor: '#3085d6#d33',
                     cancelButtonText: '??????',
                      confirmButtonText: '?????????'
                    }).then((result) => {
                      /* Read more about isConfirmed, isDenied below */
                      if (result.isConfirmed) {
                         $.ajax({            // update to fail
                                  method: "POST",
                                  url: "${contextPath}/partner/company/manageApply.do",
                                  data: {
                                   partnerApplyUserID    : userID,
                                      partnerApplyPartnerID : partnerID,
                                     partnerApplyState : '?????????'
                                   
                                  },
                                  success: (resp) => {   // update to fail and reloading
                                   location.reload();        
                                  },
                                  error: (data) => {
                                      console.log("????????? ?????? ??????:"+data);
                                   }
                              }) 
                      } else{
                          return;     /* cancel update */
                      }
                    })
                 } else{
                     return;
                   }
                     
                 })
           }
        
        function chk_reset(userID, userName, partnerID) {
           Swal.fire({
               title:'?????? ??????',
               text:'?????? ????????? ???????????????',
             icon:'warning',
               confirmButtonText: `??????`,
               confirmButtonColor: '#3085d6',
               showCloseButton: true,
               showCancelButton: true,
               cancelButtonText: `?????????`,
               cancelButtonColor: '#d33',
               }).then((res) => {
               if(res.isConfirmed){
                  
               Swal.fire({               /* check editing */
                       title:'?????? ??????',
                       text: '?????? ?????????????????????????',
                       showCancelButton: true,
                       showCloseButton: true,
                       icon:"success",
                       confirmButtonColor: '#3085d6',
                       cancelButtonColor: '#d33',
                   cancelButtonText: '??????',
                       confirmButtonText: '??????'
                     }).then((result) => {
                       /* Read more about isConfirmed, isDenied below */
                       if (result.isConfirmed) {
                          $.ajax({            // update to pass 
                                   method: "POST",
                                   url: "${contextPath}/partner/company/manageApply.do",
                                   data: {
                                    partnerApplyUserID    : userID,
                                      partnerApplyPartnerID : partnerID,
                                     partnerApplyState : '??????'
                                   },
                                   success: (resp) => {   // update success and reloading
                                    location.reload();        
                                   },
                                   error: (data) => {
                                       console.log("????????? ?????? ??????:"+data);
                                    }
                               }) 
                       } else{
                           return;     /* cancel editing */
                       }
                     })
               
               } else if( res.dismiss ==='cancel'){
                Swal.fire({               /* edit to fail */
                  title:'????????? ??????',
                  text: '????????? ?????????????????????????',
                  showCloseButton: true,
                  showCancelButton: true,
                  icon:"error",
                  confirmButtonColor: '#d33',
                  cancelButtonColor: '#3085d6',
                 cancelButtonText: '??????',
                  confirmButtonText: '?????????'
                }).then((result) => {
                  /* Read more about isConfirmed, isDenied below */
                  if (result.isConfirmed) {
                     $.ajax({            // update to not allowed
                              method: "POST",
                              url: "${contextPath}/partner/company/manageApply.do",
                              data: {
                               partnerApplyUserID    : userID,
                                  partnerApplyPartnerID : partnerID,
                                 partnerApplyState : '?????????'
                               
                              },
                              success: (resp) => {   // update success and reloading
                               location.reload();        
                              },
                              error: (data) => {
                                  console.log("????????? ?????? ??????:"+data);
                               }
                          }) 
                  } else{
                      return;     /* ?????? ?????? ?????? */
                  }
                })
             } else{
                 return;
               }
                 
             })
       }
        
        function suggestToUser(userID, partnerID, userName) {
           Swal.fire({
              html: `
              <h2>?????? ??????</h2>
              <input type="text" id="user" style="background-color: #eee;" class="swal2-input" readonly>
              <input type="text" id="suggestTitle" placeholder="??????" class="swal2-input">
              <textarea type="text" id="suggestDesc" placeholder="?????? ??????" style="height:300px; padding-top: 5px;" class="swal2-input" rows="100"></textarea>`,
               confirmButtonText: `??????`,
               confirmButtonColor: '#3085d6',
               showCloseButton: true,
               showCancelButton: true,
               cancelButtonText: `??????`,
               cancelButtonColor: '#d33',
               onOpen: function() {
                    $('#user').attr("value", userName);
                },
                preConfirm: () => {         // pre confirm
                   const suggestDesc = Swal.getPopup().querySelector('#suggestDesc').value;
                   const suggestTitle = Swal.getPopup().querySelector('#suggestTitle').value;
                   if (!suggestDesc || !suggestTitle) {
                    Swal.showValidationMessage(`Please enter title and Description`)   // check title and Descrtion is not null
                  }
                  else{
                     return;
              }
                }
               }).then((res) => {
               if(res.isConfirmed){
               const suggestDesc = Swal.getPopup().querySelector('#suggestDesc').value;
                const suggestTitle = Swal.getPopup().querySelector('#suggestTitle').value;
                Swal.fire({               /* check editing */
                       title:'????????? ??????',
                       text: '?????? ?????????????????????????',
                       showCancelButton: true,
                       showCloseButton: true,
                       icon:"success",
                       confirmButtonColor: '#3085d6',
                       cancelButtonColor: '#d33',
                   cancelButtonText: '?????? ??????',
                       confirmButtonText: '?????? ??????'
                     }).then((result) => {
                       /* Read more about isConfirmed, isDenied below */
                       if (result.isConfirmed) {
                         
                          $.ajax({            // update to pass 
                                   method: "POST",
                                   url: "${contextPath}/partner/company/manageSuggest.do",
                                   data: {
                                    partnerSuggestionUserID    : userID,
                                      partnerSuggestionPartnerID : partnerID,
                                      partnerSuggestionTitle : suggestTitle,
                                     partnerSuggestionDescription : suggestDesc
                                   },
                                   success: (resp) => {   // update success and reloading
                                     Swal.fire('?????? ??????!', '', 'success').then(()=>{
                                     location.reload(); 
                                     })
                                   },
                                   error: (data) => {
                                       console.log("????????? ?????? ??????:"+data);
                                    }
                               })  
                       } else{
                           return;     /* cancel editing */
                       }
                     })
               
               } else{
                 return;
               } 
             })
       }
        
        function deleteSuggestion(userID, partnerID){
            Swal.fire({
                title:'???????????? ??????',
                text:'?????? ?????? ????????? ??? ????????????.',
              icon:'warning',
                confirmButtonText: `??????`,
                confirmButtonColor: '#d33',
                showCloseButton: true,
                showCancelButton: true,
                cancelButtonText: `??????`,
                cancelButtonColor: '#3085d6',
                }).then((res) => {
                if(res.isConfirmed){
                           $.ajax({            //check update to pass
                                    method: "POST",
                                    url: "${contextPath}/partner/company/deleteSuggest.do",
                                    data: {
                                     partnerSuggestionUserID    : userID,
                                       partnerSuggestionPartnerID : partnerID,
                                      partnerSuggestionPartnerD : 'N'
                                    },
                                    success: (resp) => {   // update to pass and reloading
                                     location.reload();        
                                    },
                                    error: (data) => {
                                        console.log("????????? ?????? ??????"+data);
                                     }
                                }) 
                } 
                else{
                  return;
                    }
                })
        }
     </script>
<body>
	<div id="applyContents">
		
		<div class="container">
		
		<div class="pageIntro">?????? ??????</div>
		
			<!-- Modal -->
			<!-- <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog modal-dialog-scrollable">
 -->
			<div class="modal fade bd-example-modal-lg" id="myModal"
				tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
				aria-hidden="true">
				<div class="modal-dialog modal-lg modal-dialog-scrollable">
					<!-- Modal content-->
					<div class="modal-content">

						<div class="modal-header">
							<h5 class="modal-title" id="modal_title"></h5>
							<button type="button" class="close" data-dismiss="modal">X</button>
						</div>
						<div class="modal-body">
							<div class="container-fluid" id="grad1">
								<div class="row justify-content-center mt-0">
									<div>
										<div class="card px-0 pt-4 pb-0 mt-3 mb-3">
											<div class="row">
												<div class="col-md-12 mx-0">
													<form id="msform">
														<!-- progressbar -->
														<ul id="progressbar">
															<li class="active" id="basic"><strong>????????????</strong></li>
															<li id="personal"><strong>????????????</strong></li>
															<li id="education"><strong>??????/????????????</strong></li>
															<li id="project"><strong>????????????</strong></li>
															<li id="introduce"><strong>???????????????</strong></li>
														</ul>
														<!-- fieldsets -->
														<fieldset id="init">
															<div class="form-card">
																<h2 class="fs-title">????????????</h2>
																<table border id="resumeTable">
																	<tr>
																		<th rowspan="4"><img id="resPic"
																			src="${pageContext.request.contextPath}/resources/image/resume/img.jpg"
																			style="width: 122px; height: 163px;" /></th>
																	</tr>
																	<tr>
																		<th>??????</th>
																		<td id="resName"></td>
																		<th>?????????</th>
																		<td id="resEngName"></td>
																	</tr>
																	<tr>
																		<!-- &nbsp; = ?? -->
																		<th colspan="1" style="width: 84px;">??????</th>
																		<td colspan="1" style="width: 165px;" id="resAge"></td>
																		<th colspan="1" width="15%">??????</th>
																		<td colspan="1" width="200px" id="resGender"></td>

																	</tr>
																	<tr>
																		<th colspan="1">????????????</th>
																		<td colspan="3" id="resBirth"></td>
																	</tr>
																	<tr>
																		<th>??????</th>
																		<td colspan="4" id="resAddress"></td>
																	</tr>
																	<tr>
																		<th rowspan="2">?????????</th>
																		<th>H.P</th>
																		<td colspan="4" id="resPhone">000-0000-0000</td>
																	</tr>
																	<tr>
																		<th>Email</th>
																		<td colspan="4" id="resEmail">test@test.com</td>
																	</tr>
																	<tr>
																		<th rowspan="3">????????????</th>
																		<th>????????????</th>
																		<td colspan="4" id="resLastEdu">???????????????</td>
																	</tr>
																	<tr>
																		<th>??????</th>
																		<td colspan="4" id="resMajor">??????????????????</td>
																	</tr>
																	<tr>
																		<th>??????</th>
																		<td colspan="4" id="resGrade">4.0/4.5</td>
																	</tr>

																</table>
															</div>
															<input type="button" name="next"
																class="next action-button" value="??????" />
														</fieldset>
														<fieldset>
															<div class="form-card">
																<h2 class="fs-title">?????????</h2>
																<table border id="resumeTable">
																	<tr>
																		<th>????????????</th>
																		<th>?????????/??????</th>
																		<th>?????????</th>
																	</tr>
																	<tbody id="resCert">
																	</tbody>
																</table>

																<h2 class="fs-title" style="margin-top: 100px">????????????</h2>
																<table border id="resumeTable">
																	<tr>
																		<th>??????</th>
																		<th>????????????</th>
																		<th>??????</th>
																		<th>?????????</th>
																	</tr>
																	<tbody id="resFor">
																	</tbody>
																</table>
															</div>
															<input type="button" name="previous"
																class="previous action-button-previous" value="??????" /> <input
																type="button" name="next" class="next action-button"
																value="??????" />
														</fieldset>
														<fieldset>
															<div class="form-card">
																<h2 class="fs-title">????????????</h2>
																<table border id="resumeTable">
																	<tbody id="resCarr_C">
																	</tbody>
																</table>
																<h2 class="fs-title" style="margin-top: 100px">????????????</h2>
																<table border id="resumeTable">
																	<tbody id="resCarr_E">
																	</tbody>
																</table>

															</div>
															<input type="button" name="previous"
																class="previous action-button-previous" value="??????" /> <input
																type="button" name="next" class="next action-button"
																value="??????" />
														</fieldset>

														<fieldset>
															<div class="form-card">
																<h2 class="fs-title">????????????</h2>
																<table border id="resumeTable">
																	<tbody id="resPro">
																	</tbody>
																</table>
															</div>
															<input type="button" name="previous"
																class="previous action-button-previous" value="??????" /> <input
																type="button" name="next" class="next action-button"
																value="??????" />
														</fieldset>

														<fieldset>
															<div class="form-card">
																<h2 class="fs-title">???????????????</h2>
																<table border id="resumeTable">
																	<tr>
																		<th style="width: 98px;">????????????</th>
																		<td id="resCtx1"></td>
																	</tr>
																	<tr>
																		<th>????????????</th>
																		<td id="resCtx2"></td>
																	</tr>
																	<tr>
																		<th>??????(???/??????)</th>
																		<td id="resCtx3"></td>
																	</tr>
																	<tr>
																		<th>???????????? ??? ????????????</th>
																		<td id="resCtx4"></td>
																	</tr>
																	<tr>
																		<th>????????????</th>
																		<td id="resCtx5"></td>
																	</tr>


																</table>
															</div>
															<input type="button" name="previous"
																class="previous action-button-previous" value="??????" />
														</fieldset>
													</form>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- <div class="partnerInfoModalBody" style="text-align: left">
                        <div class="row">
                           <div class="col-3" style="color: #444444; font-weight: bold">
                              <p> ?? </p>
                              <p> ?? </p>
                              <p>     </p>
                              <p> ??   </p>
                              <p>      ??</p>
                           </div>
                           <div class="col-8">
                              <p id="partner_info"></p>
                              <p id="partner_addr"></p>
                              <p id="partner_headcnt"></p>
                              <p id="partner_email"></p>
                              <p id="partner_purl"></p>
                           </div>
                        </div>
                     </div> -->
						</div>
						<div class="modal-footer">
							<button type="button" id="reset" class="btn btn-default"
								data-dismiss="modal">??????</button>
						</div>
					</div>

				</div>
			</div>

			<section id="tabs" class="project-tab">
				<div>
					<div class="row">
						<div class="col-md-12">
							<nav style="margin-top: 30px;">

								<ul class="nav nav-tabs" id="myTab" role="tablist">
									<li class="nav-item"><a id="firstNav" href="#nav-home"
										data-toggle="tab" onclick="tabtab('#nav-home')"
										class="nav-link active">????????? ??????</a></li>
									<li class="nav-item"><a id="secondNav" href="#nav-profile"
										data-toggle="tab" onclick="tabtab('#nav-profile')"
										class="nav-link">?????? ??????</a></li>
								</ul>
							</nav>

							<div class="tab-content" id="nav-tabContent">
								<div class="tab-pane fade show active" id="nav-home"
									role="tabpanel" aria-labelledby="nav-home-tab">
									<%--                ??  ??         ??                 --%>
									<table class="table" cellspacing="0" >
										<thead style="border-bottom: 2px solid #dee2e6;">
											<tr>
												<th style="border-bottom: 2px solid #dee2e6;">??????</th>
												<th style="border-bottom: 2px solid #dee2e6;">?????????</th>
												<th style="border-bottom: 2px solid #dee2e6;">??? ?? ??????</th>
												<%-- <c:forEach var="apList" items="${applyList}">
                                    <c:choose>
                                    <c:when test="${apList.partnerApplyState != '      '}">
                                     --%>
												<th style="border-bottom: 2px solid #dee2e6;">?????? ??????</th>

												<%-- </c:when>
                                    </c:choose>
                                    </c:forEach>
                                  --%>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="apList" items="${applyList}">
												<tr align="center">
													<td>${apList.memberVO.userName}</td>
													<td><a class="info" data-toggle="modal"
														href="#myModal"
														onclick="getResumeInfo('${apList.partnerApplyResumeID}','${apList.memberVO.userId}','${apList.memberVO.userName}','${apList.resumeVO.resumePic}');">
															<i class="fas fa-search"></i>
													</a></td>
													<c:choose>
														<c:when test="${apList.partnerApplyState == '?????????'}">
															<td><a style="text-decoration: underline" href="#"
																onclick="chk_passOrFail('${apList.memberVO.userId}','${apList.memberVO.userName}','${apList.partnerApplyPartnerID}');"><i
																	class="fas fa-user-check"></i></a></td>
															<td></td>
														</c:when>
														<c:when test="${apList.partnerApplyState == '??????   '}">
															<td style="color: blue;">${apList.partnerApplyState}</td>
															<td><a style="text-decoration: underline" href="#"
																onclick="chk_reset('${apList.memberVO.userId}','${apList.memberVO.userName}','${apList.partnerApplyPartnerID}');"><i
																	class="fas fa-user-edit"></i></a>
														</c:when>
														<c:otherwise>
															<td style="color: red;">${apList.partnerApplyState}</td>
															<td><a style="text-decoration: underline" href="#"
																onclick="chk_reset('${apList.memberVO.userId}','${apList.memberVO.userName}','${apList.partnerApplyPartnerID}');"><i
																	class="fas fa-user-edit"></i></a>
														</c:otherwise>
													</c:choose>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
								<div class="tab-pane fade" id="nav-profile" role="tabpanel"
									aria-labelledby="nav-profile-tab">
									<%--                            --%>
									<table class="table" cellspacing="0">
										<thead>
											<tr>
												<th style="border-bottom: 2px solid #dee2e6;">??????</th>
												<th style="border-bottom: 2px solid #dee2e6;">?????????</th>
												<th style="border-bottom: 2px solid #dee2e6;">????????????</th>
												<th style="border-bottom: 2px solid #dee2e6;">??????</th>

											</tr>
										</thead>
										<tbody>
											<c:forEach var="sugList" items="${suggestionList}">
												<tr>
													<td>${sugList.userName}</td>
													<td><a class="info" data-toggle="modal"
														href="#myModal"
														onclick="getResumeInfo('${sugList.resumeVO.resumeID}','${sugList.userId}','${sugList.userName}','${sugList.resumeVO.resumePic}');">
															<i class="fas fa-search"></i>
													</a></td>

													<c:choose>
														<c:when
															test="${sugList.suggestionVO.partnerSuggestionAcception == null}">
															<td><a style="text-decoration: underline" href="#"
																onclick="suggestToUser('${sugList.userId}','${partner.partnerLicenseNum}','${sugList.userName}');return false;"><i
																	class="fas fa-hands-helping"></i></a></td>
														</c:when>
														<c:when
															test="${sugList.suggestionVO.partnerSuggestionAcception == '??????'}">
															<td style="color: blue;">${sugList.suggestionVO.partnerSuggestionAcception}</td>
														</c:when>
														<c:when
															test="${sugList.suggestionVO.partnerSuggestionAcception == '??????'}">
															<td style="color: green;">${sugList.suggestionVO.partnerSuggestionAcception}</td>
														</c:when>
														<c:otherwise>
															<td style="color: red;">${sugList.suggestionVO.partnerSuggestionAcception}</td>
														</c:otherwise>
													</c:choose>
													<c:choose>
														<c:when
															test="${sugList.suggestionVO.partnerSuggestionPartnerD != null }">
															<td><a style="text-decoration: underline" href="#"
																onclick="deleteSuggestion('${sugList.userId}','${partner.partnerLicenseNum}');"><i
																	class="fas fa-user-times"></i></a></td>
														</c:when>
														<c:otherwise>
															<td></td>
														</c:otherwise>
													</c:choose>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>
</body>
</html>