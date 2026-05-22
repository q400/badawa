<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	Response.AddHeader "P3P", "CP=ALL CURa ADMa DEVa TAIa OUR BUS IND PHY ONL UNI PUR FIN COM NAV INT DEM CNT STA POL HEA PRE LOC OTC"

	If FID_ID = "" Then
		Call noAlertGo("/_adm/login.asp")
		Response.End
	Else
		Call noAlertGo("/_adm/mem/mem.asp")
		Response.End
	End If
%>