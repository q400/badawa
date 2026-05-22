<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/inc/bsfCode.asp" -->
<%
	dbo()
	ridx						= SQLI(Request("ridx"))
	shipid						= SQLI(Request("shipid"))
	rdate						= Replace(SQLI(Request("rdate")),"-","")
	rnm							= SQLI(Request("rnm"))
	inwon						= SQLI(Request("inwon"))
	gubn						= SQLI(Request("gubn"))				'D-독선/G-개인(합승)
	tel							= SQLI(Replace(Request("tel"),"-",""))
'	tel1						= SQLI(Request("tel1"))
'	tel2						= SQLI(Request("tel2"))
'	tel3						= SQLI(Request("tel3"))
	hp							= SQLI(Replace(Request("hp"),"-",""))
'	hp1							= SQLI(Request("hp1"))
'	hp2							= SQLI(Request("hp2"))
'	hp3							= SQLI(Request("hp3"))
	email1						= SQLI(Request("email1"))
	email2						= SQLI(Request("email2"))
	email3						= SQLI(Request("email3"))
	rmoney						= SQLI(Request("rmoney"))
	pwd0						= SQLI(Request("pwd"))
	memo						= SQLI(Request("memo"))
	flag						= SQLI(Request("flag"))

	If email2 = "직접입력" Then
		email0 = email1 &"@"& email3
	Else
		If email1 = "" Then
			email0 = ""
		Else
			email0 = email1 &"@"& email2
		End If
	End If

	Set cx = New BsfCode

	If rmoney = "" Then rmoney = 0

	SQL = "	INSERT INTO _orsvt010 (rdate, uno, rnm, inwon, tel, hp, email, shipid, gubn, status, rmoney, pwd, uip, ddate, memo) VALUES (" _
		& "			'"& rdate &"'" _
		& ",		'"& FID_NO &"'" _
		& ",		'"& rnm &"'" _
		& ",		0 " _
		& ",		'"& tel &"'" _
		& ",		'"& hp &"'" _
		& ",		'"& cx.SetEncode(email0) &"'" _
		& ",		"& shipid _
		& ",		'"& gubn &"'" _
		& ",		'C'" _
		& ",		"& rmoney _
		& ",		'"& cx.SetEncode(pwd0) &"'" _
		& ",		'"& Request.ServerVariables("REMOTE_ADDR") &"'" _
		& ",		getdate()" _
		& ",		'"& memo &"'" _
		& ")"
	dbcon.Execute SQL

	rso()
	SQL = " SELECT MAX(ridx) FROM _orsvt010 "
	rs.open SQL, dbcon
		mxidx = CLng(rs(0))
	rsc()

	Set cx = Nothing
	dbc()

	noAlertGo("bookdiv.asp?ridx="& mxidx &"&shipid="& shipid &"&rdate="& rdate)
	Response.End
%>