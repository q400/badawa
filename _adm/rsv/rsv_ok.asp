<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/inc/bsfCode.asp" -->
<%
	dbo()
	ridx						= SQLI(Request("ridx"))
	shipid						= SQLI(Request("shipid"))
	uno							= SQLI(Request("uno"))
	opoint						= SQLI(Request("opoint"))			'결제 10% 포인트 계산
	ipoint						= SQLI(Request("ipoint"))			'동행 500 포인트 계산
	point						= SQLI(Request("point"))
	realchk						= SQLI(Request("realchk"))			'Y-회원/N-비회원

	SQL = "	UPDATE	_orsvt010 SET " _
		& "			status	= 'Y'" _
		& "	WHERE	ridx = "& ridx
	dbcon.Execute SQL

	If opoint = "" Then opoint = 0
	If ipoint = "" Then ipoint = 0

	If realchk = "Y" Then				'회원

			SQL = " INSERT INTO _opntt020 (uno, op, shipid, rsvid, point, note, ddate) VALUES (" _
				& "				"& uno _
				& ",			'+'" _
				& ",			"& shipid _
				& ",			"& ridx _
				& ",			"& opoint _
				& ",			'"& shipinfo(shipid,"shipnm") &" 출조 결제금액에 대한 10% 포인트'" _
				& ",			getdate()" _
				& ")"
			dbcon.Execute SQL
		If ipoint <> 0 Then
			SQL = " INSERT INTO _opntt020 (uno, op, shipid, rsvid, point, note, ddate) VALUES (" _
				& "				"& uno _
				& ",			'+'" _
				& ",			"& shipid _
				& ",			"& ridx _
				& ",			"& ipoint _
				& ",			'"& shipinfo(shipid,"shipnm") &" 출조 일행에 대한 가산 500 포인트'" _
				& ",			getdate()" _
				& ")"
			dbcon.Execute SQL
		End If

'	Else								'비회원

'		SQL = "	UPDATE	_orsvt010 SET " _
'			& "			status	= 'C'" _
'			& "	WHERE	ridx = "& ridx
'		dbcon.Execute SQL

	End If

	rdate = rsvInfo3(ridx,"rdate")
	yy = Left(rdate,4)
	mm = Mid(rdate,5,2)
	dd = Right(rdate,2)

	If realchk = "Y" Then
		Call directGo("완료되었습니다.","index.asp?shipid="& shipid &"&yy="& yy &"&mm="& mm &"&dd="& dd)
	Else
		Call directGo("취소되었습니다.","index.asp?shipid="& shipid &"&yy="& yy &"&mm="& mm &"&dd="& dd)
	End If
	dbc()
%>