<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	seq							= Request("seq")
	shipid						= Request("shipid")
	shipnm						= shipinfo(shipid,"shipnm")
	yy							= Request("yy")
	mm							= Request("mm")
	dd							= Request("dd")
	title						= Replace(Request("title"),"'","''")
	chuljo						= Request("chuljo")
	multime						= Request("multime")
	weather						= Request("weather")
	pago						= Request("pago")
	ipzil						= Request("ipzil")
	jogwa						= Request("jogwa")
	bestfish					= Request("bestfish")
	fishsize					= Request("fishsize")
	contents					= Replace(Request("contents"),"'","''")
	page						= Request("page")
	cd1							= Request("cd1")
	cd2							= Request("cd2")
	flag						= Request("flag")
	idx							= Request("idx")

	If flag = "" Then flag = "W"
	'Response.Write "flag : "& flag &"<br>"

	If flag = "W" Then

				SQL = "	INSERT INTO _obbst020 (title, uno, shipid, wdate, chuljo, multime, weather, pago, ipzil, jogwa, bestfish, fishsize, ddate, contents) " _
					& " VALUES (" _
					& "	'"& shipnm &" 조황갤러리입니다.'" _
					& ",'"& FID_NO &"'" _
					& ","& shipid _
					& ",'"& yy &"-"& setp(mm) &"-"& setp(dd) &"'" _
					& ",'"& chuljo &"'" _
					& ",'"& multime &"'" _
					& ",'"& weather &"'" _
					& ",'"& pago &"'" _
					& ",'"& ipzil &"'" _
					& ",'"& jogwa &"'" _
					& ",'"& bestfish &"'" _
					& ",'"& fishsize &"'" _
					& ",getdate()" _
					& ",'"& contents &"'" _
					& ")"
				dbcon.Execute SQL

	ElseIf flag = "M" Then

				SQL = "	UPDATE _obbst020 SET " _
					& " title			= '"& shipnm &" 조황갤러리입니다.'" _
					& ",shipid			= '"& shipid &"'" _
					& ",wdate			= '"& yy &"-"& setp(mm) &"-"& setp(dd) &"'" _
					& ",chuljo			= '"& chuljo &"'" _
					& ",multime			= '"& multime &"'" _
					& ",weather			= '"& weather &"'" _
					& ",pago			= '"& pago &"'" _
					& ",ipzil			= '"& ipzil &"'" _
					& ",jogwa			= '"& jogwa &"'" _
					& ",bestfish		= '"& bestfish &"'" _
					& ",fishsize		= '"& fishsize &"'" _
					& ",contents		= '"& contents &"'" _
					& " WHERE seq		= "& seq
'				Response.Write SQL &"<br>"
				dbcon.Execute SQL

	ElseIf flag = "DelPhoto" Then

		rso()
		SQL = " SELECT idx, seq, fpath, fnm FROM _obbst021 WHERE idx = "& idx
		rs.open SQL, dbcon
		If Not rs.eof Then
			Set fso = Server.CreateObject("Scripting.FileSystemObject")
			If rs("fnm") <> "" Then				'파일존재시
				If fso.FileExists(serverPath & "\" & rs("fnm")) Then
					fso.DeleteFile serverPath & "\" & rs("fnm"), True
				End If
			End If
			Set fso = Nothing
			SQL = "	DELETE FROM _obbst021 WHERE idx = "& rs("idx")
			dbcon.Execute SQL
		End If
		rsc()

	ElseIf flag = "D" Then

		SQL = " DELETE FROM _obbst020 WHERE seq = "& seq
		dbcon.Execute SQL

		SQL = " DELETE FROM _ogalt010 WHERE seq = "& seq
		dbcon.Execute SQL

	End If
	rsc()

	nlist = "gallery" : nwrite = "gallery_w" : nview = "gallery_v"

	If flag = "W" Then
		Call directGo("저장되었습니다. 엑셀파일을 등록하세요.", "gallery.asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&shipid="& shipid &"&flag="& flag &"&yy="& yy &"&mm="& mm &"&dd="& dd)
		'Call directGo("등록되었습니다.", nlist &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End

	ElseIf flag = "M" Or flag = "DelPhoto" Then
		Call directGo("수정되었습니다.", nlist &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&shipid="& shipid &"&flag="& flag)
		Response.End

	ElseIf flag = "D" Then
		Call directGo("삭제되었습니다.", nlist &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&shipid="& shipid &"&flag="& flag)

	End If
	dbc()
%>