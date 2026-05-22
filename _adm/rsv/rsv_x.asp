<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/inc/bsfCode.asp" -->
<%
	dbo()
	ridx						= SQLI(Request("ridx"))
	shipid						= SQLI(Request("shipid"))
	rdate						= Replace(SQLI(Request("rdate")),"-","")
	rnm							= SQLI(Request("rnm"))
	inwon						= SQLI(Request("inwon"))
	gubn						= SQLI(Request("gubn"))				'D-독배/G-개인(합승)
	tel							= SQLI(Replace(Request("tel"),"-",""))
'	tel1						= SQLI(Request("tel1"))
'	tel2						= SQLI(Request("tel2"))
'	tel3						= SQLI(Request("tel3"))
	hp							= SQLI(Replace(Request("hp"),"-",""))
'	hp1							= SQLI(Request("hp1"))
'	hp2							= SQLI(Request("hp2"))
'	hp3							= SQLI(Request("hp3"))
	email1						= SQLI(Request("email1"))
	email2						= SQLI(Request("email2"))
	email3						= SQLI(Request("email3"))
	rmoney						= SQLI(Request("rmoney"))			'예약금액
	omoney						= SQLI(Request("omoney"))			'실결제금액
	pwd0						= SQLI(Request("pwd"))
	memo						= SQLI(Request("memo"))
	flag						= SQLI(Request("flag"))

	If email2 = "직접입력" Then
		email0 = email1 &"@"& email3
	Else
		If email1 = "" Then
			email0 = ""
		Else
			email0 = email1 &"@"& email2
		End If
	End If

	If flag = "" Then flag = "M"
	If rmoney = "" Then rmoney = 0

	If flag = "W" Then

		SQL = "	INSERT INTO _orsvt010 (rdate, uno, rnm, inwon, tel, hp, email, shipid, gubn, status, rmoney, omoney, pwd, uip, ddate, memo) VALUES (" _
			& "			'"& rdate &"'" _
			& ",		'"& FID_NO &"'" _
			& ",		'"& rnm &"'" _
			& ",		'"& inwon &"'" _
			& ",		'"& tel &"'" _
			& ",		'"& hp &"'" _
			& ",		'"& email0 &"'" _
			& ",		"& shipid _
			& ",		'"& gubn &"'" _
			& ",		'C'" _
			& ",		"& rmoney _
			& ",		"& omoney _
			& ",		'"& pwd0 &"'" _
			& ",		'"& Request.ServerVariables("REMOTE_ADDR") &"'" _
			& ",		getdate()" _
			& ",		'"& memo &"'" _
			& ")"
		dbcon.Execute SQL

		rso()
		SQL = " SELECT MAX(ridx) FROM _orsvt010 "
		rs.open SQL, dbcon
			mxidx = CLng(rs(0))
		rsc()

		rso()
		SQL = " SELECT COUNT(*) FROM _orsvt020 WHERE ssid = '"& ssid &"' AND shipid = "& shipid &" AND rdate = '"& yy & mm & dd &"' "
		rs.open SQL, dbcon
			scnt = CLng(rs(0))
		rsc()
		If scnt <> 0 Then
			SQL = "	UPDATE	_orsvt020 SET " _
				& "			ridx = "& mxidx _
				& "	WHERE	ssid = '"& ssid &"' AND shipid = "& shipid &" AND rdate = '"& yy & mm & dd &"' "
			dbcon.Execute SQL
		End If

		msg1 = "[안흥낚시]정상적으로 예약되었습니다. 입금계좌안내:우체국/김종훈 312090-02-004546"

		If sms Then
			If hp <> "" Then
