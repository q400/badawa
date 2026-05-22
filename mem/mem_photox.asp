<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/imagevbs.inc" -->
<%
	dbo()

	Set upObj = Server.CreateObject("TABSUpload4.Upload")
	upObj.CodePage = 65001
	upObj.Start Server.MapPath(PATH_TMP)						'저장경로
	upObj.MaxBytesToAbort = 0.5 * 1024 * 1024					'500 byte 이하로 제한
	Set Vc = Server.CreateObject("TABSUpload4.VirusChecker")

	seq							= SQLI(upObj("seq"))
	memid						= SQLI(upObj("memid"))
	idx							= SQLI(upObj("idx"))
	page						= SQLI(upObj("page"))
	flag						= SQLI(upObj("flag"))

	comment						= SQLI(chkWord(upObj("comment")))
	cbox						= SQLI(upObj("cbox"))

	If flag = "" Then flag = "W"
	If FID_NO = "" Then FID_NO = 0
'	Response.Write "FID_NO : "& FID_NO &"<br>"

	serverPath					= Server.MapPath(PATH_MEM)
	webPath						= PATH_MEM
	nmparam						= setp(month(now)) & setp(day(now)) & setp(hour(now)) & setp(minute(now)) & setp(second(now))

	If flag = "W" Then							'쓰기

		For I = 1 To upObj.Form("upFile").Count
			Set upFile = upObj.Form("upFile")(I)
			If upFile.Value <> "" Then
				ext			= Mid(upFile.Value, InstrRev(upFile.Value,".") + 1)
				fmat		= upFile.Format.Name
				fwd			= upFile.ImageWidth					'이미지 폭
				fht			= upFile.ImageHeight				'이미지 높이
				newnm		= nmparam &"["& I &"]"				'새이름지정

'				If UCase(fmat) = "JPG" Or UCase(fmat) = "JPEG" Or UCase(fmat) = "GIF" Or UCase(fmat) = "PNG" Then
				If upFile.ImageType > 0 Then					'이미지 파일

					If Vc.Open(19978) Then						'임시 파일 형태로 저장된 업로드 파일에 대해 바이러스를 검사한다.
'						Response.Write "Connected to the TABSUpload4 Utility Service.<br>"
'						Response.Write "Scanning "& upFile.TmpFileName &"<br>"
						Vc.CheckVirus upFile.TmpFileName, True, Found, VirusName
						Vc.Close

						If Found Then
							Response.Write "Infected by "& VirusName &" and removed immediately."
						Else									'바이러스가 없을 경우 최종 목적지로 저장한다.

