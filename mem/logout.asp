<%
	Response.Cookies ("FID")("ID")		= ""
	Response.Cookies ("FID")("NAME")	= ""
	Response.Cookies ("FID")("HP")		= ""
	Response.Cookies ("FID")("AUTH")	= ""
	Response.Cookies ("FID")("EMAIL")	= ""
	Response.Cookies ("FID")("DOMAIN")	= ""
	Response.Cookies ("FID").Expires	= "July 31, 1980"

	Session.Contents.RemoveAll:
	Session.Abandon

	Response.Redirect "/index.asp?op=pc"
%>