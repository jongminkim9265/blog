<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<%--head.jsp--%>
<%@ include file="/WEB-INF/views/includes/head.jsp" %>

<body class="sidebar-mini layout-fixed vsc-initialized sidebar-collapse">
<div class="wrapper">

    <%--main_header.jsp--%>
    <%-- Main Header --%>
    <%@ include file="/WEB-INF/views/includes/main_header.jsp" %>

    <%--left_column.jsp--%>
    <%-- Left side column. contains the logo and sidebar --%>
    <%@ include file="/WEB-INF/views/includes/left_column.jsp" %>
    	
    <div class="content-wrapper">
        <%-- Content Header (Page header) --%>
        	<section class="content-header">
            <h1> 게시판 
            <small>목록</small>
            </h1>
       <ol class="breadcrumb">
                <li class = "breadcrumb-item"><a href="${pageContext.request.contextPath }/boardList"><i class="fa fa-dashboard"></i> 게시판</a></li>
                <li class="breadcrumb-item active"> 일반</li>
                
            </ol>
        </section> 
		<div class="card">
			<div class="card-header">
				<h4 class ="card-title">${map.TITLE}</h4>
				</div>
				<div class="card-body">
				<h6 class ="card-subtitle-text-muted mb-4">
					<i class="fas fa-user"></i>
					${map.CREA_ID }
					<i class="fas fa-clock"></i>
					${map.CREA_DATE }
					<i class="fas fa-check-square"></i>
					${map.HIT_CNT}
				</h6>
				<p class="card-text">${map.CONTENTS }</p>
			</div>
			<div class="card-body">
				 
					<a class = "card-body-item" href='<c:url value='/boardUpdate${pageMaker.makeQueryPage(map.IDX, page) }'/>' >수정</a>
					<a href='<c:url value='/boardDelete${pageMaker.makeQueryPage(map.IDX, page) }'/>' >삭제</a>
			</div>
			<div class="card-body">
				<a href = '<c:url value = '/boardList${pageMaker.makeQueryPage(page) }'/>' class ="btn btn-info" role = "button">목록으로</a>
			</div>
			<c:choose>
    <c:when test="${fn:length(list) > 0 }">
        <ul>
        <c:forEach items="${list }" var="file">
            <li> 
                <div class="card-body">
                
                	<input type = "hidden" id = "IDX" value = "${file.IDX }"/>
                    <a href = "#this" name = "file">${file.ORIGINAL_FILE_NAME } </a>
                    
                   ${file.FILE_SIZE }kb
                </div>
            </li>
        </c:forEach>
        </ul>
    	</c:when>
	</c:choose>
		</div>
	
	<div class="card" style ="padding-top : 10px">
		<form name = "form" id="form" method="POST">
			<input type = "hidden" id= "IDX" name="IDX"/>
			<div class = "card-body">			
						<div class = "card-body-item">
						<textarea path="replyText" id="replyText" class="form-control" rows="3" placeholder="댓글을 입력해 주세요"></textarea>
						<input type = "hidden" path= "replywriter" id = "replywriter" value = "<%=session.getAttribute("name") %>"/>
						<input type = "hidden" path= "board_IDX" id = "board_IDX" value = "${map.IDX }"/>
						</div>
						<div class = "card-body">
							<button type = "button" class = "btn btn-success float-right" id= "btnReplySave">등 록
							</button>
						</div>	
			
			</div>
		</form>
	</div>
	<div class="card" style ="padding-top : 10px">
	
					<h6 class="card-body-item">Reply list</h6>
					<div id="replyList">
					</div>

	</div>
	<%-- <div class="card-body">
           <ul class = "pagination pagination-sm m-0 float-right ">
           			<c:if test="${pageMaker.prev }">
            		<li class = "page-item">
            			<a class="page-link" href='<c:url value="/restBoard/replyList?${pageMaker.makeQueryPage(pageMaker.startPage-1) }"/>' >이전</a>           	
            		</li>
            		</c:if>
            		<c:forEach begin="${pageMaker.startPage }" end= "${pageMaker.endPage }" var = "pageNum">
            		<li class = "page-item">
            			<a class="page-link" href='<c:url value="/restBoard/replyList?${pageMaker.makeQueryPage(pageNum) }"/>'>${pageNum }</a>
            		</c:forEach>
            		<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
            		<li class = "page-item">
            			<a class="page-link" href='<c:url value="/restBoard/replyList?${pageMaker.makeQueryPage(pageMaker.endPage+1) }"/>'>다음</a>
            		</li>
            		</c:if>
           </ul>
          	
        
        </div>   --%>
	</div>	
	<%@ include file="/WEB-INF/views/includes/include-body.jspf" %>
	 <script type="text/javascript">
	 
	 $(document).ready(function(){ 
		 
		 $("a[name='file']").on("click", function(e){
			 //파일 이름 
			 e.preventDefault();
			 fn_downloadFile($(this));
			 });
		 showReplyList();
		
		 function fn_downloadFile(obj){
			 var idx = obj.parent().find("#IDX").val();
			 var comSubmit = new ComSubmit();
			 comSubmit.setUrl("<c:url value='/downloadFile' />");

			 if(gfn_isNull($("[name='IDX']").val())==false){
			 $("[name='IDX']").remove();
			 }
			 
			 comSubmit.addParam("IDX",idx);
			 comSubmit.submit();
			 
			 }
	 });
	 function showReplyList(){

			var url = "${pageContext.request.contextPath}/restBoard/replyList?${_csrf.parameterName}=${_csrf.token}";

			var paramData = {"IDX" : "${map.IDX}"};
			$.ajax({
				type: 'POST',

	            url: url,

	            data: paramData,

	            dataType: 'json',

	            success: function(result) {

	               	var htmls = "";

				if(result.length < 1){

					var htmls = "<p class= 'card-text'>등록된 댓글이 없습니다.</p>";

				} else {

					 $(result).each(function(){
							
		                     htmls += '<div class="media text-muted pt-3" id="replyIDX' + this.reply_IDX + '">';

		                     htmls += '<svg class="bd-placeholder-img mr-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder:32x32">';

		                     htmls += '<title>Placeholder</title>';

		                     htmls += '<rect width="100%" height="100%" fill="#007bff"></rect>';

		                     htmls += '<text x="50%" fill="#007bff" dy=".3em">32x32</text>';

		                     htmls += '</svg>';

		                     htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';

		                     htmls += '<span class="d-block">';

		                     htmls += '<strong class="text-gray-dark">' + this.reply_writer + '</strong>';

		                     htmls += '<span style="padding-left: 7px; font-size: 9pt">';
							 
		                     htmls += '<a href="javascript:void(0)" onclick="fn_editReply(' + this.reply_IDX + ', \'' + this.reply_writer + '\', \'' + this.reply_text + '\' )" style="padding-right:5px">수정</a>';
		                     htmls += '<a href="javascript:void(0)" onclick="fn_deleteReply(' + this.reply_IDX + ', \'' + this.reply_writer+ '\')" >삭제</a>';
		                     htmls += '</span>';
		                     htmls += '</span>';
		                     htmls += this.reply_text;
		                     htmls += '</p>';
		                     htmls += '</div>';

				});



				}

	            $("#replyList").html(htmls);

	                

	            }	   // Ajax success end

			});	// Ajax end

		}
	 $(document).on('click','#btnReplySave', function(){
		 var replyContent = $('#replyText').val();
		 var replyReg_id = $('#replywriter').val();
		 var board_idx = $('#board_IDX').val();
		 
		 if (replyReg_id == null)
		{
			 replyReg_id = "익명";
		}
		 
		 
		 var paramData = JSON.stringify({"replyText" : replyContent
							, "replywriter" : replyReg_id
							, "b_idx" : board_idx
		});
		 
		 var headers = {"Content-Type" : "application/json"
				 		, "X-HTTP-Method-Override" : "POST"};
		 $.ajax({
			 url : "${pageContext.request.contextPath}/restBoard/saveReply?${_csrf.parameterName}=${_csrf.token}"
			 , headers : headers
			 , data : paramData
			 , type : 'POST'
			 , dataType : 'text'
			 , success: function(result){
				 showReplyList();
				 
				 $('#replyText').val();
				 $('#reg_date').val();
			 }
			 , error: function(error){
				 console.log("에러: " + error);
			 }
		 });
	 	 /* sock = new SockJS('/blog/chat');
		 socket = sock;
		  
		 sock.onopen = function(event) {
			console.log('connection server'); 
		 };
		 sock.onclose = function() {
			console.log('connect close'); 
		 };
		 sock.onmessage=function(event){
			 var data = evt.data;
	    	   console.log(data)
	  		   var obj = JSON.parse(data)  	   
	    	   console.log(obj)
	    	   
		    };
		 sock.oneror = function (err) {
			 response.setStatus(200);
		 };
		  var AlarmData = {
					"myAlarm_receiverId" : replyReg_id,
					"myAlarm_title" : "댓글 작성",
					"myAlarm_content" :  replyReg_id + "님이 댓글을 작성했습니다."
			};
		
			$.ajax({
				type : 'post',
				data : JSON.stringify(AlarmData),
				contentType: "application/json; charset=utf-8",
				dataType : 'text',
				success : function(data){
					if(socket){
						let socketMsg = "reply," + replyReg_id +","+ board_idx;
						console.log("msgmsg : " + socketMsg);
						socket.send(socketMsg);
					}
		 
				},
				error : function(err){
					console.log(err);
				}
			});   */
	  
	 });
	 
	 function fn_editReply(replyIDX, reply_writer, reply_text){
		 	var current_user = "<%=session.getAttribute("name") %>"; 
			if (current_user != reply_writer)
			{
				alert("권한이 없습니다. ");
			}
			else{
			var htmls = "";
			
			htmls += '<div class="media text-muted pt-3" id="replyIDX' + replyIDX + '">';

			htmls += '<svg class="bd-placeholder-img mr-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder:32x32">';

			htmls += '<title>Placeholder</title>';

			htmls += '<rect width="100%" height="100%" fill="#007bff"></rect>';

			htmls += '<text x="50%" fill="#007bff" dy=".3em">32x32</text>';

			htmls += '</svg>';

			htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';

			htmls += '<span class="d-block">';

			htmls += '<strong class="text-gray-dark">' + reply_writer + '</strong>';

			htmls += '<span style="padding-left: 7px; font-size: 9pt">';

			htmls += '<a href="javascript:void(0)" onclick="fn_updateReply(' + replyIDX + ', \'' + reply_writer + '\')" style="padding-right:5px">저장</a>';

			htmls += '<a href="javascript:void(0)" onClick="showReplyList()">취소<a>';

			htmls += '</span>';

			htmls += '</span>';		

			htmls += '<textarea name="editContent" id="editContent" class="form-control" rows="3">';

			htmls += reply_text;

			htmls += '</textarea>';

			

			htmls += '</p>';

			htmls += '</div>';
		

			$('#replyIDX' + replyIDX).replaceWith(htmls);

			$('#replyIDX' + replyIDX + ' #editContent').focus();
			}
		}
	 function fn_updateReply(replyIDX){

			var replyEditContent = $('#editContent').val();
			var replyReg_id = $('#replywriter').val();
			

			var paramData = JSON.stringify({"replyText": replyEditContent
					, "replyIDX": replyIDX
					, "replywriter" : replyReg_id

			});

			

			var headers = {"Content-Type" : "application/json"

					, "X-HTTP-Method-Override" : "POST"};

			

			$.ajax({

				url: "${pageContext.request.contextPath}/restBoard/updateReply?${_csrf.parameterName}=${_csrf.token}"

				, headers : headers

				, data : paramData

				, type : 'POST'

				, dataType : 'text'

				, success: function(result){

	                                console.log(result);

					showReplyList();

				}

				, error: function(error){

					console.log("에러 : " + error);

				}

			});

		}
		function fn_deleteReply(replyIDX,reply_writer){
			var current_user = "<%=session.getAttribute("name") %>"; 
			if (current_user != reply_writer)
			{
				alert("권한이 없습니다. ");
			}
			else{
			var paramData = {"replyIDX": replyIDX};
			
			$.ajax({
				url: "${pageContext.request.contextPath}/restBoard/deleteReply?${_csrf.parameterName}=${_csrf.token}"
				, data : paramData
				, type : 'POST'
				, dataType : 'text'
				, success : function(result) {
					showReplyList();
				}
				, error: function(error){
					console.log("에러 :" + error);
				}
			});
			}
			
		}
		
		
	</script>

 
     <%-- /.content-wrapper --%>

	    <%--main_footer.jsp--%>
	    <%-- Main Footer --%>
	    <%@ include file="/WEB-INF/views/includes/main_footer.jsp" %>
        </div>
		<%-- ./wrapper --%>

		<%--plugin_js.jsp--%>
		<%@ include file="/WEB-INF/views/includes/plugin_js.jsp" %>
		        
        </body>
        </html>
        