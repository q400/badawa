<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/imagevbs.inc" -->
<%
	dbo()
	Call checkLevel(FID_AUTH, 100, Request.ServerVariables("PATH_INFO"))

	Set upObj = Server.CreateObject("TABSUpload4.Upload")
	upObj.CodePage = 65001
	upObj.Start Server.MapPath(PATH_TMP)						'저장경로
	upObj.MaxBytesToAbort = 1 * 1024 * 1024						'1메가 이하로 제한
	Set Vc = Server.CreateObject("TABSUpload4.VirusChecker")

	seq							= SQLI(upObj("seq"))
	idx							= SQLI(upObj("idx"))
	page						= SQLI(upObj("page"))
	cd1							= SQLI(upObj("cd1"))
	cd2							= SQLI(upObj("cd2"))
	flag						= SQLI(upObj("flag"))

	title						= SQLI(chkWord(upObj("title")))
	shipid						= SQLI(chkWord(upObj("shipid")))
	rdate						= SQLI(chkWord(upObj("rdate")))
	comment						= SQLI(chkWord(upObj("comment")))
	cbox						= SQLI(upObj("cbox"))

	If flag = "" Then flag = "W"
	If FID_NO = "" Then FID_NO = 0
'	Response.Write "FID_NO : "& FID_NO &"<br>"

	nlist						= "ps"
	nview						= "ps_v"
	nwrite						= "ps_w"

	tmpPath						= Server.MapPath(PATH_TMP)
	serverPath					= Server.MapPath(PATH_PS)
	webPath						= PATH_PS
	nmparam						= Right(year(now),2) & setp(month(now)) & setp(day(now)) & setp(hour(now)) & setp(minute(now)) & setp(second(now))

	If seq <> "" Then
		rso()
		SQL = " SELECT uno FROM _obbst050 WHERE seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			uno = rs(0)
		End If
		rsc()
	End If

	If flag = "W" Then							'쓰기

		SQL = "	INSERT INTO _obbst050	(title, shipid, uno, unm, uip, rdate, ddate) VALUES (" _
			& "			'"& title &"'" _
			& ",		"& shipid _
			& ",		"& FID_NO _
			& ",		'"& FID_NIC &"'" _
			& ",		'"& Request.ServerVariables("REMOTE_ADDR") &"'" _
			& ",		'"& rdate &"'" _
			& ",		getdate()" _
			& ")"
		If blackyn(pname) = False Then dbcon.Execute SQL

		rso()
		SQL = " SELECT ISNULL(MAX(seq),0) FROM _obbst050 "
		rs.open SQL, dbcon
			mxseq			= CInt(rs(0))
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
								If fwd <= 800 Then
											SQL = " INSERT INTO	_obbst051 (seq, fpath, fnm, onm, fsz, fwd, ext, comment) VALUES (" _
												& "			"& mxseq _
												& ",		'"& webPath &"'" _
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
											SQL = " INSERT INTO	_obbst051 (seq, fpath, fnm, onm, fsz, fwd, ext, comment) VALUES (" _
												& "			"& mxseq _
												& ",		'"& webPath &"'" _
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
'		Commit

	ElseIf flag = "M" Then						'수정

		If CInt(FID_NO) <> uno Then
			Call directGo("본인이 작성한 글만 수정하실 수 있습니다.        ", nview &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
			Response.End
		End If

		SQL = "	UPDATE	_obbst050 SET " _
			& "			title			= '"& title &"'" _
			& ",		shipid			= "& shipid _
			& ",		rdate			= '"& rdate &"'" _
			& "	WHERE	seq = "& seq
		If blackyn(title) = False Then dbcon.Execute SQL

		delidx = Split(cbox, ",")
		For Each key In delidx
			rso()
			SQL = " SELECT idx, seq, fnm FROM _obbst051 WHERE idx = "& key
			rs.open SQL, dbcon
			If Not rs.eof Then
				Set fs = Server.CreateObject("Scripting.FileSystemObject")
				If rs("fnm") <> "" Then				'파일존재시
					If fs.FileExists(serverPath &"\tm_"& rs("fnm")) Then
						fs.DeleteFile serverPath &"\tm_"& rs("fnm"), True
					End If
					If fs.FileExists(serverPath &"\"& rs("fnm")) Then
						fs.DeleteFile serverPath &"\"& rs("fnm"), True
					End If
				End If
				Set fs = Nothing
				SQL = "	DELETE FROM _obbst051 WHERE idx = "& rs("idx")
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
											SQL = " INSERT INTO	_obbst051 (seq, fpath, fnm, onm, fsz, fwd, ext, comment) VALUES (" _
												& "			"& seq _
												& ",		'"& webPath &"'" _
												& ",		'"& newnm &"."& ext &"'" _
												& ",		'"& upFile.FileName &"'" _
												& ",		'"& upFile.FileSize &"'" _
												& ",		"& fwd _
												& ",		'"& ext &"'" _
												& ",		'"& upObj.Form("upText")(I) &"'" _
												& ")"
											dbcon.Execute SQL,,128
								Else							'폭 700이 넘으면 썸네일 처리
									Set Image = Server.CreateObject("TABSUpload4.Image")
									Status				= Image.Load(serverPath &"\"& newnm &"."& ext)
									If Status = Ok Then
										If Image.SaveThumbnail(serverPath &"\"& newnm &"."& ext,800,0,100) = Ok Then
											SQL = " INSERT INTO	_obbst051 (seq, fpath, fnm, onm, fsz, fwd, ext, comment) VALUES (" _
												& "			"& seq _
												& ",		'"& webPath &"'" _
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
		SQL = " SELECT ISNULL(COUNT(*),0) FROM _obbst052 WHERE seq = "& seq
		rs.open SQL, dbcon
			commcnt = CInt(rs(0))
		rsc()

		If commcnt <> 0 Then
			Call directGo("덧글이 있으므로 삭제하실 수 없습니다. 관리자에 문의바랍니다.        ", nview &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
			Response.End
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

		'후기글 포인트 적립취소
		SQL = "	DELETE FROM _opntt010 WHERE seq = "& seq &" AND note LIKE '조황후기%' "
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
	ElseIf flag = "delpic" Then
		Call directGo("첨부파일이 삭제되었습니다.", nwrite &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "A" Then
		Call directGo("댓글이 등록되었습니다.", nview &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "AD" Then
		Call directGo("댓글이 삭제되었습니다.", nview &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "DP" Then
		Call directGo("사진이 삭제되었습니다.", nwrite &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "D" Then
		Call directGo("삭제되었습니다.", nlist &".asp?cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	End If

	Set upObj = Nothing
	Set Image = Nothing
	dbc()
%>