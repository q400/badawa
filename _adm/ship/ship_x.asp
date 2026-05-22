<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	shipid						= SQLI(Request("shipid"))
	shipno						= SQLI(Request("shipno"))
	shipnm						= SQLI(Request("shipnm"))
	captain						= SQLI(Request("captain"))
	captain_sub					= SQLI(Request("captain_sub"))
	sz							= SQLI(Request("sz"))
	capa0						= SQLI(Request("capa0"))			'선장포함 정원
	capa						= SQLI(Request("capa"))				'실제 예약가능 인원
	speed						= SQLI(Request("speed"))
	equip						= SQLI(Request("equip"))
	seat						= SQLI(Request("seat"))				'자리배정방식
	tel							= SQLI(Request("tel"))
	hp1							= SQLI(Request("hp1"))
	hp2							= SQLI(Request("hp2"))
	hp3							= SQLI(Request("hp3"))
	cost						= SQLI(Request("cost"))
	chuljo0						= SQLI(Request("chuljo0"))
	chuljo						= SQLI(Request("chuljo"))
	comfort						= SQLI(Request("comfort"))
	service						= SQLI(Request("service"))
	blog						= SQLI(Request("blog"))
	smart						= SQLI(Request("smart"))
	homp						= SQLI(Request("homp"))
	bank						= SQLI(Request("bank"))
	acc							= SQLI(Request("acc"))
	active_yn					= SQLI(Request("active_yn"))
	captel						= SQLI(Request("captel"))			'선장연락처
	capaddr						= SQLI(Request("capaddr"))			'선장주소
	memo						= SQLI(Request("memo"))

	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	cd4							= SQLI(Request("cd4"))
	page						= SQLI(Request("page"))
	flag						= Request("flag")
	idx							= Request("idx")

	If active_yn = "" Then active_yn = 0
'	Response.Write "flag : "& flag &"<br>"

	If flag = "" Then flag = "M"
	serverPath					= Server.MapPath(PATH_SHIP)

	If flag = "W" Then

		SQL = "	INSERT INTO _oshpt010 (shipnm, shipno, captain, captain_sub, sz, capa0, capa, speed, equip," _
			& "				seat, tel, hp, homp, bank, acc, cost, chuljo0, chuljo, comfort, service, blog, smart, ddate, active_yn, captel, capaddr, memo) VALUES (" _
			& " '"& shipnm &"'" _
			& ",'"& shipno &"'" _
			& ",'"& captain &"'" _
			& ",'"& captain_sub &"'" _
			& ",'"& sz &"'" _
			& ", "& capa0 _
			& ", "& capa _
			& ",'"& speed &"'" _
			& ",'"& equip &"'" _
			& ",'"& seat &"'" _
			& ",'"& tel &"'" _
			& ",'"& hp1 & hp2 & hp3 &"'" _
			& ",'"& homp &"'" _
			& ",'"& bank &"'" _
			& ",'"& acc &"'" _
			& ",'"& cost &"'" _
			& ",'"& chuljo0 &"'" _
			& ",'"& chuljo &"'" _
			& ",'"& comfort &"'" _
			& ",'"& service &"'" _
			& ",'"& blog &"'" _
			& ",'"& smart &"'" _
			& ",getdate()" _
			& ",'"& active_yn &"'" _
			& ",'"& captel &"'" _
			& ",'"& capaddr &"'" _
			& ",'"& memo &"'" _
			& ")"
		dbcon.Execute SQL

	ElseIf flag = "M" Then

		SQL = "	UPDATE _oshpt010 SET " _
			& " shipnm			= '"& shipnm &"'" _
			& ",shipno			= '"& shipno &"'" _
			& ",captain			= '"& captain &"'" _
			& ",captain_sub		= '"& captain_sub &"'" _
			& ",sz				= '"& sz &"'" _
			& ",capa0			=  "& capa0 _
			& ",capa			=  "& capa _
			& ",speed			= '"& speed &"'" _
			& ",equip			= '"& equip &"'" _
			& ",seat			= '"& seat &"'" _
			& ",tel				= '"& tel &"'" _
			& ",hp				= '"& hp1 & hp2 & hp3 &"'" _
			& ",homp			= '"& homp &"'" _
			& ",bank			= '"& bank &"'" _
			& ",acc				= '"& acc &"'" _
			& ",cost			= "& cost _
			& ",chuljo0			= '"& chuljo0 &"'" _
			& ",chuljo			= '"& chuljo &"'" _
			& ",comfort			= '"& comfort &"'" _
			& ",service			= '"& service &"'" _
			& ",blog			= '"& blog &"'" _
			& ",smart			= '"& smart &"'" _
			& ",active_yn		= '"& active_yn &"'" _
			& ",captel			= '"& captel &"'" _
			& ",capaddr			= '"& capaddr &"'" _
			& ",memo			= '"& memo &"'" _
			& " WHERE shipid	= "& shipid
