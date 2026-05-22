<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()

	seq							= SQLI(Request("seq"))
	page						= SQLI(Request("page"))
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	flag						= SQLI(Request("flag"))

	question					= SQLI(chkWord(Request("question")))
	answer						= chkWord(Request("answer"))

	If flag = "" Then flag = "W"

	nlist						= "faq"
	nview						= "faq_v"
	nwrite						= "faq_w"

	If flag = "W" Then							'쓰기

		SQL = "	INSERT INTO _ofaqt010	(question, answer, ddate) " _
			& "	VALUES (" _
			& "			'"& question &"'" _
			& ",		'"& answer &"'" _
			& ",		getdate()" _
			& ")"
		dbcon.Execute SQL

	ElseIf flag = "M" Then						'수정

		SQL = "	UPDATE	_ofaqt010 SET " _
			& "			question		= '"& question &"'" _
			& ",		answer			= '"& answer &"'" _
			& "	WHERE	seq = "& seq
		dbcon.Execute SQL

	ElseIf flag = "D" Then						'삭제

		SQL = "	DELETE FROM _ofaqt010 WHERE seq = "& seq
		dbcon.Execute SQL

	End If

	If flag = "W" Then
		Call directGo("등록되었습니다.", nlist &".asp?cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "M" Then
		Call directGo("수정되었습니다.", nwrite &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "D" Then
		Call directGo("삭제되었습니다.", nlist &".asp?cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	End If
	dbc()
%>