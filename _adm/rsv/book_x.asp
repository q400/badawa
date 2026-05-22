<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/inc/bsfCode.asp" -->
<%
	dbo()
	idx							= SQLI(Request("idx"))
	ridx						= SQLI(Request("ridx"))
	shipid						= SQLI(Request("shipid"))
	ssid						= SQLI(Request("ssid"))
	yy							= SQLI(Request("yy"))
	mm							= SQLI(Request("mm"))
	dd							= SQLI(Request("dd"))
	man							= SQLI(Request("man"))
	flag						= SQLI(Request("flag"))

	rname						= SQLI(Request("rname"))
	hp							= SQLI(Request("hp"))
	addr						= SQLI(Request("addr"))

	Set cx = New BsfCode

	If flag = "" Then flag = "W"
	If ridx = "" Then ridx = "0"
	If FID_NO = "" Then FID_NO = "0"

	If flag = "W" Then

		If ridx = "0" Then				'최초 입력, 저장 안한 상태
			SQL = "	DELETE FROM _orsvt020 WHERE ssid = '"& ssid &"' "
		Else
			SQL = "	DELETE FROM _orsvt020 WHERE ridx = "& ridx
		End If
		dbcon.Execute SQL

		For I = 1 To Request("rname").Count
			If Request("rname")(I) <> "" Then
					SQL = "	INSERT INTO _orsvt020 (ridx, ssid, uno, shipid, rdate, rname, hp, addr, ddate, gubn) VALUES (" _
						& " "& ridx _
						& ",'"& ssid &"'" _
						& ","& FID_NO _
						& ","& shipid _
						& ",'"& yy & mm & dd &"'" _
						& ",'"& Request("rname")(I) &"'" _
						& ",'"& Request("hp")(I) &"'" _
						& ",'"& Request("addr")(I) &"'" _
						& ",getdate()" _
						& ",'낚시객'" _
						& ")"
'					Response.Write SQL &"<br><br>"
					dbcon.Execute SQL
			End If
		Next

		SQL = " UPDATE _orsvt010 SET inwon = "& man &" WHERE ridx = "& ridx
		dbcon.Execute SQL

	ElseIf flag = "D" Then

		SQL = "	DELETE FROM _orsvt020 WHERE idx = "& idx
		dbcon.Execute SQL

	ElseIf flag = "DA" Then

		SQL = "	DELETE FROM _orsvt020 WHERE uno = "& FID_NO &" AND shipid = "& shipid &" AND rdate = '"& yy & mm & dd &"' "
		dbcon.Execute SQL

	End If
	Set cx = Nothing
	dbc()

	If flag = "W" Then
		AlertClose("등록되었습니다.")
		Response.End
	ElseIf flag = "D" Then
		Call AlertGo("삭제되었습니다.", "book.asp?ridx="& ridx &"&yy="& yy &"&mm="& mm &"&dd="& dd &"&shipid="& shipid &"&man="& man)
		Response.End
	End If
%>