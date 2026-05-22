<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	idx							= SQLI(Request("idx"))
	shipnm						= SQLI(Request("shipnm"))
	link						= SQLI(Request("link"))

	flag						= Request("flag")

	If flag = "" Then flag = "M"
	If flag = "W" Then

		SQL = "	INSERT INTO _oshpt030 (shipnm, link) VALUES (" _
			& " '"& shipnm &"'" _
			& ",'"& link &"'" _
			& ")"
		dbcon.Execute SQL

	ElseIf flag = "M" Then

		SQL = "	UPDATE	_oshpt030 SET " _
			& " shipnm			= '"& shipnm &"'" _
			& ",link			= '"& link &"'" _
			& " WHERE	idx	= "& idx
'		Response.Write SQL &"<br>"
		dbcon.Execute SQL

	ElseIf flag = "D" Then

		SQL = "	DELETE FROM _oshpt030 WHERE idx = "& rs("idx")
		dbcon.Execute SQL

	End If

	nlist = "link" : nwrite = "link_w"

	If flag = "W" Then
		Call directGo("등록되었습니다.", nlist &".asp")
		Response.End

	ElseIf flag = "M" Then
		Call noAlertGo(nlist &".asp")
		Response.End

	ElseIf flag = "D" Then
		Call directGo("삭제되었습니다.", nlist &".asp")

	End If
	dbc()
%>