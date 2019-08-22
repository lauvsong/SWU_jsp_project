<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="cMgr" class="www.CommentMgr"/>
<%
	String id=(String)session.getAttribute("idKey");
	String comment=request.getParameter("comment");
	int number=Integer.parseInt(request.getParameter("num"));
	int bnum=Integer.parseInt(request.getParameter("bnum"));
	
	cMgr.deleteComment(number);
%>
<script>location.href="read.jsp?num=<%=bnum%>"</script>