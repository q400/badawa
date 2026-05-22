<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	Dim isMobile
	isMobile = False
	op = Request("op")

	Function mobile_device_detect()
		Dim sUserAgent, ArrBrowser, CompareAgent
		Dim i,Us,Ds,Qs
		sUserAgent = Request.ServerVariables("HTTP_USER_AGENT")
		ArrBrowser = Array("iPhone", "iPod", "IEMobile", "Mobile", "lgtelecom", "PPC", "BlackBerry", "SCH-", "SPH-", "LG-", "CANU", "IM-" ,"EV-","Nokia")

		For i = 0 To Ubound(ArrBrowser)
			CompareAgent = ArrBrowser(i)
			If (InStr(sUserAgent, CompareAgent)) <> 0 Then		'모바일 경우
				isMobile = True
			End If
		Next
		mobile_device_detect = isMobile
	End Function

'	If op <> "pc" Then
'		Response.Write "value : "& mobile_device_detect() &"<br>"
		If mobile_device_detect() = True Then
			Us = "https://www.badawa.co.kr/m/_adm/rsv/"			'Mobile 예약메인 2025.01.04
			Ds = "?"
			If InStr(1,Us,"?") > 0 Then
				Ds = "&"
			End If
			Qs = Request.ServerVariables("QUERY_STRING")
'			Response.Write "value : "& Qs &"<br>"
			If Len(Qs)>0 Then
				Qs = Ds&Qs
			End If
			Us = Us&Qs
			Response.Redirect Us
		End If
'	End If


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
	mm							= setp(mm)

	dd							= Request("dd")
	If dd = "" Then
		dd = Day(Date)
	End If

	If yy <> "" And mm <> "" Then
		dt = CDate(yy &"-"& mm &"-01")
	Else
		dt = Date
	End If
	Response.Write "FID_AUTH : "& FID_AUTH &"<br>"
%>

<script type="text/JavaScript">
function writeKeyDown(){
	if(event.keyCode == 13)	goSearch();
}
function up(value){			//Mouse Up Event
	var arrValue = value.split("-");
	endtime = arrValue[0];	//변경후 일자
	doing();
}
function down(value){		//Mouse Down Event
	var arrValue = value.split("-");
	starttime = arrValue[0];	//변경전 일자
	rix = arrValue[1];			//ridx
}
function doing(){			//Mouse Up 했을때 동작
	var f = document.fm1;
	if(starttime == endtime){
//		alert("같은 일자로 옮기는건 의미가 없습니다.");
//		return false;
	}else{
//		if(rsv01 != ""){
//			alert("옮기려는 시간대에 이미 스케쥴이 있습니다.");
//			return false;
//		}else if(rsv02 == ""){
//			alert("옮길 스케쥴이 없습니다.");
//			return false;
//		}else{
			if(confirm("예약번호 ["+ rix +"] 를 "+ starttime +"일에서 "+ endtime +"일로 옮기겠습니까?")){
				f.action = "rsv_move.asp?shipid=<%=shipid%>&ridx="+ rix +"&day01="+ starttime +"&day02="+ endtime;
				f.method = "post";
				f.submit();
			}
//		}
	}
}
function chkOK(idx){
	var f = document.fm1;
	var msg = "출조가 이루어진 것으로 하여 모든 예약을 마칩니다.";
	if(confirm(msg)){
		f.ridx.value = idx;
		f.action = "rsv_ok.asp";
		f.method = "post";
//		f.target = "nullframe";
		f.submit();
	}
}
function goRsv(sid, yy, mm, dd){
	$(".loader").show();
	this.document.location.href = "?shipid="+ sid +"&yy="+ yy +"&mm="+ mm +"&dd="+ dd;
}
function unoPOP(rid, yy, mm, dd, sid, gubn){
	var url = "";
	var title = "예약정보";
	var wt, ht = "0";

	if(gubn == 1){			//예약신규등록
		url = "rsv_w.asp?ridx="+ rid;
		title = "예약신규등록";
		wt = 750;
		ht = 500;
	}else if(gubn == 2){	//예약확인
		url = "rsv_m.asp?ridx="+ rid;
		title = "예약확인 및 수정";
		wt = 750;
		ht = 600;
	}else if(gubn == 5){	//point 적립
		url = "rsv_end.asp?ridx="+ rid;
		title = "출조자 포인트 적립";
		wt = 500;
		ht = 330;
	}else if(gubn == 7){	//공지
		url = "notice.asp?idx="+ rid;
		title = "공지사항";
		wt = 600;
		ht = 280;
	}else if(gubn == 9){	//선박상태확인
		url = "/_adm/ship/ship_i.asp?idx="+ rid;
		title = "선박상태확인 및 수정";
		wt = 600;
		ht = 280;
	}
	$.unoDialog({
		url: url + "&shipid="+ sid +"&yy="+ yy +"&mm="+ mm +"&dd="+ dd,
		dialogArguments: '',
		top: 0,
		width: wt,
		height: ht,
		scrollable: false,
		title: title,
		onClose: function(){
			if(this.returnValue == null) return;
		}
	});
}
</script>


