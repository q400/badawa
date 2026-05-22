<!--
'************************************************************************************
'* Program 명	: gall_x.asp (조황갤러리)
'************************************************************************************
-->
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
'	Response.Write "fcolor : " & fcolor & "<br>"
	Response.Write "flag : "& flag &"<br>"

	If flag = "" Then flag = "W"

	Select Case flag
		Case "W"	: msg = "등록되었습니다."
		Case "M"	: msg = "수정되었습니다."
		Case "DP"	: msg = "이미지가 삭제되었습니다."
		Case "D"	: msg = "삭제되었습니다."
		Case Else	: msg = "오류가 있습니다."
	End Select

	serverPath = Server.MapPath("/data/gall") &"/"& shipid &"/"& syear &"/"& smon & sday
	paramNm = Right(Year(Now),2) & setp(Month(Now)) & setp(Day(Now)) & setp(Hour(Now)) & setp(Minute(Now)) & setp(Second(Now))

	If flag = "W" Then

		SQL = "	INSERT INTO _ogalt020 (title, uno, shipid, wdate, chuljo, multime, weather, pago, ipzil, jogwa, bestfish, fishsize, ddate, contents)"_
			& " VALUES (" _
			& "	'"& shipnm &" 조황갤러리입니다.'" _
			& ",'"& FID_NO &"'" _
			& ","& shipid _
			& ",'"& syear &"-"& setp(smon) &"-"& setp(sday) &"'" _
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
		Response.Write "<br><br><br>"& SQL &"<br>"
		dbcon.Execute SQL

		rso()
		SQL = " SELECT ISNULL(MAX(seq),0) FROM _ogalt020 "
		rs.open SQL, dbcon
			mxSeq = CInt(rs(0))		'key 최대값
		rsc()

		Set fso = Server.CreateObject("Scripting.FileSystemObject")
		If Not(fso.folderExists(Server.MapPath("/data/gall") &"/"& shipid)) Then
			Set folder = fso.CreateFolder(Server.MapPath("/data/gall") &"/"& shipid)	'해당 [선박] 폴더 생성
		End If

		If Not(fso.folderExists(Server.MapPath("/data/gall") &"/"& shipid &"/"& syear)) Then
			Set folder = fso.CreateFolder(Server.MapPath("/data/gall") &"/"& shipid &"/"& syear)	'해당 [년도] 폴더 생성
		End If

		If Not(fso.folderExists(Server.MapPath("/data/gall") &"/"& shipid &"/"& syear &"/"& smon & sday)) Then
			Set folder = fso.CreateFolder(Server.MapPath("/data/gall") &"/"& shipid &"/"& syear &"/"& smon & sday)
		End If

		For I = 1 To upObj.Form("upFile").Count
			Set upFile = upObj.Form("upFile")(I)
			If upFile.Value <> "" Then
				ext			= upFile.FileExtension		'Mid(upFile.Value, InstrRev(upFile.Value,".") + 1)
				fwd			= upFile.ImageWidth			'이미지 폭
				fht			= upFile.ImageHeight		'이미지 높이
				newNm		= paramNm &"_"& I			'새이름지정

				If extcheck(UCase(ext)) = False Then
						Call upFile.SaveAs(serverPath &"\"& newNm &"."& ext, False)		'실제 저장된 파일명 'Mid(ffname, InstrRev(ffname,"\")+1)
						SQL = " INSERT INTO	_ogalt021 (seq, fpath, fnm, onm, fsz, fwd, ext)" _
							& " VALUES (" _
							&			mxSeq _
							& ",		'/data/gall/"& shipid &"/"& syear &"/"& smon & sday &"'" _
							& ",		'"& newNm &"."& ext &"'" _
							& ",		'"& upFile.FileName &"'" _
							& ",		'"& upFile.FileLen &"'" _
							& ",		"& fwd _
							& ",		'"& ext &"'" _
							& ")"
						Response.Write "<br><br><br>"& SQL &"<br>"
						dbcon.Execute SQL,,128
				Else
						upObj.DeleteAllSavedFiles
						Call OnlyAlert("등록 불가능한 파일입니다.")
						Response.End
				End If
			End If
		Next

	ElseIf flag = "M" Then

		SQL = "	UPDATE _ogalt020 SET " _
			& " title			= '"& shipnm &" 조황갤러리입니다.'" _
			& ",shipid			= '"& shipid &"'" _
			& ",wdate			= '"& syear &"-"& setp(smon) &"-"& setp(sday) &"'" _
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
'		Response.Write SQL &"<br>"
		dbcon.Execute SQL

		Set fso = Server.CreateObject("Scripting.FileSystemObject")
		If Not(fso.folderExists(Server.MapPath("/data/gall") &"/"& shipid)) Then
			Set folder = fso.CreateFolder(Server.MapPath("/data/gall") &"/"& shipid)	'해당 [선박] 폴더 생성
		End If

		If Not(fso.folderExists(Server.MapPath("/data/gall") &"/"& shipid &"/"& syear)) Then
			Set folder = fso.CreateFolder(Server.MapPath("/data/gall") &"/"& shipid &"/"& syear)	'해당 [년도] 폴더 생성
		End If

		If Not(fso.folderExists(Server.MapPath("/data/gall") &"/"& shipid &"/"& syear &"/"& smon & sday)) Then
			Set folder = fso.CreateFolder(Server.MapPath("/data/gall") &"/"& shipid &"/"& syear &"/"& smon & sday)
		End If

		For I = 1 To upObj.Form("upFile").Count
			Set upFile = upObj.Form("upFile")(I)
			If upFile.Value <> "" Then
				ext			= upFile.FileExtension		'Mid(upFile.Value, InstrRev(upFile.Value,".") + 1)
				fwd			= upFile.ImageWidth			'이미지 폭
				fht			= upFile.ImageHeight		'이미지 높이
				newNm		= paramNm &"_"& I			'새이름지정

				If extcheck(UCase(ext)) = False Then
						Call upFile.SaveAs(serverPath &"\"& newNm &"."& ext, False)		'실제 저장된 파일명 'Mid(ffname, InstrRev(ffname,"\")+1)
						SQL = " INSERT INTO	_ogalt021 (seq, fpath, fnm, onm, fsz, fwd, ext)" _
							& " VALUES (" _
							&			seq _
							& ",		'/data/gall/"& shipid &"/"& syear &"/"& smon & sday &"'" _
							& ",		'"& newNm &"."& ext &"'" _
							& ",		'"& upFile.FileName &"'" _
							& ",		'"& upFile.FileLen &"'" _
							& ",		"& fwd _
							& ",		'"& ext &"'" _
							& ")"
						Response.Write "<br><br><br>"& SQL &"<br>"
						dbcon.Execute SQL,,128
				Else
						upObj.DeleteAllSavedFiles
						Call OnlyAlert("등록 불가능한 파일입니다.")
						Response.End
				End If
			End If
		Next

	ElseIf flag = "DP" Then

		rso()
		SQL = " SELECT idx, seq, fpath, fnm FROM _ogalt021 WHERE idx = "& idx
		rs.open SQL, dbcon
		If Not rs.eof Then
			Set fso = Server.CreateObject("Scripting.FileSystemObject")
			If rs("fnm") <> "" Then				'파일존재시
				If fso.FileExists(serverPath & "/" & rs("fnm")) Then
					fso.DeleteFile serverPath & "/" & rs("fnm"), True
				End If
			End If
			Set fso = Nothing
			SQL = "	DELETE FROM _ogalt021 WHERE idx = "& rs("idx")
			dbcon.Execute SQL
		End If
		rsc()

	ElseIf flag = "D" Then

		rso()
		SQL = " SELECT idx, seq, fpath, fnm FROM _ogalt021 WHERE seq = "& seq
		rs.open SQL, dbcon
		While Not rs.eof
			Set fso = Server.CreateObject("Scripting.FileSystemObject")
			If rs("fnm") <> "" Then				'파일존재시
				If fso.FileExists(Server.MapPath(rs("fpath") & "/" & rs("fnm"))) Then
					fso.DeleteFolder Server.MapPath(rs("fpath")), True		'폴더 전체 삭제
'					fso.DeleteFile Server.MapPath(rs("fpath") & "/" & rs("fnm")), True
				End If
			End If
			Set fso = Nothing
			SQL = "	DELETE FROM _ogalt021 WHERE idx = "& rs("idx")
			dbcon.Execute SQL
			rs.MoveNext
		Wend
		rsc()

		SQL = " DELETE FROM _ogalt020 WHERE seq = "& seq
		dbcon.Execute SQL

	End If
	rsc()

	nlist = "gall" : nwrite = "gall_w" : nview = "gall_v"

	If flag = "W" Then
		Call directGo(msg, nwrite &".asp?seq="& mxSeq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page)
	ElseIf flag = "M" Then
		Call directGo(msg, nlist &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page)
	ElseIf flag = "DP" Then
		Call divAlertReload(msg)
	ElseIf flag = "D" Then
		Call directGo(msg, nlist &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&shipid="& shipid)
	End If
	dbc()
%>

