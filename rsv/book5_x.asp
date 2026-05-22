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

	If flag = "" And ridx <> "" Then flag = "M"
	If flag = "" Then flag = "W"
	If ridx = "" Then ridx = "0"
	If FID_NO = "" Then FID_NO = "0"

	If FID_NO = "0" Then
		rso()
		SQL = " SELECT COUNT(*) FROM _orsvt020 WHERE ssid = '"& ssid &"' AND shipid = "& shipid &" AND rdate = '"& yy & mm & dd &"' "
		'Response.Write SQL &"<br><br>"
		rs.open SQL, dbcon
			pcnt = CInt(rs(0))
			'Response.Write "pcnt1 : "& pcnt &"<br>"
		rsc()
	Else
		rso()
		SQL = " SELECT COUNT(*) FROM _orsvt020 WHERE uno = "& FID_NO &" AND shipid = "& shipid &" AND rdate = '"& yy & mm & dd &"' "
		rs.open SQL, dbcon
			pcnt = CInt(rs(0))
			'Response.Write "pcnt2 : "& pcnt &"<br>"
		rsc()
	End If

	If flag = "W" Then

		For I = 1 To Request("rname").Count

			If Request("rname")(I) <> "" Then

				rso()
				SQL = " SELECT COUNT(*), idx FROM _orsvt020 " _
					& "	WHERE	ssid = '"& ssid &"' " _
					& "	AND		shipid = "& shipid _
					& "	AND		rdate = '"& yy & mm & dd &"'" _
					& "	AND		rname = '"& Request("rname")(I) &"'" _
					& "	AND		hp = '"& Request("hp")(I) &"'"
				rs.open SQL, dbcon
					kcnt = CInt(rs(0))
					iidx = rs(1)
				rsc()

				If kcnt = 0 Then		'INSERT

					SQL = "	INSERT INTO _orsvt020 (ridx, ssid, uno, shipid, rdate, rname, hp, addr, ddate, gubn) VALUES (" _
						& " "& ridx _
						& ",'"& Session.SessionId &"'" _
						& ","& FID_NO _
						& ","& shipid _
						& ",'"& yy & mm & dd &"'" _
						& ",'"& Trim(Request("rname")(I)) &"'" _
						& ",'"& Trim(Request("hp")(I)) &"'" _
						& ",'"& Trim(Request("addr")(I)) &"'" _
						& ",getdate()" _
						& ",'낚시객'" _
						& ")"
'					Response.Write SQL &"<br><br>"
					dbcon.Execute SQL

				Else		'UPDATE

					SQL = "	UPDATE	_orsvt020 SET " _
						& "			rname	= '"& Trim(Request("rname")(I)) &"'" _
						& ",		hp		= '"& Trim(Request("hp")(I)) &"'" _
						& ",		addr	= '"& Trim(Request("addr")(I)) &"'" _
						& "	WHERE	idx = "& iidx
'					Response.Write SQL &"<br><br>"
					dbcon.Execute SQL

				End If

			End If

		Next

	ElseIf flag = "M" Then

		For I = 1 To Request.Form("rname").Count
			If Request("rname")(I) <> "" Then
				If pcnt = 0 Then		'출항명부 작성 기록이 없는 경우
					SQL = "	INSERT INTO _orsvt020 (ridx, uno, shipid, rdate, rname, hp, addr, ddate, gubn) VALUES (" _
						& " "& ridx _
						& ","& FID_NO _
						& ","& shipid _
						& ",'"& yy & mm & dd &"'" _
						& ",'"& Request("rname")(I) &"'" _
						& ",'"& Request("hp")(I) &"'" _
						& ",'"& Request("addr")(I) &"'" _
						& ",getdate()" _
						& ",'낚시객'" _
						& ")"
					'dbcon.Execute SQL
				Else		'출항명부 작성 기록이 있는 경우
					SQL = "	MERGE INTO _orsvt020 " _
						& "	USING '"& Request("rname")(I) &"', '"& Request("hp")(I) &"', '"& Request("addr")(I) &"'" _
						& "	WHEN MATCHED THEN " _
						& "		UPDATE	_orsvt020 SET " _
						& "			rname		= '"& Request("rname")(I) &"'" _
						& ",		hp			= '"& Request("hp")(I) &"'" _
						& ",		addr		= '"& Request("addr")(I) &"'" _
						& "		WHERE	uno = "& FID_NO &" AND shipid = "& shipid &" AND rdate = '"& yy & mm & dd &"' " _
						& "	WHEN NOT MATCHED THEN " _
						& "		INSERT INTO _orsvt020 (ridx, uno, shipid, rdate, rname, hp, addr, ddate, gubn) VALUES (" _
						& "			"& ridx _
						& ",		"& FID_NO _
						& ",		"& shipid _
						& ",		'"& yy & mm & dd &"'" _
						& ",		'"& Request("rname")(I) &"'" _
						& ",		'"& Request("hp")(I) &"'" _
						& ",		'"& Request("addr")(I) &"'" _
						& ",		getdate()" _
						& ",		'낚시객'" _
						& ")"
'					Response.Write SQL &"<br><br>"
'					dbcon.Execute SQL
				End If
			End If
		Next

	ElseIf flag = "D" Then

		SQL = "	DELETE FROM _orsvt020 WHERE idx = "& idx
		dbcon.Execute SQL

	ElseIf flag = "DA" Then

		SQL = "	DELETE FROM _orsvt020 WHERE uno = "& FID_NO &" AND shipid = "& shipid &" AND rdate = '"& yy & mm & dd &"' "
		dbcon.Execute SQL

	End If
	dbc()

	If flag = "W" Then
%>
<script>
	alert("등록되었습니다.");
	this.document.location.href = "book5.asp?ridx=<%=ridx%>&yy=<%=yy%>&mm=<%=mm%>&dd=<%=dd%>&shipid=<%=shipid%>&man=<%=man%>";
	//parent.window.location.reload();
</script>
<%	Else %>
<script>
	alert("처리되었습니다.");
	window.location.href = "book5.asp?ridx=<%=ridx%>&yy=<%=yy%>&mm=<%=mm%>&dd=<%=dd%>&shipid=<%=shipid%>&man=<%=man%>";
	//parent.window.location.href = "book5.asp?ridx="& ridx &"&yy="& yy &"&mm="& mm &"&dd="& dd &"&shipid="& shipid &"&man="& man;
</script>
<%	End If %>
