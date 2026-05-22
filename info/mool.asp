<!-- #include virtual = "/inc/header.asp" -->
<%
	yy							= Request("yy")
	If yy = "" Then
		yy = Year(Date)
	End If

	mm							= Request("mm")
	If mm = "" Then
		mm = Month(Date)
	End If

	dd							= Request("dd")
	If dd = "" Then
		dd = Day(Date)
	End If

	If yy <> "" And mm <> "" Then
		dt = CDate(yy &"-"& mm &"-01")
	Else
		dt = Date
	End If
%>

<script language="javascript">
<!--
function goPrint() {
	alert("프린터 기본 설정에서 [가로] 출력을 선택하세요.");
	window.print();
}
function printWindow() {
	factory.printing.header = "";					//머릿말 설정
	factory.printing.footer = "";					//꼬릿말 설정
	factory.printing.portrait = true;				//출력방향 설정: true-가로, false-세로
	factory.printing.leftMargin = 1.0;				//왼쪽여백
	factory.printing.topMargin = 25.0;				//상단여백
	factory.printing.rightMargin = 1.0;				//우측여백
	factory.printing.bottomMargin = 0.0;			//하단여백
	factory.printing.Print(false, window)
}
//-->
</script>

<table width="800" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" align="center">
<object id="factory" viewastext style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814" codebase="/inc/smsx.cab#Version=6,5,439,50"></object>

<form name="fm1" method="post">
<input type="hidden" name="yy" value="<%=yy%>">
<input type="hidden" name="mm" value="<%=mm%>">
<input type="hidden" name="dd" value="<%=dd%>">

	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top">

			<!-- 달력 시작 -->
			<table width="805" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="ct">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
							<tr>
								<td width="170"><img src="/img/box/ad01.png" width="170"></td><!-- 230-168 -->
								<td class="ct">
									<div>
										<a href="?yy=<%=Year(dt-1)%>&mm=<%=Month(dt-1)%>&dd=01" class="btn btn21"><span><<</span></a>
										&nbsp;&nbsp;
										<font class="ff fb fcb ls3 vm" style="font-size:40px;"><%=yy%> . <%=setp(mm)%></font>
										&nbsp;&nbsp;
										<a href="?yy=<%=Year(dt+31)%>&mm=<%=Month(dt+31)%>&dd=01" class="btn btn21"><span>>></span></a>
									</div>
									<div style="padding-top:30px;"><a href="javascript:printWindow();" class="btn btn25"><span>출력</span></a></div>
								</td>
								<td width="170"><img src="/img/box/ad02.png" width="170"></td>
							</tr>
						</table>
					</td>
				</tr><!--
				<tr height="40">
					<td>
						<table border="0" cellspacing="0" cellpadding="0" align="center">
							<tr>
								<td width="200">&nbsp;</td>
								<td width="398" class="ct">
									<a href="?yy=<%=Year(dt-1)%>&mm=<%=Month(dt-1)%>&dd=01" class="btn btn25"><span>이전달</span></a>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<font class="ff fb f19 fcb ls vm"><%=yy%> . <%=setp(mm)%></font>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="?yy=<%=Year(dt+31)%>&mm=<%=Month(dt+31)%>&dd=01" class="btn btn25"><span>다음달</span></a>
								</td>
								<td width="200" class="rg"><a href="javascript:printWindow();" class="btn btn25"><span>출력</span></a></td>
							</tr>
						</table>
					</td>
				</tr> -->
			</table>

			<table width="798" border="1" cellspacing="0" cellpadding="0" bordercolor="#d5c4b9" style="border-collapse:collapse;">
				<tr>
					<td><img src="/img/rsv/sun.gif" width="114" height="30"></td>
					<td><img src="/img/rsv/mon.gif" width="114" height="30"></td>
					<td><img src="/img/rsv/tue.gif" width="114" height="30"></td>
					<td><img src="/img/rsv/wed.gif" width="114" height="30"></td>
					<td><img src="/img/rsv/thu.gif" width="114" height="30"></td>
					<td><img src="/img/rsv/fri.gif" width="114" height="30"></td>
					<td><img src="/img/rsv/sat.gif" width="114" height="30"></td>
				</tr>
