<script language="javascript">
<!--
function goDate(selDay){
	unoRequest("fm3", "index.asp?yy=<%=yy%>&mm=<%=mm%>&dd="+ selDay +"#frameleft");
}
//-->
</script>


<div id="frameleft">
<form name="fm3" id="fm3" method="post"></form>
	<ul>
		<li><img src="/img/le_fish.gif" width="170" height="40" alt="조황정보" class="db" /></li>
<%
	pg = Request.ServerVariables("PATH_INFO")

	If pg = "/bbs2/gallery3_v.asp" Then
%>
		<li class="ib">
			<center>
				<ul style="width:170px;" class="mt5">
					<li style="width:20px;" class="ib fleft"><a href="?shipid=<%=shipid%>&dt=<%=Year(vDate-1) &"-"& setp(Month(vDate-1)) &"-01"%>#frameleft"><img src="/img/calen/arrow01.gif" width="19" height="21" alt="좌측화살표" /></a></li>
					<li style="width:90px;" class="ib fleft"><b class="ff f25 fc9 ls2"><%=yy%> . </b></li>
					<li style="width:40px;" class="ib fleft"><b class="ff f25 fc9 ls2"><%=mm%></b></li>
					<li style="width:20px;" class="ib fleft"><a href="?shipid=<%=shipid%>&dt=<%=Year(vDate+31) &"-"& setp(Month(vDate+31)) &"-01"%>#frameleft"><img src="/img/calen/arrow02.gif" width="19" height="21" alt="우측화살표" /></a></li>
				</ul>
			</center>
			<center>
				<ul style="width:170px;" class="cWeek3">
					<li class="sun ib">일</li>
					<li class="ib">월</li>
					<li class="ib">화</li>
					<li class="ib">수</li>
					<li class="ib">목</li>
					<li class="ib">금</li>
					<li class="ib">토</li>
				</ul>
			</center>
			<center>
				<ul style="width:170px;" class="cDate3">
<%
		i = 1
		j = 1

		vLastday = Day(CDate(Year(vDate)&"/"& Month(vDate + 31)&"/"&"01") - 1)
		vFirstWeek = Weekday(vDate)
'		Response.Write "vLastday : "& vLastday &"<br>"

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

				ndt = ""
				rso()
				SQL = " SELECT	wdate " _
					& " FROM	_obbst020 " _
					& " WHERE	wdate = '"& yy &"-"& mm &"-"& setp(vDay) &"' AND shipid = "& shipid
				rs.open SQL, dbcon
				If Not rs.eof Then
						ndt			= rs("wdate")
						nday		= Right(setp(rs("wdate")),2)
						If CInt(nday) = vDay Then
							vclass = "event ff fb fcb"
						End If
				End If
				rsc()

				If CInt(dd) = CInt(vDay) Then
					vclass = "select ff fb fcb"
				End If
%>
					<li class="<%=vclass%>"><%If ndt <> "" Then%><a href="?shipid=<%=shipid%>&dt=<%=ndt%>"><%=vDay%></a><%Else%><%=vDay%><%End If%></li>
<%
			vDay = vDay + 1
		Else
%>
					<li class="other"></li>
<%		End If
		i = i + 1
		j = j + 1
	Wend
%>
				</ul>
			</center>
		</li>
		<li style="width:170px; border:0px solid #f99;" class="pt20 ib"></li>
<%	End If %>

		<a href="/bbs2/gallery3.asp" class="f13 ls <%If tag=2 Then%>fb<%End If%>"><li><img src="/img/box/bullet.png" class="vm" />조황갤러리</li></a>
		<a href="/bbs2/movie.asp" class="f13 ls <%If tag=7 Then%>fb<%End If%>"><li><img src="/img/box/bullet.png" class="vm" />낚시동영상</li></a>
		<a href="/bbs1/news.asp" class="f13 ls <%If tag=8 Then%>fb<%End If%>"><li><img src="/img/box/bullet.png" class="vm" />제임스이야기</li></a>
		<!--
		<li><a href="/bbs2/gallery.asp"><img src="/img/le_fish_<%=tagv(2)%>.gif" width="170" height="30" alt="조황갤러리" class="db" /></a></li>
		<li><a href="/bbs2/movie.asp"><img src="/img/le_fish_<%=tagv(7)%>.gif" width="170" height="30" alt="낚시동영상" class="db" /></a></li>
		<li><a href="/bbs2/ps.asp"><img src="/img/le_fish_<%=tagv(33)%>.gif" width="170" height="30" alt="조황후기" class="db" /></a></li>
		<li><a href="/bbs1/news.asp"><img src="/img/le_fish_<%=tagv(8)%>.gif" width="170" height="30" alt="잡다한소식" class="db" /></a></li>-->
	</ul>
	<!-- #include virtual = "/inc/left/banner.asp" -->
</div>