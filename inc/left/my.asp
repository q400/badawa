<script type="text/javascript">
<!--
function goDate(y,m,selDay){
	$(".loader").show();
	unoRequest("fm3", "index.asp?yy="+ y +"&mm="+ m +"&dd="+ selDay +"#frameleft");
}
//-->
</script>


<div id="frameleft">
<form name="fm3" id="fm3" method="post"></form>
	<ul>
		<li><img src="/img/le_reser.gif" width="170" height="40" alt="낚시배예약" class="db" /></li>
<%
	pg = Request.ServerVariables("PATH_INFO")

	If pg = "/rsv/index.asp" Or pg = "/rsv/" Or pg = "/rsv/index1.asp" Then				' Or pg = "/rsv/rsv_detail.asp"
%>
		<li class="ib">
			<center>
				<ul style="width:170px;" class="mt5">
					<li style="width:20px;" class="ib fleft">
						<a href="javascript:;" onclick="goDate('<%=Year(vDate-1)%>','<%=Month(vDate-1)%>','01');"><img src="/img/calen/arrow01.gif" width="19" height="21" alt="좌측화살표" /></a>
					</li>
					<li style="width:90px;" class="ib fleft"><b class="ff f25 fc9 ls2"><%=yy%> . </b></li>
					<li style="width:40px;" class="ib fleft"><b class="ff f25 fc9 ls2"><%=mm%></b></li>
					<li style="width:20px;" class="ib fleft">
						<a href="javascript:;" onclick="goDate('<%=Year(vDate+31)%>','<%=Month(vDate+31)%>','01');"><img src="/img/calen/arrow02.gif" width="19" height="21" alt="우측화살표" /></a>
					</li>
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
'		Response.Write "vFirstWeek : "& vFirstWeek &"<br>"

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
					<li style="background-color:#fcc" class="ib pt" onclick="goDate('<%=yy%>','<%=mm%>','<%=setp(vDay)%>')"><b class="ff"><%=vDay%></b></li>
<%				ElseIf vDay = CInt(dd) Then %>
					<li style="background-color:#ccf" class="ib pt" onclick="goDate('<%=yy%>','<%=mm%>','<%=setp(vDay)%>')"><b class="ff"><%=vDay%></b></li>
<%				Else %>
					<li class="ib pt" onclick="goDate('<%=yy%>','<%=mm%>','<%=setp(vDay)%>')"><font class="ff"><%=vDay%></font></li>
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
				</ul>
			</center>
		</li>
		<li style="width:170px; border:0px solid #f99;" class="pt20 ib"></li>
<%	End If %>

		<a href="/rsv/info.asp" class="f13 ls <%If tag=1 Then%>fb<%End If%>"><li><img src="/img/box/bullet.png" class="vm" />출조안내</li></a>
		<a href="/info/type01.asp" class="f13 ls <%If tag=2 Then%>fb<%End If%>"><li><img src="/img/box/bullet.png" class="vm" />출조종류</li></a>
		<a href="javascript:Popup('/info/help.asp',900,900,300,30,1,0,98);" class="f13 ls <%If tag=6 Then%>fb<%End If%>"><li><img src="/img/box/bullet.png" class="vm" />예약도우미</li></a>
		<a href="/rsv/" class="f13 ls <%If tag=3 Then%>fb<%End If%>"><li><img src="/img/box/bullet.png" class="vm" />예약 및 예약현황</li></a>
		<a href="/rsv/check.asp" class="f13 ls <%If tag=4 Then%>fb<%End If%>"><li><img src="/img/box/bullet.png" class="vm" />예약확인 및 취소</li></a>
		<!--
		<li><a href="/rsv/info.asp"><img src="/img/le_reser_<%=tagv(1)%>.gif" width="170" height="30" ID=rsv001 class="db" alt="출조안내" /></a></li>
		<li><a href="/info/type01.asp"><img src="/img/le_reser_<%=tagv(2)%>.gif" width="170" height="30" ID=rsv002 class="db" alt="출조종류" /></a></li>
		<li><a href="javascript:Popup('/info/help.asp',900,900,300,30,1,0,98);"><img src="/img/le_reser_<%=tagv(6)%>.gif" width="170" height="30" ID=rsv006 class="db" alt="예약도우미" /></a></li>
		<li><a href="/rsv/"><img src="/img/le_reser_<%=tagv(3)%>.gif" width="170" height="30" ID=rsv003 class="db" alt="예약하기 및 예약현황" /></a></li>
		<li><a href="/rsv/check.asp"><img src="/img/le_reser_<%=tagv(4)%>.gif" width="170" height="30" ID=rsv004 class="db" alt="예약확인 및 취소" /></a></li>-->
	</ul>
	<!-- #include virtual = "/inc/left/banner.asp" -->
</div>
