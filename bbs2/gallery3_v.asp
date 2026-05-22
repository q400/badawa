<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	shipid						= SQLI(Request("shipid"))
	dt							= SQLI(Request("dt"))				'datepicker 에서 추출한 날짜
'	seq							= SQLI(Request("seq"))				'_ogalt020 의 seq
'	yy							= SQLI(Request("yy"))
'	mm							= SQLI(Request("mm"))
'	dd							= SQLI(Request("dd"))
	tag							= 2
'	Response.Write "<font color=#ffffff>dt : "& dt &"</font><br>"

	If shipid = "" Then
		Call JSalert("선택된 선박이 없습니다.")
		Response.End
	End If

	If dt = "" Then
		rso()
		SQL = " SELECT ISNULL(MAX(seq),0), wdate " _
			& " FROM _ogalt020 " _
			& " WHERE shipid = "& shipid _
			& " GROUP BY wdate " _
			& " ORDER BY wdate DESC "
		rs.open SQL, dbcon
		If Not rs.eof Then
			seq					= CInt(rs(0))
		End If
		rsc()

		rso()
		SQL = " SELECT seq, title, uno, shipid, wdate, chuljo, multime, weather, pago, ipzil, jogwa, bestfish, fishsize, ddate, contents FROM _ogalt020 WHERE seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			title				= rs("title")
			wdate				= rs("wdate")
			chuljo				= rs("chuljo")
			multime				= rs("multime")
			weather				= rs("weather")
			pago				= rs("pago")
			ipzil				= rs("ipzil")
			jogwa				= rs("jogwa")
			bestfish			= rs("bestfish")
			fishsize			= rs("fishsize")
			contents			= rs("contents")
		Else
			Call JSalert("선택된 선박에 대한 조황정보가 없습니다.")
			Response.End
		End If
		rsc()
	Else
		rso()
		SQL = " SELECT seq, title, uno, shipid, wdate, chuljo, multime, weather, pago, ipzil, jogwa, bestfish, fishsize, ddate, contents FROM _ogalt020 WHERE shipid = "& shipid &" AND wdate = '"& dt &"'"
		rs.open SQL, dbcon
		If Not rs.eof Then
			seq					= rs("seq")
			title				= rs("title")
			wdate				= rs("wdate")
			chuljo				= rs("chuljo")
			multime				= rs("multime")
			weather				= rs("weather")
			pago				= rs("pago")
			ipzil				= rs("ipzil")
			jogwa				= rs("jogwa")
			bestfish			= rs("bestfish")
			fishsize			= rs("fishsize")
			contents			= rs("contents")
		Else
			wdate				= dt
		End If
		rsc()
	End If

	yy							= Year(wdate)
	mm							= setp(Month(wdate))
	dd							= setp(Day(wdate))

'	Response.Write "<font color=#ffffff>yy : "& yy &"</font><br>"
'	Response.Write "<font color=#ffffff>mm : "& mm &"</font><br>"
'	Response.Write "<font color=#ffffff>dd : "& dd &"</font><br>"

'	If yy = "" Then yy = vyy
'	If mm = "" Then mm = vmm
'	If dd = "" Then dd = vdd

	vToday = Day(Now)

	vdate						= CDate(yy &"/"& mm &"/01")			'Response.Write "<font color=#ffffff>vdate : "& vdate &"</font><br>"
	vThisWeek					= Weekday(yy &"/"& mm &"/"& dd)
%>

<!-- jQuery Plugin scripts -->
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-core.css" media="screen, projection" />
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-demos.css" media="screen, projection" />

<script type="text/javascript" src="/lib/js/jquery-ui-1.8.17.custom.min.js"></script>
<script type="text/javascript" src="/lib/js/external/_oldies/jquery-1.3.min.js"></script>
<script type="text/javascript" src="/lib/js/external/jquery.easing.1.3.min.js"></script>
<script type="text/javascript" src="/lib/js/external/jquery.mousewheel.min.js"></script>
<script type="text/javascript" src="/lib/ui/jquery.ui.datepicker.js"></script>
<!-- <script type="text/javascript" src="/lib/js/jquery.ui.datepicker-ko.js"></script> -->
<script type="text/javascript" src="/lib/js/jquery.animate-colors-min.js"></script>
<!-- <script type="text/javascript" src="/inc/js/whole.js"></script> -->

<!-- Site styles -->
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-site.css" media="screen, projection" />

