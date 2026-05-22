<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/imagevbs.inc" -->
<%
	dbo()
	Call checkLevel(FID_AUTH, 100, Request.ServerVariables("PATH_INFO"))

	chk							= SQLI(Request("chk"))
	page						= SQLI(Request("page"))
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	flag						= SQLI(Request("flag"))
'	Response.Write "flag : "& flag &"<br>"

	If flag = "" Then flag = "inhwa"
'	Response.Write "FID_NO : "& FID_NO &"<br>"

	nlist						= "album"

'	If flag = "inhwa" Then						'인화
'
'		arrChk = Split(Trim(chk), ",")
'		For k = LBound(arrChk) To UBound(arrChk)
'			SQL = "	UPDATE	_oalbt010 SET " _
'				& "			status				= 'C'" _
'				& ",		xdate				= getdate()" _
'				& " WHERE	idx = "& Trim(arrChk(k))
'			dbcon.Execute SQL
'		Next
'
'	ElseIf flag = "frame" Then					'액자
'
'		arrChk = Split(Trim(chk), ",")
'		For k = LBound(arrChk) To UBound(arrChk)
'			SQL = "	UPDATE	_oalbt010 SET " _
'				& "			status				= 'E'" _
'				& ",		xdate				= getdate()" _
'				& " WHERE	idx = "& Trim(arrChk(k))
'			dbcon.Execute SQL
'		Next
'
'	ElseIf flag = "OK" Then						'신청
	If flag <> "D" Then							'신청

		arrChk = Split(Trim(chk), ",")

		If flag = "inhwa" Then
			For k = LBound(arrChk) To UBound(arrChk)
				SQL = "	UPDATE	_oalbt010 SET " _
					& "			status				= 'C'" _
					& ",		sz					= "& Request("size"& Trim(arrChk(k))) _
					& ",		cnt					= "& Request("cnt"& Trim(arrChk(k))) _
					& ",		xdate				= getdate()" _
					& " WHERE	idx = "& Trim(arrChk(k))
				dbcon.Execute SQL
			Next
		Else
			For k = LBound(arrChk) To UBound(arrChk)
				SQL = "	UPDATE	_oalbt010 SET " _
					& "			status				= 'E'" _
					& ",		sz					= "& Request("size"& Trim(arrChk(k))) _
					& ",		cnt					= "& Request("cnt"& Trim(arrChk(k))) _
					& ",		xdate				= getdate()" _
					& " WHERE	idx = "& Trim(arrChk(k))
				dbcon.Execute SQL
			Next
		End If

	ElseIf flag = "D" Then						'삭제

		arrChk = Split(Trim(chk), ",")
		For k = LBound(arrChk) To UBound(arrChk)
			SQL = "	DELETE FROM _oalbt010 WHERE idx = "& Trim(arrChk(k))
			dbcon.Execute SQL
		Next

	End If

	If flag = "inhwa" Then
		Call AlertGo("[사진인화] 신청되었습니다.", "album.asp?cd1="& cd1 &"&cd2="& cd2 &"&page="& page)
		Response.End
	ElseIf flag = "frame" Then
		Call AlertGo("[액자] 신청되었습니다.", "album.asp?cd1="& cd1 &"&cd2="& cd2 &"&page="& page)
		Response.End
	ElseIf flag = "D" Then
		Call AlertGo("삭제되었습니다.", "album.asp?cd1="& cd1 &"&cd2="& cd2 &"&page="& page)
		Response.End
	End If
	dbc()
%>