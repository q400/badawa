<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/imagevbs.inc" -->
<%
	dbo()
	'2017년 04월 01일부로 이미지호스팅 실시 (내가게.com)
	'이미지/동영상 업로드는 FTP 이용, 파일경로와 이름만 DB에 저장

	filecnt						= SQLI(Request("filecnt"))
	imgFilePath					= SQLI(Request("imgFilePath"))
	imgFileNm					= SQLI(Request("imgFileNm"))
	imgText						= SQLI(Request("imgText"))

	iidx						= SQLI(Request("iidx"))
	idx							= SQLI(Request("idx"))
	imgFilePathUpdate			= SQLI(Request("imgFilePathUpdate"))
	imgFileNmUpdate				= SQLI(Request("imgFileNmUpdate"))
	imgTextUpdate				= SQLI(Request("imgTextUpdate"))

	page						= SQLI(Request("page"))
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	flag						= SQLI(Request("flag"))

	arrFileCnt					= Split(filecnt,",",-1)
	arrImgFilePath				= Split(imgFilePath,",",-1)
	arrImgFileNm				= Split(imgFileNm,",",-1)
	arrImgText					= Split(imgText,",",-1)

	arrIdx						= Split(idx,",",-1)
	arrImgFilePathUpdate		= Split(imgFilePathUpdate,",",-1)
	arrImgFileNmUpdate			= Split(imgFileNmUpdate,",",-1)
	arrImgTextUpdate			= Split(imgTextUpdate,",",-1)

	vodFilePath					= SQLI(Request("vodFilePath"))		'동영상 저장 공통경로
	vodFileNm					= SQLI(Request("vodFileNm"))

	If flag = "" Then flag = "W"

	nlist						= "intro"

	If flag = "W" Then							'쓰기
		If filecnt <> 0 Then
			For i = LBound(arrFileCnt) To UBound(arrFileCnt) + 1
								SQL = "	INSERT INTO _ocmmt010 (gubn, fpath, fnm, fsz, fwd, ext, ddate, comment) VALUES (" _
									& "			'photo'" _
									& ",		'"& Trim(arrImgFilePath(i)) &"'" _
									& ",		'"& Trim(arrImgFileNm(i)) &"'" _
									& ",		0" _
									& ",		0" _
									& ",		''" _
									& ",		getdate()" _
									& ",		'"& Trim(arrImgText(i)) &"'" _
									& ")"
								'Response.Write SQL &"<br>"
								dbcon.Execute SQL
			Next
		End If

			For k = LBound(arrIdx) To UBound(arrIdx)
								SQL = "	UPDATE _ocmmt010 SET " _
									& "			fpath = '"& Trim(arrImgFilePathUpdate(k)) &"'" _
									& ",		fnm = '"& Trim(arrImgFileNmUpdate(k)) &"'" _
									& ",		ddate = getdate()" _
									& ",		comment = '"& Trim(arrImgTextUpdate(k)) &"'" _
									& " WHERE idx ="& Trim(arrIdx(k))
								'Response.Write SQL &"<br>"
								dbcon.Execute SQL
			Next

			If vodFileNm <> "" Then
								SQL = "	INSERT INTO _ocmmt010 (gubn, fpath, fnm, fsz, fwd, ext, ddate, comment) VALUES (" _
									& "			'movie'" _
									& ",		'"& Trim(vodFilePath) &"'" _
									& ",		'"& Trim(vodFileNm) &"'" _
									& ",		0" _
									& ",		0" _
									& ",		''" _
									& ",		getdate()" _
									& ",		''" _
									& ")"
								'dbcon.Execute SQL
			End If

	ElseIf flag = "M" Then						'수정

	ElseIf flag = "D" Then						'삭제

				SQL = "	DELETE FROM _ocmmt010 WHERE idx = "& iidx
				dbcon.Execute SQL

	End If

	Call directGo("처리되었습니다.", nlist &".asp")
	Response.End

	Set Request = Nothing
	Set Image = Nothing
	dbc()
%>