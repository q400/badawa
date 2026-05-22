<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	Set upObj = Server.CreateObject("DEXT.FileUpload")
	upObj.CodePage = 65001
	upObj.AutoMakeFolder = True
	upObj.DefaultPath = Server.MapPath(PATH_GALL)				'저장경로
	upObj.MaxFileLen = 1 * 1024 * 1024							'하나의 최대파일 크기를 2MB이하로 제한
	upObj.TotalLen = 1 * 1024 * 1024							'전체 데이타의 크기를 50MB 이하로 제한

	seq							= SQLI(upObj("seq"))
	shipid						= SQLI(upObj("shipid"))
	yy							= SQLI(upObj("yy"))
	mm							= SQLI(upObj("mm"))
	dd							= SQLI(upObj("dd"))
	page						= SQLI(upObj("page"))
	cd1							= SQLI(upObj("cd1"))
	cd2							= SQLI(upObj("cd2"))
	flag						= SQLI(upObj("flag"))
	idx							= SQLI(upObj("idx"))

	If flag = "" Then flag = "W"

	serverPath					= Server.MapPath(PATH_GALL)

	Set upFile = upObj.Form("upFile")

	If upFile.Value <> "" Then
		If upFile.FileLen <= upObj.MaxFileLen Then
			ext = upFile.FileExtension				'확장자
			If UCase(ext) <> "XLS" And UCase(ext) <> "XLSX" Then
				Err.number = 1
				Call OnlyAlert("엑셀파일만 등록 가능합니다!")
				Responde.End
			Else
				newname = "iimgur_"& shipid &"_"& yy & setp(mm) & setp(dd) &".xls"		'"imgur_"& shipid &".xls"
				Call upFile.SaveAs(serverPath &"\"& newname, True)	'true : 같은 파일이름 덮어 씌우기
			End If
		Else
			Err.number = 1
			Call OnlyAlert("1MB 이하의 엑셀파일만 업로드가 가능합니다.")
			Responde.End
		End If
	End If

	If flag <> "DX" Then
			'객체 생성
			Set excelDB = Server.CreateObject("ADODB.Connection")
'			Set xlsConn = Server.CreateObject("ADODB.Connection")

			'엑셀 2003 ~ 2007 연결 설정
			excelConn = "Provider=Microsoft.ACE.OLEDB.12.0; Data Source="& serverPath &"\"& newname &"; Extended Properties='Excel 12.0;HDR=NO;IMEX=1'"

			'97-2000 형태의 엑셀로 변환해야 함
'			excelConn = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source="& serverPath &"\"& newname &"."& ext &"; Mode=ReadWrite|Share Deny None; Extended Properties='Excel 8.0; HDR=YES;';Persist Security Info=False"
'			excelConn = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source="& serverPath &"\"& newname &"."& ext &";"
'			excelConn = "Provider=Microsoft.Jet.OLEDB.4.0;Excel 8.0;HDR=YES;IMEX=1;Database="& serverPath &"\"& newname &"."& ext &";"
'			excelConn = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source="& serverPath &"\"& newname &"."& ext &"; Extended Properties='Excel 8.0';"
'			excelConn = "Driver={Microsoft Excel Driver (*.xls)};DriverId=790;Dbq="& serverPath &"\"& newname &"."& ext &";DefaultDir="& serverPath &""
'			excelConn = "Driver={excel};DriverId=790;Dbq="& serverPath &"\"& newname &"."& ext &";DefaultDir="& serverPath &""
'			excelConn = "DSN=excel;DriverId=790;Dbq="& serverPath &"\"& newname &"."& ext &";DefaultDir="& serverPath &""
'			excelConn = "Driver={MySQL ODBC 3.51 Driver}; Server=localhost; Database="& dbname &"; Uid="& dbid &"; Pwd="& dbpwd

			dbo()
			If seq <> "" Then
				rso()
				SQL = " SELECT ISNULL(COUNT(*),0) FROM _ogalt010 " _
					& " WHERE seq = "& seq
				rs.open SQL, dbcon
				If Not rs.eof Then
					cnt = rs(0)
				End If
				rsc()
			End If

			excelDB.open excelConn

			SQL = " SELECT * FROM [Sheet1$] "
			Set rs7 = excelDB.Execute(SQL)

			If cnt = 0 Then
				Do Until rs7.eof
					If Trim(rs7(0)) <> "" Then
							SQL = " INSERT INTO _ogalt010 (seq, shipid, yymmdd, imgur, ext, best, ddate) " _
								& " VALUES (" _
								& " "& seq _
								& ",'"& shipid &"'" _
								& ",'"& yy & setp(mm) & setp(dd) &"'" _
								& ",'"& Trim(rs7(0)) &"'" _
								& ",'jpg'" _
								& ",'"& Trim(UCase(rs7(1))) &"'" _
								& ",getdate()" _
								& ")"
'							Response.Write SQL &"<br>"
							dbcon.Execute SQL
							rs7.MoveNext
					End If
				Loop
			Else
				SQL = " DELETE FROM _ogalt010 " _
					& " WHERE seq = "& seq _
					& " AND shipid = "& shipid
				dbcon.Execute SQL

				Do Until rs7.eof
					If Trim(rs7(0)) <> "" Then
							SQL = " INSERT INTO _ogalt010 (seq, shipid, yymmdd, imgur, ext, best, ddate) " _
								& " VALUES (" _
								& " "& seq _
								& ",'"& shipid &"'" _
								& ",'"& yy & setp(mm) & setp(dd) &"'" _
								& ",'"& Trim(rs7(0)) &"'" _
								& ",'jpg'" _
								& ",'"& Trim(UCase(rs7(1))) &"'" _
								& ",getdate()" _
								& ")"
'							Response.Write SQL &"<br>"
							dbcon.Execute SQL
							rs7.MoveNext
					End If
				Loop
			End If


	ElseIf flag = "DX" Then

		dbo()
		SQL = " DELETE FROM _ogalt010 WHERE seq = "& seq &" AND shipid = "& shipid
		dbcon.Execute SQL

	End If
	rsc()

	nlist = "gallery" : nwrite = "gallery_w" : nview = "gallery_v" : nMiddle = "gallery_mx"

	If flag = "W" Then
		Call directGo("정상적으로 등록되었습니다.", nMiddle &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&shipid="& shipid &"&yy="& yy &"&mm="& mm &"&dd="& dd &"&flag="& flag)
		Response.End

	ElseIf flag = "M" Or flag = "DelPhoto" Then
		Call noAlertGo(nMiddle &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&shipid="& shipid &"&yy="& yy &"&mm="& mm &"&dd="& dd &"&flag="& flag)
		Response.End

	ElseIf flag = "DX" Then
		Call directGo("DB가 삭제되었습니다.", "gallery_excel.asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&shipid="& shipid &"&yy="& yy &"&mm="& mm &"&dd="& dd &"&flag="& flag)

	End If

	Set rs7 = Nothing

	excelDB.close
	Set excelDB = Nothing
	dbc()
%>