<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	seq							= SQLI(Request("seq"))
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))			'M:수정/R:답글/NULL:입력
	prevURL						= SQLI(Request("prevURL"))
	inpwd						= SQLI(Request("pwd"))

	If prevURL = "" Then prevURL = "qna_v"

	Select Case prevURL
		Case "qna_v"
			tblSelect = " SELECT * FROM _obbst030 WHERE seq = "& seq &" AND pwd = '"& inpwd &"'"
			nPage = httpRoot &"/bbs1/qna_v.asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&pwd="& inpwd
	End Select

		rso()
		SQL = tblSelect
		rs.open SQL, dbcon, 3

		If rs.EOF Then
			Call JSalert("비밀번호를 확인하세요.")
			Response.End
		Else		'비밀번호 일치
			divCloseGo(nPage)
		End If
		rsc()

	dbc()
%>