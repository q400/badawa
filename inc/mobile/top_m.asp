<table width="100%">
	<tr>
		<td><a href="/"><img src="/img/mobile_title31.png"></a></td>
		<td class="rg vm">
<%	If FID_ID = "" Then %>
			<a href="login.asp?preURL=<%=Request.ServerVariables("PATH_INFO")%>"><img src="/img/login.png" width=25></a>
<%	Else %>
			<a href="logout.asp"><img src="/img/logout.png" width=25></a>
<%	End If %>
			<a href="http://www.badawa.co.kr/index.asp?op=pc"><img src="/img/pc.png" width=25></a>&nbsp;&nbsp;
		</td>
	</tr>
</table>
<table width="100%">
	<tr height="30">
		<td width="17%" class="ct vm"<%If tag = "10" Then%> bgcolor="#00b5c8"<%Else%> bgcolor="#000"<%End If%>><a href="/"><span class="f12 fcw fz ls">Home</span></a></td>
		<td width="16%" class="ct vm"<%If tag = "60" Then%> bgcolor="#00b5c8"<%Else%> bgcolor="#000"<%End If%>><a href="/info.asp"><span class="f12 fcw fz ls">소개</span></a></td>
		<td width="17%" class="ct vm"<%If tag = "20" Then%> bgcolor="#00b5c8"<%Else%> bgcolor="#000"<%End If%>><a href="/rsv.asp"><span class="f12 fcw fz ls">출조예약</span></a></td>
		<td width="17%" class="ct vm"<%If tag = "30" Then%> bgcolor="#00b5c8"<%Else%> bgcolor="#000"<%End If%>><a href="/gallery.asp"><span class="f12 fcw fz ls">갤러리</span></a></td>
		<td width="16%" class="ct vm"<%If tag = "40" Then%> bgcolor="#00b5c8"<%Else%> bgcolor="#000"<%End If%>><a href="/movie.asp"><span class="f12 fcw fz ls">동영상</span></a></td>
		<td width="17%" class="ct vm"<%If tag = "50" Then%> bgcolor="#00b5c8"<%Else%> bgcolor="#000"<%End If%>><a href="/qna.asp"><span class="f12 fcw fz ls">게시판</span></a></td>
	</tr>
</table>