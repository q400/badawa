<!-- 달력 시작 -->
		<div id="mainwrap4" class="mb10">
			<center>
				<a href="?shipid=<%=shipid%>&yy=<%=Year(dt-1)%>&mm=<%=Month(dt-1)%>&dd=01#mainwrap4"><img src="/img/calen/arrow01.gif" width="19" height="21" class="vm" alt="이전달" /></a>&nbsp;
				<b class="ff f25 fc9 ls2 vm"><%=yy%> .</b>&nbsp;
				<b class="ff f25 fc9 ls2 vm"><%=mm%></b>&nbsp;
				<a href="?shipid=<%=shipid%>&yy=<%=Year(dt+31)%>&mm=<%=Month(dt+31)%>&dd=01#mainwrap4"><img src="/img/calen/arrow02.gif" width="19" height="21" class="vm" alt="다음달" /></a>
			</center>
		</div>
		<div id="mainwrap4">
			<ul>
				<li style="width:115px;" class="ib fleft"><img src="/img/rsv/sun.png" class="db" alt="일" /></li>
				<li style="width:116px;" class="ib fleft"><img src="/img/rsv/mon.png" class="db" alt="월" /></li>
				<li style="width:116px;" class="ib fleft"><img src="/img/rsv/tue.png" class="db" alt="화" /></li>
				<li style="width:116px;" class="ib fleft"><img src="/img/rsv/wed.png" class="db" alt="수" /></li>
				<li style="width:116px;" class="ib fleft"><img src="/img/rsv/thu.png" class="db" alt="목" /></li>
				<li style="width:116px;" class="ib fleft"><img src="/img/rsv/fri.png" class="db" alt="금" /></li>
				<li style="width:115px;" class="ib fleft"><img src="/img/rsv/sat.png" class="db" alt="토" /></li>
			</ul>
			<div style="width:810px; border:0px solid #f00;" class="fleft">
<%
		i = 1
		j = 1

		vLastday = Day(CDate(Year(vDate)&"/"& Month(vDate + 31)&"/"&"01") - 1)
		vFirstWeek = Weekday(vDate)
		'Response.Write "vFirstWeek : "& vFirstWeek &"<br>"

		vDay = 1

		If ( vFirstWeek = 6 And vLastday = 31 ) Or ( vFirstWeek = 7 ) Then
			vDisplayCol = 42
		Else
			vDisplayCol = 35
		End If

		While i <= vDisplayCol
			If j = 8 Then
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
				If vDay = today Then
%>
					<li style="background-color:#fcc" class="ib pt" onClick="goDate(<%=setp(vDay)%>)"><b class="ff"><%=vDay%></b></li>
<%				ElseIf vDay = CInt(dd) Then %>
					<li style="background-color:#ccf" class="ib pt" onClick="goDate(<%=setp(vDay)%>)"><b class="ff"><%=vDay%></b></li>
<%				Else %>
					<li class="ib pt" onClick="goDate(<%=setp(vDay)%>)"><font class="ff"><%=vDay%></font></li>
<%				End If
				vDay = vDay + 1
			Else
%>
					<li class="other"></li>
<%			End If

			i = i + 1
			j = j + 1
		Wend
%>





<%
		dt						= yy &"-"& mm &"-01"
		first_day				= Weekday(dt)
'		Response.Write "first_day : "& first_day &"<br>"
		col						= 0
%>

<%
		'col						= col + 1
		For i = 1 To first_day - 1
%>
		<div style="width:113px;" class="ib"></div>
<%
			col = col + 1
		Next

		For i = 1 To calc_last_day(yy, mm)
			sun_date = yy &"-"& mm &"-"& setp(i)
			color_td = "#ffffff"
			If sun_date = Left(CDate(Now()),10) Then color_td = "#e7e3f7"
'			If IsDate(sun_date) Then
'				If Year(sun_date) = Year(Now()) And Month(sun_date) = Month(Now()) And Day(sun_date) = Day(Now()) Then
'					color_td = "#f7f3f7"
'				End If
'			End If
%>
		<div style="width:112px; border:0px solid #ccc;" class="vt ib">
			<ul class="vt ib cboth">
				<li style="width:112px; height:100%; background:<%=color_td%>; border:0px solid #ccc;" class="vt ib cboth">
<%
			color_chk = "#333333"
			If col = 1 Then
				color_chk = "#ef3a02"
			ElseIf col = 7 Then
				color_chk = "#20aed7"
			End If
%>

<%			If sstat(shipid, yy & mm & setp(i)) = "1" Then		'마감/정비/탐사 return = 1 %>
					<div style="background:#9e9;" class="pl5">
						<a href="?shipid=<%=shipid%>&yy=<%=yy%>&mm=<%=mm%>&dd=<%=setp(i)%>"><font style="color:<%=color_chk%>" class="ff f15 ls fb"><%=i%></font></a>
					</div>
		<!-- <%=getIcon("마감")%> -->
<%			Else
				'예약가능인원
				vcnt		= shipinfo(shipid,"capa") - guestCount(shipid,yy & mm & setp(i))
				If vcnt <= 0 Or Date() >= CDate(yy &"-"& mm &"-"& setp(i)) Then		'만원이거나 과거 => 마감처리
