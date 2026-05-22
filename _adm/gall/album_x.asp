<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	idx							= SQLI(Request("idx"))
	flag						= SQLI(Request("flag"))

	If flag = "" And ridx <> "" Then flag = "M"
	If flag = "" Then flag = "W"
	If ridx = "" Then ridx = "0"
	If FID_NO = "" Then FID_NO = "0"

	If flag = "W" Then

	ElseIf flag = "M" Then

	ElseIf flag = "D" Then

		SQL = "	DELETE FROM _oalbt010 WHERE idx = "& idx
		dbcon.Execute SQL

	End If
	dbc()

	If flag = "W" Then
		divClose("등록되었습니다.")
		Response.End
	ElseIf flag = "M" Then
		Call AlertGo("수정되었습니다.", "album.asp")
		Response.End
	ElseIf flag = "D" Then
		Call AlertGo("삭제되었습니다.", "album.asp")
		Response.End
	End If
%>