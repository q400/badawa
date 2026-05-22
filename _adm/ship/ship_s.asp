<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	shipid						= Request("shipid")
	If shipid = "" Then
		shipid = "2"
	End If
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
'	Response.Write "FID_AUTH : "& FID_AUTH &"<br>"
%>

<script language="JavaScript">
<!--
function writeKeyDown(){
	if(event.keyCode == 13)	goSearch();
}
function up(value){								//Mouse Up Event
	var arrValue = value.split("-");
	endtime = arrValue[0];							//변경후 일자
	doing();
}
function down(value){								//Mouse Down Event
	var arrValue = value.split("-");
	starttime = arrValue[0];						//변경전 일자
	rix = arrValue[1];								//ridx
}
function doing(){									//Mouse Up 했을때 동작
	var f = document.fm1;
	if(starttime == endtime){
//		alert("같은 일자로 옮기는건 의미가 없습니다.       ");
//		return false;
	}else{
//		if(rsv01 != ""){
//			alert("옮기려는 시간대에 이미 스케쥴이 있습니다.          ");
//			return false;
//		}else if(rsv02 == ""){
//			alert("옮길 스케쥴이 없습니다.          ");
//			return false;
//		}else{
			if(confirm("예약번호 ["+ rix +"] 를 "+ starttime +"일에서 "+ endtime +"일로 옮기겠습니까?         ")){
				f.action = "rsv_move.asp?shipid=<%=shipid%>&ridx="+ rix +"&day01="+ starttime +"&day02="+ endtime;
				f.method = "post";
				f.submit();
			}
//		}
	}
}
//-->
</script>


<body oncontextmenu="return true" onselectstart="return false" ondragstart="return false">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="68" align="center" valign="top"><!-- #include virtual = "/_adm/inc/top.asp" --></td>
	</tr>
	<tr>
		<td height="11"></td>
	</tr>
	<tr>
		<td align="center" valign="top">
			<table width="1040" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="176" valign="top"><!-- #include virtual = "/_adm/inc/left.asp" --></td>
					<td width="10"></td>
					<td width="854" valign="top">

<form name="fm1">
<input type="hidden" name="page" value="<%=page%>">

						<table width="854" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="854" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td><img src="/img/adm/box01.gif" width="854" height="14"></td>
										</tr>

										<tr>
											<td align="center" background="/img/adm/box03.gif">&nbsp;</td>
										</tr>
										<tr>
											<td height="10" background="/img/adm/box03.gif"></td>
										</tr>

										<tr>
											<td align="center" background="/img/adm/box03.gif">
												<table width="810" border="0" cellspacing="0" cellpadding="0">
													<tr>
<%
	rso()
	SQL = " SELECT shipid, shipnm, captain, sz, capa, speed, equip, tel, hp, homp, bank, acc, ddate, active_yn, memo FROM _oshpt010 "
	rs.open SQL, dbcon
	While Not rs.eof
%>
														<td class="fb ct ls"><a href="?shipid=<%=rs("shipid")%>"><%=rs("shipnm")%></a></td>
<%
		rs.MoveNext
	Wend
	rsc()
