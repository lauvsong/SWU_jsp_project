<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="www.MemberBean, java.util.*"%>
<%
	request.setCharacterEncoding("EUC-KR");
%>
<jsp:useBean id="mMgr" class="www.MemberMgr"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link href="style.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
<script type="text/javascript">
	function MySubmit(num, id){
		if (num==1)
			document.form.action="member/memberUpdate.jsp?id="+id;
		if (num==2)
			document.form.action="member/memberDelete.jsp?id="+id;
		document.form.submit();
	}	
</script>
</head>
<body>
<%
	Vector<MemberBean> vlist=null;
	vlist=mMgr.memberTable();
	if(vlist.isEmpty())
		out.println("���Ե� ȸ���� �����ϴ�.");
	else{
		int listsize=vlist.size();
	%>
	<form method="post" name="form">
		<table border="0" width="100%" cellpadding="2" cellspacing="0">
					<tr align="center" bgcolor="#D0D0D0" height="120%">
						<td>���̵�</td>
						<td>��й�ȣ</td>
						<td>�̸�</td>
						<td>����</td>
						<td>����</td>
						<td>�̸���</td>
						<td>���θ��ּ�</td>
						<td>�ּ�</td>
						<td>����</td>
					</tr>
	<% 
		for (int i=0;i<listsize;i++){
			MemberBean bean = new MemberBean();
			bean=vlist.get(i);
	%>
		<tr>
			<td><%=bean.getId()%></td>
			<td><%=bean.getPwd()%></td>
			<td><%=bean.getName()%></td>
			<td><%=bean.getGender()%></td>
			<td><%=bean.getBirthday()%></td>
			<td><%=bean.getEmail()%></td>
			<td><%=bean.getZipcode()%></td>
			<td><%=bean.getAddress()%></td>
			<td><%=bean.getJob()%></td>
			<td><input type="button" value="����" onclick="MySubmit(1,'<%=bean.getId() %>')"></td>
			<td><input type="button" value="����" onclick="MySubmit(2, '<%=bean.getId()%>')"></td>
		</tr>
		<%} %>
		</table>
		</form> 
	<% }%>
</body>
</html>