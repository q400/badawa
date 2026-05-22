<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/imagevbs.inc" -->
<%
	dbo()

	Set upObj = Server.CreateObject("TABSUpload4.Upload")
	Set Image = Server.CreateObject("TABSUpload4.Image")
	Set vc = Server.CreateObject("TABSUpload4.VirusChecker")
	upObj.CodePage = 65001
	upObj.Start Server.MapPath(PATH_TMP)						'저장경로
	upObj.MaxBytesToAbort = 50 * 1024 * 1024					'50메가 이하로 제한

	bbs_id						= 50
	seq							= SQLI(upObj("seq"))
	page						= SQLI(upObj("page"))
	cd1							= SQLI(upObj("cd1"))
	cd2							= SQLI(upObj("cd2"))
	flag						= SQLI(upObj("flag"))

	title						= SQLI(chkWord(upObj("title")))
	contents					= SQLI(chkWord(upObj("contents")))
	comment						= SQLI(chkWord(upObj("comment")))
	gubn						= upObj("gubn")
	cbox						= SQLI(upObj("cbox"))

	If flag = "" Then flag = "W"
	If flag = "W" And seq <> "" Then flag = "M"

	serverPath					= Server.MapPath(PATH_COOK)
	webPath						= PATH_COOK
	nmparam						= Right(year(now),2) & setp(month(now)) & setp(day(now)) & setp(hour(now)) & setp(minute(now)) & setp(second(now))

	nlist						= "cook"
	nview						= "cook_v"
	nwrite						= "cook_w"

	If flag = "W" Then							'쓰기

		SQL = "	INSERT INTO _obbst010 (bbs_id, title, gubn, uno, uip, cnt, ddate, contents) VALUES (" _
			& "			"& bbs_id _
			& ",		'"& title &"'" _
			& ",		'"& gubn &"'" _
			& ",		"& FID_NO _
			& ",		'"& Request.ServerVariables("REMOTE_ADDR") &"'" _
			& ",		0" _
			& ",		getdate()" _
			& ",		'"& contents &"'" _
			& ")"
		dbcon.Execute SQL

		rso()
		SQL = " SELECT ISNULL(MAX(seq),0) FROM _obbst010 "
		rs.open SQL, dbcon
			mxseq			= CInt(rs(0))
		rsc()

		For I = 1 To upObj.Form("upFile").Count
			Set upFile			= upObj.Form("upFile")(I)
			If upFile.Value <> "" Then
							ext			= upFile.FileType												'확장자
							fwd			= upFile.ImageWidth
							newnm		= nmparam &"["& I &"]"											'새이름지정
							savenm		= upFile.SaveAs(serverPath &"\"& newnm &"."& ext, False)		'실제 저장된 파일명

							If fwd > 800 Then
								Status	= Image.Load(serverPath &"\"& newnm &"."& ext)
								If Status = Ok Then
									Image.SaveThumbnail serverPath &"\"& newnm &"."& ext, 800, 0, 100
									Image.Close
								Else
									Response.Write "이미지 파일을 열 수 없습니다. 오류코드: "& Status
								End If
							End If

							If vc.Open(19978) Then
								vc.CheckVirus serverPath &"\"& newnm &"."& ext, True, found, virusName
								If found = True Then
									Response.Write virusName & " detected"
								End If
								vc.Close
							End If

							SQL = "	INSERT INTO _obbst011 (seq, fpath, fnm, onm, fsz, fwd, ext, comment) VALUES (" _
								& "			"& mxseq _
								& ",		'"& webPath &"'" _
								& ",		'"& newnm &"."& ext &"'" _
								& ",		'"& upFile.FileName &"'" _
								& ",		"& upFile.FileSize _
								& ",		"& fwd _
								& ",		'"& ext &"'" _
								& ",		'"& upObj.Form("upText")(I) &"'" _
								& ")"
							dbcon.Execute SQL
			End If
		Next

		For I = 1 To upObj.Form("upVod").Count
			Set upVod			= upObj.Form("upVod")(I)
			If upVod.Value <> "" Then
							ext			= upVod.FileType												'확장자
							newnm		= nmparam &"_vod"												'새이름지정
							savenm		= upVod.SaveAs(serverPath &"\"& newnm &"."& ext, False)			'실제 저장된 파일명

							SQL = "	INSERT INTO _obbst011 (seq, fpath, fnm, onm, fsz, fwd, ext) VALUES (" _
								& "			"& mxseq _
								& ",		'"& webPath &"'" _
								& ",		'"& newnm &"."& ext &"'" _
								& ",		'"& upVod.FileName &"'" _
								& ",		"& upVod.FileSize _
								& ",		"& fwd _
								& ",		'"& ext &"'" _
								& ")"
							dbcon.Execute SQL
			End If
		Next

	ElseIf flag = "M" Then						'수정

		SQL = "	UPDATE	_obbst010 SET " _
			& "			title = '"& title &"'" _
			& ",		gubn = '"& gubn &"'" _
			& ",		contents = '"& contents &"' " _
			& "	WHERE	seq = "& seq
		If blackyn(title) = False And blackyn(contents) = False Then dbcon.Execute SQL

		delidx = Split(cbox, ",")
		For Each key In delidx
			rso()
			SQL = " SELECT idx, seq, fnm FROM _obbst011 WHERE idx = "& key
			rs.open SQL, dbcon
			If Not rs.eof Then
				Set fso = Server.CreateObject("Scripting.FileSystemObject")
				If rs("fnm") <> "" Then				'파일존재시
					If fso.FileExists(serverPath &"\"& rs("fnm")) Then
						fso.DeleteFile serverPath &"\"& rs("fnm"), True
					End If
				End If
				Set fso = Nothing
				SQL = "	DELETE FROM _obbst011 WHERE idx = "& rs("idx")
				dbcon.Execute SQL
			End If
			rsc()
		Next

		For I = 1 To upObj.Form("upFile").Count
			Set upFile			= upObj.Form("upFile")(I)
			If upFile.Value <> "" Then
							ext			= upFile.FileType												'확장자
							fwd			= upFile.ImageWidth
							newnm		= nmparam &"["& I &"]"											'새이름지정
							savenm		= upFile.SaveAs(serverPath &"\"& newnm &"."& ext, False)		'실제 저장된 파일명
							Status		= Image.Load(serverPath &"\"& newnm &"."& ext)
							If Status = Ok Then
								Image.SaveThumbnail serverPath &"\"& newnm &"."& ext, 800, 0, 100
								Image.Close
							Else
								Response.Write "이미지 파일을 열 수 없습니다. 오류코드: "& Status
							End If
							SQL = " INSERT INTO _obbst011 (seq, fpath, fnm, onm, fwd, fsz, ext, best) VALUES (" _
								& "			"& seq _
								& ",		'"& webPath &"'" _
								& ",		'"& newnm &"."& ext &"'" _
								& ",		'"& upFile.FileName &"'" _
								& ",		"& fwd _
								& ",		"& upFile.FileSize _
								& ",		'"& ext &"'" _
								& ",		''" _
								& ")"
							dbcon.Execute SQL,,128
			End If
		Next

		For I = 1 To upObj.Form("upVod").Count
			Set upVod			= upObj.Form("upVod")(I)
			If upVod.Value <> "" Then
							ext			= upVod.FileType												'동영상 확장자
							newnm		= nmparam &"_vod"												'동영상 새이름지정
							savenm		= upVod.SaveAs(serverPath &"\"& newnm &"."& ext, False)			'실제 저장된 파일명
							SQL = " INSERT INTO _obbst011 (seq, fpath, fnm, onm, fwd, fsz, ext, best) VALUES (" _
								& "			"& seq _
								& ",		'"& webPath &"'" _
								& ",		'"& newnm &"."& ext &"'" _
								& ",		'"& upVod.FileName &"'" _
								& ",		0" _
								& ",		"& upVod.FileSize _
								& ",		'"& ext &"'" _
								& ",		''" _
								& ")"
							dbcon.Execute SQL,,128
			End If
		Next

	ElseIf flag = "delpic" Then					'첨부파일삭제

		delidx = Split(cbox, ",")
		For Each key In delidx
			rso()
			SQL = " SELECT idx, seq, fnm FROM _obbst011 WHERE idx = "& key
			rs.open SQL, dbcon
			If Not rs.eof Then
				Set fso = Server.CreateObject("Scripting.FileSystemObject")
				If rs("fnm") <> "" Then				'파일존재시
					If fso.FileExists(serverPath &"\"& rs("fnm")) Then
						fso.DeleteFile serverPath &"\"& rs("fnm"), True
					End If
				End If
				Set fso = Nothing
				SQL = "	DELETE FROM _obbst011 WHERE idx = "& rs("idx")
				dbcon.Execute SQL
			End If
			rsc()
		Next

	ElseIf flag = "D" Then						'삭제

		rso()
		SQL = " SELECT idx, seq, fnm FROM _obbst011 WHERE seq = "& seq
		rs.open SQL, dbcon
		While Not rs.eof
			Set fso = Server.CreateObject("Scripting.FileSystemObject")
			If rs("fnm") <> "" Then				'파일존재시
				If fso.FileExists(serverPath & "\" & rs("fnm")) Then
					fso.DeleteFile serverPath & "\" & rs("fnm"), True
				End If
			End If
			Set fso = Nothing
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
		Call directGo("처리되었습니다.", nwrite &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "delpic" Then
		Call directGo("처리되었습니다.", nwrite &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "D" Then
		Call directGo("삭제되었습니다.", nlist &".asp?cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	End If

	Set upObj = Nothing
	Set Image = Nothing
	dbc()
%>