<%
		dt						= yy &"-"& setp(mm) &"-01"
		first_day				= Weekday(dt)
		col						= 0
%>
				<tr>
<%
		col						= col + 1
		For i = 1 To first_day - 1
%>
					<td bgcolor="#ffffff"></td>
<%
			col = col + 1
		Next

		For i = 1 To calc_last_day(yy, mm)
			sun_date = yy &"-"& mm &"-"& i
			color_td = "#ffffff"
			If IsDate(sun_date) Then
				If Year(sun_date) = Year(Now()) And Month(sun_date) = Month(Now()) And Day(sun_date) = Day(Now()) Then
					color_td = "#f7f3f7"
				End If
			End If
%>
					<td bgcolor=<%=color_td%> valign="top">
<%
			color_chk = "black"
			If col = 1 Then
				color_chk = "red"
			ElseIf col = 7 Then
				color_chk = "blue"
			End If
%>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" id="table2">
							<tr>
								<td width="114">
									<table id="bxList">
										<tr>
											<td class="pt5">&nbsp;<b class="ff f25 ls" style="color:<%=color_chk%>"><%=i%></b></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr height="40">
								<td width="114" valign="top" style="word-break:all">
<%
			dbo()
			rso()
			SQL = " SELECT	yy, mm, dd, op1, op2, op3, op4, moon, mtime1, mtime7, mtime8 " _
				& " FROM	mooltime " _
				& " WHERE	yy = '"& yy &"' AND mm = '"& setp(mm) &"' AND dd = '"& setp(i) &"' "
			rs.open SQL, dbcon
			If Not (rs.eof And rs.bof) Then
				k = 1
				Do Until rs.EOF
					mool = rs("mtime8")
'					If mool = "조금" Then
'						mool = "<b class='fcr'>조금</b>"
'					Else
'						mool = "<b class='fc9'>"& mool &"</b>"
'					End If
%>
									<table width="114" border="0" cellspacing="0" cellpadding="0" class="lf">
										<tr>
											<td height="30">
												<span class="ff fc1 f11 pl5 ls"><%=rs("moon")%>&nbsp;&nbsp;|&nbsp;&nbsp;<%=mool%></span>
											</td>
										</tr>
										<tr>
											<td>
												<span class="ff fc3 f12 pl5 ls"><%=rs("op1")%></span>
											</td>
										</tr>
										<tr>
											<td>
												<span class="ff fc3 f12 pl5 ls"><%=rs("op2")%></span>
											</td>
										</tr>
										<tr>
											<td>
												<span class="ff fc3 f12 pl5 ls"><%=rs("op3")%></span>
											</td>
										</tr>
										<tr>
											<td>
												<span class="ff fc3 f12 pl5 ls"><%=rs("op4")%></span>
											</td>
										</tr>
										<tr>
											<td height="5"></td>
										</tr>
									</table>
<%
					rs.MoveNext
					k = k + 1
				Loop
			Else
%>
									<table width="114" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>&nbsp;</td>
										</tr>
									</table>
<%
			End If
			rsc()
%>
								</td>
							</tr>
						</table>
					</td>
<%			If col = 7 Then %>
				</tr>
<%
				col = 0
			End If
			col = col + 1
		Next
		Do Until col = 8
%>
					<td bgcolor="#ffffff"></td>
<%
			col = col + 1
		Loop
%>
			</table>
			<!-- 달력 끝 -->

					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>
<div id="upload" style="top:0; left:0; width:220px; height:50px; position:absolute; visibility:hidden; z-index:10;">
<table width="430" border="0" cellspacing="0" cellpadding="0">
	<tr height="300" bgcolor="#ffffff">
		<td align="center"><img src="/img/icon/loader05.gif"></td>
	</tr>
</table>
</div>
<%
	Set cx = Nothing
%>
<!-- #include virtual = "/inc/footer.asp" -->