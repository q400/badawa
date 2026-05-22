<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/inc/bsfCode.asp" -->
<%
	dbo()
	idx							= SQLI(Request("idx"))
	ridx						= SQLI(Request("ridx"))
	shipid						= SQLI(Request("shipid"))
	ssid						= SQLI(Request("ssid"))
	rdate						= SQLI(Request("rdate"))
	inwon						= SQLI(Request("inwon"))
	gubn						= SQLI(Request("gubn"))
	flag						= SQLI(Request("flag"))

	rname						= SQLI(Request("rname"))
	hp							= SQLI(Request("hp"))
	addr						= SQLI(Request("addr"))

	If flag = "" Then flag = "W"

	For I = 1 To Request("rname").Count
		If Request("rname")(I) <> "" Then
				SQL = "	INSERT INTO _orsvt020 (ridx, ssid, uno, shipid, rdate, rname, hp, addr, ddate, gubn) VALUES (" _
					& " "& ridx _
					& ",'"& ssid &"'" _
					& ","& FID_NO _
					& ","& shipid _
					& ",'"& rdate &"'" _
					& ",'"& Request("rname")(I) &"'" _
					& ",'"& Request("hp")(I) &"'" _
					& ",'"& Request("addr")(I) &"'" _
					& ",getdate()" _
					& ",'낚시객'" _
					& ")"
				'Response.Write SQL &"<br><br>"
		End If
	Next

	SQL = " UPDATE _orsvt010 SET inwon = "& inwon &", gubn = '"& gubn &"' WHERE ridx = "& ridx
	dbcon.Execute SQL

	dbc()

	divAlertReload("등록되었습니다.")
%>