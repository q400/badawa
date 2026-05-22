<!--
'************************************************************************************
'* Program 명	: gallery_xx.asp (조황갤러리 NFupload 이용)
'************************************************************************************
-->
<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->

<%
	dbo()

	Set upObj = Server.CreateObject("DEXT.FileUpload")			'첨부파일 저장 Dext Upload Componentset
	upObj.DefaultPath = Server.MapPath(PATH_GALL)				'임시저장경로

	Set objImage = Server.CreateObject("DEXT.ImageProc")
	upObj.MaxFileLen = 20 * 1024 * 1024							'20 MB 제한

	seq							= upObj.Form("seq")
	shipid						= upObj.Form("shipid")
	shipnm						= shipinfo(shipid,"shipnm")
	syear						= upObj.Form("syear")
	smon						= upObj.Form("smon")
	sday						= upObj.Form("sday")
	title						= Replace(upObj.Form("title"),"'","''")
	chuljo						= upObj.Form("chuljo")
	multime						= upObj.Form("multime")
	weather						= upObj.Form("weather")
	pago						= upObj.Form("pago")
	ipzil						= upObj.Form("ipzil")
	jogwa						= upObj.Form("jogwa")
	bestfish					= upObj.Form("bestfish")
	fishsize					= upObj.Form("fishsize")
	contents					= Replace(upObj.Form("contents"),"'","''")
	page						= upObj.Form("page")
	cd1							= upObj.Form("cd1")
	cd2							= upObj.Form("cd2")
	flag						= upObj.Form("flag")
	idx							= upObj.Form("idx")

	Set hidFiles				= upObj.Form("hidFileName")

	fcolor						= upObj.Form("fcolor")
	farray						= upObj.Form("farray")
	fontx						= upObj.Form("fontx")
	fonty						= upObj.Form("fonty")
	pcomment					= upObj.Form("pcomment")
'	Response.Write "fcolor : " & fcolor & "<br>"
	Response.Write "<br>shipid : "& shipid &"<br>"

	If flag = "" Then flag = "W"

	serverPath					= Server.MapPath("/data/gallery2") &"/"& shipid &"/"& syear &"/"& smon & sday &""

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
		'Response.Write "<br><br><br>"& SQL &"<br>"
		dbcon.Execute SQL

		rso()
		SQL = " SELECT ISNULL(MAX(seq),0) FROM _ogalt020 "
		rs.open SQL, dbcon
			mxSeq = CInt(rs(0))		'key 최대값
		rsc()

		Set fso = Server.CreateObject("Scripting.FileSystemObject")
		If Not(fso.folderExists(Server.MapPath("/data/gallery2") &"/"& shipid)) Then
			Set folder = fso.CreateFolder(Server.MapPath("/data/gallery2") &"/"& shipid)	'해당 [선박] 폴더 생성
		End If

		If Not(fso.folderExists(Server.MapPath("/data/gallery2") &"/"& shipid &"/"& syear)) Then
			Set folder = fso.CreateFolder(Server.MapPath("/data/gallery2") &"/"& shipid &"/"& syear)	'해당 [년도] 폴더 생성
		End If

		If Not(fso.folderExists(Server.MapPath("/data/gallery2") &"/"& shipid &"/"& syear &"/"& smon & sday)) Then
			Set folder = fso.CreateFolder(Server.MapPath("/data/gallery2") &"/"& shipid &"/"& syear &"/"& smon & sday)
		End If

		folderPath = Server.MapPath("/data/tmp")		'"D:\web\LocalUser\badawa\data\tmp\"

		Set folders = fso.GetFolder(folderPath)
		Set files = folders.Files

		If files.Count <> 0 Then
			i = 1
			For Each file In files
				fso.MoveFile Server.MapPath("/data/tmp") &"/"& file.name, serverPath &"/"
				'fso.MoveFile Server.MapPath("/data/tmp") & file.name, Server.MapPath("/data/gallery2") &"/"& shipid &"/"& syear &"/"& smon & sday &"/"
			Next
		Else					'해당 폴더 내 파일이 없다면
			Response.Write "tmp 폴더에 파일이 없습니다.<br>"
			Response.End
		End If
		Set fso = Nothing

		xfile = Split(hidFiles, "|:|")

		For i = 0 To UBound(xfile)
				filename	= Split(xfile(i), "/")
				ext			= Mid(filename(1), InstrRev(filename(1),".") + 1)

				SQL = " INSERT INTO _ogalt021 (seq, fpath, fnm, onm, fsz, fwd, ext)"_
					& " VALUES (" _
					& " "& mxSeq _
					& ",'/data/gallery2/"& shipid &"/"& syear &"/"& smon & sday &"'" _
					& ",'"& filename(0) &"."& ext &"'" _
					& ",'"& filename(1) &"'" _
					& ",0" _
					& ",0" _
					& ",'"& ext &"'" _
					& ")"
				dbcon.Execute SQL

