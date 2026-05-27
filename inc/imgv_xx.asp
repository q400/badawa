<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	idx							= Request("idx")
	op							= Request("op")
	comment						= Request("comment")

	SQL = "	UPDATE	_obbst011 SET " _
		& "			comment = '"& comment &"'" _
		& " WHERE	idx = "& idx
	dbcon.Execute SQL

	Call directGo("변경되었습니다.", "imgv.asp?idx="& idx &"&op="& op)
	Response.End

	dbc()
%>