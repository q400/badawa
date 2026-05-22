<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/inc/bsfCode.asp" -->
<%
	dbo()
	unamee						= SQLI(Request("unamee"))
	pw01						= SQLI(Request("pw01"))
	pw02						= SQLI(Request("pw02"))
	tel1						= SQLI(Request("tel1"))
	tel2						= SQLI(Request("tel2"))
	tel3						= SQLI(Request("tel3"))
	hp1							= SQLI(Request("hp1"))
	hp2							= SQLI(Request("hp2"))
	hp3							= SQLI(Request("hp3"))
	email1						= SQLI(Request("email1"))
	email2						= SQLI(Request("email2"))
	email3						= SQLI(Request("email3"))
	zip							= SQLI(Request("zip"))
	addr						= SQLI(Request("addr"))

	If email2 = "직접입력" Then
		email0 = email1 &"@"& email3
	Else
		email0 = email1 &"@"& email2
	End If

	Set cx = New BsfCode

		SQL = "	UPDATE	_omemt010 SET " _
			& "			tel				= '"& tel1 & tel2 & tel3 &"'" _
			& ",		unamee			= '"& unamee &"'" _
			& ",		hp				= '"& hp1 & hp2 & hp3 &"'"
		If pw01 <> "" Then
		SQL = SQL & ",	mempw			= '"& cx.SetEncode(pw01) &"'"
		End If
		SQL = SQL & ",	zip				= '"& zip &"'" _
			& ",		addr1			= '"& addr &"'" _
			& ",		addr2			= ''" _
			& ",		email			= '"& cx.SetEncode(email0) &"'" _
			& " WHERE	seq = "& FID_NO
'		Response.Write SQL &"<br>"
		dbcon.Execute SQL

		Call directGo("회원정보가 수정되었습니다.", "mod.asp")
		Response.End

	Set cx = Nothing
	dbc()
%>