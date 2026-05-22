<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	note						= SQLI(Request("note"))
	j							= 0

	'N-대기중/C-예약완료/Y-출조완료/K-예약대기/X-예약취소
	rso()
	SQL = " SELECT DISTINCT hp FROM _omemt010 WHERE hp <> '' "
'	Response.Write SQL &"<br>"
	rs.open SQL, dbcon
	While Not rs.eof
		If sms Then
			dbo7()
			SQL = "	INSERT INTO fidplus.fid.em_tran (tran_id, tran_phone, tran_callback, tran_status, tran_date, tran_msg) " _
				& "	VALUES ('badawa-all', '"& Replace(rs("hp"),"-","") &"', '"& OffTel01 &"', '1', getdate(), '"& note &"') "
'			Response.Write SQL &"<br>"
			dbco.Execute SQL
			dbc7()
		End If
		j = j + 1
		rs.MoveNext
	Wend
	rsc()
'	Response.Write "value : "& j &"<br>"

	divAlertReload(CStr(j) +" 건 발송되었습니다.")
	dbc()
%>