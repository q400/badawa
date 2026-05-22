<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()

	yy							= Request("yy")
	mm							= Request("mm")
	dd							= Request("dd")
Response.Write "<br>yy : "& yy &"<br>"
Response.Write "<br>mm : "& mm &"<br>"
Response.Write "<br>dd : "& dd &"<br>"

	rso()
	SQL = " SELECT	mtime7 " _
		& " FROM	mooltime " _
		& " WHERE	yy = '"& yy &"' AND mm = '"& mm &"' AND dd = '"& dd &"' "
	rs.open SQL, dbcon

	If Not(rs.Eof Or rs.Bof) Then
		moolv = rs(0)
	End If
	rsc()
	dbc()
%>

<script type="text/javascript">
<!--
function init(){
	parent.document.all.multime.value = "<%=moolv%>";
}
window.onload = init;
-->
</script>