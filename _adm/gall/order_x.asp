<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	idx							= SQLI(Request("idx"))
	flag						= SQLI(Request("flag"))

	If flag = "" And ridx <> "" Then flag = "M"
	If flag = "" Then flag = "W"
	If ridx = "" Then ridx = "0"
	If FID_NO = "" Then FID_NO = "0"

	If flag = "OK" Then

		rso()
		SQL = " SELECT status FROM _oalbt010 WHERE idx = "& idx
		rs.open SQL, dbcon
		If Not rs.eof Then
			stat = rs("status")
		End If
		rsc()

		If stat = "C" Then
			SQL = "	UPDATE	_oalbt010 SET " _
				& "			status				= 'ZC'" _
				& ",		okdate				= getdate()" _
				& " WHERE	idx = "& idx
			dbcon.Execute SQL
		ElseIf stat = "E" Then
			SQL = "	UPDATE	_oalbt010 SET " _
				& "			status				= 'ZE'" _
				& ",		okdate				= getdate()" _
				& " WHERE	idx = "& idx
			dbcon.Execute SQL
		End If

	ElseIf flag = "D" Then

'		SQL = "	DELETE FROM _oalbt010 WHERE idx = "& idx
		SQL = "	UPDATE _oalbt010 SET status = 'A' WHERE idx = "& idx
		dbcon.Execute SQL

	End If
	dbc()

	If flag = "OK" Then
		Call directGo("처리되었습니다.", "order.asp")
		Response.End
	ElseIf flag = "D" Then
		Call directGo("취소되었습니다.", "order.asp")
		Response.End
	End If
%>