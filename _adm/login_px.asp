<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/inc/bsfCode.asp" -->
<%
'************************************************************************************
'*  윈도우 명		: login_px.asp
'************************************************************************************

	Call dbo()
	uid						= Replace(Request("uid"),"'","''")
	pwd						= Request("pwd")
	preURL					= SQLI(Request("preURL"))
	uid_len					= Len(uid)

	If uid_len > 19 Then
		Call JSalert("아이디는 20자 이내로 입력하세요.")
		Response.End
	End If

	If uid <> "admin" Then
		Call JSAlert("관리자가 아닙니다.")
		Response.End
	Else
		If pwd <> "@qkekdhk*" Then
			Call JSAlert("비밀번호가 일치하지 않습니다.")
			Response.End
		Else
			uname = "관리자"
			hp = "01055549462"

			Response.Cookies ("FID")("ID")			= uid
			Response.Cookies ("MEM_ID")				= uid
			Response.Cookies ("FID")("NAME")		= uname
			Response.Cookies ("FID")("HP")			= hp
			Response.Cookies ("FID")("AUTH")		= 10
			Response.Cookies ("MEM_ID").expires		= Date + 7			'7일간 보관

			If preURL = "" Or preURL = "index.asp" Then
				Call divCloseGo("/")
			Else
				Call divCloseGo(preURL)
			End If
		End If
	End If
	Call rsc()
	Call dbc()
%>