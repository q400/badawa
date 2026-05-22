<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/imagevbs.inc" -->
<%
	dbo()

	Set upObj = Server.CreateObject("DEXT.FileUpload")
	Set objImage = Server.CreateObject("DEXT.ImageProc")
	upObj.CodePage = 65001
	upObj.DefaultPath = Server.MapPath(PATH_MOOL)				'저장경로
	upObj.MaxFileLen = 1 * 1024 * 1024							'하나의 최대파일 크기를 2MB이하로 제한
	upObj.TotalLen = 10 * 1024 * 1024							'전체 데이타의 크기를 50MB 이하로 제한

	bbs_id						= upObj("bbs_id")				'10-공지/20-메모/50-요리/60-초보자/70-노하우/80-매니아/90-카풀/100-중고/110-레시피/120-잡다한소식/130-상품소개
	seq							= SQLI(upObj("seq"))
	idx							= SQLI(upObj("idx"))
	page						= SQLI(upObj("page"))
	cd1							= SQLI(upObj("cd1"))
	cd2							= SQLI(upObj("cd2"))
	flag						= SQLI(upObj("flag"))

	title						= SQLI(chkWord(upObj("title")))
	gubn						= SQLI(upObj("gubn"))
	nicknm						= SQLI(upObj("nicknm"))
'	Response.Write "title : "& title &"<br>"
	contents					= SQLI(chkWord(upObj("contents")))
	answer						= chkWord(upObj("answer"))
	cbox						= SQLI(upObj("cbox"))
	vodUrl						= SQLI(upObj("vodUrl"))			'유투브 URL

	If flag = "" Then flag = "W"

	Select Case bbs_id
		Case ""		: fpath = PATH_TMP		'tmp
		Case "10"	: fpath = PATH_NOTICE	: nlist = "notice"		: nview = "notice_v"	: nwrite = "notice_w"		'10 공지
		Case "20"	: fpath = PATH_TMP		: nlist = "memo"		: nview = "memo_v"		: nwrite = "memo_w"			'20 한줄메모
		Case "50"	: fpath = PATH_COOK		: nlist = "cook"		: nview = "cook_v"		: nwrite = "cook_w"			'50 요리교실
		Case "120"	: fpath = PATH_NEWS		: nlist = "news"		: nview = "news_v"		: nwrite = "news_w"			'120 잡다한소식
		Case "130"	: fpath = PATH_SHOP		: nlist = "shop"		: nview = "shop_v"		: nwrite = "shop_w"			'130 상품소개
	End Select

	serverPath					= Server.MapPath(fpath)
	paramNm						= Right(year(now),2) & setp(month(now)) & setp(day(now)) & setp(hour(now)) & setp(minute(now)) & setp(second(now))

	If flag = "W" Then							'쓰기

		SQL = "	INSERT INTO _obbst010 (bbs_id, title, gubn, uno, nicknm, uip, ddate, contents) VALUES (" _
			& "			"& bbs_id _
			& ",		'"& title &"'" _
			& ",		'"& gubn &"'" _
			& ",		"& CInt(FID_NO) _
			& ",		'"& nicknm &"'" _
			& ",		'"& Request.ServerVariables("REMOTE_ADDR") &"'" _
			& ",		getdate()" _
			& ",		'"& contents &"'" _
			& ")"
