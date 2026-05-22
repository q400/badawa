<%
'************************************************************************************
'* Program 명	: gallery_xx.asp (조황갤러리 NFupload 이용)
'************************************************************************************
%>
<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	Set upObj = Server.CreateObject("DEXT.FileUpload")			'첨부파일 저장 Dext Upload Componentset
	upObj.DefaultPath = Server.MapPath(PATH_GOODS)				'임시저장경로
	Set objImage = Server.CreateObject("DEXT.ImageProc")
	upObj.MaxFileLen = 20 * 1024 * 1024							'20 MB 제한

	seq							= Request("seq")
	shipid						= Request("shipid")
	shipnm						= shipinfo(shipid,"shipnm")
	syear						= Request("syear")
	smon						= Request("smon")
	sday						= Request("sday")
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

	hidFiles					= Request("hidFileName")

	fcolor						= Request("fcolor")
	farray						= Request("farray")
	fontx						= Request("fontx")
	fonty						= Request("fonty")
	pcomment					= Request("pcomment")
'	Response.Write "fcolor : " & fcolor & "<br>"

	If flag = "" Then flag = "W"

	serverPath					= Server.MapPath("/data/gallery/"& shipid &"/"& syear &"/"& smon & sday &"")

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
			& ",NOW()" _
			& ",'"& contents &"'" _
			& ")"
		dbcon.Execute SQL

		rso()
		SQL = " SELECT ISNULL(MAX(seq),0) FROM _ogalt020 "
		rs.open SQL, dbcon
			mxSeq = CInt(rs(0))		'key 최대값
		rsc()

		Set fso = Server.CreateObject("Scripting.FileSystemObject")
		If Not(fso.folderExists("D:\web\LocalUser\badawa\data\gallery\"& shipid)) Then
			Set folder = fso.CreateFolder("D:\web\LocalUser\badawa\data\gallery\"& shipid)	'해당 [선박] 폴더 생성
		End If

		If Not(fso.folderExists("D:\web\LocalUser\badawa\data\gallery\"& shipid &"\"& syear)) Then
			Set folder = fso.CreateFolder("D:\web\LocalUser\badawa\data\gallery\"& shipid &"\"& syear)	'해당 [년도] 폴더 생성
		End If

		If Not(fso.folderExists("D:\web\LocalUser\badawa\data\gallery\"& shipid &"\"& syear &"\"& smon & sday)) Then
			Set folder = fso.CreateFolder("D:\web\LocalUser\badawa\data\gallery\"& shipid &"\"& syear &"\"& smon & sday)
		End If

		folderPath = "D:\web\LocalUser\badawa\data\tmp\"

		Set folders = fso.GetFolder(folderPath)
		Set files = folders.Files

		If files.Count <> 0 Then
			i = 1
			For Each file In files
				fso.MoveFile "D:\web\LocalUser\badawa\data\tmp\"& file.name, "D:\web\LocalUser\badawa\data\gallery\"& shipid &"\"& syear &"\"& smon & sday &"\"
			Next
		Else					'해당 폴더 내 파일이 없다면
			Response.Write "tmp 폴더에 파일이 없습니다.<br>"
			Response.End
		End If
		Set fso = Nothing

		xfile = Split(hidFiles, "|:|")

		For i = 0 To UBound(xfile)
				filename	= Split(xfile(i), "/")
				ext0		= Mid(filename(1), InstrRev(filename(1),".") + 1)

				'이미지 내 문자 생성
				Status = Image.Load(serverPath &"\"& filename(0) &"."& ext0)
				'Response.Write "Status : " & Status & "<br>"
				If Status = Ok Then
					Image.SetFont "Verdana", 20, FontStyleBold
					If farray = "left" Then
						Image.SetTextFormat StringAlignmentCenter, True, False, False
					ElseIf farray = "center" Then
						Image.SetTextFormat StringAlignmentCenter, False, True, False
					Else
						Image.SetTextFormat StringAlignmentCenter, False, False, True
					End If
					Image.DrawText pcomment, fcolor, fontx, fonty, Image.Width - 50, Image.Height - 50

					Image.Save serverPath &"\"& filename(0) &"."& ext0, 100, True
					Image.close
				Else
					Response.Write "이미지 파일을 열 수 없습니다. 오류 코드: " & Status
				End If

				SQL = " INSERT INTO _ogalt021 (seq, fpath, fnm, onm, fsz, fwd, ext) VALUES (" _
					& " "& mxSeq _
					& ",'/data/gallery/"& shipid &"/"& syear &"/"& smon & sday &"'" _
					& ",'"& filename(0) &"."& ext0 &"'" _
					& ",'"& filename(1) &"'" _
					& ",0" _
					& ",0" _
					& ",'"& ext0 &"'" _
					& ")"
				dbcon.Execute SQL
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
		folderPath = "D:\web\LocalUser\badawa\data\tmp\"

		Set folders = fso.GetFolder(folderPath)
		Set files = folders.Files

		If files.Count <> 0 Then
			i = 1
			For Each file In files
				If fso.FileExists(serverPath &"\"& file.name) Then
					JSalert("중복된 이름의 파일("& file.name &")이 존재합니다.         \n이름을 수정하여 올리세요.")
				Else
					fso.MoveFile folderPath & file.name, serverPath &"\"		'파일이동
				End If
			Next
		End If

		If files.Count <> 0 Then
			i = 1
			For Each file In files
				fso.DeleteFile folderPath & file.name, True			'tmp 폴더내용 삭제
			Next
		End If
		Set fso = Nothing

		xfile = Split(hidFiles, "|:|")
		For i = 0 To UBound(xfile)
				filename	= Split(xfile(i), "/")
				ext0		= Mid(filename(1), InstrRev(filename(1),".") + 1)

				'이미지 내 문자 생성
				Status = Image.Load(serverPath &"\"& filename(0) &"."& ext0)
'		Response.Write "Status : " & Status & "<br>"
				If Status = Ok Then
					Image.SetFont "Verdana", 20, FontStyleBold
					If farray = "left" Then
						Image.SetTextFormat StringAlignmentCenter, True, False, False
					ElseIf farray = "center" Then
						Image.SetTextFormat StringAlignmentCenter, False, True, False
					Else
						Image.SetTextFormat StringAlignmentCenter, False, False, True
					End If
					Image.DrawText "www.badawa.co.kr", fcolor, fontx, fonty, Image.Width - 50, Image.Height - 50

					Image.Save serverPath &"\"& filename(0) &"."& ext0, 100, True
					Image.close
				Else
					Response.Write "이미지 파일을 열 수 없습니다. 오류 코드: " & Status
				End If

				SQL = " INSERT INTO _ogalt021 (seq, fpath, fnm, onm, fsz, fwd, ext) VALUES (" _
					& " "& seq _
					& ",'/data/gallery/"& shipid &"/"& syear &"/"& smon & sday &"'" _
					& ",'"& filename(0) &"."& ext0 &"'" _
					& ",'"& filename(1) &"'" _
					& ",0" _
					& ",0" _
					& ",'"& ext0 &"'" _
					& ")"
				dbcon.Execute SQL
		Next

	ElseIf flag = "DelPhoto" Then

		rso()
		SQL = " SELECT idx, seq, fpath, fnm FROM _ogalt021 WHERE idx = "& idx
		rs.open SQL, dbcon
		If Not rs.eof Then
			Set fso = Server.CreateObject("Scripting.FileSystemObject")
			If rs("fnm") <> "" Then				'파일존재시
				If fso.FileExists(serverPath & "\" & rs("fnm")) Then
					fso.DeleteFile serverPath & "\" & rs("fnm"), True
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
				If fso.FileExists(serverPath & "\" & rs("fnm")) Then
					fso.DeleteFile serverPath & "\" & rs("fnm"), True
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

	nlist = "gallery" : nwrite = "gallery_w" : nview = "gallery_v"

	If flag = "W" Then
		Call directGo("등록되었습니다.", nlist &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End

	ElseIf flag = "M" Or flag = "DelPhoto" Then
		Call directGo("수정되었습니다.", nlist &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End

	ElseIf flag = "D" Then
		Call directGo("삭제되었습니다.", nlist &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)

	End If
	dbc()
%>