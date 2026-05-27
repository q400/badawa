<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	Dim objImage
	Set upObj = Server.CreateObject("DEXT.FileUpload")
	upObj.AutoMakeFolder = True
	upObj.DefaultPath = Server.MapPath(PATH_TMP)				'저장경로
	upObj.MaxFileLen = 3 * 1024 * 1024							'하나의 최대파일 크기를 3MB이하로 제한
	upObj.TotalLen = 30 * 1024 * 1024							'전체 데이타의 크기를 30MB 이하로 제한
	'upObj.CodePage = 65001

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
	If serverPath = "" Then serverPath = upObj.DefaultPath

	nmParam						= Right(year(now),2) & setp(month(now)) & setp(day(now)) & setp(hour(now)) & setp(minute(now)) & setp(second(now))

	If flag = "W" Then			'쓰기

			For I=1 To upObj.Form("upFile").Count
				Set upFile = upObj.Form("upFile")(I)
				If upFile.Value <> "" Then
					If upFile.FileLen <= upObj.MaxFileLen Then
						ext				= upFile.FileExtension	'Mid(upFile.Value, InstrRev(upFile.Value,".") + 1)		'확장자
						If extcheck(UCase(ext)) = True Then
							upObj.DeleteAllSavedFiles
							dbcon.Execute "ROLLBACK"
							Call OnlyAlert("등록 불가능한 확장자입니다.")
							Call divReload()
							Response.End
						Else
							Set objImage = Server.CreateObject("DEXT.ImageProc")

							If True = objImage.SetSourceFile( upFile.TempFilePath ) Then
								objImage.Quality = 80	'default value is 75 (range 1~100)
								'savedNm = objImage.SaveasThumbnail(serverPath & "\thumb\["& shipid &"]"& nmParam & "_"& I &".gif", objImage.ImageWidth/10, objImage.ImageHeight/10, False)
								savedNm = objImage.SaveasThumbnail(serverPath & "\thumb\["& shipid &"]"& nmParam & "_"& I &".gif", 100, objImage.ImageHeight/objImage.ImageWidth * 100, False)
							End If

							Set objImage = Nothing

							ffname		= upFile.SaveAs(serverPath &"\["& shipid &"]"& nmParam & "_"& I &"." & ext, False)
							'ffname		= upFile.SaveAs(serverPath &"\["& shipid &"]"& upFile.FileName, False)
							fname		= "["& shipid &"]"& nmParam & "_"& I	'Mid(ffname, InstrRev(ffname, "\") + 1)
							SQL = " INSERT INTO	"& tblnm &" (shipid, fpath, fnm, fsz, fwd, ext, comment) VALUES (" _
								& "			"& shipid _
								& ",		'"& webPath &"'" _
								& ",		'"& fname &"'" _
								& ",		'"& upFile.FileLen &"'" _
								& ",		'"& upFile.ImageWidth &"'" _
								& ",		'"& upFile.FileExtension &"'" _
								& ",		'"& upObj.Form("upText")(I) &"'" _
								& ")"
							dbcon.Execute SQL,,128

							'Status				= Image.Load(serverPath &"\["& shipid &"]"& nmParam & "_"& I &"." & ext)
							'If Status = Ok Then
								'Image.SaveThumbnail serverPath &"\thumb\["& shipid &"]"& nmParam & "("& I &")." & ext, 145, 0, 100
								'Image.Save "serverPath &"\thumb\["& shipid &"]"& nmParam & "." & ext", 100, True
								'Call Image.SaveThumbnail(serverPath &"\thumb\["& shipid &"]"& nmParam & "." & ext,145,0,100)
							'End If
						End If
					Else
						upObj.DeleteAllSavedFiles
						Call OnlyAlert("3 MB이하의 파일만 등록하세요.")
						Call divReload()
						Response.End
					End If
				End If
			Next

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

			For I=1 To upObj.Form("upFile").Count
				Set upFile = upObj.Form("upFile")(I)
				If upFile.Value <> "" Then
					If upFile.FileLen <= upObj.MaxFileLen Then
						ext			= Mid(upFile.Value, InstrRev(upFile.Value,".") + 1)			'확장자
						If extcheck(UCase(ext)) = True Then
							upObj.DeleteAllSavedFiles
							dbcon.Execute "ROLLBACK"
							Call OnlyAlert("등록이 불가능한 확장자입니다.")
							Call divReload()
							Response.End
						Else
							ffname		= upFile.SaveAs(serverPath &"\["& shipid &"]"& nmParam & "_"& I &"." & ext, False)	'jpg로 저장해야 함
							fname		= "["& shipid &"]"& nmParam & "_"& I	'Mid(ffname, InstrRev(ffname, "\") + 1)

							SQL = " INSERT INTO	"& tblnm &" (shipid, fpath, fnm, fsz, fwd, ext, comment) VALUES (" _
								& "			"& shipid _
								& ",		'"& webPath &"'" _
								& ",		'"& fname &"'" _
								& ",		'"& upFile.FileLen &"'" _
								& ",		'"& upFile.ImageWidth &"'" _
								& ",		'"& upFile.FileExtension &"'" _
								& ",		'"& upObj.Form("upText")(I) &"'" _
								& ")"
							dbcon.Execute SQL,,128

							Set objImage = Server.CreateObject("DEXT.ImageProc")

							If True = objImage.SetSourceFile( upFile.TempFilePath ) Then
								objImage.Quality = 80	'default value is 75 (range 1~100)
								savedNm = objImage.SaveasThumbnail(serverPath & "\thumb\["& shipid &"]"& nmParam & "_"& I &".gif", objImage.ImageWidth/10, objImage.ImageHeight/10, False)
							End If

							Set objImage = Nothing
						End If
					Else
						upObj.DeleteAllSavedFiles
						Call OnlyAlert("3 MB이하의 파일만 등록하세요.")
						Call divReload()
						Response.End
					End If
				End If
			Next

	ElseIf flag = "delpic" Then					'첨부파일삭제

			delPhoto_id = Split(cbox, ",")
			For Each key In delPhoto_id
				rso()
				SQL = " SELECT idx, shipid, fpath, fnm, ext FROM "& tblnm &" WHERE idx = "& key
				rs.open SQL, dbcon
				If Not rs.eof Then
					Set fs = Server.CreateObject("Scripting.FileSystemObject")
					If rs("fnm") <> "" Then				'파일존재시
						If fs.FileExists(serverPath & "\" & rs("fnm") &"."& rs("ext")) Then
							fs.DeleteFile serverPath & "\" & rs("fnm") &"."& rs("ext"), True
						End If
						If fs.FileExists(serverPath & "\thumb\" & rs("fnm") &".gif") Then
							fs.DeleteFile serverPath & "\thumb\" & rs("fnm") &".gif", True
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
			SQL = " SELECT idx, shipid, file_path, file_nm, ext FROM "& tblnm &" WHERE shipid = "& shipid
			rs.open SQL, dbcon

			While Not rs.eof
				If rs("fnm") <> "" Then				'파일존재시
					Set fs = Server.CreateObject("Scripting.FileSystemObject")
					If fs.FileExists(serverPath & "\" & rs("fnm") &"."& rs("ext")) Then
						fs.DeleteFile serverPath & "\" & rs("fnm") &"."& rs("ext"), True
					End If
					If fs.FileExists(serverPath & "\thumb\" & rs("fnm") &".gif") Then
						fs.DeleteFile serverPath & "\thumb\" & rs("fnm") &".gif", True
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