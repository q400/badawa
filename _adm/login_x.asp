<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/inc/bsfCode.asp" -->
<%
	dbo()
	uid							= Replace(Request("memid"),"'","''")
	pwd							= Request("passwd")
	preURL						= SQLI(Request("preURL"))
	uid_len						= Len(uid)
'	Response.Write "preURL : "& preURL &"<br>"

	If uid_len > 19 Then
		Call JSalert("아이디는 20자 이내로 입력하세요.")
		Response.End
	End If

	Set cx = New BsfCode

	rso()
	SQL = " SELECT * FROM _omemt010 WHERE memid = '"& uid &"' AND mempw = '"& cx.SetEncode(pwd) &"' AND memtype = 1 "
	rs.open SQL, dbcon

	If rs.eof Then
			Call JSAlert("관리자가 아닙니다.")
			Response.End
	Else
			Response.Cookies("FID")("NO")		= rs("seq")
			Response.Cookies("FID")("ID")		= uid
			Response.Cookies("FID")("NAME")		= rs("uname")
			Response.Cookies("FID")("NIC")		= "관리자"
			Response.Cookies("FID")("HP")		= rs("hp")
			Response.Cookies("FID")("AUTH")		= rs("memtype")

			If preURL = "" Or preURL = "index.asp" Then
				Response.Redirect "/_adm/mem/mem.asp"
			Else
				Response.Redirect preURL
			End If
	End If
	Set cx = Nothing
	rsc()
	dbc()
%>