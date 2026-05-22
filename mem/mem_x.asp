<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/inc/bsfCode.asp" -->
<%
	dbo()
	ip							= Request.servervariables("REMOTE_ADDR")
	uname						= SQLI(Request("uname"))
	unamee						= SQLI(Request("unamee"))
	memid						= SQLI(Request("memid"))
	pw01						= SQLI(Request("pw01"))
	pw02						= SQLI(Request("pw02"))
	tel1						= SQLI(Request("tel1"))
	tel2						= SQLI(Request("tel2"))
	tel3						= SQLI(Request("tel3"))
	hp1							= SQLI(Request("hp1"))
	hp2							= SQLI(Request("hp2"))
	hp3							= SQLI(Request("hp3"))
	email1						= SQLI(Request("email1"))
	email2						= SQLI(Request("email2"))
	email3						= SQLI(Request("email3"))
	zip							= SQLI(Request("zip"))
	addr						= SQLI(Request("addr"))
	memtype						= 90			'1-관리자/30-선장/70-매니아/90-일반

	If email2 = "직접입력" Then
		email0 = email1 &"@"& email3
	Else
		email0 = email1 &"@"& email2
	End If

	Set cx = New BsfCode

	rso()
	SQL = "	SELECT * FROM _omemt010 WHERE memid = '"& memid &"' "
	rs.open SQL, dbcon, 3
	If Not rs.eof Then
		Call JSalert("이미 존재하는 ID입니다.        \n다시 확인해 주세요.")
		Response.End
	Else
		SQL = "	INSERT INTO _omemt010	(" _
			& " memid" _
			& ",mempw" _
			& ",uname" _
			& ",unamee" _
			& ",tel" _
			& ",hp" _
			& ",zip" _
			& ",addr1" _
			& ",addr2" _
			& ",email" _
			& ",memtype" _
			& ",ddate" _
			& ",cnt" _
			& ",ip" _
			& ") VALUES (" _
			& " '"& memid &"'" _
			& ",'"& cx.SetEncode(pw01) &"'" _
			& ",'"& uname &"'" _
			& ",'"& unamee &"'" _
			& ",'"& tel1 & tel2 & tel3 &"'" _
			& ",'"& hp1 & hp2 & hp3 &"'" _
			& ",'"& zip &"'" _
			& ",'"& addr &"'" _
			& ",''" _
			& ",'"& cx.SetEncode(email0) &"'" _
			& ",'"& memtype &"'" _
			& ",getdate()" _
			& ",0" _
			& ",'"& ip &"'" _
			& ")"
		dbcon.Execute SQL

		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = " SELECT MAX(seq) FROM _omemt010 "
		rs3.open SQL, dbcon
			mxseq = CInt(rs3(0))
		Set rs3 = Nothing

		Call directGo("회원가입이 완료 되었습니다.","mem_finish.asp?seq="& mxseq &"&memid="& memid)
'		Call directGo("가입 완료 되었습니다. 사진 등록 화면으로 이동합니다.","mem_photo.asp?seq="& mxseq &"&memid="& memid)
'		Response.Redirect "mem_photo.asp?seq="& mxseq &"&memid="& memid
	End If
	rsc()

	Set cx = Nothing
	dbc()
%>