%>
					<div style="background:#9e9;" class="pl5">
						<a href="?shipid=<%=shipid%>&yy=<%=yy%>&mm=<%=mm%>&dd=<%=setp(i)%>"><font style="color:<%=color_chk%>" class="ff f15 ls fb"><%=i%></font></a>
						&nbsp;<font class="ff f10 ls">(<%=guestCount(shipid,yy & mm & setp(i))%>/<%=shipinfo(shipid,"capa")%>)</font>
<%
						If Date() < CDate(yy &"-"& mm &"-"& setp(i)) Then	'대기예약으로 처리
%>
						<span class="fright"><a href="rsv_ww5.asp?shipid=<%=shipid%>&yy=<%=yy%>&mm=<%=mm%>&dd=<%=setp(i)%>&op=SB"><img src="/img/icon/red_plus.gif" class="vt pt3" alt="대기예약"></a></span>
<%
						End If
%>
					</div>
<%
				Else	'만원이 아니고 미래
%>
					<div class="vt pl5" style="background:#9e9;">
<%
					If rsvInfo(shipid, yy & mm & setp(i),"gubn") = "D" Then		'독선
%>
						<a href="?shipid=<%=shipid%>&yy=<%=yy%>&mm=<%=mm%>&dd=<%=setp(i)%>"><font style="color:<%=color_chk%>" class="ff f15 ls fb"><%=i%></font></a>
						<img src="/img/icon/doc.png" class="vt pt3" title="독선" />
						<span class="fright"><a href="rsv_ww5.asp?shipid=<%=shipid%>&yy=<%=yy%>&mm=<%=mm%>&dd=<%=setp(i)%>&op=SB"><img src="/img/icon/red_plus.gif" class="vt pt3" alt="대기예약" /></a></span>
<%
					Else
%>
						<a href="?shipid=<%=shipid%>&yy=<%=yy%>&mm=<%=mm%>&dd=<%=setp(i)%>"><font style="color:<%=color_chk%>" class="ff f15 ls fb"><%=i%></font></a>
<%
						If CDate(yy &"-"& mm &"-"& setp(i)) < Date() + 90 Then
							If standbyCnt(shipid, yy & mm & setp(i)) = 0 Then	'대기예약자가 없을 때
%>
						&nbsp;<font class="ff f10 ls">(<%=guestCount(shipid,yy & mm & setp(i))%>/<%=shipinfo(shipid,"capa")%>)</font>
						<span class="fright pr3"><a href="rsv_ww5.asp?shipid=<%=shipid%>&yy=<%=yy%>&mm=<%=mm%>&dd=<%=setp(i)%>"><img src="/img/icon/rsv.png" class="vt pt3" title="예약" /></a></span>
<%							Else	'대기예약자가 있을 때 %>
						&nbsp;<font class="ff f10 ls">(<%=guestCount(shipid,yy & mm & setp(i))%>/<%=shipinfo(shipid,"capa")%>)</font>
<%
							End If
						End If
					End If
%>
					</div>
<%
				End If
			End If
%>
					<div style="background:#cfc;"><!-- 물때 -->
						&nbsp;
					</div>
					<div style="border:1px solid #eee; <%If guestCount(shipid,yy & mm & setp(i)) < 5 Then%>height:100px;<%End If%>">
<%
			qDate = yy & mm & setp(i)

			Set rsv = Server.CreateObject("ADODB.Recordset")
			SQL = " SELECT	ridx, rdate, uno, rnm, inwon, tel, hp, email, shipid, gubn, status, rmoney, pwd, uip, ddate, memo " _
				& " FROM	_orsvt010 " _
				& " WHERE	shipid = "& shipid &" AND rdate = '"& qDate &"' " _
				& " ORDER BY ddate ASC "
			rsv.open SQL, dbcon, 0, 3
			If Not (rsv.eof And rsv.bof) Then
				k = 1
				Do Until rsv.EOF
%>
						<div class="pl5">
							<a href="javascript:;" onClick="popup1('<%=rsv("ridx")%>'); return false;" class="ls">
<%					If rsv("status") = "K" Then %>
							<span class="fc2"><%=trimtext(rsv("rnm"),6)%></span><span class="ff f10 fc2 fb ls">ㆍ<%=rsv("inwon")%></span></a>
<%					ElseIf rsv("status") = "N" Then %>
							<span class="fc4"><%=trimtext(rsv("rnm"),6)%></span><span class="ff f10 fc2 fb ls">ㆍ<%=rsv("inwon")%></span></a>
<%					ElseIf rsv("status") = "X" Then %>

<%					Else %>
							<%=trimtext(rsv("rnm"),6)%><span class="ff f10 fc7 fb ls">ㆍ<%=rsv("inwon")%></span></a>
<%
					End If
%>
						</div>
<%
					rsv.MoveNext
					k = k + 1
				Loop
			Else
%>

<%
			End If
			Set rsv = Nothing
%>
					</div>
					<div class="pt5"></div>
				</li>
			</ul>
		</div>
<%
			col = col + 1
		Next
%>
	</div>
</div>
<!-- 달력 끝 -->