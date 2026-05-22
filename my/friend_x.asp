<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/imagevbs.inc" -->
<%
	dbo()
	Call checkLevel(FID_AUTH, 100, Request.ServerVariables("PATH_INFO"))

	idx							= SQLI(Request("idx"))
	page						= SQLI(Request("page"))
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	flag						= SQLI(Request("flag"))

	rname						= SQLI(chkWord(Request("rname")))
	tel1						= SQLI(Request("tel1"))
	tel2						= SQLI(Request("tel2"))
	tel3						= SQLI(Request("tel3"))
	tel0						= tel1 & tel2 & tel3
	hp							= SQLI(Request("hp"))
	hp1							= SQLI(Request("hp1"))
	hp2							= SQLI(Request("hp2"))
	hp3							= SQLI(Request("hp3"))
	hp0							= hp1 & hp2 & hp3
	rel							= SQLI(Request("rel"))
	zip1						= SQLI(Request("zip1"))
	zip2						= SQLI(Request("zip2"))
	zip0						= zip1 & zip2
	addr1						= SQLI(Request("addr1"))
	addr2						= SQLI(Request("addr2"))

	If flag = "" And idx <> "" Then flag = "M"
	If flag = "" Then flag = "W"
	Response.Write "FID_NO : "& FID_NO &"<br>"

	nlist						= "friend"
	nwrite						= "friend_w"

	If idx <> "" Then
		rso()
		SQL = " SELECT uno FROM _omemt020 WHERE idx = "& idx
		rs.open SQL, dbcon
		If Not rs.eof Then
			uno = rs(0)
		End If
		rsc()
	End If
	Response.Write "uno : "& uno &"<br>"

	If flag = "W" Then							'쓰기

		SQL = "	INSERT INTO _omemt020	(uno, rname, hp, rel, zip, addr1, addr2, ddate) " _
			& "	VALUES ( " _
			& "			"& FID_NO _
			& ",		'"& rname &"'" _
			& ",		'"& hp &"'" _
			& ",		'"& rel &"'" _
			& ",		'"& zip0 &"'" _
			& ",		'"& addr1 &"'" _
			& ",		'"& addr2 &"'" _
			& ",		getdate()" _
			& ")"
		dbcon.Execute SQL

	ElseIf flag = "M" Then						'수정

		If cint(FID_NO) <> cint(uno) Then
			Call directGo("본인이 작성한 정보만 수정하실 수 있습니다.", nwrite &".asp?idx="& idx &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
			Response.End
		End If

		SQL = "	UPDATE	_omemt020 SET " _
			& "			rname			= '"& rname &"'" _
			& ",		hp				= '"& hp &"'" _
			& ",		rel				= '"& rel &"'" _
			& ",		zip				= '"& zip0 &"' " _
			& ",		addr1			= '"& addr1 &"' " _
			& ",		addr2			= '"& addr2 &"' " _
			& "	WHERE	idx = "& idx
		dbcon.Execute SQL

	ElseIf flag = "D" Then						'삭제

		If FID_AUTH <> 1 Then
			If cint(FID_NO) <> cint(uno) Then
				Call directGo("본인이 작성한 정보만 삭제하실 수 있습니다.", nwrite &".asp?idx="& idx &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
				Response.End
			End If
		End If

		SQL = "	DELETE FROM _omemt020 WHERE idx = "& idx
		dbcon.Execute SQL

	End If

	If flag = "W" Then
		divAlertReload("등록되었습니다.")
		Response.End
	ElseIf flag = "M" Then
		Call AlertGo("수정되었습니다.", nwrite &".asp?idx="& idx &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "D" Then
		divAlertReload("삭제되었습니다.")
		Response.End
	End If
	dbc()
%>