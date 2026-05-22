<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	Set upObj = Server.CreateObject("DEXT.FileUpload")
	upObj.AutoMakeFolder = True
	upObj.CodePage = 65001
	upObj.DefaultPath = Server.MapPath(PATH_MOOL)				'저장경로
	upObj.MaxFileLen = 1 * 1024 * 1024							'하나의 최대파일 크기를 2MB이하로 제한
	upObj.TotalLen = 1 * 1024 * 1024							'전체 데이타의 크기를 50MB 이하로 제한
	Set objImage = Server.CreateObject("DEXT.ImageProc")

	yy							= SQLI(upObj("yy"))
	mm							= SQLI(upObj("mm"))

	serverPath					= Server.MapPath(PATH_MOOL)
	'Response.Write "serverPath : "& serverPath &"<br>"

	Set upFile = upObj.Form("cFile")

	If upFile.Value <> "" Then
		If upFile.FileLen <= upObj.MaxFileLen Then
			ext = upFile.FileExtension				'확장자
			If UCase(ext) <> "XLS" And UCase(ext) <> "XLSX" Then
				Err.number = 1
				Call OnlyAlert("엑셀파일만 등록 가능합니다!")
				Responde.End
			Else
				newname = "mooltime_"& yy & setp(mm)	'새이름지정
				ext = upFile.FileExtension				'확장자
				Call upFile.SaveAs(serverPath &"\"& newname &"."& ext, true)	'true : 같은 파일이름 덮어 씌우기
			End If
		Else
			Err.number = 1
			Call OnlyAlert("1MB 이하의 파일만 업로드가 가능합니다.")
			Responde.End
		End If
	End If

	'객체 생성
	Set excelDB = Server.CreateObject("ADODB.Connection")
'	Set xlsConn = Server.CreateObject("ADODB.Connection")
'	xlsConn.Open "Provider=Microsoft.ACE.OLEDB.12.0; Data Source="& serverPath &"\mooltime.xlsx; Extended Properties='Excel 12.0;HDR=YES;IMEX=1'"

	'엑셀 2003 ~ 2007 연결 설정
'	excelConn = "Provider=Microsoft.ACE.OLEDB.12.0; Data Source="& serverPath &"\mooltime.xls; Extended Properties='Excel 12.0;HDR=YES;IMEX=1'"

	'97-2000 형태의 엑셀로 변환해야 함
'	excelConn = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source="& serverPath &"\mooltime.xls; Mode=ReadWrite|Share Deny None; Extended Properties='Excel 8.0; HDR=YES;';Persist Security Info=False"
'	excelConn = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source="& serverPath &"\mooltime.xls;"
'	excelConn = "Provider=Microsoft.Jet.OLEDB.4.0;Excel 8.0;HDR=YES;IMEX=1;Database="& serverPath &"\mooltime.xls;"
	excelConn = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source="& serverPath &"\"& newname &"."& ext &"; Extended Properties='Excel 8.0';"
'	excelConn = "Driver={Microsoft Excel Driver (*.xls)};DriverId=790;Dbq="& serverPath &"\mooltime.xls;DefaultDir="& serverPath &""
''	excelConn = "Driver={excel};DriverId=790;Dbq="& serverPath &"\mooltime.xls;DefaultDir="& serverPath &""
'	excelConn = "DSN=excel;DriverId=790;Dbq="& serverPath &"\mooltime.xls;DefaultDir="& serverPath &""
'	excelConn = "Driver={MySQL ODBC 3.51 Driver}; Server=localhost; Database="& dbname &"; Uid="& dbid &"; Pwd="& dbpwd

	excelDB.Open excelConn

	SQL = " SELECT * FROM [Sheet1$] "
	Set excelRs = excelDB.Execute(SQL)

	Set dbcon6 = Server.CreateObject("ADODB.Connection")
	str = "Provider=SQLOLEDB.1;User ID=badawa;PWD=qkekskRtl9;Initial Catalog=badawa;Data Source=114.108.175.224"
	dbcon6.open str

	k = 0			'반드시 위에 한줄이 존재해야 함
	Do Until excelRs.eof
		If Trim(excelRs(1)) <> "" Then
			op1					= Trim(excelRs(1))
			op1					= Replace(op1," ","")
		Else
			op1					= ""
		End If
		If Trim(excelRs(2)) <> "" Then
			op2					= Trim(excelRs(2))
			op2					= Replace(op2," ","")
		Else
			op2					= ""
		End If
		If Trim(excelRs(3)) <> "" Then
			op3					= Trim(excelRs(3))
			op3					= Replace(op3," ","")
		Else
			op3					= ""
		End If
		If Trim(excelRs(4)) <> "" Then
			op4					= Trim(excelRs(4))
			op4					= Replace(op4," ","")
		Else
			op4					= ""
		End If

		SQL = " INSERT INTO mooltime (yy, mm, dd, op1, op2, op3, op4, moon, mtime1, mtime7, mtime8)" _
			& " VALUES (" _
			& "			'"& yy &"'" _
			& ",		'"& setp(Trim(mm)) &"'" _
			& ",		'"& setp(Trim(excelRs(0))) &"'" _
			& ",		'"& op1 &"'" _
			& ",		'"& op2 &"'" _
			& ",		'"& op3 &"'" _
			& ",		'"& op4 &"'" _
			& ",		'"& Trim(excelRs(5)) &"'" _
			& ",		'"& Trim(excelRs(6)) &"'" _
			& ",		'"& Trim(excelRs(7)) &"'" _
			& ",		'"& Trim(excelRs(8)) &"'" _
			& ") "
		'Response.Write SQL &"<br>"
		dbcon6.Execute SQL
		excelRs.MoveNext
		k = k + 1
	Loop

	If Err.number <> 0 Then
		Call AlertGo("실패","/_adm/mool/mool.asp")
		Response.End
	Else
		Call AlertGo("성공","/_adm/mool/mool.asp")
		Response.End
	End If

	Set excelRs = Nothing

	dbcon6.close
	Set dbcon6 = Nothing

	excelDB.close
	Set excelDB = Nothing
%>