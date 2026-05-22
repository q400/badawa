<script type="text/javascript">
<!--
function goDate(selDay){
	unoRequest("fm3", "?shipid=<%=shipid%>&yy=<%=yy%>&mm=<%=mm%>&dd="+ selDay +"#frameleft");
}
function goRsv(selDay){
	unoRequest("fm3", "rsv_ww5.asp?shipid=<%=shipid%>&yy=<%=yy%>&mm=<%=mm%>&dd="+ selDay +"&op=SB");
}
//-->
</script>

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
				<ul style="width:826px;" class="cDate3">
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
			color_chk = "#ef3a02"
		Else
			vclass = "ff"
		End If

		If (vFirstWeek = j And vDay = 1) Or (vDay > 1 And vDay <= vLastday) Then
%>
					<li style="background-color:#9e9; height:100%;" class="ib lf pt">
<%
			If sstat(shipid, yy & mm & setp(vDay)) = "1" Then		'마감/정비/탐사 return = 1
%>
						<span class="ff f15 ls fb" onClick="goDate(<%=setp(vDay)%>)"><%=vDay%></span>
<%
			Else
				vcnt = shipinfo(shipid,"capa") - guestCount(shipid, yy & mm & setp(vDay))	'예약가능인원
				If vcnt <= 0 Or Date() >= CDate(yy &"-"& mm &"-"& setp(vDay)) Then			'예약 full 또는 과거 => 마감처리
%>
						<span class="ff f15 ls fb" onClick="goDate(<%=setp(vDay)%>)"><%=vDay%></span>
						&nbsp;
						<font class="ff f10 ls">(<%=guestCount(shipid, y & mm & setp(vDay))%>/<%=shipinfo(shipid,"capa")%>)</font>
<%
					If Date() < CDate(yy &"-"& mm &"-"& setp(vDay)) Then	'대기예약으로 처리
%>
						<span class="frt"><img src="/img/icon/red_plus.gif" class="vt pt3" onclick="goRsv(<%=setp(vDay)%>)" alt="대기예약" /></span>
<%
					End If
				Else	'만원이 아니고 미래
					If rsvInfo(shipid, yy & mm & setp(vDay),"gubn") = "D" Then		'독배
%>
						<span class="ff f15 ls fb" onClick="goDate(<%=setp(vDay)%>)"><%=vDay%></span>
						&nbsp;
						<img src="/img/icon/doc.png" class="vt pt3" title="독배" />
						<span class="frt"><img src="/img/icon/red_plus.gif" class="vt pt3" onclick="goRsv(<%=setp(vDay)%>)" alt="대기예약" /></span>
<%
					Else
%>
						<span class="ff f15 ls fb" onClick="goDate(<%=setp(vDay)%>)"><%=vDay%></span>
<%
						If CDate(yy &"-"& mm &"-"& setp(vDay)) < Date() + 90 Then
							If standbyCnt(shipid, yy & mm & setp(vDay)) = 0 Then	'대기예약자가 없을 때
%>
						&nbsp;
						<font class="ff f10 ls">(<%=guestCount(shipid, yy & mm & setp(vDay))%>/<%=shipinfo(shipid,"capa")%>)</font>
						<span class="frt pr3"><img src="/img/icon/rsv.png" class="vt pt3" onclick="goRsv(<%=setp(vDay)%>)" title="예약" /></span>
<%
							Else	'대기예약자가 있을 때
%>
						&nbsp;<font class="ff f10 ls">(<%=guestCount(shipid, yy & mm & setp(vDay))%>/<%=shipinfo(shipid,"capa")%>)</font>
<%
							End If
						End If
					End If
				End If
			End If

			qDate = yy & mm & setp(vDay)
			qCnt = guestGrpCnt(shipid, qDate)
%>
						<div style="border:1px solid #eee; background-color:#fff; height:200px;">
<%
			Set rsv = Server.CreateObject("ADODB.Recordset")
			SQL = " SELECT	ridx, rdate, uno, rnm, inwon, tel, hp, email, shipid, gubn, status, rmoney, pwd, uip, ddate, memo " _
				& " FROM	_orsvt010 " _
				& " WHERE	shipid = "& shipid &" AND rdate = '"& qDate &"' " _
				& " AND		status IN ('K','N','C','Y') " _
				& " ORDER BY ddate ASC "
			rsv.open SQL, dbcon, 0, 3
			If Not (rsv.eof And rsv.bof) Then
				k = 1
				Do Until rsv.EOF
					'N-대기중/C-예약완료/Y-출조완료/K-예약대기/X-예약취소
%>
							<div class="pl5" style="height:14px;">
								<a href="javascript:;" onClick="popup1('<%=rsv("ridx")%>'); return false;" class="ls">
<%
					If rsv("status") = "K" Then			'K-예약대기
%>
								<span class="fc2"><%=TrimText(rsv("rnm"),6)%></span><span class="ff f10 fc2 fb ls">ㆍ<%=rsv("inwon")%></span></a>
<%
					ElseIf rsv("status") = "N" Then		'N-대기중
%>
								<span class="fc4"><%=TrimText(rsv("rnm"),6)%></span><span class="ff f10 fc2 fb ls">ㆍ<%=rsv("inwon")%></span></a>
<%
					ElseIf rsv("status") = "C" Or rsv("status") = "Y" Then
%>
								<%=TrimText(rsv("rnm"),6)%><span class="ff f10 fc7 fb ls">ㆍ<%=rsv("inwon")%></span></a>
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
<%
			vDay = vDay + 1
%>
					</li>
<%
		Else
%>
					<li class="other"></li>
<%
		End If
		i = i + 1
		j = j + 1
	Wend
%>
				</ul>
			</div>
			<!-- 달력 끝 -->