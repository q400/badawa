<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/inc/bsfCode.asp" -->
<%
	dbo()
	seq							= SQLI(Request("seq"))
	uname						= SQLI(Request("uname"))
	unamee						= SQLI(Request("unamee"))
	memid						= SQLI(Request("memid"))
	mempw01					= SQLI(Request("mempw01"))
	mempw02					= SQLI(Request("mempw02"))
	tel1							= SQLI(Request("tel1"))
	tel2							= SQLI(Request("tel2"))
	tel3							= SQLI(Request("tel3"))
	hp1							= SQLI(Request("hp1"))
	hp2							= SQLI(Request("hp2"))
	hp3							= SQLI(Request("hp3"))
	email1							= SQLI(Request("email1"))
	email2							= SQLI(Request("email2"))
	email3							= SQLI(Request("email3"))
	zip								= SQLI(Request("zip"))
	zip1							= SQLI(Request("zip1"))
	zip2							= SQLI(Request("zip2"))
	addr							= SQLI(Request("addr"))
	addr1							= SQLI(Request("addr1"))
	addr2							= SQLI(Request("addr2"))
	memtype						= SQLI(Request("memtype"))

	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	cd4							= SQLI(Request("cd4"))
	page							= SQLI(Request("page"))
	flag							= Request("flag")

	If flag = "" Then flag = "M"

	If email2 = "직접입력" Then
		email0 = email1 &"@"& email3
	Else
		email0 = email1 &"@"& email2
	End If

	Set cx = New BsfCode
'	Response.Write "flag : "& flag &"<br>"

	If flag = "M" Then
		SQL = "	UPDATE _omemt010 SET " _
			& " uname			= '"& uname &"'"
		If mempw01 <> "" Then
		SQL = SQL & "" _
			& ",mempw			= '"& cx.SetEncode(mempw01) &"'"
		End If
		SQL = SQL & "" _
			& ",unamee			= '"& unamee &"'" _
			& ",tel					= '"& tel1 & tel2 & tel3 &"'" _
			& ",hp				= '"& hp1 & hp2 & hp3 &"'" _
			& ",zip				= '"& zip &"'" _
			& ",addr1				= '"& addr &"'" _
			& ",addr2				= '"& addr2 &"'" _
			& ",email				= '"& cx.SetEncode(email0) &"'" _
			& ",memtype			= "& memtype _
			& " WHERE seq		= "& seq
'		Response.Write SQL &"<br>"
		dbcon.Execute SQL
'		Response.Redirect "mem_v.asp?seq="& seq &"&page="& page &"&cd1="& cd1 &"&cd2="& cd2 &"&cd3="& cd3 &"&cd4="& cd4

	ElseIf flag = "D" Then
		SQL = " DELETE FROM _omemt010 WHERE seq = "& seq
		dbcon.Execute SQL
'		Response.Redirect "mem.asp?page="& page &"&cd1="& cd1 &"&cd2="& cd2 &"&cd3="& cd3 &"&cd4="& cd4

	End If
	rsc()

	Set cx = Nothing
%>
<form name="fm1" id=fm1>
<input type="hidden" name="seq" value="<%=seq%>" />
<input type="hidden" name="memid" value="<%=memid%>" />
<input type="hidden" name="page" value="<%=page%>" />
<input type="hidden" name="cd1" value="<%=cd1%>" />
<input type="hidden" name="cd2" value="<%=cd2%>" />
<input type="hidden" name="cd4" value="<%=cd4%>" />
<input type="hidden" name="flag" />
</form>
<script>
<%	If flag = "M" Then %>
	alert("수정되었습니다.");
	document.fm1.action = "mem_v.asp";
<%	ElseIf flag = "D" Then %>
	alert("삭제되었습니다.");
	document.fm1.action = "mem.asp";
<%	End If %>
	document.fm1.method = "post";
	document.fm1.target = "_top";
	document.fm1.submit();
</script>
<%	dbc() %>