%>
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td align="center" background="/img/adm/box03.gif" height="10"></td>
										</tr>

										<tr>
											<td height="2" align="center" background="/img/adm/box03.gif">
												<table width="800" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="2" bgcolor="#666666"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td align="center" background="/img/adm/box03.gif">
												<table width="800" border="0" cellspacing="0" cellpadding="0" align="center" bordercolor="#CCCCCC" style="border-collapse:collapse;">
													<tr>
														<td align="center">
			<!-- 달력 시작 -->
			<table width="798" border="0" cellspacing="0" cellpadding="0">
				<tr height="40">
					<td width="150" class="fcb fb lf"><%=shipinfo(shipid,"shipnm")%> 선박일정관리</td>
					<td>
						<table border="0" cellspacing="0" cellpadding="0" align="center">
							<tr>
								<td>
									<a href="?shipid=<%=shipid%>&yy=<%=Year(dt-1)%>&mm=<%=Month(dt-1)%>&dd=01" class="btn btn21"><span>이전달</span></a>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<font class="ff fb f15 fcb ls"><%=yy%> . <%=setp(mm)%></font>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="?shipid=<%=shipid%>&yy=<%=Year(dt+31)%>&mm=<%=Month(dt+31)%>&dd=01" class="btn btn21"><span>다음달</span></a>
								</td>
							</tr>
						</table>
					</td>
					<td width="150" class="rg"><a href="ship.asp" class="btn btn21"><span>목록</span></a></td>
				</tr>
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

		j						= CDbl(0)
		jj						= 10000

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
								<td width="114" valign="top" height="20">
									<table id="table3">
										<tr>
											<td>
												<a href="#" onClick="return mpop5('ship_i.asp?shipid=<%=shipid%>&yy=<%=yy%>&mm=<%=setp(mm)%>&dd=<%=setp(i)%>','ev','center',600,200,0);" class="ff fb" style="color:<%=color_chk%>"><%=i%></a>
											</td>
											<td align="right">
<%
			If col = 7 Then
			Else
				Response.write "&nbsp;"
			End If
%>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr height="40">
								<td width="114" valign="top" style="word-break:all">
<%
			qDate = yy & setp(mm) & setp(i)

			Set rsv = Server.CreateObject("ADODB.Recordset")
			SQL = " SELECT	idx, shipid, rdate, note " _
				& " FROM	_oshpt020 " _
				& " WHERE	rdate = '"& qDate &"' AND shipid = "& shipid _
				& " ORDER BY ddate ASC "
			rsv.open SQL, dbcon, 0, 3
			If Not (rsv.eof And rsv.bof) Then
				k = 1
				Do Until rsv.EOF
					If rsv("note") = "마감" Or rsv("note") = "정비" Or rsv("note") = "탐사" Or rsv("note") = "취소" Then
						sc_font = "#ff0000"
					Else
						sc_font = "#909090"
					End If
%>
									<table width="114" border="0" cellspacing="0" cellpadding="0" onMouseUp="return up('<%=i%>-<%=rsv("idx")%>');" onMouseDown="down('<%=i%>-<%=rsv("idx")%>');" title="<%=i%>-<%=rsv("idx")%>">
										<tr>
											<td>
												<span align="center" valign="top" class="fcb f11 p2">
												<a href="#" onClick="return mpop5('ship_i.asp?shipid=<%=shipid%>&idx=<%=rsv("idx")%>&yy=<%=yy%>&mm=<%=setp(mm)%>&dd=<%=setp(i)%>','ev','center',600,200,0);">
												<font color="<%=sc_font%>"><%=rsv("note")%></font></a></span>
											</td>
										</tr>
									</table>
<%
					rsv.MoveNext
					k = k + 1
				Loop
			Else
%>
									<table width="114" border="0" cellspacing="0" cellpadding="0" onMouseUp="return up('<%=i%>');" onMouseDown="down('<%=i%>');" title="<%=i%>">
										<tr>
											<td>&nbsp;</td>
										</tr>
									</table>
<%
			End If
			Set rsv = Nothing
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
												</table>
											</td>
										</tr>
										<tr>
											<td height="10" background="/img/adm/box03.gif"></td>
										</tr>
										<tr>
											<td align="center" background="/img/adm/box03.gif">
												<font class="fc5">■</font> 대기자
												<font class="fcb">■</font> 예약확정자
											</td>
										</tr>
										<tr>
											<td height="10" background="/img/adm/box03.gif"></td>
										</tr>
										<tr>
											<td><img src="/img/adm/box02.gif" width="854" height="14"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
						</table>
</form>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="50"><!-- #include virtual = "/_adm/inc/footer.asp" --></td>
	</tr>
</table>
</body>
<%	Set cx = Nothing %>
