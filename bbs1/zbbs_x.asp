<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/imagevbs.inc" -->
<%
	dbo()

	Set upObj = Server.CreateObject("TABSUpload4.Upload")
	upObj.CodePage = 65001
	upObj.Start Server.MapPath(PATH_TMP)						'저장경로
	upObj.MaxBytesToAbort = 5 * 1024 * 1024						'5메가 이하로 제한
	Set Vc = Server.CreateObject("TABSUpload4.VirusChecker")

	bbs_id						= SQLI(upObj("bbs_id"))			'10-공지/20-메모/50-요리/60-초보자/70-노하우/80-매니아/90-카풀/100-중고/110-레시피/120-잡다한소식/130-상품소개
	seq							= SQLI(upObj("seq"))
	idx							= SQLI(upObj("idx"))
	page						= SQLI(upObj("page"))
	cd1							= SQLI(upObj("cd1"))
	cd2							= SQLI(upObj("cd2"))
	flag						= SQLI(upObj("flag"))

	title						= SQLI(chkWord(upObj("title")))
	nicknm						= SQLI(chkWord(upObj("nicknm")))
	contents					= SQLI(chkWord(upObj("contents")))
	comment						= SQLI(chkWord(upObj("comment")))
	hp1							= SQLI(upObj("hp1"))
	hp2							= SQLI(upObj("hp2"))
	hp3							= SQLI(upObj("hp3"))
	hp							= hp1 &"."& hp2 &"."& hp3
	cbox						= SQLI(upObj("cbox"))

	If bbs_id <> 90 Then hp = ""

	If flag = "" Then flag = "W"
	If FID_NO = "" Then FID_NO = 0

	Select Case bbs_id
		Case ""		: fpath		= PATH_TMP		'tmp
		Case "10"	: fpath		= PATH_NOTICE	: nlist = "notice"		: nview = "notice_v"	: nwrite = "notice_w"		'10-공지
		Case "20"	: fpath		= PATH_QNA		: nlist = "memo"		: nview = "memo_v"		: nwrite = "memo_w"			'20-한줄메모
		Case "40"	: fpath		= PATH_FR		: nlist = "frame"		: nview = "frame_v"		: nwrite = "frame_w"		'40-액자신청
		Case "50"	: fpath		= PATH_COOK		: nlist = "cook"		: nview = "cook_v"		: nwrite = "cook_w"			'50-요리교실
		Case "60"	: fpath		= PATH_BEGINNER	: nlist = "beginner"	: nview = "beginner_v"	: nwrite = "beginner_w"		'60-초보자교실
		Case "70"	: fpath		= PATH_KNOWHOW	: nlist = "knowhow"		: nview = "knowhow_v"	: nwrite = "knowhow_w"		'70-노하우
		Case "80"	: fpath		= PATH_MANIA	: nlist = "mania"		: nview = "mania_v"		: nwrite = "mania_w"		'80-매니아
		Case "90"	: fpath		= PATH_TMP		: nlist = "full"		: nview = "full_v"		: nwrite = "full_w"			'90-카풀
		Case "100"	: fpath		= PATH_MARKET	: nlist = "market"		: nview = "market_v"	: nwrite = "market_w"		'100-중고장터
		Case "110"	: fpath		= PATH_RECIPE	: nlist = "recipe"		: nview = "recipe_v"	: nwrite = "recipe_w"		'110-레시피
		Case "120"	: fpath		= PATH_NEWS		: nlist = "news"		: nview = "news_v"		: nwrite = "news_w"			'120-잡다한소식
	End Select

	serverPath					= Server.MapPath(fpath)
	webPath						= fpath
	nmparam						= Right(year(now),2) & setp(month(now)) & setp(day(now)) & setp(hour(now)) & setp(minute(now)) & setp(second(now))

	If flag = "W" Then							'쓰기

		SQL = "	INSERT INTO _obbst010 (bbs_id, title, uno, nicknm, hp, uip, ddate, contents) VALUES (" _
			& "			"& bbs_id _
			& ",		'"& title &"'" _
			& ",		"& FID_NO _
			& ",		'"& nicknm &"'" _
			& ",		'"& hp &"'" _
			& ",		'"& Request.ServerVariables("REMOTE_ADDR") &"'" _
			& ",		getdate()" _
			& ",		'"& contents &"'" _
			& ")"