'				dbo7()		'OK일때 sms 발송
'				SQL = "	INSERT INTO fidplus.fid.em_tran (tran_id, tran_phone, tran_callback, tran_status, tran_date, tran_msg) " _
'					& "	VALUES ('badawa-rsv', '"& Replace(hp,"-","") &"', '"& OffTel01 &"', '1', getdate(), '"& msg1 &"') "
'				dbco.Execute SQL
'				dbc7()
			End If
		End If

	ElseIf flag = "M" Then

		SQL = "	UPDATE	_orsvt010 SET " _
			& "			rdate		= '"& rdate &"'" _
			& ",		rnm			= '"& rnm &"'" _
			& ",		inwon		= '"& inwon &"'" _
			& ",		gubn		= '"& gubn &"'" _
			& ",		tel			= '"& tel &"'" _
			& ",		hp			= '"& hp &"'" _
			& ",		email		= '"& email0 &"'" _
			& ",		shipid		= "& shipid _
			& ",		rmoney		= "& rmoney _
			& ",		omoney		= "& omoney _
			& ",		memo		= '"& memo &"'" _
			& "	WHERE	ridx = "& ridx
		dbcon.Execute SQL

	ElseIf flag = "OK" Then

		msg1 = "[안흥낚시] "& Left(rdate,4) &" 년 "& Mid(rdate,5,2) &" 월 "& Right(rdate,2) &" 일 ["& shipinfo(shipid,"shipnm") &"]로 예약이 확정되었습니다. 즐거운 하루 되세요!"
		'msg1 = "[안흥낚시] "& Left(rdate,1,4) &" 년 "& Mid(rdate,5,2) &" 월 "& Right(rdate,2) &" 일로 예약되었으며, 계약금 "& FormatNumber(rmoney,0) &"원 입금확인 되었습니다."

		If sms Then
			If hp <> "" Then
				If Len(hp) > 8 Then
					dbo7()
					SQL = "	INSERT INTO fidplus.fid.em_tran (tran_id, tran_phone, tran_callback, tran_status, tran_date, tran_msg) " _
						& "	VALUES ('badawa-admRsvOK', '"& Replace(hp,"-","") &"', '"& OffTel01 &"', '1', getdate(), '"& msg1 &"') "
					dbco.Execute SQL
'					SQL = "	INSERT INTO fidplus.fid.em_tran (tran_id, tran_phone, tran_callback, tran_status, tran_date, tran_msg) " _
'						& "	VALUES ('badawa-rsvok2', '"& Replace(hp1 & hp2 & hp3,"-","") &"', '"& OffTel01 &"', '1', getdate(), '입금계좌안내:"& account &" 결제금액:"& FormatNumber(rmoney,0) &"원') "
'					dbco.Execute SQL
					dbc7()
				End If
			End If
		End If
		SQL = "	UPDATE	_orsvt010 SET " _
			& "			status		= 'C'" _
			& ",		gubn		= '"& gubn &"'" _
			& ",		tel			= '"& tel &"'" _
			& ",		hp			= '"& hp &"'" _
			& ",		email		= '"& email0 &"'" _
			& ",		rmoney		= "& rmoney _
			& ",		omoney		= "& omoney _
			& ",		memo		= '"& memo &"'" _
			& " WHERE ridx = "& ridx
		dbcon.Execute SQL

	ElseIf flag = "X" Then					'예약취소 - N-신청중/C-예약완료/Y-출조완료/K-예약대기/X-예약취소

		SQL = "	UPDATE _orsvt010 SET status = 'X', gubn = 'G' WHERE ridx = "& ridx
		dbcon.Execute SQL
		SQL = "	DELETE FROM _orsvt020 WHERE ridx = "& ridx
		dbcon.Execute SQL

	ElseIf flag = "A" Then					'예약복구 - N-신청중/C-예약완료/Y-출조완료/K-예약대기/X-예약취소

		SQL = "	UPDATE _orsvt010 SET status = 'C', gubn = '"& gubn &"' WHERE ridx = "& ridx
		dbcon.Execute SQL

	ElseIf flag = "D" Then

		SQL = "	DELETE FROM _orsvt010 WHERE ridx = "& ridx
		dbcon.Execute SQL
		SQL = "	DELETE FROM _orsvt020 WHERE ridx = "& ridx
		dbcon.Execute SQL
		SQL = "	DELETE FROM _opntt020 WHERE rsvid = "& ridx
		dbcon.Execute SQL

	End If
	rsc()
	dbc()

	If flag = "W" Then
		divAlertReload("예약되었습니다.")
'		noAlertGo("bookdiv.asp?ridx="& mxidx)
		Response.End
	ElseIf flag = "M" Then
		divAlertReload("수정되었습니다.")
		Response.End
	ElseIf flag = "D" Then
		divAlertReload("삭제되었습니다.")
		Response.End
	ElseIf flag = "A" Then
		divAlertReload("예약이 복구되었습니다.\n\n독배의 경우 꼭 확인해 주세요.       ")
		Response.End
	Else
		divAlertReload("처리되었습니다.")
		Response.End
	End If
%>