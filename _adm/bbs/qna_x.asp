<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/imagevbs.inc" -->
<%
	dbo()
	seq							= SQLI(request("seq"))
	idx							= SQLI(request("idx"))
	page						= SQLI(request("page"))
	cd1							= SQLI(request("cd1"))
	cd2							= SQLI(request("cd2"))
	flag						= SQLI(request("flag"))

	title						= SQLI(chkWord(request("title")))
	contents					= SQLI(chkWord(request("contents")))
	answer						= chkWord(request("answer"))
	cbox						= SQLI(request("cbox"))

	If flag = "" Then flag = "M"

	nlist						= "qna"
	nview						= "qna_v"
	nwrite						= "qna_w"

	If flag = "M" Then						'수정 - 답변달기

		rso()
		SQL = " SELECT hp, hp_chk FROM _obbst030 WHERE seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			hp					= rs(0)
			hp_chk				= rs(1)
		End If
		rsc()

		If sms Then
			If hp <> "" And Not hp_chk Then
'				dbo7()
'				SQL = "	INSERT INTO fidplus.fid.em_tran (tran_id, tran_phone, tran_callback, tran_status, tran_date, tran_msg) " _
'					& "	VALUES ('badawa', '"& Replace(hp,"-","") &"', '"& OffTel01 &"', '1', "& sendSMS() &", '[바다와] 문의에 대한 답변이 등록되었습니다.') "
'				dbco.Execute SQL
'				SQL = "	INSERT INTO fidplus.fid.em_tran (tran_id, tran_phone, tran_callback, tran_status, tran_date, tran_msg) " _
'					& "	VALUES ('zam-dbuy', '"& Replace(OVE_HP,"-","") &"', '"& OffTel01 &"', '1', DateAdd(ss,20,getdate()), '입금계좌안내:"& accinfo &" 결제금액:"& FormatNumber(price,0) &"원') "
'				dbc7()
			End If
		End If

		SQL = "	UPDATE	_obbst030 SET " _
			& "			hp_chk			= 1 " _
			& ",		answer			= '"& answer &"' " _
			& "	WHERE	seq = "& seq
		dbcon.Execute SQL

	ElseIf flag = "D" Then						'삭제
		SQL = "	DELETE FROM _obbst030 WHERE seq = "& seq
		dbcon.Execute SQL

	End If

	If flag = "W" Then
		Call directGo("등록되었습니다.", nlist &".asp?cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "M" Then
		Call directGo("처리되었습니다.", nlist &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "R" Then
		Call directGo("답변글이 등록되었습니다.", nlist &".asp?cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "delpic" Then
		Call directGo("첨부파일이 삭제되었습니다.", nwrite &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "A" Then
		Call directGo("댓글이 등록되었습니다.", nview &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "AD" Then
		Call directGo("댓글이 삭제되었습니다.", nview &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	ElseIf flag = "D" Then
		Call directGo("삭제되었습니다.", nlist &".asp?cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&flag="& flag)
		Response.End
	End If

	Set request = Nothing
	Set Image = Nothing
	dbc()
%>