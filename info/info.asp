<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	cd1							= SQLI(Request("cd1"))			'검색조건
	cd2							= SQLI(Request("cd2"))			'검색단어
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))
	setsize						= 10							'보여지는 페이지 수
	pgsize						= 50							'보여지는 게시물 수
	tag							= 1

	If cd1 = "" Then cd1 = "shipnm"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If

	If cd2 <> "" Then					'검색조건이 있는 경우
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' AND active_yn = 1 "
	Else								'검색조건이 없는 경우
		param = " WHERE active_yn = 1 "
	End If

	'게시물 개수
	rso()
	SQL = " SELECT	COUNT(*) FROM _oshpt010 "& param
	rs.open SQL, dbcon
		recordcount				= CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1

	dd = setp(Day(Date + 1))
	mm = setp(Month(Date))
	If mm = 13 Then
		yy = Year(Date) + 1
	Else
		yy = Year(Date)
	End If

	If mm = 13 Then mm = "01"			'다음달이 13이면 1월로 처리
%>

<!-- jQuery Plugin scripts -->
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-core.css" media="screen, projection" />
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-info-ship.css" media="screen, projection" />
<!--
<script type="text/javascript" src="/lib/js/external/_oldies/jquery-1.3.min.js"></script>
//-->
<script type="text/javascript" src="/lib/js/external/jquery.easing.1.3.min.js"></script>
<script type="text/javascript" src="/lib/js/external/jquery.mousewheel.min.js"></script>

<!-- Site styles -->
<!-- <link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-site.css" media="screen, projection" /> -->

<script type="text/javascript" src="/lib/js/sliderkit/jquery.sliderkit.1.9.2.pack.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.delaycaptions.1.1.pack.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.counter.1.0.pack.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.timer.1.0.pack.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.imagefx.1.0.pack.js"></script>

<!-- Slider Kit launch -->
<script type="text/javascript">
$(window).load(function(){ //$(window).load() must be used instead of $(document).ready() because of Webkit compatibility
	// Multiple sliders gallery
	$(".photoslider-1click").sliderkit({
		auto:false,
		circular:true,
		panelclick:true,
		mousewheel:true,
		panelfx:"sliding",
		panelfxspeed:400
	});
});
</script>
<script language="JavaScript">
<!--
function goSearch(){
	var f = document.fm1;
	f.action = "info.asp";
	f.method = "post";
	f.submit();
}

