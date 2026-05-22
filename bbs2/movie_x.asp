<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()

	seq							= SQLI(Request("seq"))
	idx							= SQLI(Request("idx"))
	page						= SQLI(Request("page"))
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	flag						= SQLI(Request("flag"))

	title						= SQLI(chkWord(Request("title")))
	shipid						= SQLI(chkWord(Request("shipid")))
	rdate						= SQLI(chkWord(Request("rdate")))
	rdate0						= Replace(SQLI(chkWord(Request("rdate"))),"-","")
	contents					= SQLI(chkWord(Request("contents")))
	comment						= SQLI(chkWord(Request("comment")))
	pnt							= SQLI(Request("pnt"))
	cbox						= SQLI(Request("cbox"))

	If flag = "" Then flag = "W"
	If FID_NO = "" Then FID_NO = 0
'	Response.Write "FID_NO : "& FID_NO &"<br>"

	nlist						= "movie"
	nview						= "movie_v"
	nwrite						= "movie_w"

	If flag = "A" Then							'덧글입력

		SQL = "	INSERT INTO _obbst042 (seq, uno, ddate, comment) VALUES (" _
			& "			"& seq _
			& ",		'"& FID_NO &"'" _
			& ",		getdate()" _
			& ",		'"& comment &"'" _
			& ")"
		dbcon.Execute SQL

	ElseIf flag = "AD" Then						'덧글삭제

		SQL = "	DELETE FROM _obbst042 WHERE idx = "& idx
		dbcon.Execute SQL

	ElseIf flag = "RECOM" Then					'추천

		SQL = "	UPDATE _obbst040 SET recom = recom + 1 WHERE seq = "& seq
		dbcon.Execute SQL

	End If

	If flag = "A" Then
		Call directGo("댓글이 등록되었습니다.", nview &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page)
		Response.End
	ElseIf flag = "AD" Then
		Call directGo("댓글이 삭제되었습니다.", nview &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page)
		Response.End
	ElseIf flag = "RECOM" Then
		Call directGo("추천되었습니다.", nlist &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page)
		Response.End
	End If
	dbc()
%>