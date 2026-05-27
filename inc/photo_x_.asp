<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	Set upObj = Server.CreateObject("TABSUpload4.Upload")
'	upObj.CodePage = 65001
	upObj.Start Server.MapPath(PATH_TMP)						'저장경로
	upObj.MaxBytesToAbort = 1 * 1024 * 1024						'5메가 이하로 제한

	shipid						= SQLI(upObj("shipid"))
	page						= SQLI(upObj("page"))
	cd1							= SQLI(upObj("cd1"))
	cd2							= SQLI(upObj("cd2"))
	op							= SQLI(upObj("op"))
	cbox						= SQLI(upObj("cbox"))
	idx							= SQLI(upObj("idx"))
	flag						= SQLI(upObj("flag"))

	If flag = "" Then flag = "W"

	Select Case op
		Case "ship" :
			serverPath			= Server.MapPath(PATH_SHIP)
			webPath				= PATH_SHIP
			vpath				= "/_adm/ship/ship"
			tblnm				= "_oshpt011"
	End Select

	If flag = "W" Then							'쓰기

			dbcon.Execute "BEGIN"
			For I = 1 To upObj.Form("upFile").Count
				Set upFile = upObj.Form("upFile")(I)
				If upFile.Value <> "" Then
					If upFile.FileSize <= upObj.MaxBytesToAbort Then
						ext				= Mid(upFile.Value, InstrRev(upFile.Value,".") + 1)			'확장자
						If extcheck(UCase(ext)) = True Then
							upObj.DeleteAllSavedFiles
							dbcon.Execute "ROLLBACK"
							Call OnlyAlert("등록이 불가능한 확장자입니다.        ")
							Call divReload()
							Response.End
						Else
							ffname		= upFile.SaveAs(serverPath &"\["& shipid &"]"& upFile.FileName, False)
							fname		= Mid(ffname, InstrRev(ffname, "\")+1)
							SQL = " INSERT INTO	"& tblnm &" (shipid, fpath, fnm, fsz, fwd, ext, comment) VALUES (" _
								& "			"& shipid _
								& ",		'"& webPath &"'" _
								& ",		'"& fname &"'" _
								& ",		'"& upFile.FileSize &"'" _
								& ",		'"& upFile.ImageWidth &"'" _
								& ",		'"& ext &"'" _
								& ",		'"& upObj.Form("upText")(I) &"'" _
								& ")"
							dbcon.Execute SQL,,128
						End If
					Else
						upObj.DeleteAllSavedFiles
						dbcon.Execute "ROLLBACK"
						Call OnlyAlert("3 MB이하의 파일만 등록하세요.         ")
						Call divReload()
						Response.End
					End If
				End If
			Next
			dbcon.Execute "COMMIT"

	ElseIf flag = "M" Then						'수정

			delPhoto_id = Split(cbox, ",")
			For Each key In delPhoto_id
				rso()
				SQL = " SELECT idx, shipid, fpath, fnm FROM "& tblnm &" WHERE idx = "& key
				rs.open SQL, dbcon
				If Not rs.eof Then
					Set fs = Server.CreateObject("Scripting.FileSystemObject")
					If rs("fnm") <> "" Then				'파일존재시
						If fs.FileExists(serverPath & "\" & rs("fnm")) Then
							fs.DeleteFile serverPath & "\" & rs("fnm"), True
						End If
					End If
					Set fs = Nothing
					SQL = "	DELETE FROM "& tblnm &" WHERE idx = "& rs("idx")
					dbcon.Execute SQL
				End If
				rsc()
			Next

			For I = 1 To upObj.Form("upFile").Count
				Set upFile = upObj.Form("upFile")(I)
				If upFile.Value <> "" Then
					If upFile.FileSize <= upObj.MaxBytesToAbort Then
						ext			= Mid(upFile.Value, InstrRev(upFile.Value,".") + 1)			'확장자
						If extcheck(UCase(ext)) = True Then
							upObj.DeleteAllSavedFiles
							dbcon.Execute "ROLLBACK"
							Call OnlyAlert("등록이 불가능한 확장자입니다.        ")
							Call divReload()
							Response.End
						Else
							ffname		= upFile.SaveAs(serverPath &"\["& shipid &"]"& upFile.FileName, False)
							fname		= Mid(ffname, InstrRev(ffname, "\")+1)
							SQL = " INSERT INTO	"& tblnm &" (shipid, fpath, fnm, fsz, fwd, ext) VALUES (" _
								& "			"& shipid _
								& ",		'"& webPath &"'" _
								& ",		'"& fname &"'" _
								& ",		'"& upFile.FileSize &"'" _
								& ",		'"& upFile.ImageWidth &"'" _
								& ",		'"& ext &"'" _
								& ")"
							dbcon.Execute SQL,,128
						End If
					Else
						upObj.DeleteAllSavedFiles
						dbcon.Execute "ROLLBACK"
						Call OnlyAlert("3 MB이하의 파일만 등록하세요.         ")
						Call divReload()
						Response.End
					End If
				End If
			Next

	ElseIf flag = "delpic" Then					'첨부파일삭제

			delPhoto_id = Split(cbox, ",")
			For Each key In delPhoto_id
				rso()
				SQL = " SELECT idx, shipid, fpath, fnm FROM "& tblnm &" WHERE idx = "& key
				rs.open SQL, dbcon
				If Not rs.eof Then
					Set fs = Server.CreateObject("Scripting.FileSystemObject")
					If rs("fnm") <> "" Then				'파일존재시
						If fs.FileExists(serverPath & "\" & rs("fnm")) Then
							fs.DeleteFile serverPath & "\" & rs("fnm"), True
						End If
					End If
					Set fs = Nothing
					SQL = "	DELETE FROM "& tblnm &" WHERE idx = "& rs("idx")
					dbcon.Execute SQL
				End If
				rsc()
			Next

	ElseIf flag = "D" Then						'삭제

			rso()
			SQL = " SELECT idx, shipid, file_path, file_nm FROM "& tblnm &" WHERE shipid = "& shipid
			rs.open SQL, dbcon

			While Not rs.eof
				Set fs = Server.CreateObject("Scripting.FileSystemObject")
				If rs("fnm") <> "" Then				'파일존재시
					If fs.FileExists(serverPath & "\" & rs("fnm")) Then
						fs.DeleteFile serverPath & "\" & rs("fnm"), True
					End If
				End If
				Set fs = Nothing
				SQL = "	DELETE FROM "& tblnm &" WHERE idx = "& rs("idx")
				dbcon.Execute SQL
				rs.MoveNext
			Wend
			rsc()

	End If

	If flag = "W" Then
		Call directGo("등록되었습니다.", vpath &"_w.asp?shipid="& shipid &"&op="& op &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End

	ElseIf flag = "M" Then
		Call directGo("수정되었습니다.", vpath &"_w.asp?shipid="& shipid &"&op="& op &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End

	ElseIf flag = "delpic" Then
		Call directGo("첨부파일이 삭제되었습니다.", vpath &"_w.asp?shipid="& shipid &"&op="& op &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End

	ElseIf flag = "D" Then
		Call directGo("삭제되었습니다.", vpath &".asp?shipid="& shipid &"&op="& op &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)

	End If
	Set upObj = Nothing
	Set Image = Nothing
	dbc()
%>