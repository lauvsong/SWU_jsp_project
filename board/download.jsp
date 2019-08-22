<%@ page contentType="application;charset=euc-kr"%>
<jsp:useBean id="bMgr" class="www.BoardMgr" />
<%
	  bMgr.downLoad(request, response,out,pageContext);
%>