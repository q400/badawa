<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	rdate						= Replace(Request("rdate"),"-","")
	note						= SQLI(Request("note"))

	'N-대기중/C-예약완료/Y-출조완료/K-예약대기/X-예약취소
	If rdate <> "" Then
		rso()
		SQL = " SELECT DISTINCT hp FROM _orsvt010 WHERE rdate = '"& rdate &"' AND status IN ('N','C','Y','K') "
'		Response.Write SQL &"<br>"
		rs.open SQL, dbcon
		While Not rs.eof
			If sms Then
				dbo7()
				SQL = "	INSERT INTO fidplus.fid.em_tran (tran_id, tran_phone, tran_callback, tran_status, tran_date, tran_msg) " _
					& "	VALUES ('badawa-rsvnotice-all', '"& Replace(rs("hp"),"-","") &"', '"& OffTel01 &"', '1', getdate(), '"& note &"') "
'				Response.Write SQL &"<br>"
				dbco.Execute SQL
				dbc7()
			End If
			rs.MoveNext
		Wend
		rsc()
	Else
			dbo7()
'			SQL = "	INSERT INTO fidplus.fid.em_tran (tran_id, tran_phone, tran_callback, tran_status, tran_date, tran_msg) " _
'				& "	VALUES ('badawa-rsvnotice-all', '01055549462', '"& OffTel01 &"', '1', getdate(), '"& note &"') "
'			dbco.Execute SQL
			dbc7()
	End If

	divReload()
	dbc()
%>