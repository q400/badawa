<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/imagevbs.inc" -->
<%
	dbo()
	Set upObj = Server.CreateObject("DEXT.FileUpload")
	upObj.CodePage = 65001
	upObj.AutoMakeFolder = True
	upObj.DefaultPath = Server.MapPath(PATH_TMP)				'저장경로
	upObj.MaxFileLen = 1 * 1024 * 1024							'하나의 최대파일 크기를 2MB이하로 제한
	upObj.TotalLen = 1 * 1024 * 1024							'전체 데이타의 크기를 50MB 이하로 제한

	seq							= SQLI(upObj("seq"))
	page						= SQLI(upObj("page"))
	cd1							= SQLI(upObj("cd1"))
	cd2							= SQLI(upObj("cd2"))
	flag						= SQLI(upObj("flag"))

	shipid						= SQLI(upObj("shipid"))
	title						= SQLI(chkWord(upObj("title")))
	wdate						= upObj("wdate")
	contents					= SQLI(upObj("contents"))

	If flag = "" Then flag = "M"

	serverPath					= Server.MapPath(PATH_VOD)
	webPath						= PATH_VOD
	nmparam						= Right(year(now),2) & setp(month(now)) & setp(day(now)) & setp(hour(now)) & setp(minute(now)) & setp(second(now))

	nlist						= "movie"
	nview						= "movie_v"
	nwrite						= "movie_w"

	If flag = "W" Then			'쓰기
		'Response.Write "value : "& upObj.Form("upThumb").value &"<br>"

		'For I = 1 To upObj.Form("upThumb").Count
		If upObj.Form("upThumb").value <> "" Then
			Set upThumb			= upObj.Form("upThumb")
			If upThumb.Value <> "" Then
							newnm		= nmparam &"_th"	'새 이름지정
							ext			= upThumb.FileExtension	'확장자
							thumbNm		= upThumb.SaveAs(serverPath &"\"& newnm &"."& ext, False)	'실제 저장된 파일명

							SQL = "	INSERT INTO _obbst040 (shipid, title, cnt, wdate, ddate, tnm, fnm, onm, fsz, ext, contents) VALUES (" _
								& "			"& shipid _
								& ",		'"& title &"'" _
								& ",		0" _
								& ",		'"& wdate &"'" _
								& ",		getdate()" _
								& ",		'"& newnm &"."& ext &"'" _
								& ",		''" _
								& ",		'"& upThumb.FileName &"'" _
								& ",		"& upThumb.FileLen _
								& ",		'"& ext &"'" _
								& ",		'"& contents &"'" _
								& ")"
							dbcon.Execute SQL
			End If
		End If
		'Next

	ElseIf flag = "M" Then		'수정 - 첨부파일이 있으면 기존꺼 삭제
		If upObj.Form("upThumb").value <> "" Then		'썸네일 이미지를 새로 등록한 경우
							Set upThumb = upObj.Form("upThumb")

							rso()
							SQL = " SELECT tnm, fnm FROM _obbst040 WHERE seq = "& seq
							rs.open SQL, dbcon
							If Not rs.eof Then
								Set fs = Server.CreateObject("Scripting.FileSystemObject")
								If rs("tnm") <> "" Then			'파일존재시
									If fs.FileExists(serverPath &"\"& rs("tnm")) Then
										fs.DeleteFile serverPath &"\"& rs("tnm"), True
									End If
								End If
								Set fs = Nothing
								SQL = "	UPDATE _obbst040 SET tnm = '', ext = '' WHERE seq = "& seq
								dbcon.Execute SQL
							End If
							rsc()

							ext			= upThumb.FileExtension		'동영상 확장자
							newnm		= nmparam &"_th"	'새 이름지정
							savenm		= upThumb.SaveAs(serverPath &"\"& newnm &"."& ext, False)	'실제 저장된 파일명
							SQL = " UPDATE	_obbst040 SET " _
								& "			shipid		= "& shipid _
								& ",		wdate		= '"& wdate &"'" _
								& ",		title		= '"& title &"'" _
								& ",		tnm			= '"& newnm &"."& ext &"'" _
								& ",		onm			= '"& upThumb.FileName &"'" _
								& ",		fsz			= "& upThumb.FileLen _
								& ",		ext			= '"& ext &"'" _
								& ",		contents	= '"& contents &"'" _
								& " WHERE	seq = "& seq
							dbcon.Execute SQL,,128
		Else			'upThumb is empty
							SQL = " UPDATE	_obbst040 SET " _
								& "			shipid		= "& shipid _
								& ",		wdate		= '"& wdate &"'" _
								& ",		title		= '"& title &"'" _
								& ",		contents	= '"& contents &"'" _
								& " WHERE	seq = "& seq
							dbcon.Execute SQL,,128
		End If

	ElseIf flag = "delpic" Then		'썸네일 삭제

		rso()
		SQL = " SELECT fnm FROM _obbst040 WHERE seq = "& seq
		rs.open SQL, dbcon
		While Not rs.eof
			Set fs = Server.CreateObject("Scripting.FileSystemObject")
			If rs("tnm") <> "" Then		'파일존재시
				If fs.FileExists(serverPath & "\" & rs("tnm")) Then
					fs.DeleteFile serverPath & "\" & rs("tnm"), True
				End If
			End If
			Set fs = Nothing
			SQL = " UPDATE	_obbst040 SET " _
				& "			tnm			= ''" _
				& ",		onm			= ''" _
				& ",		fsz			= 0" _
				& ",		ext			= ''" _
				& " WHERE	seq = "& seq
			dbcon.Execute SQL,,128
			rs.MoveNext
		Wend
		rsc()

	ElseIf flag = "D" Then			'삭제

		rso()
		SQL = " SELECT tnm, fnm FROM _obbst040 WHERE seq = "& seq
		rs.open SQL, dbcon
		While Not rs.eof
			Set fs = Server.CreateObject("Scripting.FileSystemObject")
			If rs("fnm") <> "" Then				'파일존재시
				If fs.FileExists(serverPath & "\" & rs("fnm")) Then
					fs.DeleteFile serverPath & "\" & rs("fnm"), True
				End If
			End If
			If rs("tnm") <> "" Then				'파일존재시(Thumbnail)
				If fs.FileExists(serverPath &"\"& rs("tnm")) Then
					fs.DeleteFile serverPath &"\"& rs("tnm"), True
				End If
			End If
			Set fs = Nothing
			SQL = "	DELETE FROM _obbst040 WHERE seq = "& seq
			dbcon.Execute SQL
			rs.MoveNext
		Wend
		rsc()

	End If

	If flag = "W" Then
		Call directGo("등록되었습니다.", nlist &".asp?cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "M" Then
		Call directGo("처리되었습니다.", nwrite &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "delpic" Then
		Call directGo("삭제되었습니다.", nwrite &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "D" Then
		Call directGo("삭제되었습니다.", nlist &".asp?cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	End If

	Set upObj = Nothing
	Set Image = Nothing
	dbc()
%>