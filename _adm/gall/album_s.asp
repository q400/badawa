<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	flag						= SQLI(Request("flag"))
	size						= SQLI(Request("ssize"))
	cnt							= SQLI(Request("ccnt"))
	oz							= SQLI(Request("oz"))

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
	rtn = sz * cnt
	Response.Write "rtn : "& rtn &"<br>"
%>

<script language="javascript">
<!--
function init(){
	parent.document.all.cost"+<%=oz%>+".value = "<%=rtn%>";
}
window.onload = init;
-->
</script>