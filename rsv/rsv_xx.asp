<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/inc/bsfCode.asp" -->
<%
	dbo()
	ssid						= session.sessionid
	ridx						= SQLI(Request("ridx"))
	shipid						= SQLI(Request("shipid"))
	yy							= SQLI(Request("yy"))
	mm							= SQLI(Request("mm"))
	dd							= SQLI(Request("dd"))
	op							= SQLI(Request("op"))				'대기예약 구분
	rdate						= Replace(SQLI(Request("rdate")),"-","")
	rnm							= SQLI(Request("rnm"))
	inwon						= SQLI(Request("inwon"))
	gubn						= SQLI(Request("gubn"))				'D-독선/G-개인(합승)
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
	rmoney						= SQLI(Request("rmoney"))
	pwd0						= SQLI(Request("pwd"))
	memo						= SQLI(Request("memo"))
	flag						= SQLI(Request("flag"))

	If email2 = "직접입력" Then
		email0 = email1 &"@"& email3
	Else
		email0 = email1 &"@"& email2
	End If

	If op = "" Then
		status = "N"
	Else
		status = "K"
	End If

	If flag = "" Then flag = "W"
	If FID_NO = "" Then FID_NO = 0
	If rmoney = "" Then rmoney = 0

	If flag = "W" Then
		SQL = "	INSERT INTO _orsvt010 (rdate, uno, rnm, inwon, tel, hp, email, shipid, gubn, status, rmoney, pwd, uip, ddate, memo) VALUES (" _
			& " '"& rdate &"'" _
			& ","& FID_NO _
			& ",'"& rnm &"'" _
			& ",'"& inwon &"'" _
			& ",'"& tel &"'" _
			& ",'"& hp &"'" _
			& ",'"& email0 &"'" _
			& ","& shipid _
			& ",'"& gubn &"'" _
			& ",'"& status &"'" _
			& ","& rmoney _
			& ",'"& pwd0 &"'" _
			& ",'"& Request.ServerVariables("REMOTE_ADDR") &"'" _
			& ",getdate()" _
			& ",'"& memo &"'" _
			& ")"
'		Response.Write SQL &"<br>"
		dbcon.Execute SQL

		rso()
		SQL = " SELECT MAX(ridx) FROM _orsvt010 "
		rs.open SQL, dbcon
			mxidx = CLng(rs(0))
		rsc()

		If FID_NO <> 0 Then
			rso()
			SQL = " SELECT COUNT(*) FROM _orsvt020 WHERE uno = "& FID_NO &" AND shipid = "& shipid &" AND rdate = '"& yy & mm & dd &"' "
			rs.open SQL, dbcon
				pcnt = CLng(rs(0))
			rsc()
			If pcnt <> 0 Then
				SQL = "	UPDATE	_orsvt020 SET " _
					& "			ridx = "& mxidx _
					& "	WHERE	uno = "& FID_NO &" AND shipid = "& shipid &" AND rdate = '"& yy & mm & dd &"' "
				dbcon.Execute SQL
			End If
		Else
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
		End If

		If op = "" Then
			msg1 = "[안흥낚시]정상적으로 예약되었습니다. 입금계좌안내:우체국/김종훈 312090-02-004546"
		Else
			msg1 = "[안흥낚시]정상적으로 대기 예약되었습니다. 입금계좌안내:우체국/김종훈 312090-02-004546"
		End If

		If sms Then
			If hp <> "" Then
'				dbo7()
'				SQL = "	INSERT INTO fidplus.fid.em_tran (tran_id, tran_phone, tran_callback, tran_status, tran_date, tran_msg) " _
'					& "	VALUES ('badawa-rsv', '"& Replace(hp,"-","") &"', '"& OffTel01 &"', '1', getdate(), '"& msg1 &"') "
'				dbco.Execute SQL
'				dbc7()
			End If
		End If

	ElseIf flag = "M" Then
		rso()
		SQL = " SELECT status FROM _orsvt010 WHERE ridx = "& ridx
		rs.open SQL, dbcon
			sts = rs(0)
		rsc()
		If sts = "N" Or sts = "K" Then
			SQL = "	UPDATE	_orsvt010 SET " _
				& "			rdate = '"& rdate &"'" _
				& ",		rnm = '"& rnm &"'" _
				& ",		inwon = '"& inwon &"'" _
				& ",		tel = '"& Replace(tel,"-","") &"'" _
				& ",		hp = '"& Replace(hp,"-","") &"'" _
				& ",		email = '"& email0 &"'" _
				& ",		shipid = '"& shipid &"'" _
				& ",		rmoney = "& rmoney _
				& ",		memo = '"& memo &"'" _
				& ",		pwd = '"& pwd0 &"'" _
				& "	WHERE	ridx = "& ridx
			dbcon.Execute SQL
		Else
			Call directGo("예약이 확정 또는 취소되었으므로 수정/삭제가 불가능합니다.\n\n안흥낚시로 문의 바랍니다. 041-675-1133", "index.asp?ridx="& ridx &"&yy="& yy &"&mm="& mm &"&dd="& dd)
			Response.End
		End If

	ElseIf flag = "D" Then
		SQL = "	DELETE FROM _orsvt010 WHERE ridx = "& ridx
		dbcon.Execute SQL
		SQL = "	DELETE FROM _orsvt020 WHERE ridx = "& ridx
		dbcon.Execute SQL
	End If
	dbc()

	If flag = "W" Then
		Call directGo("예약되었습니다.", "index.asp?ridx="& ridx &"&yy="& yy &"&mm="& mm &"&dd="& dd)
		Response.End
	ElseIf flag = "M" Then
		Call directGo("수정되었습니다.", "index.asp?ridx="& ridx &"&yy="& yy &"&mm="& mm &"&dd="& dd &"&flag="& flag)
		Response.End
	ElseIf flag = "D" Then
'		Call directGo("예약이 취소되었습니다.", "index.asp?ridx="& ridx &"&yy="& yy &"&mm="& mm &"&dd="& dd)
		Call directGo("예약이 취소되었습니다.", "check.asp")
		Response.End
	End If
%>