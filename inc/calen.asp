<%
	yy							= SQLI(Request("yy"))
	mm							= SQLI(Request("mm"))
	dd							= SQLI(Request("dd"))

	If dd <> "" Then
		dd = setp(dd)
	Else
		dd = setp(Day(Date))
	End If
'	Response.Write "dd : "& dd &"<br>"

	If mm <> "" Then
		mm = setp(mm)
	Else
'		If dd > 28 Then				'매월 26일이 넘으면 다음달이 보이게
'			mm = setp(Month(Date) + 1)
'			dd = "01"
'		Else
			mm = setp(Month(Date))
'		End If
	End If

	If yy <> "" Then
		yy = yy
	Else
		If mm = 13 Then
			yy = Year(Date) + 1
		Else
			yy = Year(Date)
		End If
	End If

	If mm = 13 Then
		mm = "01"					'다음달이 13이면 1월로 처리
		yy = yy + 1
	End If

	If mm = 0 Then
		mm = "12"					'이전달이 0이면 12월로 처리
		yy = yy - 1
	End If

	vdate = CDate(yy &"/"& mm &"/01")
'	Response.Write "vdate : "& CDate(vdate) &"<br>"
	vThisWeek = Weekday(CDate(yy &"/"& mm &"/"& dd))
%>

<div>
	<div id="midmenu" style="position:absolute; width:412px; height:274px; z-index:30; left:685px; top:170px;">
		<table width="412" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<table width="412" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="119"><!-- <img src="/img/m_cal_tle.png"> --></td>
							<td width="18"><a href="?yy=<%=yy%>&mm=<%=mm-1%>&dd=01"><img src="/img/m_cal_arrow01.png" width="18" height="18"></a></td>
							<td width="137" class="fcw f17 ff fb ls ct"><%=yy%> 년 <%=mm%> 월</td>
							<td width="18"><a href="?yy=<%=yy%>&mm=<%=mm+1%>&dd=01"><img src="/img/m_cal_arrow02.png" width="18" height="18"></a></td>
							<td width="118"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="6"></td>
			</tr>
			<tr>
				<td>
					<table width="412" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="58" height="5" bgcolor="#000" style="filter:alpha(opacity=70)"></td>
							<td width="1"></td>
							<td width="58" height="5" bgcolor="#000" style="filter:alpha(opacity=70)"></td>
							<td width="1"></td>
							<td width="58" height="5" bgcolor="#000" style="filter:alpha(opacity=70)"></td>
							<td width="1"></td>
							<td width="57" height="5" bgcolor="#000" style="filter:alpha(opacity=70)"></td>
							<td width="1"></td>
							<td width="58" height="5" bgcolor="#000" style="filter:alpha(opacity=70)"></td>
							<td width="1"></td>
							<td width="58" height="5" bgcolor="#000" style="filter:alpha(opacity=70)"></td>
							<td width="1"></td>
							<td height="4" bgcolor="#000" style="filter:alpha(opacity=70)"></td>
						</tr>
						<tr>
							<td width="58" height="26" bgcolor="#000" style="filter:alpha(opacity=70)" class="fcw f12 fb ct">일</td>
							<td width="1"></td>
							<td width="58" height="26" bgcolor="#000" style="filter:alpha(opacity=70)" class="fcw f12 fb ct">월</td>
							<td width="1"></td>
							<td width="58" height="26" bgcolor="#000" style="filter:alpha(opacity=70)" class="fcw f12 fb ct">화</td>
							<td width="1"></td>
							<td width="57" height="26" bgcolor="#000" style="filter:alpha(opacity=70)" class="fcw f12 fb ct">수</td>
							<td width="1"></td>
							<td width="58" height="26" bgcolor="#000" style="filter:alpha(opacity=70)" class="fcw f12 fb ct">목</td>
							<td width="1"></td>
							<td width="58" height="26" bgcolor="#000" style="filter:alpha(opacity=70)" class="fcw f12 fb ct">금</td>
							<td width="1"></td>
							<td height="26" bgcolor="#000" style="filter:alpha(opacity=70)" class="fcw f12 fb ct">토</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="1"></td>
			</tr>
			<tr>
				<td>
					<table class="cDate5" width="412" border="0" cellspacing="0" cellpadding="0">
						<tr height="44">
