<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/inc/bsfCode.asp" -->
<%
'************************************************************************************
'*  윈도우 명		: zip_sub.asp
'************************************************************************************

	dbo()
	sValue					= SQLI(Request("cValue"))

	If sValue = "" Then
		sValue = "-------------------------------------"
	End If

	Set cx = New BsfCode
%>

<html>
<head>
<title>ID검색</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/inc/css/basic01.css">
<script language="JavaScript" type="text/javascript" src="/inc/js/common.js"></script>
<script language="javascript">
<!--
function zipselect(pid, pemail, ptel, php1, php2, php3) {
//	var arrZipCode = pZipCode.split("-");
//	parent.parent.document.all.zip1.value = arrZipCode[0];
//	parent.parent.document.all.zip2.value = arrZipCode[1];
	parent.parent.document.all.captain.value = pid;
//	parent.parent.document.all.email.value = pemail;
	parent.parent.document.all.tel.value = ptel;
//	parent.parent.document.all.hp1.value = php1;
//	parent.parent.document.all.hp2.value = php2;
//	parent.parent.document.all.hp3.value = php3;
	parent.parent.document.all.capa0.focus();
	parent.parent.document.all.showimage.style.visibility = "hidden";
	parent.parent.document.all.overlay.style.visibility = "hidden";
}
-->
</script>

<table width="380" border="0" cellspacing="0" cellpadding="0">
<%
		rso()
		SQL = " SELECT	memid, uname, unamee, email, tel, hp FROM _omemt010 WHERE uname LIKE '%"& sValue &"%' "
'		Response.Write SQL &"<br>"
		rs.open SQL, dbcon
		While Not(rs.Eof Or rs.Bof)
			email			= cx.SetDecode(rs("email"))
'			If rs("tel") <> "" And rs("tel") <> "--" Then
'				tel1		= TelSepa(rs("tel"),1)
'				tel2		= TelSepa(rs("tel"),2)
'				tel3		= TelSepa(rs("tel"),3)
'			End If
			If rs("hp") <> "" And rs("hp") <> "--" Then
				hp1			= onTel(rs("hp"),1)
				hp2			= onTel(rs("hp"),2)
				hp3			= onTel(rs("hp"),3)
			End If
%>
	<tr height="23" bgcolor="#efefef">
		<th width="150">회원ID</th>
		<th width="230">회원이름 (닉네임)</th>
	</tr>
	<tr height="23" align="center">
		<th><a style="cursor:hand" onClick="zipselect('<%=rs("memid")%>','<%=email%>','<%=rs("tel")%>','<%=hp1%>','<%=hp2%>','<%=hp3%>')"><%=rs("memid")%></a></th>
		<td class="f12"><a style="cursor:hand" onClick="zipselect('<%=rs("memid")%>','<%=email%>','<%=rs("tel")%>','<%=hp1%>','<%=hp2%>','<%=hp3%>')"><%=rs("uname")%> (<%=rs("unamee")%>)</a></td>
	</tr>
	<tr>
		<td height="1" colspan="2"></td>
	</tr>
<%
			rs.MoveNext
		Wend
		Set cx = Nothing
		rsc()
%>
</table>
</body>
</html>
<%	dbc() %>