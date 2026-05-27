<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	idx							= Request("idx")
	comment						= Request("comment")

	SQL = "	UPDATE	_ocmmt010 SET " _
		& "			comment = '"& comment &"'" _
		& " WHERE	idx = "& idx
	dbcon.Execute SQL

	Call directGo("저장되었습니다.", "imgv_intro.asp?idx="& idx)
	Response.End
	dbc()
%>