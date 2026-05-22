<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	shipid						= SQLI(Request("shipid"))
	seq							= SQLI(Request("seq"))
	yy							= SQLI(Request("yy"))
	mm							= SQLI(Request("mm"))
	dd							= SQLI(Request("dd"))
	color						= SQLI(Request("color"))
	note						= SQLI(Request("note"))
	sms							= SQLI(Request("sms"))
	status						= SQLI(Request("status"))
	flag						= Request("flag")

	If seq <> "" Then
		If flag = "" Then flag = "M"
	Else
		If flag = "" Then flag = "W"
	End If

	If flag = "W" Then

		SQL = "	INSERT INTO _onott010 (shipid, rdate, color, ddate, note) VALUES (" _
				& "		"& shipid _
				& ",	'"& yy & mm & dd &"'" _
				& ",	'"& color &"'" _
				& ",	getdate()" _
				& ",	'"& note &"'" _
				& ")"
		dbcon.Execute SQL

		If sms = "1" Then				'N-대기중/C-예약완료/Y-출조완료/K-예약대기/X-예약취소
			rso()
			If status = "Z" Then		'전체(출조완료 + 취소자 제외)
				SQL = " SELECT DISTINCT hp FROM _orsvt010 WHERE rdate = '"& yy & mm & dd &"' AND status IN ('N','C','K') AND shipid = "& shipid
			Else
				SQL = " SELECT DISTINCT hp FROM _orsvt010 WHERE rdate = '"& yy & mm & dd &"' AND status = '"& status &"' AND shipid = "& shipid
			End If
			rs.open SQL, dbcon
			While Not rs.eof
				dbo7()
'				SQL = "	INSERT INTO fidplus.fid.em_tran (tran_id, tran_phone, tran_callback, tran_status, tran_date, tran_msg) " _
'					& "	VALUES ('badawa-rsvnotice', '"& Replace(rs("hp"),"-","") &"', '"& OffTel01 &"', '1', getdate(), '"& note &"') "
'				Response.Write SQL &"<br>"
'				dbco.Execute SQL
				dbc7()
				rs.MoveNext
			Wend
			rsc()
		End If

	ElseIf flag = "M" Then

		SQL = "	UPDATE	_onott010 SET " _
			& "			color	= '"& color &"'" _
			& ",		note	= '"& note &"'" _
			& " WHERE	seq = "& seq
		dbcon.Execute SQL

	ElseIf flag = "D" Then

		SQL = " DELETE FROM _onott010 WHERE seq = "& seq
		dbcon.Execute SQL

	End If
	divReload()
	dbc()
%>