'								ffname		= upFile.SaveAs(serverPath &"\"& upFile.FileName, False)
'								fname		= Mid(ffname, InstrRev(ffname, "\")+1)
								savenm		= upFile.SaveAs(serverPath &"\"& newnm &"."& ext, False)					'실제 저장된 파일명
'								Response.Write "savenm "& savenm &"<br>"
								If fwd <= 130 Then
											SQL = " INSERT INTO	_omemt011 (seq, memid, fnm, onm, fwd, ext, comment) VALUES (" _
												& "			"& seq _
												& ",		'"& memid &"'" _
												& ",		'"& newnm &"."& ext &"'" _
												& ",		'"& upFile.FileName &"'" _
												& ",		"& fwd _
												& ",		'"& ext &"'" _
												& ",		'"& upObj.Form("upText")(I) &"'" _
												& ")"
											dbcon.Execute SQL,,128
								Else							'폭 130이 넘으면 썸네일 처리
									Set Image = Server.CreateObject("TABSUpload4.Image")
									Status				= Image.Load(serverPath &"\"& newnm &"."& ext)
'									bonname				= Mid(upFile.SaveName,InstrRev(upFile.SaveName,"\")+1)
'									bonname				= Left(bonname, InstrRev(bonname,".")-1)						'확장자 제외한 파일명
									If Status = Ok Then
										If Image.SaveThumbnail(serverPath &"\"& newnm &"."& ext,130,0,100) = Ok Then
											SQL = " INSERT INTO	_omemt011 (seq, memid, fnm, onm, fwd, ext, comment) VALUES (" _
												& "			"& seq _
												& ",		'"& memid &"'" _
												& ",		'"& newnm &"."& ext &"'" _
												& ",		'"& upFile.FileName &"'" _
												& ",		130" _
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

		delidx = Split(cbox, ",")
		For Each key In delidx
			rso()
			SQL = " SELECT idx, seq, fnm FROM _omemt011 WHERE idx = "& key
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
				SQL = "	DELETE FROM _omemt011 WHERE idx = "& rs("idx")
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
'						Response.Write "Connected to the TABSUpload4 Utility Service.<br>"
'						Response.Write "Scanning "& upFile.TmpFileName &"<br>"
						Vc.CheckVirus upFile.TmpFileName, True, Found, VirusName
						Vc.Close

						If Found Then
							Response.Write "Infected by "& VirusName &" and removed immediately."
						Else									'바이러스가 없을 경우 최종 목적지로 저장한다.

								savenm		= upFile.SaveAs(serverPath &"\"& newnm &"."& ext, False)					'실제 저장된 파일명
								If fwd <= 130 Then
											SQL = " INSERT INTO	_omemt011 (seq, memid, fnm, onm, fwd, ext, comment) VALUES (" _
												& "			"& seq _
												& ",		'"& memid &"'" _
												& ",		'"& newnm &"."& ext &"'" _
												& ",		'"& upFile.FileName &"'" _
												& ",		"& fwd _
												& ",		'"& ext &"'" _
												& ",		'"& upObj.Form("upText")(I) &"'" _
												& ")"
											dbcon.Execute SQL,,128
								Else							'폭 700이 넘으면 썸네일 처리
									Set Image = Server.CreateObject("TABSUpload4.Image")
									Status				= Image.Load(serverPath &"\"& newnm &"."& ext)
									If Status = Ok Then
										If Image.SaveThumbnail(serverPath &"\"& newnm &"."& ext,130,0,100) = Ok Then
											SQL = " INSERT INTO	_omemt011 (seq, memid, fnm, onm, fwd, ext, comment) VALUES (" _
												& "			"& seq _
												& ",		'"& memid &"'" _
												& ",		'"& newnm &"."& ext &"'" _
												& ",		'"& upFile.FileName &"'" _
												& ",		130" _
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

	ElseIf flag = "DP" Then						'사진삭제

		rso()
		SQL = " SELECT idx, seq, fnm FROM _omemt011 WHERE idx = "& idx
		rs.open SQL, dbcon
		If Not rs.eof Then
			Set fs = Server.CreateObject("Scripting.FileSystemObject")
			If rs("fnm") <> "" Then				'파일존재시
				If fs.FileExists(serverPath & "\" & rs("fnm")) Then
					fs.DeleteFile serverPath & "\" & rs("fnm"), True
				End If
			End If
			Set fs = Nothing
			SQL = "	DELETE FROM _omemt011 WHERE idx = "& rs("idx")
			dbcon.Execute SQL
		End If
		rsc()

	ElseIf flag = "delpic" Then					'첨부파일삭제

		delidx = Split(cbox, ",")
		For Each key In delidx
			rso()
			SQL = " SELECT idx, seq, fnm FROM _omemt011 WHERE idx = "& key
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
				SQL = "	DELETE FROM _omemt011 WHERE idx = "& rs("idx")
				dbcon.Execute SQL
			End If
			rsc()
		Next

	ElseIf flag = "B" Then						'대표 이미지 선정

		SQL = " UPDATE _omemt011 SET best = 'N' WHERE seq = "& seq
		dbcon.Execute SQL

		SQL = " UPDATE _omemt011 SET best = 'Y' WHERE idx = "& idx
		dbcon.Execute SQL

	ElseIf flag = "D" Then						'삭제

		rso()
		SQL = " SELECT idx, seq, fnm FROM _omemt011 WHERE seq = "& seq
		rs.open SQL, dbcon

		While Not rs.eof
			Set fs = Server.CreateObject("Scripting.FileSystemObject")
			If rs("fnm") <> "" Then				'파일존재시
				If fs.FileExists(serverPath & "\" & rs("fnm")) Then
					fs.DeleteFile serverPath & "\" & rs("fnm"), True
				End If
			End If
			Set fs = Nothing
			SQL = "	DELETE FROM _omemt011 WHERE idx = "& rs("idx")
			dbcon.Execute SQL
			rs.MoveNext
		Wend
		rsc()

	End If

	If flag = "W" Then
		Call directGo("등록되었습니다.", "mem_finish.asp")
		Response.End
	ElseIf flag = "M" Then
		Call directGo("수정되었습니다.", "mem_photo.asp?seq="& seq &"&memid="& memid)
		Response.End
	ElseIf flag = "DP" Then
		Call directGo("사진이 삭제되었습니다.", "mem_photo.asp?seq="& seq &"&memid="& memid)
		Response.End
	ElseIf flag = "delpic" Then
		Call directGo("사진이 삭제되었습니다.", "mem_photo.asp?seq="& seq &"&memid="& memid)
		Response.End
	ElseIf flag = "B" Then
		Call directGo("처리되었습니다.", "mem_photo.asp?seq="& seq &"&memid="& memid)
		Response.End
	ElseIf flag = "D" Then
		Call directGo("삭제되었습니다.", "mod.asp")
		Response.End
	End If

	Set upObj = Nothing
	Set Image = Nothing
	dbc()
%>