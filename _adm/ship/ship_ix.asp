<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	shipid						= SQLI(Request("shipid"))
	idx							= SQLI(Request("idx"))
	yy							= SQLI(Request("yy"))
	mm							= SQLI(Request("mm"))
	dd							= SQLI(Request("dd"))
	note						= SQLI(Request("note"))
	flag						= Request("flag")

	If idx <> "" Then
		If flag = "" Then flag = "M"
	Else
		If flag = "" Then flag = "W"
	End If

	If note = "탐사" Or note = "정비" Or note = "마감" Then
		etc = 3
	Else
		etc = 1
	End If

	If flag = "W" Then
		rso()
		SQL = " SELECT COUNT(*) FROM _oshpt020 WHERE shipid = "& shipid &" AND rdate = '"& yy & mm & dd &"' "
		rs.open SQL, dbcon
			rcnt = CInt(rs(0))
		rsc()

		If rcnt = 0 Then
			SQL = "	INSERT INTO _oshpt020 (shipid, rdate, note, etc, ddate) VALUES (" _
				& "		"& shipid _
				& ",	'"& yy & mm & dd &"'" _
				& ",	'"& note &"'" _
				& ",	'"& etc &"'" _
				& ",	getdate()" _
				& ")"
			dbcon.Execute SQL
		Else
			Call divAlertReload("이미 등록된 데이타가 있습니다.")
			Response.End
		End If

	ElseIf flag = "M" Then
		SQL = "	UPDATE	_oshpt020 SET " _
			& "			note		= '"& note &"'" _
			& ",		etc			= '"& etc &"'" _
			& " WHERE	idx = "& idx
		dbcon.Execute SQL

	ElseIf flag = "D" Then
		SQL = " DELETE FROM _oshpt020 WHERE idx = "& idx
		dbcon.Execute SQL

	End If

	divReload()
	dbc()
%>