<%
	i = 1
	j = 1

	vLastday					= Day(CDate(Year(vdate)&"/"& Month(vdate + 31)&"/"&"01") - 1)
	vFirstWeek					= Weekday(vdate)
'	Response.Write "vLastday : "& vLastday &"<br>"

	vDay = 1

	If ( vFirstWeek = 6 And vLastday = 31 ) Or ( vFirstWeek = 7 ) Then
		vDisplayCol = 42
	Else
		vDisplayCol = 35
	End If

	While i <= vDisplayCol
		If j = 8 Then
%>
						</tr>
						<tr height="44">
<%
			j = 1
		End If

		If j = 7 Then
			vclass = "sat ff"
		ElseIf j = 1 Then
			vclass = "sun ff"
		Else
			vclass = "ff"
		End If

		If (vFirstWeek = j And vDay = 1) Or (vDay > 1 And vDay <= vLastday) Then
%>
							<td width="58" bgcolor="#000" style="filter:alpha(opacity=50)" class="rg vt"><a href="/rsv/index.asp?yy=<%=yy%>&mm=<%=mm%>&dd=<%=vDay%>"><b class="fcw ff f13"><%=vDay%></b></a>&nbsp;</td>
							<td width="1">
<%
			vDay = vDay + 1
		Else
%>
							<td width="58" class="other" bgcolor="#000" style="filter:alpha(opacity=50)">&nbsp;</td>
							<td width="1">
<%		End If %>
							</td>
<%
		i = i + 1
		j = j + 1
	Wend
%>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
</div>
<!--
<div style="position:relative;" style="background:#fff;">
	<div id="topmenu" style="position:absolute; width:1100px; height:110px; z-index:30; left:65px; top:-30px; background:#fff;">
		<table width="1100" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="110">
					<table width="1017" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="15"></td>
							<td width="110" valign="top"><img src="/img/m_gall_tle.png" width="110" height="22"></td>
							<td width="17"></td>
							<td width="103"><A HREF="/bbs2/gallery.asp"><img src="/img/m_gall_img.png" width="103" height="76" title="조황갤러리"></A></td>
							<td width="30"></td>
							<td width="112" valign="top"><img src="/img/m_mov_tle.png" width="112" height="22"></td>
							<td width="11"></td>
							<td width="144"><A HREF="/bbs2/movie.asp"><img src="/img/m_mov_img.png" width="144" height="80" title="낚시동영상"></A></td>
							<td width="100">&nbsp;</td>
							<td width="59"><a href="/info/info.asp" onMouseOver='bt("banner01","/img/m_banner01b.gif")' onMouseOut='bt("banner01","/img/m_banner01a.gif")'><img src="/img/m_banner01a.gif" ID=banner01 style="filter:blendTrans(duration=0.3)" title="선박안내"></a></td>
							<td width="33">&nbsp;</td>
							<td width="59"><a href="/rsv/info.asp" onMouseOver='bt("banner02","/img/m_banner02b.gif")' onMouseOut='bt("banner02","/img/m_banner02a.gif")'><img src="/img/m_banner02a.gif" ID=banner02 style="filter:blendTrans(duration=0.3)" title="출조안내"></a></td>
							<td width="33">&nbsp;</td>
							<td width="59"><a href="/f_data/fstype.asp" onMouseOver='bt("banner03","/img/m_banner03b.gif")' onMouseOut='bt("banner03","/img/m_banner03a.gif")'><img src="/img/m_banner03a.gif" ID=banner03 style="filter:blendTrans(duration=0.3)" title="출조종류"></a></td>
							<td width="33">&nbsp;</td>
							<td width="59"><a href="/f_data/time.asp" onMouseOver='bt("banner04","/img/m_banner04b.gif")' onMouseOut='bt("banner04","/img/m_banner04a.gif")'><img src="/img/m_banner04a.gif" ID=banner04 style="filter:blendTrans(duration=0.3)" title="조석,물때표보기"></a></td>
							<td height="80">&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
</div>
//-->