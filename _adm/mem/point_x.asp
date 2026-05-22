<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	idx							= SQLI(Request("idx"))
	uno							= SQLI(Request("uno"))
	op							= SQLI(Request("op"))
	shipid						= SQLI(Request("shipid"))
	rsvid						= SQLI(Request("rsvid"))
	point						= SQLI(Request("point"))
	seq							= SQLI(Request("seq"))
	note						= SQLI(Request("note"))

	gubn						= SQLI(Request("gubn"))				'ship/talk
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))
	cbox						= SQLI(Request("cbox"))

	If flag = "" And ridx <> "" Then flag = "M"
	If flag = "" Then flag = "W"

	If flag = "M" Then

		If gubn = "ship" Then
'			SQL = " INSERT INTO _opntt020 (uno, op, shipid, rsvid, point, note, ddate) VALUES (" _
'				& "				"& uno _
'				& ",			'"& op &"'" _
'				& ",			"& shipid _
'				& ",			"& rsvid _
'				& ",			"& point _
'				& ",			'"& note &"'" _
'				& ",			getdate()" _
'				& ")"
			SQL = " UPDATE _opntt020 SET " _
				& "				op = '"& op &"'" _
				& " ,			point = "& point _
				& " ,			note = '"& note &"'" _
				& " ,			ddate = getdate()" _
				& " WHERE idx = "& idx
			Response.Write SQL &"<br>"
			dbcon.Execute SQL
			nlist = "point01"
		Else
'			SQL = " INSERT INTO _opntt010 (uno, op, seq, point, note, ddate) VALUES (" _
'				& "				"& uno _
'				& ",			'"& op &"'" _
'				& ",			"& seq _
'				& ",			"& point _
'				& ",			'"& note &"'" _
'				& ",			getdate()" _
'				& ")"
			SQL = " UPDATE _opntt010 SET " _
				& "				op = '"& op &"'" _
				& " ,			point = "& point _
				& " ,			note = '"& note &"'" _
				& " ,			ddate = getdate()" _
				& " WHERE idx = "& idx
			dbcon.Execute SQL
			nlist = "point02"
		End If

	ElseIf flag = "D01" Then

		SQL = "	DELETE FROM _opntt020 WHERE idx = "& idx
		dbcon.Execute SQL
		nlist = "point01"

	ElseIf flag = "D02" Then

		SQL = "	DELETE FROM _opntt010 WHERE idx = "& idx
		dbcon.Execute SQL
		nlist = "point02"

	End If
		Response.Write "nlist : "& nlist &"<br>"
	dbc()

	If flag = "M" Then
		Call divAlertCloseGo("처리되었습니다.",nlist &".asp?page="& page &"&cd1="& cd1 &"&cd2="& cd2)
'		Call AlertGo("처리되었습니다.", nlist &".asp?page="& page &"&cd1="& cd1 &"&cd2="& cd2)
		Response.End
	ElseIf flag = "D01" Or flag = "D02" Then
		Call divAlertCloseGo("삭제되었습니다.",nlist &".asp?page="& page &"&cd1="& cd1 &"&cd2="& cd2)
		Response.End
	End If
%>