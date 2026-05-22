<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()

	Set upObj = Server.CreateObject("TABSUpload4.Upload")
	upObj.CodePage = 65001
	upObj.Start Server.MapPath(PATH_MOOL)						'저장경로
	upObj.MaxBytesToAbort = 3 * 1024 * 1024						'3메가 이하로 제한

	yy							= SQLI(upObj("yy"))
	mm							= SQLI(upObj("mm"))

	serverPath					= Server.MapPath(PATH_MOOL)

	Set upFile = upObj.Form("cFile")

	If upFile.FileSize <= upObj.MaxBytesToAbort Then
		ext = Mid(upFile.Value, InstrRev(upFile.Value,".") + 1)				'확장자
		If UCase(ext) <> "XLSX" AND UCase(ext) <> "XLS" Then
			Err.number = 1
			Call OnlyAlert("업로드가 불가능한 파일입니다!        ")
		Else
			Call upFile.SaveAs(serverPath &"\mool.xls", True)
		End If
	Else
		Err.number = 1
		Call OnlyAlert("5MB 이하의 파일만 업로드가 가능합니다.       ")
	End If

	'97-2000 형태의 엑셀로 변환해야 함
	excelConn = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source="& serverPath &"\mool.xls; Mode=ReadWrite|Share Deny None; Extended Properties='Excel 8.0; HDR=YES;';Persist Security Info=False"
	Set excelDB = Server.CreateObject("ADODB.Connection")
	excelDB.Open excelConn

	SQL = " SELECT * FROM [sheet1$] "
	Set rs = excelDB.Execute(SQL)

	k = 0			'반드시 위에 한줄이 존재해야 함
	Do Until rs.eof

'		If Len(Trim(rs(2))) = 13 Then
'			sno = Left(rs(2),6) & "-" & Right(rs(2),7)
'		Else
'			sno = rs(2)
'		End If
'		sno = "'" & rs(2)
'		sno = CStr(sno)
'		sno = rs(2)
		If Trim(rs(2)) <> "" Then
			op1					= Trim(rs(2))
			op1					= Replace(op1," ","")
		Else
			op1					= ""
		End If
		If Trim(rs(3)) <> "" Then
			op2					= Trim(rs(3))
			op2					= Replace(op2," ","")
		Else
			op2					= ""
		End If
		If Trim(rs(4)) <> "" Then
			op3					= Trim(rs(4))
			op3					= Replace(op3," ","")
		Else
			op3					= ""
		End If
		If Trim(rs(5)) <> "" Then
			op4					= Trim(rs(5))
			op4					= Replace(op4," ","")
		Else
			op4					= ""
		End If
		moon					= Trim(rs(6))
'		moon = Replace(moon,"월 ","")
'		moon = Replace(moon,"일","")

		SQL = " INSERT INTO _ocodt020 (gubn, yy, mm, dd, op1, op2, op3, op4, moon) VALUES (" _
			& "			'"& getMool(setp(Day(moon))) &"'" _
			& ",		'"& yy &"'" _
			& ",		'"& mm &"'" _
			& ",		'"& setp(Trim(rs(1))) &"'" _
			& ",		'"& op1 &"'" _
			& ",		'"& op2 &"'" _
			& ",		'"& op3 &"'" _
			& ",		'"& op4 &"'" _
			& ",		'"& moon &"'" _
			& ") "
'		Response.Write SQL &"<br>"
		dbcon.Execute SQL
		rs.MoveNext
		k = k + 1
	Loop

	If Err.number <> 0 Then
		Call AlertGo("실패","/_adm/mool.asp")
		Response.End
	Else
		Call AlertGo("성공","/_adm/mool.asp")
		Response.End
	End If

	Set rs = Nothing
	dbc()

	excelDB.close
	Set excelDB = Nothing
%>