'	Response.Write "value : "& blackyn(title) &"<br>"
		If blackyn(title) = False Then
			If blackyn(contents) = False Then
				dbcon.Execute SQL
			End If
		End If

		rso()
		SQL = " SELECT ISNULL(MAX(seq),0) FROM _obbst010 "
		rs.open SQL, dbcon
			mxseq = CInt(rs(0))
		rsc()

		For I = 1 To upObj.Form("upFile").Count
			Set upFile = upObj.Form("upFile")(I)
			If upFile.Value <> "" Then
				ext			= Mid(upFile.Value, InstrRev(upFile.Value,".") + 1)
				fmat		= upFile.Format.Name
				fwd			= upFile.ImageWidth					'이미지 폭
				fht			= upFile.ImageHeight				'이미지 높이
				newnm		= nmparam &"["& I &"]"				'새이름지정

				If upFile.ImageType > 0 Then					'이미지 파일

					If Vc.Open(19978) Then						'임시 파일 형태로 저장된 업로드 파일에 대해 바이러스를 검사한다.
'						Response.Write "Connected to the TABSUpload4 Utility Service.<br>Scanning "& upFile.TmpFileName &"<br>"
						Vc.CheckVirus upFile.TmpFileName, True, Found, VirusName
						Vc.Close

						If Found Then
							Response.Write "Infected by "& VirusName &" and removed immediately."
						Else									'바이러스가 없을 경우 최종 목적지로 저장한다.

								savenm		= upFile.SaveAs(serverPath &"\"& newnm &"."& ext, False)					'실제 저장된 파일명
'								Response.Write "savenm "& savenm &"<br>"
								If fwd <= 800 Then
											SQL = " INSERT INTO	_obbst011 (seq, fpath, fnm, onm, fsz, fwd, ext, comment) VALUES (" _
												& "			"& mxseq _
												& ",		'"& fpath &"'" _
												& ",		'"& newnm &"."& ext &"'" _
												& ",		'"& upFile.FileName &"'" _
												& ",		'"& upFile.FileSize &"'" _
												& ",		"& fwd _
												& ",		'"& ext &"'" _
												& ",		'"& upObj.Form("upText")(I) &"'" _
												& ")"
											dbcon.Execute SQL,,128
								Else							'폭 800이 넘으면 썸네일 처리
									Set Image = Server.CreateObject("TABSUpload4.Image")
									Status				= Image.Load(serverPath &"\"& newnm &"."& ext)
									If Status = Ok Then
										If Image.SaveThumbnail(serverPath &"\"& newnm &"."& ext,800,0,100) = Ok Then
											SQL = " INSERT INTO	_obbst011 (seq, fpath, fnm, onm, fsz, fwd, ext, comment) VALUES (" _
												& "			"& mxseq _
												& ",		'"& fpath &"'" _
												& ",		'"& newnm &"."& ext &"'" _
												& ",		'"& upFile.FileName &"'" _
												& ",		'"& upFile.FileSize &"'" _
												& ",		800" _
												& ",		'jpg'" _
												& ",		'"& upObj.Form("upText")(I) &"'" _
												& ")"
											dbcon.Execute SQL,,128
										End If
									End If
									Image.Close
								End If

						End If
					End If

				Else
					upObj.Delete()
					Call OnlyAlert("이미지 파일만 등록 가능합니다.        ")
				End If
			End If
		Next

	ElseIf flag = "M" Then						'수정

		SQL = "	UPDATE	_obbst010 SET " _
			& "			title		= '"& title &"'" _
			& ",		hp			= '"& hp &"'" _
			& ",		contents	= '"& contents &"' " _
			& "	WHERE	seq = "& seq
		If blackyn(title) = False Then
			If blackyn(contents) = False Then
				dbcon.Execute SQL
			End If
		End If

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
				ext			= Mid(upFile.Value, InstrRev(upFile.Value,".") + 1)
				fmat		= upFile.Format.Name
				fwd			= upFile.ImageWidth					'이미지 폭
				fht			= upFile.ImageHeight				'이미지 높이
				newnm		= nmparam &"["& I &"]"				'새이름지정

				If upFile.ImageType > 0 Then					'이미지 파일

					If Vc.Open(19978) Then						'임시 파일 형태로 저장된 업로드 파일에 대해 바이러스를 검사한다.
'						Response.Write "Connected to the TABSUpload4 Utility Service.<br>Scanning "& upFile.TmpFileName &"<br>"
						Vc.CheckVirus upFile.TmpFileName, True, Found, VirusName
						Vc.Close

						If Found Then
							Response.Write "Infected by "& VirusName &" and removed immediately."
						Else									'바이러스가 없을 경우 최종 목적지로 저장한다.

								savenm		= upFile.SaveAs(serverPath &"\"& newnm &"."& ext, False)					'실제 저장된 파일명
								If fwd <= 800 Then
											SQL = " INSERT INTO	_obbst011 (seq, fpath, fnm, onm, fsz, fwd, ext, comment) VALUES (" _
												& "			"& seq _
												& ",		'"& fpath &"'" _
												& ",		'"& newnm &"."& ext &"'" _
												& ",		'"& upFile.FileName &"'" _
												& ",		'"& upFile.FileSize &"'" _
												& ",		"& fwd _
												& ",		'"& ext &"'" _
												& ",		'"& upObj.Form("upText")(I) &"'" _
												& ")"
											dbcon.Execute SQL,,128
								Else							'폭 800이 넘으면 썸네일 처리
									Set Image = Server.CreateObject("TABSUpload4.Image")
									Status				= Image.Load(serverPath &"\"& newnm &"."& ext)
									If Status = Ok Then
										If Image.SaveThumbnail(serverPath &"\"& newnm &"."& ext,800,0,100) = Ok Then
											SQL = " INSERT INTO	_obbst011 (seq, fpath, fnm, onm, fsz, fwd, ext, comment) VALUES (" _
												& "			"& seq _
												& ",		'"& fpath &"'" _
												& ",		'"& newnm &"."& ext &"'" _
												& ",		'"& upFile.FileName &"'" _
												& ",		'"& upFile.FileSize &"'" _
												& ",		800" _
												& ",		'jpg'" _
												& ",		'"& upObj.Form("upText")(I) &"'" _
												& ")"
											dbcon.Execute SQL,,128
										End If
									End If
								End If

						End If
					End If

				Else
					upObj.Delete()
					Call OnlyAlert("이미지 파일만 등록 가능합니다.        ")
				End If
			End If
		Next

	ElseIf flag = "A" Then						'덧글입력

		SQL = "	INSERT INTO _obbst012 (seq, uno, ddate, comment) " _
			& "	VALUES (" _
			& "			"& seq _
			& ",		'"& FID_NO &"'" _
			& ",		getdate()" _
			& ",		'"& comment &"'" _
			& ")"
		dbcon.Execute SQL

	ElseIf flag = "AD" Then						'덧글삭제

		SQL = "	DELETE FROM _obbst012 WHERE idx = "& idx
		dbcon.Execute SQL

	ElseIf flag = "DP" Then						'사진삭제

		rso()
		SQL = " SELECT idx, seq, fpath, fnm FROM _obbst011 WHERE idx = "& idx
		rs.open SQL, dbcon
		If Not rs.eof Then
			Set fs = Server.CreateObject("Scripting.FileSystemObject")
			If rs("fnm") <> "" Then				'파일존재시
				If fs.FileExists(serverPath & "\" & rs("fnm")) Then
					fs.DeleteFile serverPath & "\" & rs("fnm"), True
				End If
			End If
			Set fs = Nothing
			SQL = "	DELETE FROM _obbst011 WHERE idx = "& rs("idx")
			dbcon.Execute SQL
		End If
		rsc()

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

	ElseIf flag = "D" Then						'삭제

		rso()
		SQL = " SELECT ISNULL(COUNT(*),0) FROM _obbst012 WHERE seq = "& seq
		rs.open SQL, dbcon
			commcnt = CInt(rs(0))
		rsc()

		If commcnt <> 0 Then
			Call directGo("덧글이 있으므로 삭제하실 수 없습니다. 관리자에 문의바랍니다.        ", nview &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
			Response.End
		End If

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
		Call directGo("수정되었습니다.", nview &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "R" Then
		Call directGo("답변글이 등록되었습니다.", nlist &".asp?cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "DP" Then
		Call directGo("첨부파일이 삭제되었습니다.", nwrite &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
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