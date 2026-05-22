<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	shipid						= SQLI(Request("shipid"))
	ridx						= SQLI(Request("ridx"))
	day01						= setp(SQLI(Request("day01")))			'변경 전 일자
	day02						= setp(SQLI(Request("day02")))			'변경 후 일자

	rso()
	SQL = " SELECT	ridx, rdate, uno, rnm, inwon, tel, hp, email, shipid, gubn, rmoney, pwd, uip, ddate, memo " _
		& " FROM	_orsvt010 " _
		& " WHERE	ridx = "& ridx
	rs.open SQL, dbcon
	If Not rs.eof Then
			rdate				= rs("rdate")
			rnm					= rs("rnm")
			inwon				= rs("inwon")
			tel					= rs("tel")
			hp					= rs("hp")
			email				= rs("email")
			shipid				= rs("shipid")
			gubn				= rs("gubn")				'D-독선/G-개인(합승)
			rmoney				= rs("rmoney")
			pwd					= rs("pwd")
			uip					= rs("uip")
			ddate				= rs("ddate")
			memo				= rs("memo")
	End If
	rsc()

	new_rdate					= Left(rdate,6) + day02

	If ridx <> "" Then
		SQL = " UPDATE	_orsvt010 SET " _
			& "			rdate = '"& new_rdate &"'" _
			& " WHERE	ridx = "& ridx
		dbcon.execute SQL
	End If
	dbc()

	noAlertGo("index.asp?shipid="& shipid)
%>