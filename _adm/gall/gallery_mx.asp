<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	seq							= SQLI(Request("seq"))
	shipid						= SQLI(Request("shipid"))
	yy							= SQLI(Request("yy"))
	mm							= SQLI(Request("mm"))
	dd							= SQLI(Request("dd"))
	page						= SQLI(Request("page"))
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	flag						= SQLI(Request("flag"))

	serverPath					= Server.MapPath(PATH_GALL)

	newName = "iimgur_"& shipid &"_"& yy & setp(mm) & setp(dd) &".xls"		'"imgur_"& shipid &".xls"

	Set fso = Server.CreateObject("Scripting.FileSystemObject")
	If newName <> "" Then		'파일존재시
		If fso.FileExists(serverPath & "\" & newName) Then
			fso.DeleteFile serverPath & "\" & newName, True
		End If
	End If
	Set fso = Nothing

	nlist = "gallery" : nwrite = "gallery_w" : nview = "gallery_v"

	If flag = "W" Then
		Call directGo("정상적으로 등록되었습니다.", nlist &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&shipid="& shipid &"&yy="& yy &"&mm="& mm &"&dd="& dd &"&flag="& flag)
		Response.End

	ElseIf flag = "M" Or flag = "DelPhoto" Then
		Call directGo("수정되었습니다.", nlist &".asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&shipid="& shipid &"&yy="& yy &"&mm="& mm &"&dd="& dd &"&flag="& flag)
		Response.End

	ElseIf flag = "DX" Then
		Call directGo("DB가 삭제되었습니다.", "gallery_excel.asp?seq="& seq &"&cd1="& cd1 &"&cd2="& cd2 &"&page="& page &"&shipid="& shipid &"&yy="& yy &"&mm="& mm &"&dd="& dd &"&flag="& flag)

	End If
%>