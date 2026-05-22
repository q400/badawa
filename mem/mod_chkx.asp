<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/inc/bsfCode.asp" -->
<%
	Call checkLevel(FID_AUTH, 100, Request.ServerVariables("PATH_INFO"))

	dbo()
	passwd						= SQLI(Request("passwd"))

	Set cx = New BsfCode

	rso()
	SQL = " SELECT memid, mempw FROM _omemt010 WHERE seq = "& FID_NO
	rs.open SQL, dbcon
	If rs.eof Then
		Call JSAlert("해당되는 아이디가 존재하지 않습니다.")
		Response.End
	Else
		If cx.SetEncode(passwd) <> rs("mempw") Then
				Call JSAlert("비밀번호가 일치하지 않습니다.")
				Response.End
		Else
				Response.Redirect httpsRoot &"/mem/mod.asp"
		End If
	End If
	rsc()
	Set cx = Nothing
	dbc()
%>