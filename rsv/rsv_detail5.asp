<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	shipid						= Request("shipid")
	tag							= 3
	If shipid = "" Then
		Call JSalert("선박정보가 없습니다.")
		Response.End
	End If
	yy							= Request("yy")
	If yy = "" Then
		yy = Year(Date)
	End If

	mm							= setp(Request("mm"))
	If mm = "" Then
		mm = setp(Month(Date))
	End If

	dd							= setp(Request("dd"))
	If dd = "" Then
		dd = setp(Day(Date))
	End If

	If yy <> "" And mm <> "" Then
		dt = CDate(yy &"-"& mm &"-01")
	Else
		dt = Date
	End If

	vdate = CDate(yy &"/"& mm &"/01")
	mcnt						= shipinfo(shipid,"capa") - guestCount(shipid,yy & mm & dd)
'	Response.Write "FID_AUTH : "& FID_AUTH &"<br>"
%>
<script type="text/JavaScript">
/* modal */
function popup1(rid){
	$.unoDialog({
		url: "rsv_pop5.asp?ridx="+ rid,
		dialogArguments: '',
		top: 0,
		width: 460,
		height: 360,
		scrollable: false,
		title: "예약정보확인",
		onClose: function() {
			if(this.returnValue == null) return;
		}
	});
}
</script>


<div id="wrap">
	<div>
		<ul>
			<li class="ib vt" style="width:230px;"><!-- #include virtual = "/inc/left/rsv.asp" --></li>
			<li class="ib vt">
				<div id="mainwrap4">
					<div class="mt20"><img src="/img/rsv_title.gif" width="197" height="24" alt="예약타이틀" /></div>
					<div class="mt10 mb10"><img src="/img/reser_list_tle.gif" width="239" height="18" title="낚시배예약"></div>
					<div style="width:810px; border:0px solid #000;" class="mb10">
						<ul>
							<li class="ct ib" style="width:100px; border:1px solid #ccc;"><a href="index.asp">전체</a></li>
<%
	rso()
	i = 0
	SQL = " SELECT shipid, shipnm FROM _oshpt010 "
	rs.open SQL, dbcon
	While Not rs.eof
%>
							<li class="ct ib" style="width:100px; border:1px solid #ccc;"><a href="?shipid=<%=rs("shipid")%>&yy=<%=yy%>&mm=<%=mm%>&dd=<%=dd%>"><%=rs("shipnm")%></a></li>
<%
		rs.MoveNext
		i = i + 1
	Wend
	rsc()
%>
						</ul>
					</div>

					<hr style="border:1px solid #ccc;">
					<div style="background:#f5f5f5;" class="pt5 pb5 pl20">
						<ul>
							<li style="width:150px;" class="ib ml20"><span class="f17 fb fc9"><%=shipinfo(shipid,"shipnm")%></span></li>
							<li class="ib vt"><span class="fcb">정원 <b><%=shipinfo(shipid,"capa0")%></b> 명(예약가능인원 <b><%=mcnt%></b> 명) | 주요출조 : <%=shipinfo(shipid,"chuljo0")%></span></li>
							<li class="ib vt fright"><span class="ff fc7 f17 ls pr10 fright"><b><%=yy%>-<%=mm%>-<%=dd%></b>&nbsp;&nbsp;<b class="f15 fc5 vt">(<%=getMool1(yy,mm,dd)%>)</b></span></li>
						</ul>
					</div>
					<hr style="border:1px solid #ccc;">
					<div class="mb10">
<%
	rso()
	SQL = " SELECT * FROM _orsvt010 WHERE rdate = '"& yy & mm & dd &"' AND shipid = "& shipid
	rs.open SQL, dbcon
	k = 1
	While Not rs.eof
		'N-대기중/C-예약완료/Y-출조완료/K-예약대기/X-예약취소
%>
						<div style="width:400px;" class="vt ib">
							<ul class="pt3 pb3">
								<li style="width:80px;" class="ib">
									<a href="#" onClick="return mpop5('rsv_pop5.asp?ridx=<%=rs("ridx")%>&shipid=<%=rs("shipid")%>','ev','center',460,328,0);"><b class="ls"><%=rs("rnm")%></b></a>
								</li>
								<li style="width:70px;" class="ib">
									<span class="f11 fc2 ls"><%=Left(rs("ddate"),10)%></span>
								</li>
								<li style="width:70px;" class="f11 fc8 ls ib"><%=rs("inwon")%> 명 예약</li>
								<li style="width:120px;" class="f11 ls ib">예약금 : <%=FormatNumber(rs("rmoney"),0)%> 원</li>
								<li style="width:40px;" class="ib rg">
<%		If rs("status") = "N" Then %>
									<img src="/img/box/bn_r.gif" width="36" height="17" class="vm" alt="예약" />
<%		ElseIf rs("status") = "K" Then %>
									<img src="/img/box/bn_s.gif" width="36" height="17" class="vm" alt="대기" />
<%		ElseIf rs("status") = "C" Or rs("status") = "Y" Then %>
									<img src="/img/box/bn_c.gif" width="36" height="17" class="vm" alt="완료" />
<%		ElseIf rs("status") = "X" Then %>
									<img src="/img/box/bn_x.gif" width="36" height="17" class="vm" alt="취소" />
<%		End If %>
								</li>
							</ul>
							<hr style="border:1px dotted #ccc;">
						</div>
<%
		k = k + 1
		rs.MoveNext
	Wend
	rsc()
%>
					</div>

					<!-- #include file = "calendar5.asp" -->

					<div class="ct">※ <b class="fc7">90일 이내</b>까지만 예약이 가능합니다. 다른 조사님들을 위해 예약은 신중하게 해 주시길 부탁드립니다.</div>
					<div class="pt20 pb20"></div>
				</div>
			</li>
			<li class="ib vt"><!-- #include virtual = "/inc/quick.asp" --></li>
		</ul>
	</div>
</div>
<!-- #include virtual = "/inc/footer.asp" -->
