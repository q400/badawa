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

	nlist						= "ps"
	nview						= "ps_v"
	nwrite						= "ps_w"

	If seq <> "" Then
		rso()
		SQL = " SELECT uno FROM _obbst050 WHERE seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			uno = rs(0)
		End If
		rsc()
	End If

	If flag = "A" Then							'덧글입력

		SQL = "	INSERT INTO _obbst052 (seq, uno, ddate, comment) VALUES (" _
			& "			"& seq _
			& ",		'"& FID_NO &"'" _
			& ",		getdate()" _
			& ",		'"& comment &"'" _
			& ")"
		dbcon.Execute SQL

	ElseIf flag = "AD" Then						'덧글삭제

		SQL = "	DELETE FROM _obbst052 WHERE idx = "& idx
		dbcon.Execute SQL

	ElseIf flag = "PP" Then						'포인트적립

		If rsvInfo5(shipid,rdate0,uno) = "" Then
				Call directGo("실제 해당일자에 예약이 없습니다. 따라서 포인트를 부여할 수 없습니다.        ", nlist &".asp")
				Response.End
		Else
				'후기글 500 포인트 적립
				SQL = "	INSERT INTO _opntt020 (uno, op, shipid, rsvid, point, note, ddate) VALUES (" _
					& "			"& uno _
					& ",		'+'" _
					& ",		"& shipid _
					& ",		"& rsvInfo5(shipid,rdate0,uno) _
					& ",		500" _
					& ",		'조황후기("& seq &") 등록-기본'" _
					& ",		getdate()" _
					& ")"
				Response.Write SQL &"<br>"
'				dbcon.Execute SQL

			If pnt <> 0 Then
				'사진 갯수에 따른 포인트 적립
				SQL = "	INSERT INTO _opntt020 (uno, op, shipid, rsvid, point, note, ddate) VALUES (" _
					& "			"& uno _
					& ",		'+'" _
					& ",		"& shipid _
					& ",		"& rsvInfo5(shipid,rdate0,uno) _
					& ",		"& pnt _
					& ",		'조황후기("& seq &") 등록-사진'" _
					& ",		getdate()" _
					& ")"
				Response.Write SQL &"<br>"
'				dbcon.Execute SQL
			End If
		End If

	ElseIf flag = "PM" Then						'포인트취소

		'후기글 포인트 적립 취소
		SQL = "	DELETE FROM _opntt010 WHERE seq = "& seq
		dbcon.Execute SQL

	ElseIf flag = "DP" Then						'사진삭제

		rso()
		SQL = " SELECT idx, seq, fpath, fnm FROM _obbst051 WHERE idx = "& idx
		rs.open SQL, dbcon
		If Not rs.eof Then
			Set fs = Server.CreateObject("Scripting.FileSystemObject")
			If rs("fnm") <> "" Then				'파일존재시
				If fs.FileExists(serverPath & "\" & rs("fnm")) Then
					fs.DeleteFile serverPath & "\" & rs("fnm"), True
				End If
			End If
			Set fs = Nothing
			SQL = "	DELETE FROM _obbst051 WHERE idx = "& rs("idx")
			dbcon.Execute SQL
		End If
		rsc()

	ElseIf flag = "D" Then						'삭제

		If FID_AUTH <> 1 Then
			If CInt(FID_NO) <> uno Then
				Call directGo("본인이 작성한 글만 삭제하실 수 있습니다.        ", nview &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
				Response.End
			End If
		End If

		rso()
		SQL = " SELECT idx, seq, fnm FROM _obbst051 WHERE seq = "& seq
		rs.open SQL, dbcon

		While Not rs.eof
			Set fs = Server.CreateObject("Scripting.FileSystemObject")
			If rs("fnm") <> "" Then				'파일존재시
				If fs.FileExists(serverPath & "\" & rs("fnm")) Then
					fs.DeleteFile serverPath & "\" & rs("fnm"), True
				End If
			End If
			Set fs = Nothing
			SQL = "	DELETE FROM _obbst051 WHERE idx = "& rs("idx")
			dbcon.Execute SQL
			rs.MoveNext
		Wend
		rsc()

		SQL = "	DELETE FROM _obbst050 WHERE seq = "& seq
		dbcon.Execute SQL

		'전체 덧글 삭제
		SQL = "	DELETE FROM _obbst052 WHERE seq = "& seq
		dbcon.Execute SQL

		'후기글 포인트 적립취소
		SQL = "	DELETE FROM _opntt010 WHERE seq = "& seq &" AND note LIKE '조황후기%' "
		dbcon.Execute SQL

	End If

	If flag = "A" Then
		Call directGo("댓글이 등록되었습니다.", nview &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page)
		Response.End
	ElseIf flag = "AD" Then
		Call directGo("댓글이 삭제되었습니다.", nview &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page)
		Response.End
	ElseIf flag = "PP" Then
		Call directGo("포인트가 적립되었습니다.", nlist &".asp?cd1="& cd1 &"&cd2="& cd2 &"&page="& page)
		Response.End
	ElseIf flag = "PM" Then
		Call directGo("포인트가 차감되었습니다.", nlist &".asp?cd1="& cd1 &"&cd2="& cd2 &"&page="& page)
		Response.End
	ElseIf flag = "DP" Then
		Call directGo("사진이 삭제되었습니다.", nview &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page)
		Response.End
	ElseIf flag = "D" Then
		Call directGo("삭제되었습니다.", nlist &".asp?cd1="& cd1 &"&cd2="& cd2 &"&page="& page)
		Response.End
	End If
	dbc()
%>