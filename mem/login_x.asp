<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/inc/bsfCode.asp" -->
<%
	dbo()
	uid							= Replace(Request("userId"),"'","''")
	pwd							= Request("userPw")
	ip							= Request.servervariables("REMOTE_ADDR")
	preURL						= SQLI(Request("preURL"))
	uid_len						= Len(uid)
'	Response.Write "preURL : "& preURL &"<br>"

	If uid_len > 19 Then
		Call JSalert("아이디는 20자 이내로 입력하세요.")
		Response.End
	End If

	rso()
	SQL = " SELECT * FROM _omemt010 WHERE memid = '"& uid &"' "
	rs.open SQL, dbcon
	If rs.eof Then
		Call JSAlert("해당되는 아이디가 존재하지 않습니다.")
		Response.End
	Else
		Set cx = New BsfCode
		If cx.SetEncode(pwd) <> rs("mempw") Then
				Call JSAlert("비밀번호가 일치하지 않습니다.")
				Response.End
		Else
				no				= rs("seq")
				uname			= rs("uname")
				unamee			= rs("unamee")
				email			= cx.SetDecode(rs("email"))
				hp				= rs("hp")
				tel				= rs("tel")
				memtype			= rs("memtype")

				Response.Cookies("FID")("NO")			= no
				Response.Cookies("FID")("ID")			= uid
				Response.Cookies("MEM_ID")				= uid
				Response.Cookies("FID")("NAME")			= uname
				Response.Cookies("FID")("NIC")			= unamee
				Response.Cookies("FID")("EMAIL")		= email
				Response.Cookies("FID")("HP")			= hp
				Response.Cookies("FID")("AUTH")			= memtype
				Response.Cookies("MEM_ID").expires		= Date + 7			'7일간 보관

				SQL = " UPDATE _omemt010 SET ldate = getdate(), cnt = cnt + 1 WHERE memid = '"& uid &"' "
				dbcon.execute SQL

				If preURL = "" Then
					Response.Redirect "/index.asp?op=pc"
				Else
					Response.Redirect preURL
				End If
		End If
		Set cx = Nothing
	End If
	rsc()
	dbc()
%>