'		Response.Write SQL &"<br>"
		dbcon.Execute SQL
'		Response.Redirect "mem_v.asp?seq="& seq &"&page="& page &"&cd1="& cd1 &"&cd2="& cd2 &"&cd3="& cd3 &"&cd4="& cd4

	ElseIf flag = "DP" Then

		rso()
		SQL = " SELECT idx, shipid, fpath, fnm, ext FROM _oshpt011 WHERE idx = "& idx
		rs.open SQL, dbcon
		If Not rs.eof Then
			Set fs = Server.CreateObject("Scripting.FileSystemObject")
			If rs("fnm") <> "" Then				'파일존재시
				If fs.FileExists(serverPath &"\"& rs("fnm") &"."& rs("ext")) Then
					fs.DeleteFile serverPath &"\"& rs("fnm") &"."& rs("ext"), True
				End If
				If fs.FileExists(serverPath &"\thumb\"& rs("fnm") &".gif") Then
					fs.DeleteFile serverPath &"\thumb\"& rs("fnm") &".gif", True
				End If
			End If
			Set fs = Nothing
			SQL = "	DELETE FROM _oshpt011 WHERE idx = "& rs("idx")
			dbcon.Execute SQL
		End If
		rsc()

	ElseIf flag = "D" Then

		rso()
		SQL = " SELECT idx, shipid, fpath, fnm, ext FROM _oshpt011 WHERE shipid = "& shipid
		rs.open SQL, dbcon
		While Not rs.eof
			Set fs = Server.CreateObject("Scripting.FileSystemObject")
			If rs("fnm") <> "" Then				'파일존재시
				If fs.FileExists(serverPath &"\"& rs("fnm") &"."& rs("ext")) Then
					fs.DeleteFile serverPath &"\"& rs("fnm") &"."& rs("ext"), True
				End If
			End If
			Set fs = Nothing
			SQL = "	DELETE FROM _oshpt011 WHERE idx = "& rs("idx")
			dbcon.Execute SQL
			rs.MoveNext
		Wend
		rsc()

		SQL = " DELETE FROM _oshpt010 WHERE shipid = "& shipid
		dbcon.Execute SQL

	End If

	nlist = "ship" : nwrite = "ship_w" : nview = "ship_v"

	If flag = "W" Then
		Call directGo("등록되었습니다.", nlist &".asp?shipid="& shipid &"&memid="& memid &"&cd1="& cd1 &"&cd2="& cd2 &"&cd4="& cd4 &"&page="& page)
		Response.End

	ElseIf flag = "M" Then
		Call noAlertGo(nwrite &".asp?shipid="& shipid &"&memid="& memid &"&cd1="& cd1 &"&cd2="& cd2 &"&cd4="& cd4 &"&page="& page &"&flag="& flag)
		Response.End

	ElseIf flag = "DP" Then
		Call noAlertGo(nwrite &".asp?shipid="& shipid &"&memid="& memid &"&cd1="& cd1 &"&cd2="& cd2 &"&cd4="& cd4 &"&page="& page)
		Response.End

	ElseIf flag = "D" Then
		Call directGo("삭제되었습니다.", nlist &".asp?shipid="& shipid &"&memid="& memid &"&cd1="& cd1 &"&cd2="& cd2 &"&cd4="& cd4 &"&page="& page)

	End If
	dbc()
%>