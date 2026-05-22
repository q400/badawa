<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	yy = Request("yy")
	If yy = "" Then
		yy = Year(Date)
	End If

	mm = Request("mm")
	If mm = "13" Then
		yy = yy + 1
		mm = 1
	ElseIf mm = "00" Then
		yy = yy - 1
		mm = 12
	End If
	If mm = "" Then
		mm = Month(Date)
	End If
	'Response.Write "value : "& yy &"-"& setp(mm)
%>


<div>
<%
	moolImg = Server.MapPath(PATH_MOOL) & "/mool_" & yy & setp(mm) &".png"

	Set FileSys = CreateObject("Scripting.FileSystemObject")
'	Response.Write "value : "& moolImg &"<br>"
'	Response.Write "value : "& FileSys.FileExists(moolImg) &"<br>"
	If(FileSys.FileExists(moolImg)) Then
%>
	<div class="ct"><img src="<%=PATH_MOOL%>/mool_<%=yy%><%=setp(mm)%>.png" title="mool_<%=yy%><%=setp(mm)%>" usemap="#map09" /></div>
<%
	Else
%>
	<div class="ct mt30">
		<svg width="130" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg"><!-- 느낌표06 -->
		    <path fill="#ff7733" d="m91.17 81.374l.006-.004l-.139-.24c-.068-.128-.134-.257-.216-.375l-37.69-65.283c-.611-1.109-1.776-1.87-3.133-1.87c-1.47 0-2.731.887-3.285 2.153l-.004-.002L9.312 80.529l.036.021a3.553 3.553 0 0 0-.82 2.257a3.59 3.59 0 0 0 3.588 3.59h75.767a3.59 3.59 0 0 0 3.589-3.589c0-.511-.11-.994-.302-1.434zm-41.135-1.757c-2.874 0-5.201-2.257-5.201-5.13c0-2.874 2.326-5.2 5.201-5.2c2.803 0 5.13 2.325 5.13 5.2a5.123 5.123 0 0 1-5.13 5.13zm5.13-45.367v28.299h-.002l.002.016c0 1.173-.95 2.094-2.094 2.094l-.014-.001v.001h-6.093c-1.174 0-2.123-.921-2.123-2.094l.002-.016h-.002V34.326c-.001-.026-.008-.051-.008-.077c0-1.117.865-1.996 1.935-2.078v-.016h6.288v.001c1.149.007 2.074.897 2.103 2.039h.005v.055h.001z"/>
		</svg>
		<br><br>
		"물때표 준비중"
		<br><br>
		<a href="javascript:history.go(-1);" class="btn btn25"><span>뒤로</span></a>
		<a href="javascript:;" onClick="simsClosePopup();" class="btn btn25"><span>닫기</span></a>
	</div>
<%
	End If
%>
</div>
<map name="map09">
	<area shape="rect" coords="370,60,470,100" class="pt" href="?yy=<%=yy%>&mm=<%=setp(mm-1)%>" alt="이전 달" title="<%=yy%>-<%=setp(mm-1)%>">
	<area shape="rect" coords="660,60,760,100" class="pt" href="?yy=<%=yy%>&mm=<%=setp(mm+1)%>" alt="다음 달" title="<%=yy%>-<%=setp(mm+1)%>">
</map>
