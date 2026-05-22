<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/imagevbs.inc" -->
<%
	dbo()

	Set upObj = Server.CreateObject("DEXT.FileUpload")
	Set objImage = Server.CreateObject("DEXT.ImageProc")

	upObj.CodePage = 65001
	upObj.DefaultPath = Server.MapPath(PATH_TMP)				'저장경로
	upObj.MaxFileLen = 10 * 1024 * 1024							'하나의 최대파일 크기를 2MB이하로 제한
	upObj.TotalLen = 50 * 1024 * 1024							'전체 데이타의 크기를 50MB 이하로 제한

	seq							= SQLI(upObj("seq"))
	idx							= SQLI(upObj("idx"))
	page						= SQLI(upObj("page"))
	cd1							= SQLI(upObj("cd1"))
	cd2							= SQLI(upObj("cd2"))
	flag						= SQLI(upObj("flag"))

	title						= SQLI(chkWord(upObj("title")))
	sdate						= SQLI(upObj("sdate"))
	edate						= SQLI(upObj("edate"))
	winw						= SQLI(upObj("winw"))
	winh						= SQLI(upObj("winh"))
	ttop						= SQLI(upObj("ttop"))
	lleft						= SQLI(upObj("lleft"))
	link						= SQLI(upObj("link"))
	contents					= SQLI(chkWord(upObj("contents")))
	cbox						= SQLI(upObj("cbox"))

	If flag = "" Then flag = "W"
	If title = "" Then title = "제목없음"

	fpath						= PATH_NOTICE					'공지사항과 공유
	nlist						= "pop"
	nwrite						= "pop_w"

	serverPath					= Server.MapPath(fpath)
	nmParam						= Right(Year(Now),2) & setp(Month(Now)) & setp(Day(Now)) & setp(Hour(Now)) & setp(Minute(Now)) & setp(Second(Now))

	If flag = "W" Then							'쓰기

		For I = 1 To upObj.Form("upFile").Count
			Set upFile = upObj.Form("upFile")(I)
			If upFile.Value <> "" Then
				ext			= upFile.FileExtension
				fwd			= upFile.ImageWidth					'이미지 폭
				fht			= upFile.ImageHeight				'이미지 높이
				newNm		= nmParam &"["& I &"]"				'새이름지정

				If extcheck(UCase(ext)) = False Then
								If fwd <= 800 Then
											Call upFile.SaveAs(serverPath &"\"& newNm &"."& ext, False)		'실제 저장된 파일명 'Mid(ffname, InstrRev(ffname,"\")+1)
											SQL = " INSERT INTO	_opopt010 (sdate, edate, title, fnm, ttop, lleft, winw, winh, link, ddate, contents)" _
												& " VALUES (" _
												& "			'"& sdate &"'" _
												& ",		'"& edate &"'" _
												& ",		'"& title &"'" _
												& ",		'"& newNm &"."& ext &"'" _
												& ",		"& ttop _
												& ",		"& lleft _
												& ",		"& winw _
												& ",		"& winh _
												& ",		'"& link &"'" _
												& ",		getdate()" _
												& ",		'"& contents &"'" _
												& ")"
											dbcon.Execute SQL
								Else		'폭 800이 넘으면 썸네일 처리
									If True = objImage.SetSourceFile(upFile.TempFilePath) Then		'임시저장
											thumbNm = newNm & "_800.jpg"
											Call objImage.SaveasThumbnail(serverPath &"\"& thumbNm, objImage.ImageWidth/500*800, objImage.ImageHeight/500*800, False)
											SQL = " INSERT INTO	_opopt010 (sdate, edate, title, fnm, ttop, lleft, winw, winh, link, ddate, contents)" _
												& " VALUES (" _
												& "			'"& sdate &"'" _
												& ",		'"& edate &"'" _
												& ",		'"& title &"'" _
												& ",		'"& thumbNm &"'" _
												& ",		"& ttop _
												& ",		"& lleft _
												& ",		"& winw _
												& ",		"& winh _
												& ",		'"& link &"'" _
												& ",		getdate()" _
												& ",		'"& contents &"'" _
												& ")"
											dbcon.Execute SQL
									End If
								End If
				Else
					upObj.DeleteAllSavedFiles()
					Call OnlyAlert("이미지 파일만 등록 가능합니다.")
				End If
			Else
											SQL = " INSERT INTO	_opopt010 (sdate, edate, title, fnm, ttop, lleft, winw, winh, link, ddate, contents) VALUES (" _
												& "			'"& sdate &"'" _
												& ",		'"& edate &"'" _
												& ",		'"& title &"'" _
												& ",		''" _
												& ",		"& ttop _
												& ",		"& lleft _
												& ",		"& winw _
												& ",		"& winh _
												& ",		'"& link &"'" _
												& ",		getdate()" _
												& ",		'"& contents &"'" _
												& ")"
											dbcon.Execute SQL,,128
			End If
		Next

	ElseIf flag = "M" Then						'수정

		SQL = "	UPDATE	_opopt010 SET " _
			& "			sdate			= '"& sdate &"'" _
			& ",		edate			= '"& edate &"'" _
			& ",		title			= '"& title &"'" _
			& ",		ttop			= "& ttop _
			& ",		lleft			= "& lleft _
			& ",		winw			= "& winw _
			& ",		winh			= "& winh _
			& ",		link			= '"& link &"'" _
			& ",		contents		= '"& contents &"' " _
			& "	WHERE	seq = "& seq
		dbcon.Execute SQL

		delIdx = Split(cbox, ",")
		For Each key In delIdx
			rso()
			SQL = " SELECT fnm FROM _opopt010 WHERE seq = "& key
			rs.open SQL, dbcon
			If Not rs.eof Then
				Set fs = Server.CreateObject("Scripting.FileSystemObject")
				If rs("fnm") <> "" Then				'파일존재시
					If fs.FileExists(serverPath &"\"& rs("fnm")) Then
						fs.DeleteFile serverPath &"\"& rs("fnm"), True
					End If
				End If
				Set fs = Nothing
				SQL = "	UPDATE _opopt010 SET fnm = '' WHERE seq = "& key
				dbcon.Execute SQL
			End If
			rsc()
		Next

		For I = 1 To upObj.Form("upFile").Count
			Set upFile = upObj.Form("upFile")(I)
			If upFile.Value <> "" Then
				ext			= Mid(upFile.Value, InstrRev(upFile.Value,".") + 1)
				fwd			= upFile.ImageWidth					'이미지 폭
				fht			= upFile.ImageHeight				'이미지 높이
				newNm		= nmParam &"["& I &"]"				'새이름지정

				If upFile.isImageItem Then						'이미지 파일
								savenm		= upFile.SaveAs(serverPath &"\"& newNm &"."& ext, False)					'실제 저장된 파일명
								If fwd <= 800 Then
											SQL = " UPDATE	_opopt010 SET fnm = '"& newNm &"."& ext &"' WHERE seq = "& seq
											dbcon.Execute SQL,,128
								Else							'폭 700이 넘으면 썸네일 처리
									Set Image = Server.CreateObject("TABSUpload4.Image")
									Status				= Image.Load(serverPath &"\"& newNm &"."& ext)
									If Status = Ok Then
										If Image.SaveThumbnail(serverPath &"\"& newNm &"."& ext,800,0,100) = Ok Then
											SQL = " UPDATE	_opopt010 SET fnm = '"& newNm &"."& ext &"' WHERE seq = "& seq
											dbcon.Execute SQL,,128
										End If
									End If
								End If
				Else
					upObj.DeleteAllSavedFiles()
					Call OnlyAlert("이미지 파일만 등록 가능합니다.")
				End If
			End If
		Next

	ElseIf flag = "delpic" Then					'첨부파일삭제

		delIdx = Split(cbox, ",")
		For Each key In delIdx
			rso()
			SQL = " SELECT fnm FROM _opopt010 WHERE seq = "& key
			rs.open SQL, dbcon
			If Not rs.eof Then
				Set fs = Server.CreateObject("Scripting.FileSystemObject")
				If rs("fnm") <> "" Then				'파일존재시
					If fs.FileExists(serverPath &"\"& rs("fnm")) Then
						fs.DeleteFile serverPath &"\"& rs("fnm"), True
					End If
				End If
				Set fs = Nothing
				SQL = "	UPDATE _opopt010 SET fnm = '' WHERE seq = "& key
				dbcon.Execute SQL
			End If
			rsc()
		Next

	ElseIf flag = "D" Then						'삭제

		rso()
		SQL = " SELECT fnm FROM _opopt010 WHERE seq = "& seq
		rs.open SQL, dbcon
		While Not rs.eof
			Set fs = Server.CreateObject("Scripting.FileSystemObject")
			If rs("fnm") <> "" Then				'파일존재시
				If fs.FileExists(serverPath & "\" & rs("fnm")) Then
					fs.DeleteFile serverPath & "\" & rs("fnm"), True
				End If
			End If
			Set fs = Nothing
			rs.MoveNext
		Wend
		rsc()
		SQL = "	DELETE FROM _opopt010 WHERE seq = "& seq
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

	Set upObj = Nothing
	Set Image = Nothing
	dbc()
%>