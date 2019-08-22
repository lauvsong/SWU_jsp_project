<%@ page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="bMgr" class="www.BoardMgr"/>
<%
	  bMgr.insertBoard(request);
	  response.sendRedirect("list.jsp");
%>