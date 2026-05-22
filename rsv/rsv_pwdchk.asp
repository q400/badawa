<!-- #include virtual = "/inc/header_pop.asp" -->
<%
'************************************************************************************
'*  윈도우 명		: pwdchk.asp
'************************************************************************************

	dbo()
	ridx					= SQLI(Request("ridx"))
	shipid					= SQLI(Request("shipid"))
	yy						= SQLI(Request("yy"))
	mm						= SQLI(Request("mm"))
	dd						= SQLI(Request("dd"))
	inpwd					= SQLI(Request("pwd"))

	Set cx = New BsfCode

	rso()
	SQL = "	SELECT pwd FROM _orsvt010 WHERE ridx = "& ridx &" AND pwd = '"& cx.SetEncode(inpwd) &"' "
	rs.open SQL, dbcon
	If rs.eof Then
		Call JSalert("비밀번호가 다릅니다.")
		Response.End
	Else
%>
	<script>
		parent.document.location.href = "rsv_ww5.asp?ridx=<%=ridx%>&shipid=<%=shipid%>&yy=<%=yy%>&mm=<%=mm%>&dd=<%=dd%>&inpwd=<%=inpwd%>";
	</script>
<%
	End If
	'Set cx = Nothing
	rsc()
	dbc()
%>