'		Response.Write SQL &"<br>"
		dbcon.Execute SQL

		For I = 1 To upObj.Form("upFile").Count
			Set upFile = upObj.Form("upFile")(I)
			If upFile.Value <> "" Then
				ext			= upFile.FileExtension	'Mid(upFile.Value, InstrRev(upFile.Value,".") + 1)
				fwd			= upFile.ImageWidth					'이미지 폭
				fht			= upFile.ImageHeight				'이미지 높이
				newNm		= paramNm &"["& I &"]"				'새이름지정

					If extcheck(UCase(ext)) = False Then
								If fwd <= 800 Then
											Call upFile.SaveAs(serverPath &"\"& newNm &"."& ext, False)		'실제 저장된 파일명 'Mid(ffname, InstrRev(ffname,"\")+1)
											SQL = " INSERT INTO	_obbst011 (seq, fpath, fnm, onm, fsz, fwd, ext, comment, ddate)" _
												& " VALUES (" _
												& "			IDENT_CURRENT('_obbst010')" _
												& ",		'"& fpath &"'" _
												& ",		'"& newNm &"."& ext &"'" _
												& ",		'"& upFile.FileName &"'" _
												& ",		'"& upFile.FileLen &"'" _
												& ",		"& fwd _
												& ",		'"& ext &"'" _
												& ",		'"& upObj.Form("upText")(I) &"'" _
												& ",		getdate() " _
												& ")"
											dbcon.Execute SQL,,128
								Else		'폭 800이 넘으면 썸네일 처리
									If True = objImage.SetSourceFile(upFile.TempFilePath) Then		'임시저장
											thumbNm = newNm & "_800.jpg"
											Call objImage.SaveasThumbnail(serverPath &"\"& thumbNm, objImage.ImageWidth/500*800, objImage.ImageHeight/500*800, False)
											SQL = " INSERT INTO	_obbst011 (seq, fpath, fnm, onm, fsz, fwd, ext, comment, ddate)" _
												& " VALUES (" _
												& "			IDENT_CURRENT('_obbst010')" _
												& ",		'"& fpath &"'" _
												& ",		'"& thumbNm &"'" _
												& ",		'"& upFile.FileName &"'" _
												& ",		'"& upFile.FileLen &"'" _
												& ",		'800' " _
												& ",		'jpg' " _
												& ",		'"& upObj.Form("upText")(I) &"'" _
												& ",		getdate() " _
												& ")"
											'Response.Write "<br>"& SQL &"<br>"
											dbcon.Execute SQL,,128
									End If
								End If
					Else
						upObj.DeleteAllSavedFiles
						Call OnlyAlert("등록 불가능한 파일입니다.")
						Response.End
					End If
'				Else
'					upObj.Delete()
'					Call OnlyAlert("이미지 파일만 등록 가능합니다.        ")
'				End If
			End If
		Next

		If bbs_id <> "120" Then
			For I = 1 To upObj.Form("upVod").Count
				Set upVod			= upObj.Form("upVod")(I)
				If upVod.Value <> "" Then
					ext				= upVod.FileType					'확장자
					newNm			= paramNm &"["& I &"]_vod"			'새이름지정

									Call upVod.SaveAs(serverPath &"\"& newNm &"."& ext, False)		'실제 저장된 파일명
									SQL = "	INSERT INTO _obbst011 (fpath, fnm, onm, fsz, fwd, ext, ddate)" _
										& " VALUES (" _
										& "	'"& webPath &"'" _
										& ",'"& newNm &"."& ext &"'" _
										& ",'"& upVod.FileName &"'" _
										& ","& upVod.FileLen _
										& ","& fwd _
										& ",'"& ext &"'" _
										& ",getdate() " _
										& ")"
									dbcon.Execute SQL
				End If
			Next
		Else
									SQL = "	INSERT INTO _obbst011 (seq, fpath, fnm, onm, fsz, fwd, ext, comment, ddate)" _
										& " VALUES (" _
										& "IDENT_CURRENT('_obbst010')" _
										& ",''" _
										& ",'"& vodUrl &"'" _
										& ",''" _
										& ",0" _
										& ",0" _
										& ",'movie'" _
										& ",''" _
										& ",getdate() " _
										& ")"
									dbcon.Execute SQL
		End If

	ElseIf flag = "M" Then						'수정

		SQL = "	UPDATE	_obbst010 SET " _
			& "			title		= '"& title &"'" _
			& ",		gubn		= '"& gubn &"' " _
			& ",		contents	= '"& contents &"' " _
			& "	WHERE	seq = "& seq
		dbcon.Execute SQL

		delidx = Split(cbox, ",")
		For Each key In delidx
			rso()
			SQL = " SELECT idx, seq, fnm FROM _obbst011 WHERE idx = "& key
			rs.open SQL, dbcon
			If Not rs.eof Then
				Set fs = Server.CreateObject("Scripting.FileSystemObject")
				If rs("fnm") <> "" Then				'파일존재시
					If fs.FileExists(serverPath &"\thumb_"& rs("fnm")) Then
						fs.DeleteFile serverPath &"\thumb_"& rs("fnm"), True
					End If
					If fs.FileExists(serverPath &"\"& rs("fnm")) Then
						fs.DeleteFile serverPath &"\"& rs("fnm"), True
					End If
				End If
				Set fs = Nothing
				SQL = "	DELETE FROM _obbst011 WHERE idx = "& rs("idx")
				dbcon.Execute SQL
			End If
			rsc()
		Next

		For I = 1 To upObj.Form("upFile").Count
			Set upFile = upObj.Form("upFile")(I)
			If upFile.Value <> "" Then
				ext			= upFile.FileExtension
				fwd			= upFile.ImageWidth					'이미지 폭
				fht			= upFile.ImageHeight				'이미지 높이
				newNm		= paramNm &"["& I &"]"				'새이름지정

					If extcheck(UCase(ext)) = False Then
								Call upFile.SaveAs(serverPath &"\"& newNm &"."& ext, False)		'실제 저장된 파일명
								If fwd <= 800 Then
											SQL = " INSERT INTO	_obbst011 (seq, fpath, fnm, onm, fsz, fwd, ext, comment, ddate)" _
												& " VALUES (" _
												& "			"& seq _
												& ",		'"& fpath &"'" _
												& ",		'"& newNm &"."& ext &"'" _
												& ",		'"& upFile.FileName &"'" _
												& ",		'"& upFile.FileLen &"'" _
												& ",		"& fwd _
												& ",		'"& ext &"'" _
												& ",		'"& upObj.Form("upText")(I) &"'" _
												& ",		getdate() " _
												& ")"
											dbcon.Execute SQL,,128
								Else		'폭 800이 넘으면 썸네일 처리
									If True = objImage.SetSourceFile(upFile.TempFilePath) Then		'임시저장
											thumbNm = newNm & "_800.jpg"
											Call objImage.SaveasThumbnail(serverPath &"\"& thumbNm, objImage.ImageWidth/500*800, objImage.ImageHeight/500*800, False)
											SQL = " INSERT INTO	_obbst011 (seq, fpath, fnm, onm, fsz, fwd, ext, comment, ddate)" _
												& " VALUES (" _
												& "			"& seq _
												& ",		'"& fpath &"'" _
												& ",		'"& thumbNm &"'" _
												& ",		'"& upFile.FileName &"'" _
												& ",		'"& upFile.FileLen &"'" _
												& ",		'800' " _
												& ",		'jpg' " _
												& ",		'"& upObj.Form("upText")(I) &"'" _
												& ",		getdate() " _
												& ")"
											dbcon.Execute SQL,,128
									End If
								End If
					Else
						upObj.DeleteAllSavedFiles
						Call OnlyAlert("등록 불가능한 파일입니다.")
						Response.End
					End If
			End If
		Next

		If bbs_id <> "120" Then
			For I = 1 To upObj.Form("upVod").Count
				Set upVod			= upObj.Form("upVod")(I)
				If upVod.Value <> "" Then
					ext				= upVod.FileType					'확장자
					newNm			= paramNm &"["& I &"]_vod"			'새이름지정

									Call upVod.SaveAs(serverPath &"\"& newNm &"."& ext, False)		'실제 저장된 파일명
									SQL = "	INSERT INTO _obbst011 (seq, fpath, fnm, onm, fsz, fwd, ext, comment, ddate)" _
										& " VALUES (" _
										& seq _
										& ",'"& webPath &"'" _
										& ",'"& newNm &"."& ext &"'" _
										& ",'"& upVod.FileName &"'" _
										& ","& upVod.FileLen _
										& ","& fwd _
										& ",'"& ext &"'" _
										& ",''" _
										& ",getdate() " _
										& ")"
									dbcon.Execute SQL
				End If
			Next
		Else
									SQL = "	INSERT INTO _obbst011 (seq, fpath, fnm, onm, fsz, fwd, ext, comment, ddate)" _
										& " VALUES (" _
										& seq _
										& ",''" _
										& ",'"& vodUrl &"'" _
										& ",''" _
										& ",0" _
										& ",0" _
										& ",'movie'" _
										& ",''" _
										& ",getdate() " _
										& ")"
									dbcon.Execute SQL
		End If

	ElseIf flag = "delpic" Then					'첨부파일삭제

		delidx = Split(cbox, ",")
		For Each key In delidx
			rso()
			SQL = " SELECT idx, seq, fnm FROM _obbst011 WHERE idx = "& key
			rs.open SQL, dbcon
			If Not rs.eof Then
				Set fs = Server.CreateObject("Scripting.FileSystemObject")
				If rs("fnm") <> "" Then				'파일존재시
					If fs.FileExists(serverPath &"\thumb_"& rs("fnm")) Then
						fs.DeleteFile serverPath &"\thumb_"& rs("fnm"), True
					End If
					If fs.FileExists(serverPath &"\"& rs("fnm")) Then
						fs.DeleteFile serverPath &"\"& rs("fnm"), True
					End If
				End If
				Set fs = Nothing
				SQL = "	DELETE FROM _obbst011 WHERE idx = "& rs("idx")
				dbcon.Execute SQL
			End If
			rsc()
		Next

	ElseIf flag = "eachDelPhoto" Then			'첨부사진 개별삭제

			rso()
			SQL = " SELECT idx, seq, fnm FROM _obbst011 WHERE idx = "& idx
			rs.open SQL, dbcon
			If Not rs.eof Then
				Set fs = Server.CreateObject("Scripting.FileSystemObject")
				If rs("fnm") <> "" Then				'파일존재시
					If fs.FileExists(serverPath &"\thumb_"& rs("fnm")) Then
						fs.DeleteFile serverPath &"\thumb_"& rs("fnm"), True
					End If
					If fs.FileExists(serverPath &"\"& rs("fnm")) Then
						fs.DeleteFile serverPath &"\"& rs("fnm"), True
					End If
				End If
				Set fs = Nothing
				SQL = "	DELETE FROM _obbst011 WHERE idx = "& idx
				dbcon.Execute SQL
			End If
			rsc()

	ElseIf flag = "D" Then						'삭제

		rso()
		SQL = " SELECT idx, seq, fnm FROM _obbst011 WHERE seq = "& seq
		rs.open SQL, dbcon

		While Not rs.eof
			Set fs = Server.CreateObject("Scripting.FileSystemObject")
			If rs("fnm") <> "" Then				'파일존재시
				If fs.FileExists(serverPath & "\" & rs("fnm")) Then
					fs.DeleteFile serverPath & "\" & rs("fnm"), True
				End If
			End If
			Set fs = Nothing
			SQL = "	DELETE FROM _obbst011 WHERE idx = "& rs("idx")
			dbcon.Execute SQL
			rs.MoveNext
		Wend
		rsc()
		SQL = "	DELETE FROM _obbst010 WHERE seq = "& seq
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
	ElseIf flag = "eachDelPhoto" Then
		Call directGo("첨부사진이 삭제되었습니다.", nwrite &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
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