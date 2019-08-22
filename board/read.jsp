<%@ page contentType="text/html; charset=EUC-KR"%>
<%@page import="www.BoardBean,www.CommentBean,java.util.*"%>
<%
	String id = (String)session.getAttribute("idKey");
	request.setCharacterEncoding("EUC-KR");
%>
<jsp:useBean id="bMgr" class="www.BoardMgr" />
<jsp:useBean id="cMgr" class="www.CommentMgr" />
<%
	  int num = Integer.parseInt(request.getParameter("num"));
	  String nowPage = request.getParameter("nowPage");
	  String keyField = request.getParameter("keyField");
	  String keyWord = request.getParameter("keyWord");
	  bMgr.upCount(num);//조회수 증가
	  BoardBean bBean = bMgr.getBoard(num);//게시물 가져오기
	  String name = bBean.getName();
	  String subject = bBean.getSubject();
      String regdate = bBean.getRegdate();
	  String content = bBean.getContent();
	  String filename = bBean.getFilename();
	  int filesize = bBean.getFilesize();
	  String ip = bBean.getIp();
	  int count = bBean.getCount();
	  session.setAttribute("bBean", bBean);//게시물을 세션에 저장
%>
<html>
<head>
<title>JSPBoard</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function list(){
	 	document.listFrm.action="list.jsp";
	    document.listFrm.submit();
	 } 
	
	function down(filename){
		 document.downFrm.filename.value=filename;
		 document.downFrm.submit();
	}
</script>
</head>
<body bgcolor="#FFFFCC">
<%
	if (id==null){
	%>
	<script>alert("로그인이 필요합니다.");history.back();</script>
<%} %>

<br><br>
<table align="center" width="70%" border=0 cellspacing="3" cellpadding="0">
 <tr>
  <td bgcolor="#9CA2EE" height="25" align="center">글읽기</td>
 </tr>
 <tr>
  <td colspan="2">
   <table border="0" cellpadding="3" cellspacing="0" width=100%> 
    <tr> 
  <td align="center" bgcolor="#DDDDDD" width="10%"> 이 름 </td>
  <td bgcolor="#FFFFE8"><%=name%></td>
  <td align="center" bgcolor="#DDDDDD" width=10%> 등록날짜 </td>
  <td bgcolor="#FFFFE8"><%=regdate%></td>
 </tr>
 <tr> 
    <td align="center" bgcolor="#DDDDDD"> 제 목</td>
    <td bgcolor="#FFFFE8" colspan="3"><%=subject%></td>
   </tr>
   <tr> 
     <td align="center" bgcolor="#DDDDDD">첨부파일</td>
     <td bgcolor="#FFFFE8" colspan="3">
     <% if( filename !=null && !filename.equals("")) {%>
  		<a href="javascript:down('<%=filename%>')"><%=filename%></a>
  		 &nbsp;&nbsp;<font color="blue">(<%=filesize%>KBytes)</font>  
  		 <%} else{%> 등록된 파일이 없습니다.<%}%>
     </td>
   </tr>
   <tr> 
    <td colspan="4"><br><pre><%=content%></pre><br></td>
   </tr>
   <tr>
    <td colspan="4" align="right">
     <%=ip%>로 부터 글을 남기셨습니다./  조회수  <%=count%>
    </td>
   </tr>
   </table>
  </td>
 </tr>
 <tr>
 	<td><hr>댓글</td>
 </tr>
 <tr>
 	<form method="post" action="comment.jsp?num=<%=num%>">
 		<tr><td>작성자 : <input type="text" name="id" value="<%=id %>" readonly></td></tr>
 		<tr><td>내용: <textarea name="comment" cols="50" rows="10"></textarea><input type="submit" value="작성"></td></tr>
 		<%
 			Vector<CommentBean> vlist=null;
 			vlist=cMgr.getComments(num);
 			if (vlist!=null){
 				for (int i=0;i<vlist.size();i++){
 	 				CommentBean bean=new CommentBean();
 	 				bean=vlist.get(i);
 	 		%>
 	 				<tr><td><hr>작성자 : <%=bean.getId() %></td></tr>
 	 				<tr><td>내용 : <%=bean.getText() %>
 	 				<%
 	 					if (id.equals(bean.getId())||session.getAttribute("admin")!=null){
 	 				%>
 	 					<form method="post" action="deleteComment.jsp?num=<%=bean.getNum() %>&bnum=<%=num%>">
 	 						<input type="submit" value="삭제"></td></tr>
 	 					</form>		
 	 				<% 	}
 	 		 	}
 			}
 	 		%>	
 	</form>
 </tr>
 <tr>
  <td align="center" colspan="2"> 
 <hr size="1">
 [ <a href="javascript:list()" >리스트</a> | 
 <a href="update.jsp?nowPage=<%=nowPage%>&num=<%=num%>" >수 정</a> |
 <a href="reply.jsp?nowPage=<%=nowPage%>" >답 변</a> |
 <a href="delete.jsp?nowPage=<%=nowPage%>&num=<%=num%>">삭 제</a> ]<br>
  </td>
 </tr>
</table>

<form name="downFrm" action="download.jsp" method="post">
	<input type="hidden" name="filename">
</form>

<form name="listFrm" method="post">
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<%if(!(keyWord==null || keyWord.equals("null"))){ %>
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<%}%>
</form>
</body>
</html>