<%@ page contentType="text/html; charset=EUC-KR" %>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mMgr" class="www.MemberMgr"/>

<%
	  String id=request.getParameter("id");
	  boolean result = mMgr.deleteMember(id);
	  if(result){
%>
<script type="text/javascript">
		alert("Ż�� �����Ͽ����ϴ�.");
</script>

<%
	if (session.getAttribute("admin")==null){
		%> <script>location.href="logout.jsp";</script>
	<%}else{ %>
		<script>location.href="../admin.jsp";</script>
	<% }%>
<% }else{%>
<script type="text/javascript">
		alert("Ż�� �����߽��ϴ�.");
		history.back();
</script>
<%} %>