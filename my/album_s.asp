<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	flag						= SQLI(Request("flag"))
	size						= SQLI(Request("ssize"))
	cnt							= SQLI(Request("ccnt"))
	oz							= SQLI(Request("oz"))
	total						= 0

	If flag = "inhwa" Then
		Select Case size
			Case "1"	: sz = 2500
			Case "2"	: sz = 5000
			Case Else	: sz = 0
		End Select
	Else
		Select Case size
			Case "1"	: sz = 15000
			Case "2"	: sz = 20000
			Case Else	: sz = 0
		End Select
	End If

	rtn							= sz * cnt
'	total						= total + rtn

'	Response.Write "rtn : "& rtn &"<br>"
%>

<script language="javascript">
<!--
function init() {
	parent.document.all.cost<%=oz%>.value = "<%=rtn%>";
//	parent.document.all.total.value = "<%=total%>";
}
window.onload = init;
//-->
</script>