<body oncontextmenu="return true" onselectstart="return false" ondragstart="return false">
<form name="fm1">
<input type="hidden" name="shipid" value="<%=shipid%>">
<input type="hidden" name="yy" value="<%=yy%>">
<input type="hidden" name="mm" value="<%=mm%>">
<input type="hidden" name="dd" value="<%=dd%>">
<input type="hidden" name="ridx">
<div id="wrap">
	<div>
		<!-- #include virtual = "/_adm/inc/top.asp" -->
	</div>
	<center>
		<div id="admwrap0">
			<div class="ib vt" id="admLeft"><!-- #include virtual = "/_adm/inc/left.asp" --></div>
			<div class="ib vt" id="admwrap1">
				<div id="poptitle2">
					<div class="lf mt5">
<%
	rso()
	SQL = " SELECT	shipid, shipnm, captain, sz, capa, speed, equip, tel, hp, homp, bank, acc, ddate, active_yn, memo " _
		& " FROM	_oshpt010 "
	rs.open SQL, dbcon
	While Not rs.eof
%>
						<a href="javascript:;" onclick="goRsv(<%=rs("shipid")%>, '', '', '')" class="f13 mr10 ls" title="<%=rs("shipid")%>">
						<%If rs("shipid") = CInt(shipid) Then%><b class="fcr"><%=rs("shipnm")%></b><%Else%><span class="fc2"><%=rs("shipnm")%></span><%End If%>
						</a>
<%
		rs.MoveNext
	Wend
	rsc()
%>
					</div>
					<hr style="border:1px solid #ccc;">
					<div width=100% class="lf">
						<ul>
							<li style="width:30%;" class="f15 fb lf ib ls"><%=shipinfo(shipid,"shipnm")%> 예약관리</li>
							<li style="width:100px;" class="ct ib">
								<a href="javascript:;" onclick='goRsv("<%=shipid%>", "<%=Year(dt-1)%>", "<%=Month(dt-1)%>", "01")' class="btn btn25"><span>이전달</span></a>
							</li>
							<li style="width:100px;" class="f17 ct ib"><b><%=yy%> . <%=mm%></b>
							<li style="width:100px;" class="ct ib">
								<a href="javascript:;" onclick='goRsv("<%=shipid%>", "<%=Year(dt+31)%>", "<%=Month(dt+31)%>", "01")' class="btn btn25"><span>다음달</span></a>
							</li>
							<li style="" class="ib frt">
<%
	If FID_ID = "master" Then
%>
								<a href="rsv.asp" class="btn btn25"><span>목록보기</span></a>
<%
	End If
%>
								<a href="javascript:;" onclick='goRsv("<%=shipid%>", "<%=yy%>", "<%=mm%>", "<%=dd%>")'" class="btn btn25"><span>새로고침</span></a>
							</li>
						</ul>
					</div>
					<div>
						<table width=100% cellspacing=0 cellpadding=0 border=1 style="border-collapse:collapse; border:1px solid #dcb;">
							<tr height="20">
								<td width=15% class="fcr ct">SUN</td>
								<td width=14% class="fcb ct">MON</td>
								<td width=14% class="fcb ct">TUE</td>
								<td width=14% class="fcb ct">WED</td>
								<td width=14% class="fcb ct">THU</td>
								<td width=14% class="fcb ct">FRI</td>
								<td width=15% class="fcu ct">SAT</td>
							</tr>
<%
		dt						= yy &"-"& mm &"-01"
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