<script type="text/javascript" src="/lib/js/sliderkit/jquery.sliderkit.1.9.2.pack.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.delaycaptions.1.1.pack.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.counter.1.0.pack.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.timer.1.0.pack.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.imagefx.1.0.pack.js"></script>

<!-- Slider Kit launch -->
<script type="text/javascript">
	$(window).load(function(){ //$(window).load() must be used instead of $(document).ready() because of Webkit compatibility
		// Photo gallery > Standard
		$("#standardPhotosgallery").sliderkit({
			mousewheel: true,
			shownavitems: 7,
			//navfx: "none",
			panelbtnshover: true,
			auto: true,						//default 4초
//			autospeed: 3000,				//3초
//			autospeed: 5000,				//5초
			circular: true,
			navscrollatend: true,
			counter: true
		});
	});
</script>
<script language="javascript">
<!--
function goSearch(){
	var f = document.fm1;
	$("#wdate").val($("#yy").val() +"-"+ $("#mm").val() +"-"+ $("#dd").val());
	alert($("#wdate").val());
	f.action = "gallery3_v.asp";
	f.method = "post";
	f.submit();
}
function goBasket(gcode){		//액자신청하기
	var f = document.fm1;
<%	If FID_NO = "" Then %>
	alert("My앨범에 담으시려면 로그인이 필요합니다.");
	this.document.location = "/mem/login.asp?preURL=/bbs2/gallery3_v.asp?shipid=<%=shipid%>&dt=<%=dt%>";
	return;
<%	End If %>
	if(confirm("이 사진을 My앨범에 담겠습니까?")){
		f.idx.value = gcode;
		f.op.value = "gallery";
		f.method = "post";
//		f.target = "nullframe";
		f.action = "basket_x.asp";
		f.submit();
		if(confirm("My앨범에 담겼습니다. My앨범을 보시겠습니까?")){
			f.method = "post";
			f.target = "_top";
			f.action = "/my/album.asp";
			f.submit();
		}else{
			return;
		}
	}else{
		return;
	}
}
//-->
</script>


<form name="fm1" method="post">
<input type="hidden" name="idx" id="idx" />
<input type="hidden" name="op" id="op" />
<input type="hidden" name="wdate" id="wdate" value="<%=wdate%>" />
<div id="wrap">
	<div>
		<ul>
			<li class="ib vt" style="width:230px;"><!-- #include virtual = "/inc/left/fish.asp" --></li>
			<li class="ib vt">
				<div id="mainwrap4">
					<div class="mt20">
						<img src="/img/fish_info_tle.gif" alt="조황정보" title="조황정보" />
					</div>
					<div class="mt10 mb10">
						<img src="/img/fish_gallery.gif" alt="조황갤러리" title="조황갤러리" />
					</div>

					<div style="width:810px; border:0px solid #000;" class="mb10">
						<ul>
							<li class="ct ib pt" style="width:100px; border:1px solid #ccc;" onClick="location='gallery3.asp'">전체</a></li>
<%
	rso()
	i = 0
	SQL = " SELECT shipid, shipnm, captain, sz, capa, speed, equip, tel, hp, homp, bank, acc, ddate, active_yn, memo "_
		& " FROM _oshpt010 "
	rs.open SQL, dbcon

	While Not rs.eof
		If CInt(shipid) = rs("shipid") Then
			bgcolor = "#59c"
			fncolor = "#fff"
		Else
			bgcolor = "#fff"
			fncolor = "#000"
		End If
%>
							<li class="ct ib pt" style="width:100px; border:1px solid #ccc; background-color:<%=bgcolor%>; color:<%=fncolor%>;"
							onClick="location='gallery3_v.asp?shipid=<%=rs("shipid")%>'"><%=rs("shipnm")%></a></li>
<%
		rs.MoveNext
		i = i + 1
	Wend
	rsc()
%>
						</ul>
					</div>
					<hr style="border:1px solid #ddd;">
					<div class="mt10">
						<table width="800" border="0" cellspacing="0" cellpadding="0">
							<tr class="vt">
								<td width="230" rowspan="2">
									<table width="230" border="0" cellspacing="0" cellpadding="0" align="center">
										<tr height="40">
											<td class="ct vm" colspan="2"><span class="f25 fcb fz fb ls"><%=shipInfo(shipid,"shipnm")%></span></td>
										</tr>
										<tr>
											<td class="vt ct">
												<div class="f17 ff fb ls"><%=yy%> 년&nbsp; <%=mm%> 월&nbsp;<%=dd%> 일</div>
												<div class="f15 fb pt10">(출조 :&nbsp;<%=chuljo%>)</div><!-- getMool1(yy,mm,dd) -->
											</td>
										</tr>
									</table>
								</td>
								<td width="580" class="rg" colspan="2">
									<img src="/img/bbs/quick.gif" class="vm" alt="빠른검색" title="빠른검색">&nbsp;&nbsp;
									<select name="yy" id="yy" style="width:60px;">
