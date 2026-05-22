<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	op							= SQLI(Request("op"))			'닉네임

	rso()
	SQL = " SELECT COUNT(*) FROM _omemt010 WHERE memid = '"& op &"' "
	rs.open SQL, dbcon
	If Not(rs.Eof Or rs.Bof) Then
		idcnt = CInt(rs(0))
	End If
	rsc()
	dbc()

	If idcnt <> 0 Then
%>
<script language="javascript">
<!--
function init(){
	alert("이미 사용중인 ID입니다. 다른 것을 입력하세요.");
	parent.document.fm1.memid.value = "";
	parent.document.fm1.memid.focus();
	parent.document.fm1.checkIdFlag.value = "";
}
window.onload = init;
-->
</script>
<%
	Else
%>
<script language="javascript">
<!--
function init(){
	alert("사용 가능한 ID입니다.");
	parent.document.fm1.memid.value = "<%=op%>";
	parent.document.fm1.pw01.focus();
	parent.document.fm1.checkIdFlag.value = "Y";
}
window.onload = init;
-->
</script>
<%	End If %>