function unoPOP(sid, gubn){
	var urllink = "";
	var title = "선박정보";
	var wt, ht = "0";

	if(gubn == 1){			//선박정보
		urllink = "info_ship.asp?shipid="+ sid;
		title = "선박정보";
		wt = 1150;
		ht = 760;
	}
	$.unoDialog({
		url: urllink,
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
//-->
</script>


<form name="fm1">
<input type="hidden" name="shipid">
<input type="hidden" name="page" value="<%=page%>">
<div id="wrap">
	<div>
		<ul>
			<li class="ib vt" style="width:230px;"><!-- #include virtual = "/inc/left/info.asp" --></li>
			<li class="ib vt">
				<div id="mainwrap4">
					<div class="mt20"><img src="/img/info_tle.gif" width="209" height="24" alt="낚시배소개" /></div>
					<div class="mt10 mb5"><img src="/img/info_boat_tle.gif" width="166" height="18" title="선박소개"></div>
					<div><img src="/img/info_sul.gif" alt="설명1"></div>
					<span>
						<img src="/img/bbs_line02.gif" width="810" height="5" class="db" alt="라인" />
					</span>

					<div style="width:810px; height:100%; border:0px solid #000;">
<%
		rso()
		SQL = " SELECT * FROM _oshpt010 "& param & " ORDER BY shipid ASC "
		rs.open SQL, dbcon, 0, 3
		j = recordcount

		If Not (rs.eof And rs.bof) Then
			If page <> 1 Then
				j = j - (page - 1) * pgsize
			End If

			i = 1
			rs.MoveFirst
			Do Until rs.EOF
%>
						<div class="mt10 ib" style="position:relative; width:400px; height:100%; border:0px solid #c00;">
							<div style="width:153px; height:100%; float:left;">
								<div class="multiple-sliders-1">
									<div class="multiple-sliders-part-1">
										<!-- start photos slider -->
										<div class="sliderkit photoslider-1click">
											<div class="sliderkit-panels">
<%
				Set rs3 = Server.CreateObject("ADODB.Recordset")
				SQL = " SELECT idx, shipid, fpath, fnm, fwd, fsz, ext, comment FROM _oshpt011 WHERE shipid = "& rs("shipid") &" ORDER BY idx "
				rs3.open SQL, dbcon
				While Not rs3.eof
%>
												<div class="sliderkit-panel">
													<!-- <a href="#" onClick="return mpop5('info_ship.asp?shipid=<%=rs("shipid")%>','ev','center',1150,700,0);"> -->
													<img src="<%=rs3("fpath") &"/thumb/"& rs3("fnm")%>.gif" title="<%=rs3("comment")%>" />
												</div>
<%
					rs3.MoveNext
				Wend
				rs3.close
%>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div style="width:237px; height:100%; float:right;">
								<div style="">
									<a href="javascript:;" onClick="unoPOP('<%=rs("shipid")%>',1); return false;"><font class="fb f14 fcb"><%=rs("shipnm")%></font></a>
									<!-- <a href="#" onClick="return mpop5('info_ship.asp?shipid=<%=rs("shipid")%>','ev','center',1150,760,0);"><font class="fb f14 fcb"><%=rs("shipnm")%></font></a> -->
									<font class="fc2 ib">(선장: <%=rs("captain")%>)</font>
								</div>
								<div style="width:100%; height:50%;">
									<ul style="width:230px; height:23px">
										<li style="width:23px;" class="ib"><img src="/img/icon_ton.gif" width="20" height="23" alt="선박크기" title="선박크기" /></li>
										<li style="width:83px;" class="fc2 ib"><%=rs("sz")%> t</li>
										<li style="width:30px;" class="ib"><img src="/img/icon_per.gif" width="26" height="23" alt="예약인원" title="예약인원" /></li>
										<li style="width:83px;" class="fc2 ib"><%=rs("capa")%>명</li>
									</ul>
									<!-- <hr style="border:1px dotted #ccc;"> -->
									<ul style="width:230px; height:23px">
										<li style="width:23px;" class="ib"><img src="/img/icon_price.gif" width="20" height="23" alt="출조비용" title="출조비용" /></li>
										<li style="width:83px;" class="fb fc2 ib"><%=FormatNumber(rs("cost"),0)%>원</li>
										<li style="width:30px;" class="ib"><img src="/img/icon_fish3.gif" width="20" height="23" alt="주요출조" title="주요출조" /></li>
										<li style="width:83px;" class="fc2 ib"><%=rs("chuljo0")%></li>
									</ul>
									<ul style="width:230px; height:25px">
										<li style="width:23px;" class="ib"><img src="/img/icon_fish.gif" width="20" height="23" alt="기타출조종류" title="기타출조종류" /></li>
										<li style="width:200px;" class="f11 fc2 ls ib"><%=trimtext(rs("chuljo"),20)%></li>
									</ul>
									<ul style="width:230px; height:23px">
										<li class="ib"><a href="javascript:;" onClick="unoPOP('<%=rs("shipid")%>',1); return false;"><img src="/img/info_btn01.gif" alt="선박소개" title="선박소개" /></a></li>
										<li class="ib"><a href="/rsv/rsv_ww5.asp?shipid=<%=rs("shipid")%>&yy=<%=yy%>&mm=<%=mm%>&dd=<%=dd%>"><img src="/img/info_btn02.gif" alt="예약" title="예약" /></a></li>
										<li class="ib"><a href="/bbs2/gallery3_v.asp?shipid=<%=rs("shipid")%>"><img src="/img/info_btn03.gif" alt="갤러리" title="갤러리" /></a></li>
									</ul>
								</div>
							</div>
						</div>
<%
				rs.MoveNext
				i = i + 1
				j = j - 1
			Loop
		Else
%>
						<div style="height:300px;">내용이 없습니다.</div>
<%
		End If
		rsc()
%>
					</div>
					<span class="mt30 mb30">&nbsp;</span>
				</div>
			</li>
			<li class="ib vt"><!-- #include virtual = "/inc/quick.asp" --></li>
		</ul>
	</div>
</div>
</form>
<!-- #include virtual = "/inc/footer.asp" -->
