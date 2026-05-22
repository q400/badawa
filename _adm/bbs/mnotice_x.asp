<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/imagevbs.inc" -->
<%
	dbo()

	bbs_id						= 10
	seq							= 59		'59로 고정

	title						= SQLI(chkWord(Request("title")))
	contents					= title

	SQL = "	UPDATE	_obbst010 SET " _
		& "			title		= '"& title &"'" _
		& ",		gubn		= '' " _
		& ",		ddate		= getdate() " _
		& ",		contents	= '"& contents &"' " _
		& "	WHERE	seq = "& seq
	dbcon.Execute SQL

	Call directGo("수정되었습니다.", "/_adm/bbs/notice.asp")
	Response.End
	dbc()
%>