'				Call hidFiles.SaveAs(serverPath &"\"& filename(0) &"."& ext, False)	'파일저장
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

		If Not(fso.folderExists(Server.MapPath("/data/gallery2") &"/"& shipid)) Then
			Set folder = fso.CreateFolder(Server.MapPath("/data/gallery2") &"/"& shipid)	'해당 [선박] 폴더 생성
		End If

		If Not(fso.folderExists(Server.MapPath("/data/gallery2") &"/"& shipid &"/"& syear)) Then
			Set folder = fso.CreateFolder(Server.MapPath("/data/gallery2") &"/"& shipid &"/"& syear)	'해당 [년도] 폴더 생성
		End If

		If Not(fso.folderExists(Server.MapPath("/data/gallery2") &"/"& shipid &"/"& syear &"/"& smon & sday)) Then
			Set folder = fso.CreateFolder(Server.MapPath("/data/gallery2") &"/"& shipid &"/"& syear &"/"& smon & sday)
		End If

		folderPath = Server.MapPath("/data/tmp")	'"D:\web\LocalUser\badawa\data\tmp\"

		Set folders = fso.GetFolder(folderPath)
		Set files = folders.Files

		If files.Count <> 0 Then
			i = 1
			For Each file In files
				If fso.FileExists(serverPath &"/"& file.name) Then
					JSalert("중복된 이름의 파일("& file.name &")이 존재합니다.\n이름을 수정하여 올리세요.")
				Else
					fso.MoveFile Server.MapPath("/data/tmp") &"/"& file.name, serverPath &"/"
					'fso.MoveFile folderPath & file.name, serverPath &"\"		'파일이동
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
				ext			= Mid(filename(1), InstrRev(filename(1),".") + 1)

				SQL = " INSERT INTO _ogalt021 (seq, fpath, fnm, onm, fsz, fwd, ext)"_
					& " VALUES (" _
					& " "& seq _
					& ",'/data/gallery2/"& shipid &"/"& syear &"/"& smon & sday &"'" _
					& ",'"& filename(0) &"."& ext &"'" _
					& ",'"& filename(1) &"'" _
					& ",0" _
					& ",0" _
					& ",'"& ext &"'" _
					& ")"
				dbcon.Execute SQL

'				Call hidFiles.SaveAs(serverPath &"\"& filename(0) &"."& ext, False)	'파일저장
		Next

	ElseIf flag = "DelPhoto" Then

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
				If fso.FileExists(serverPath & "/" & rs("fnm")) Then
					fso.DeleteFile serverPath & "/" & rs("fnm"), True
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

	nlist = "gallery3" : nwrite = "gallery_ww" : nview = "gallery_vv"

	If flag = "W" Then
		Call directGo("등록되었습니다.", nlist &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End

	ElseIf flag = "M" Then
		Call directGo("수정되었습니다.", nwrite &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End

	ElseIf flag = "DelPhoto" Then
		Call divAlertReload("삭제되었습니다.")

	ElseIf flag = "D" Then
		Call directGo("삭제되었습니다.", nlist &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)

	End If
	dbc()
%>