<%		For ii = 2012 To year(Date) %>
									<option value="<%=ii%>"<%If yy = ii Then%> selected<%End If%>><%=ii%></option>
<%		Next %>
									</select> 년&nbsp;
									<select name="mm" id="mm" style="width:50px;" onChange="location='?shipid=<%=shipid%>&dt='+ fm1.yy.value +'-'+ this.options[this.selectedIndex].value +'-'+ fm1.dd.value +''">
<%		For j = 1 To 12 Step 1 %>
									<option value="<%=setp(j)%>"<%If setp(mm) = setp(j) Then%> selected<%End If%>><%=setp(j)%></option>
<%		Next %>
									</select> 월&nbsp;
									<select name="dd" id="dd" style="width:50px;" onChange="location='?shipid=<%=shipid%>&dt='+ fm1.yy.value +'-'+ fm1.mm.value +'-'+ this.options[this.selectedIndex].value +''">
									<option value="01"<%If dd <> nday Then%> selected<%End If%>>선택</option>
<%
				rso()
				SQL = " SELECT seq, wdate " _
					& " FROM _ogalt020 " _
					& " WHERE CAST(wdate AS CHAR(7)) = '"& yy &"-"& mm &"' AND shipid = "& shipid
				rs.open SQL, dbcon
				If Not rs.eof Then
					While Not rs.eof
						nday		= setp(Day(rs("wdate")))
%>
									<option value="<%=nday%>"<%If dd = nday Then%> selected<%End If%>><%=nday%></option>
<%
						rs.MoveNext
					Wend
				End If
				rsc()
%>
									</select> 일&nbsp;&nbsp;<a href="javascript:;" onClick="goSearch()" class="btnp btn25"><span>조회</span></a>&nbsp;&nbsp;&nbsp;

									<img src="/img/bbs/shipnm.gif" class="vm" alt="낚시배">&nbsp;&nbsp;
									<select name="shipid" id="shipid" style="width:120px;" onChange="location='?shipid='+ this.options[this.selectedIndex].value +''">
<%
	rso()
	SQL = " SELECT shipid, shipnm FROM _oshpt010 "
	rs.open SQL, dbcon
	While Not rs.eof
%>
									<option value="<%=rs("shipid")%>"<%If CInt(shipid) = rs("shipid") Then%> selected<%End If%>><%=rs("shipnm")%></option>
<%
		rs.MoveNext
	Wend
	rsc()
%>
									</select>
								</td>
							</tr>
							<tr>
								<td width="280" class="ct">
									<table width="270" border="1" cellspacing="0" cellpadding="0" align="center" bordercolor="#ffffff" style="border-collapse:collapse;">
										<tr>
											<td class="ct">
												<table width="270" border="0" cellspacing="0" cellpadding="0" bordercolor="#ffffff" style="border-collapse:collapse;">
													<tr>
														<td width="50" class="f11 ct"><img src="/img/bbs/weather.gif"></td>
														<td width="50" class="f11 ct"><img src="/img/bbs/pago.gif"></td>
														<td width="50" class="f11 ct"><img src="/img/bbs/ipzil.gif"></td>
														<td width="50" class="f11 ct"><img src="/img/bbs/jogwa.gif"></td>
														<td width="70" class="f11 ct"><img src="/img/bbs/fishsize.gif"></td>
													</tr>
													<tr height="30">
														<td class="f11 ct"><%=weather%></td>
														<td class="f11 ct"><%=pago%></td>
														<td class="f11 ct"><%=ipzil%></td>
														<td class="f11 ct"><%=jogwa%></td>
														<td class="f11 ct"><%=bestfish%>(<%=fishsize%>)</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
								<td width="280" height="85" class="rg">
									<div style="width:290px; height:80px; overflow-x:visible; overflow-y:hidden;">
										<iframe src="gallery3_sub.asp?shipid=<%=shipid%>" width="270" height="85" frameborder="0" name="obj" style="width:270px; height:80px; background-color:#fff;"></iframe>
									</div>
								</td>
							</tr>
						</table>
					</div>