'		j					= CDbl(0)
'		jj					= 10000

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

			rso()
			SQL = " SELECT ISNULL(COUNT(*),0) FROM _onott010 WHERE shipid = "& shipid &" AND rdate = '"& yy & mm & setp(i) &"' "
			'Response.Write SQL &"<br>"
			rs.open SQL, dbcon
				mcnt = CInt(rs(0))
			rsc()
			If mcnt = 0 Then
				class9 = "f11 fc6"
			Else
				class9 = "f11 fc5"
			End If
%>
									<table width="100%" cellspacing="0" cellpadding="0" id="table2">
										<tr>
											<td height="20">
												<span class="fleft">&nbsp;
													<a href="javascript:;" onclick="unoPOP('','<%=yy%>','<%=mm%>','<%=setp(i)%>','<%=shipid%>',9); return false;" class="ff f15 fb" style="color:<%=color_chk%>"><%=i%></a>
													<a href="javascript:;" onclick="unoPOP('','<%=yy%>','<%=mm%>','<%=setp(i)%>','<%=shipid%>',1); return false;"><b class="ff f15 fc7 fb">＋</b></a>
												</span>
												<span class="fright vm pt2">
													<a href="javascript:;" onclick="unoPOP('','<%=yy%>','<%=mm%>','<%=setp(i)%>','<%=shipid%>',7); return false;" class="<%=class9%>">공지</font></a>
													<a href="excelBook.asp?shipid=<%=shipid%>&yy=<%=yy%>&mm=<%=mm%>&dd=<%=setp(i)%>"><img src="/img/adm/doc.gif" title="출항명부" class="vm"></a>
													<a href="excelStat01.asp?yy=<%=yy%>&mm=<%=mm%>&dd=<%=setp(i)%>">
													<img src="/img/adm/doc.gif" title="출조예약 현황표" class="vm" onclick="alert('인쇄시 인쇄미리보기-페이지설정-여백에서 좌우 여백을 1.0 으로 줄이세요.')"></a>
													&nbsp;
												</span>
											</td>
										</tr>
										<tr>
											<td class="fcb f11 ct">
												<span class="fcr ff ls"><%=shipinfo(shipid,"capa") - guestCount(shipid,yy & mm & setp(i))%> (<font class="fc9"><%=getMool1(yy,mm,setp(i))%></font>)</span>
											</td>
										</tr>
										<tr height="90">
											<td style="word-break:all;" class="vt mb10"><!-- 예약자 목록 부분 -->
<%
			qDate = yy & mm & setp(i)

			rso()
			SQL = " SELECT	ridx, rdate, uno, rnm, inwon, tel, hp, email, shipid, gubn, status, rmoney, pwd, uip, ddate, memo " _
				& " FROM	_orsvt010 " _
				& " WHERE	rdate = '"& qDate &"' AND shipid = "& shipid _
				& " ORDER BY ddate ASC "
			rs.open SQL, dbcon, 0, 3

			If Not (rs.eof And rs.bof) Then
				'ship = "& shipid &" AND
				k = 1
				Do Until rs.EOF
					'N-대기중/C-예약완료/Y-출조완료/K-예약대기/X-예약취소
%>
												<table width="99%" border=0 cellspacing=0 cellpadding=0 class="lf" onMouseUp="return up('<%=i%>-<%=rs("ridx")%>');"
												onMouseDown="down('<%=i%>-<%=rs("ridx")%>');" title="<%=i%>-<%=rs("ridx")%>">
													<tr>
														<td>
															<span class="pl5 vt ct" style="line-height:14px;">
<%					If rs("status") = "N" Then '대기자 %>
															<a href="javascript:;" onclick="unoPOP('<%=rs("ridx")%>','<%=yy%>','<%=mm%>','<%=setp(i)%>','<%=shipid%>',2); return false;" class="f11 ls">
															[<%=shipInfo(rs("shipid"),"shipnm")%>]&nbsp;<font class="fc5"><blink><%=rs("rnm")%>&nbsp;(<%=rs("inwon")%>)</blink></font></a>
<%					ElseIf rs("status") = "Y" Then '출조완료 %>
															<a href="javascript:;" onclick="unoPOP('<%=rs("ridx")%>','<%=yy%>','<%=mm%>','<%=setp(i)%>','<%=shipid%>',2); return false;" class="f11 ls">
															<font class="fc2"><%=rs("rnm")%>&nbsp;(<%=rs("inwon")%>)</font></a>
															<!-- <input type="checkbox" name="realchk" value="N" onclick="chkOK(<%=rs("ridx")%>)" class="vm" style="width:10px;height:15px;"> -->
