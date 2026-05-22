<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()

	idx							= SQLI(Request("idx"))
	op							= SQLI(Request("op"))				'gallery | ps |
	wdate						= SQLI(Request("wdate"))

	If op = "" Then op = "gallery"

	SQL = "	INSERT INTO _oalbt010 (uno, op, status, photo, wdate, ddate) VALUES (" _
		& "			"& FID_NO _
		& ",		'"& op &"'" _
		& ",		'A'" _
		& ",		"& idx _
		& ",		'"& wdate &"'" _
		& ",		getdate()" _
		& ")"
'	Response.Write SQL &"<br>"
	dbcon.Execute SQL

	Call JSalert("My 앨범에 담았습니다.")
	Response.End
	dbc()
%>