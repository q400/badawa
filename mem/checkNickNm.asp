<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	op							= SQLI(Request("op"))			'닉네임

	rso()
	SQL = " SELECT	COUNT(*) FROM _omemt010 WHERE unamee = '"& op &"' "
	rs.open SQL, dbcon
	If Not(rs.Eof Or rs.Bof) Then
		nickcnt = CInt(rs(0))
	End If
	rsc()
	dbc()

	If nickcnt <> 0 Then
%>
<script language="javascript">
<!--
function init(){
	alert("이미 사용중인 닉네임입니다. 다른 것을 입력하세요.");
	parent.document.fm1.unamee.value = "";
	parent.document.fm1.unamee.focus();
	parent.document.fm1.checkNickNmFlag.value = "";
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
	alert("사용 가능한 닉네임입니다.");
	parent.document.fm1.unamee.value = "<%=op%>";
	parent.document.fm1.memid.focus();
	parent.document.fm1.checkNickNmFlag.value = "Y";
}
window.onload = init;
-->
</script>
<%	End If %>