<%					ElseIf rs("status") = "X" Then '취소자 %>
															<a href="javascript:;" onclick="unoPOP('<%=rs("ridx")%>','<%=yy%>','<%=mm%>','<%=setp(i)%>','<%=shipid%>',2); return false;" class="f11 ls">
															<font class="fc3">[취소]<%=rs("rnm")%>&nbsp;(<%=rs("inwon")%>)</font></a>
<%					ElseIf rs("status") = "K" Then '예약대기자%>
															<a href="javascript:;" onclick="unoPOP('<%=rs("ridx")%>','<%=yy%>','<%=mm%>','<%=setp(i)%>','<%=shipid%>',2); return false;" class="f11 ls">
															<font class="fc8">[대기]<%=rs("rnm")%>&nbsp;(<%=rs("inwon")%>)</font></a>
<%					ElseIf rs("status") = "C" Then '예약완료 %>
															<input type="checkbox" name="realchk" id="realchk" value="Y" onclick="unoPOP('<%=rs("ridx")%>','<%=yy%>','<%=mm%>','<%=setp(i)%>','<%=shipid%>',5); return false;"
															class="vm" style="height:11px;margin:0 -3px 0 -5px;" title="출조가 확인되면 체크해 주세요.">
															<a href="javascript:;" onclick="unoPOP('<%=rs("ridx")%>','<%=yy%>','<%=mm%>','<%=setp(i)%>','<%=shipid%>',2); return false;" class="f11 ls">
															<font class="fc2"><%=rs("rnm")%>&nbsp;(<%=rs("inwon")%>)</font></a>
															<!-- <input type="checkbox" name="realchk" value="Y" onclick="chkOK(<%=rs("ridx")%>)" class="vm" style="height:9px;" title="출조가 확인되면 체크해 주세요."> -->
<%					End If %>
															</span>
														</td>
													</tr>
												</table>
<%
					rs.MoveNext
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
			rsc()
%>


<%
			rso()
			SQL = " SELECT idx, shipid, note, etc, ddate FROM _oshpt020 WHERE rdate = '"& qDate &"' AND shipid = "& shipid
			rs.open SQL, dbcon
			If Not rs.eof Then
				Do Until rs.eof
					If rs("etc") = "3" Then				'탐사/정비/마감
						sc_font = "#aa44aa"
					Else								'나머지(정상출조)
						sc_font = "blue"
					End If
%>
												<table width="114" border="0" class="lf" cellspacing="0" cellpadding="0">
													<tr>
														<td class="pl5">
<%					'If rs("etc") = "3" Then				'탐사/정비/마감 %>
															<a href="javascript:;" onclick="unoPOP('<%=rs("idx")%>','<%=yy%>','<%=mm%>','<%=setp(i)%>','<%=shipid%>',9); return false;" title="<%=rs("note")%>" class="f11 fb">
															[<%=shipinfo(rs("shipid"),"shipnm")%>]&nbsp;<font color="<%=sc_font%>"><%=rs("note")%></a>
<%					'Else %>
															<!--<a href="#" onclick="return mpop5('sche_pop.asp?schIdx=<%=rs("shipid")%>','ev','center',460,328);" title="<%=rs("note")%>" class="f11 ls">
															[<%=shipinfo(rs("shipid"),"shipnm")%>]&nbsp;<font color="<%=sc_font%>"><%=rs("note")%></a>//-->
<%					'End If %>
														</td>
													</tr>
												</table>
<%
					rs.MoveNext
				Loop
			End If
			now_cnt = 0
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
					</div>
					<div class="lf mt10 mb5">
						<font class="fc5">■&nbsp;&nbsp;정상예약</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<font class="fc2">■&nbsp;&nbsp;예약확정</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<font class="fc8">■&nbsp;&nbsp;대기신청</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<font class="fc10">■&nbsp;&nbsp;대기변경</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<font class="fc3">■&nbsp;&nbsp;취소</font>
					</div>
					<div class="lf mt5 mb20">
						※ <font class="fc6">공지</font>를 클릭하여 [긴급한줄공지]를 남길 수 있고 공지가 있으면 보라색 <font class="fc5">공지</font>로 보입니다.
					</div>
				</div>
				<!-- poptitle2 E -->
			</div>
			<!-- admwrap2 E -->
		</div>
	</center>
	<div>
		<!-- #include virtual = "/_adm/inc/footer.asp" -->
	</div>
</div>
</form>
<%	Set cx = Nothing %>