<%	If seq <> "" Then %>
					<!-- Start Start photosgallery-std --><!-- sliderkit-demos.css -->
					<div id="standardPhotosgallery" class="sliderkit photosgallery-std">
						<div class="sliderkit-nav">
							<div class="sliderkit-btn sliderkit-nav-btn sliderkit-nav-prev"><a rel="nofollow" href="#" title="이전사진"><span>이전</span></a></div>
							<div class="sliderkit-btn sliderkit-nav-btn sliderkit-nav-next"><a rel="nofollow" href="#" title="다음사진"><span>다음</span></a></div>

							<div class="sliderkit-nav-clip">
								<ul>
<%
		rso()
		SQL = " SELECT idx, seq, fpath, fnm, onm, fsz, fwd, ext, best, ddate FROM _ogalt021 WHERE seq = "& seq
		rs.open SQL, dbcon
		While Not rs.eof
%>
									<li><a href="#" rel="nofollow" title="마우스 휠을 이용하시면 편리합니다."><img src="<%=rs("fpath")%>/<%=rs("fnm")%>" width="80" alt="<%=title%>" /></a></li>
<%
			rs.MoveNext
		Wend
		rsc()
%>
								</ul>
							</div>
						</div>
						<div class="sliderkit-panels">
							<div class="sliderkit-btn sliderkit-go-btn sliderkit-go-prev"><a rel="nofollow" href="#" title="이전"><span>이전</span></a></div>
							<div class="sliderkit-btn sliderkit-go-btn sliderkit-go-next"><a rel="nofollow" href="#" title="다음"><span>다음</span></a></div>

							<div class="sliderkit-count sliderkit-count-items">
								<span class="sliderkit-count-current"></span><span class="sliderkit-count-sep">/</span><span class="sliderkit-count-total"></span>
							</div>
<%
		rso()
		SQL = " SELECT idx, seq, fpath, fnm, onm, fsz, fwd, ext, best, ddate FROM _ogalt021 WHERE seq = "& seq
		rs.open SQL, dbcon
		While Not rs.eof
%>
							<div class="sliderkit-panel" title="마우스 휠을 이용하여 다음 사진을 볼 수 있습니다. 사진을 클릭하여 액자신청을 할 수 있습니다."><img src="<%=rs("fpath")%>/<%=rs("fnm")%>" alt="<%=title%>" /></div>
<%
			rs.MoveNext
		Wend
		rsc()
%>
						</div>
					</div>
					<!-- // end of photosgallery-std -->
<%	Else %>
					<div class="ct mt30" style="height:150px;">"해당 일자에 조황정보가 없습니다. 다른 일자를 선택해 보세요."</div>
<%	End If %>
					<div>
						<meta name="description" content="<%=title%>"/>
						<a href="#" onClick="twitterOpen('<%=snsRoots%>/bbs1/gallery3_v.asp?shipid=<%=shipid%>&dt=<%=dt%>');return false;"><img alt="트위터에 공유하기" src="/img/icon/posttwit.png" /></a>
						<a href="#" onClick="facebookOut('<%=snsRoots%>/bbs1/gallery3_v.asp?shipid=<%=shipid%>&dt=<%=dt%>');return false;"><img alt="페이스북에 공유하기" src="/img/icon/postfb.png" /></a>
						<a href="#" onClick="me2DayOpen('<%=snsRoots%>/bbs1/gallery3_v.asp?shipid=<%=shipid%>&dt=<%=dt%>');return false;"><img alt="미투데이에 공유하기" src="/img/icon/postmeto.png" /></a>
						<a href="#" onClick="yozmOpen('<%=snsRoots%>/bbs1/gallery3_v.asp?shipid=<%=shipid%>&dt=<%=dt%>');return false;"><img alt="요즘에 공유하기" src="/img/icon/postyozm.png" /></a>
					</div>
					<div class="rg">
						<!-- <a href="gallery.asp" class="btnr btn25"><span>앨범예약</span></a> -->
						<a href="gallery3.asp" class="btn btn25"><span>전체보기</span></a>
					</div>
					<div class="pt20 pb20"></div>
				</div>
			</li>
			<li class="ib vt"><!-- #include virtual = "/inc/quick.asp" --></li>
		</ul>
	</div>
</div>
<!-- #include virtual = "/inc/footer.asp" -->
