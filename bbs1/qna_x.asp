<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/imagevbs.inc" -->
<%
	dbo()

	seq							= SQLI(Request("seq"))
	idx							= SQLI(Request("idx"))
	page						= SQLI(Request("page"))
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	flag						= SQLI(Request("flag"))
	pwd							= SQLI(Request("pwd"))
	secret						= SQLI(Request("secret"))
	If secret = "" Then secret = "0" Else secret = "1"

	title						= SQLI(chkWord(Request("title")))
	uname						= SQLI(chkWord(Request("uname")))			'닉네임
	email						= SQLI(Request("email"))
	email1						= SQLI(Request("email1"))
	email2						= SQLI(Request("email2"))
	email0						= email1 &"@"& email2
	hp1							= SQLI(Request("hp1"))
	hp2							= SQLI(Request("hp2"))
	hp3							= SQLI(Request("hp3"))
	contents					= chkWord(Request("contents"))
	answer						= chkWord(Request("answer"))
	cbox						= SQLI(Request("cbox"))

	If flag = "" Then flag = "W"
	If FID_NO = "" Then FID_NO = 0

	nlist						= "qna"
	nview						= "qna_v"
	nwrite						= "qna_w"

	If flag <> "W" Then
		rso()									'원래 비밀번호
		SQL = " SELECT pwd FROM _obbst030 WHERE seq = "& seq
		rs.open SQL, dbcon
			pwd0 = rs(0)
		rsc()
	End If

	If flag = "W" Then							'쓰기

		SQL = "	INSERT INTO _obbst030 (title, uno, uname, pwd, hp, uip, secret, ddate, contents, answer) " _
			&" VALUES (" _
			& "			'"& title &"'" _
			& ",		"& FID_NO _
			& ",		'"& uname &"'" _
			& ",		'"& pwd &"'" _
			& ",		'"& hp1 & hp2 & hp3 &"'" _
			& ",		'"& Request.ServerVariables("REMOTE_ADDR") &"'" _
			& ",		"& secret _
			& ",		getdate()" _
			& ",		'"& contents &"'" _
			& ",		''" _
			& ")"
'		Response.Write SQL &"<br>"
		If blackyn(pname) = False And blackyn(contents) = False Then dbcon.Execute SQL

	ElseIf flag = "M" Then						'수정

		If pwd <> pwd0 Then
			Call directGo("비밀번호가 일치하지 않습니다.",nwrite &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
			Response.End
		End If

		SQL = "	UPDATE	_obbst030 SET " _
			& "			title			= '"& title &"'" _
			& ",		secret			= "& secret &"" _
			& ",		contents		= '"& contents &"'" _
			& "	WHERE	seq = "& seq
		If blackyn(title) = False And blackyn(contents) = False Then dbcon.Execute SQL

	ElseIf flag = "D" Then						'삭제

		If pwd <> pwd0 Then
			Call directGo("비밀번호가 일치하지 않습니다.", nview &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&pwd="& pwd &"&flag="& flag)
			Response.End
		End If

		SQL = "	DELETE FROM _obbst030 WHERE seq = "& seq
		dbcon.Execute SQL

	End If

	If flag = "W" Then
		Call directGo("등록되었습니다.", nlist &".asp?cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "M" Then
		Call directGo("수정되었습니다.", nwrite &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "R" Then
		Call directGo("답변글이 등록되었습니다.", nlist &".asp?cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "delpic" Then
		Call directGo("첨부파일이 삭제되었습니다.", nwrite &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "A" Then
		Call directGo("댓글이 등록되었습니다.", nview &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "AD" Then
		Call directGo("댓글이 삭제되었습니다.", nview &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "D" Then
		Call directGo("삭제되었습니다.", nlist &".asp?cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	End If

	dbc()
%>