<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/whole.asp" -->

<%
	YY							= Request("YY")
	MM							= Request("MM")

	dbo()
	SQL = " SELECT	wdate FROM _obbst020 " _
		& " WHERE	CAST(wdate AS CHAR(7)) = '"& YY &"-"& setp(MM) &"'" _
		& " GROUP BY wdate "
	sbRsSqlGetrows()
	calday = ""
	If Not IsNull(data) Then
		For ix = 0 To UBound(data,2)
			calday = calday & CInt(Right(data(0,ix),2))
			If ix < UBound(data,2) Then
				calday = calday & "`"
			End If
		Next
		Response.Write "{""rs"":""true"",""arr"":""" & calday & """}"
	Else
		Response.Write "{""rs"":""false""}"
	End If
	dbc()
%>