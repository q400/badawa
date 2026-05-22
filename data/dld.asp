<%@ CodePage=65001 Language=VBScript EnableSessionState="False"%>
<%
	Response.Buffer = True
	'클라이언트 브라우저에 HTTP 헤더가 이미 쓰여 있습니다. HTTP 헤더는 페이지 컨텐트를 쓰기 전에만 수정해야 합니다.

	PATH_TMP					= "/data/tmp"
	PATH_QNA					= "/data/qna"
	PATH_NOTICE					= "/data/notice"
	PATH_SHIP					= "/data/ship"
	PATH_NEWS					= "/data/news"
	PATH_GALL					= "/data/gallery"
	PATH_VOD					= "/data/vod"
	PATH_FR						= "/data/frame"
	PATH_COOK					= "/data/cook"
	PATH_PS						= "/data/ps"
	PATH_MOOL					= "/data/mool"

	path						= Request.QueryString("path")

	Select Case path
		Case "notice"			: serverPath = server.MapPath(PATH_NOTICE)
		Case "gallery"			: serverPath = server.MapPath(PATH_GALL)
		Case "frame"			: serverPath = server.MapPath(PATH_FR)
		Case "cook"				: serverPath = server.MapPath(PATH_COOK)
		Case "movie"			: serverPath = server.MapPath(PATH_VOD)
		Case "ps"				: serverPath = server.MapPath(PATH_PS)
		Case "mool"				: serverPath = server.MapPath(PATH_MOOL)
	End Select

	file						= Request.QueryString("file")
	filepath					= serverPath &"\"& file
'	filename					= Mid(filepath, InStrRev(filepath, "\")+1)

	if(filepath.indexOf("..") != -1 || filepath.indexOf("\\") != -1){
		filepath = ""
	}

'	Response.AddHeader "Content-Disposition","attachment;filename="& filename

'	Set objFS = Server.CreateObject("Scripting.FileSystemObject")
'	Set objF = objFS.GetFile(filepath)
'	Response.AddHeader "Content-Length", objF.Size
'	Set objF = Nothing
'	Set objFS = Nothing

'	Response.ContentType = "application/unknown"
'	Response.CacheControl = "public"

	Set Download = Server.CreateObject("DEXT.FileUpload")
	Download.FilePath = filepath
'	Download.CodePage = "65001"
	Download.TransferFile True, True
	Set Download = Nothing
%>