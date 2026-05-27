<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	idx							= Request("idx")
	comment						= Request("comment")

	SQL = "	UPDATE	_oshpt011 SET " _
		& "			comment = '"& comment &"'" _
		& " WHERE	idx = "& idx
	dbcon.Execute SQL

	Call directGo("변경되었습니다.", "imgv_ship.asp?idx="& idx &"&op=ship")
	Response.End

	dbc()
%>