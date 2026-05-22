<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	Call dbo()
	shipid						= SQLI(Request("shipid"))
	seq							= SQLI(Request("seq"))				'_obbst020 의 seq
	yy							= SQLI(Request("yy"))
	mm							= SQLI(Request("mm"))
	dd							= SQLI(Request("dd"))
	op							= SQLI(Request("op"))				'회원mem/비회원nomem 예약수정
'	Response.Write "seq : "& seq &"<br>"

	If seq = "" Then
		Call rso()
		SQL = " SELECT MAX(seq) FROM _obbst020 WHERE shipid = "& shipid
		rs.open SQL, dbcon
		If Not rs.eof Then
			seq					= rs(0)
		End If
		Call rsc()
	End If

	If seq = "" Then
			Call JSalert("선택된 조황정보가 없습니다.        ")
			Response.End
	End If

	If seq <> "" Then
		Call rso()
		SQL = " SELECT seq, title, uno, shipid, wdate, chuljo, multime, weather, pago, ipzil, jogwa, bestfish, fishsize, ddate, contents FROM _obbst020 WHERE seq = "& seq
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
		End If
		Call rsc()
	End If

	vyy							= Year(wdate)
	vmm							= setp(Month(wdate))
	vdd							= setp(Day(wdate))

	If yy = "" Then yy = vyy
	If mm = "" Then mm = vmm
	If dd = "" Then dd = vdd

	vdate						= CDate(yy &"/"& mm &"/01")			'Response.Write "<font color=#ffffff>vdate : "& vdate &"</font><br>"
	vThisWeek					= Weekday(yy &"/"& mm &"/"& dd)
%>

<!-- jQuery Plugin scripts -->
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-core.css" media="screen, projection" />
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-demos.css" media="screen, projection" />

<script type="text/javascript" src="/lib/js/external/_oldies/jquery-1.3.min.js"></script>
<script type="text/javascript" src="/lib/js/external/jquery.easing.1.3.min.js"></script>
<script type="text/javascript" src="/lib/js/external/jquery.mousewheel.min.js"></script>

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
			mousewheel:true,
			shownavitems:7,
			//navfx:"none",
			panelbtnshover:true,
			auto:false,
			circular:true,
			navscrollatend:true,
			counter:true
		});

		// Photo gallery > With captions
		$(".photosgallery-captions").sliderkit({
			mousewheel:false,
			keyboard:true,
			shownavitems:4,
			auto:false,
			delaycaptions:true
		});

		// Photo gallery > Vertical
		$(".photosgallery-vertical").sliderkit({
			circular:true,
			mousewheel:true,
			shownavitems:4,
			verticalnav:true,
			navclipcenter:true,
			auto:false
		});

		// Photo gallery > Minimalistic
		$(".photosgallery-minimalistic").sliderkit({
			shownavitems:6,
			circular:true,
			navitemshover:false,
			panelfxspeed:400,
			auto:true,
			autostill:true,
			timer:true
		});

		// Photo gallery > Example #5
		$(".photosgallery-5").sliderkit({
			mousewheel:false,
			shownavitems:5,
			panelbtnshover:false,
			auto:false,
			circular:false,
			navscrollatend:false,
			navpanelautoswitch:false,
			counter:true,
			debug:1
		});

	});
</script>

<table width="100%"  border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td bgcolor="#ffffff">
			<table width="1100" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="250" valign="top"><!-- #include virtual = "/inc/left/fish.asp" --></td>
					<td width="710" valign="top">
						<table width="710" border="0" cellspacing="0" cellpadding="0">

<form name="fm1" method="post">

							<tr>
								<td height="21"></td>
							</tr>
							<tr>
								<td><img src="/img/fish_info_tle.gif" width="335" height="24" /></td>
							</tr>
							<tr>
								<td height="15"></td>
							</tr>
							<tr>
								<td><img src="/img/fish_info_gall_tle.gif" width="160" height="18" /></td>
							</tr>
							<tr>
								<td height="32">&nbsp;</td>
							</tr>
							<tr>
								<td>
									<table width="710" border="0" cellspacing="0" cellpadding="0">
										<tr>
<%
	Call rso()
	SQL = " SELECT shipid, shipnm, captain, sz, capa, speed, equip, tel, hp, homp, email, bank, acc, ddate, active_yn, memo FROM _oshpt010 "
	rs.open SQL, dbcon
	While Not rs.eof
		If CInt(shipid) = rs("shipid") Then
			bgcolor = "#f7f700"
		Else
			bgcolor = "#ffffff"
		End If
%>
											<td width="75" class="fb ct ls" bgcolor="<%=bgcolor%>"><a href="gallery_v.asp?shipid=<%=rs("shipid")%>"><%=rs("shipnm")%></a></td>
											<td width="2"><img src="/img/gall_line.gif" width="2" height="11" /></td>
<%
		rs.MoveNext
	Wend
	Call rsc()
%>
											<td>&nbsp;</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>
							<tr>
								<td><img src="/img/bbs_line02.gif" width="710" height="5" /></td>
							</tr>
							<tr>
								<td height="15"></td>
							</tr>
							<tr>
								<td>
									<table width="710" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="310">
												<table width="170" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="19"><a href="?shipid=<%=shipid%>&yy=<%=Year(vDate-1)%>&mm=<%=Month(vDate-1)%>&dd=01"><img src="/img/calen/arrow01.gif" width="19" height="21" /></a></td>
														<td width="10"></td>
														<td width="73"><img src="/img/calen/<%=vyy%>.gif" width="73" height="21" /></td>
														<td width="7"></td>
														<td width="32"><img src="/img/calen/<%=setp(vmm)%>.gif" width="32" height="21" /></td>
														<td width="10"></td>
														<td width="19"><a href="?shipid=<%=shipid%>&yy=<%=Year(vDate+31)%>&mm=<%=Month(vDate+31)%>&dd=01"><img src="/img/calen/arrow02.gif" width="19" height="21" /></a></td>
													</tr>
												</table>
											</td>
											<td width="300" class="rg">
												<select name="wdate" style="width:150px;" onChange="location='?shipid=<%=shipid%>&seq='+this.options[this.selectedIndex].value+''">
												<option value=""<%If seq = "" Then%> selected<%End If%>>조황일자 선택</option>
<%
	Call rso()
	SQL = " SELECT TOP 30 * FROM _obbst020 WHERE shipid = "& shipid &" ORDER BY seq "
	rs.open SQL, dbcon
	While Not rs.eof
%>
												<option value="<%=rs("seq")%>"<%If rs("seq") = CInt(seq) Then%> selected<%End If%>><%=rs("wdate")%> 조황보기</option>
<%
		rs.MoveNext
	Wend
	Call rsc()
%>
												</select>
											</td>
											<td width="100" class="rg">
												<meta name="description" content="<%=title%>"/>
												<a href="#" onClick="twitterOpen('<%=snsRoots%>/bbs1/gallery_v.asp?shipid=<%=shipid%>&seq=<%=seq%>');return false;"><img alt="트위터에 공유하기" src="/img/icon/_twitter.gif" /></a> &nbsp;<a href="#" onClick="facebookOut('<%=snsRoots%>/bbs1/gallery_v.asp?shipid=<%=shipid%>&seq=<%=seq%>');return false;"><img alt="페이스북에 공유하기" src="/img/icon/_facebook.gif" /></a> &nbsp;<a href="#" onClick="me2DayOpen('<%=snsRoots%>/bbs1/gallery_v.asp?shipid=<%=shipid%>&seq=<%=seq%>');return false;"><img alt="미투데이에 공유하기" src="/img/icon/_me2day.gif" /></a> &nbsp;<a href="#" onClick="yozmOpen('<%=snsRoots%>/bbs1/gallery_v.asp?shipid=<%=shipid%>&seq=<%=seq%>');return false;"><img alt="요즘에 공유하기" src="/img/icon/_yozm.gif" /></a>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="6"></td>
							</tr>

							<tr>
								<td><img src="/img/calen/line01.gif" width="710" height="9" /></td>
							</tr>
							<tr>
								<td background="/img/calen/bg01.gif" colspan="3">
									<table width="710" border="0" cellspacing="0" cellpadding="0">
										<tr height="24">
											<td>&nbsp;</td>
											<td width="30" class="fc7 fb ct">일</td>
											<td width="30" class="fb ct">월</td>
											<td width="30" class="fb ct">화</td>
											<td width="30" class="fb ct">수</td>
											<td width="30" class="fb ct">목</td>
											<td width="30" class="fb ct">금</td>
											<td width="30" class="fc9 fb ct">토</td>
											<td width="10"></td>
											<td width="30" class="fc7 fb ct">일</td>
											<td width="30" class="fb ct">월</td>
											<td width="30" class="fb ct">화</td>
											<td width="30" class="fb ct">수</td>
											<td width="30" class="fb ct">목</td>
											<td width="30" class="fb ct">금</td>
											<td width="30" class="fc9 fb ct">토</td>
											<td width="10"></td>
											<td width="30" class="fc7 fb ct">일</td>
											<td width="30" class="fb ct">월</td>
											<td width="30" class="fb ct">화</td>
											<td width="30" class="fb ct">수</td>
											<td width="30" class="fb ct">목</td>
											<td width="30" class="fb ct">금</td>
											<td width="30" class="fc9 fb ct">토</td>
											<td>&nbsp;</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="1" bgcolor="dfdfdf" colspan="3"></td>
							</tr>

							<tr>
								<td background="/img/calen/bg02.gif" colspan="3">
									<table width="710" border="0" cellspacing="0" cellpadding="0">
										<tr height="24">
											<td width="30">&nbsp;</td>
<%
		Dim arrDefaultWeek(8)
		i = 1
		j = 1
		n = 1
		k = 22

		vLastday				= Day(CDate(Year(vDate) &"/"& Month(vDate + 31) &"/01") - 1)
		vFirstWeek				= Weekday(vDate)
		vDay					= 1

		While i <= 21
			If j = 8 Then j = 1
			If (vFirstWeek = j And vDay = 1) Or (vDay > 1 And vDay <= vLastday) Then

				If vDay = CInt(dd) Then
%>
											<td width="30" class="ct" bgcolor="#cccccc"><a href="?shipid=<%=shipid%>&seq=<%=gallInfo(shipid, vyy &"-"& vmm &"-"& vdd)%>"><b class="ff f11"><%=vDay%></b></a>
<%				Else %>
											<td width="30" class="ct"><a href="?shipid=<%=shipid%>&seq=<%=gallInfo(shipid, vyy &"-"& vmm &"-"& vdd)%>" class="ff f11"><%=vDay%></a>
<%				End If
				vDay = vDay + 1
			Else
%>
											<td width="30">&nbsp;
<%			End If %>
											</td>
<%			If i = 7 Or i = 14 Then %>
											<td width="10"></td>
<%			End If
			i = i + 1
			j = j + 1
		Wend
%>
											<td width="30">&nbsp;</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="1" bgcolor="dfdfdf" colspan="3"></td>
							</tr>
							<tr>
								<td background="/img/calen/bg02.gif" colspan="3">
									<table width="710" border="0" cellspacing="0" cellpadding="0">
										<tr height="24">
											<td width="30">&nbsp;</td>
<%
		While k <= 42
			If n = 8 Then n = 1
			If (vFirstWeek = n And vDay = 1) Or (vDay > 1 And vDay <= vLastday) Then
				If vDay = today Then
%>
											<td width="30" class="ct" bgcolor="#cccccc"><a href="?shipid=<%=shipid%>&yy=<%=vyy%>&mm=<%=vmm%>&dd=<%=vDay%>"><b class="ff f11"><%=vDay%></b></a>
<%				ElseIf vDay = CInt(dd) Then %>
											<td width="30" class="ct" bgcolor="#cccccc"><a href="?shipid=<%=shipid%>&yy=<%=vyy%>&mm=<%=vmm%>&dd=<%=vDay%>"><b class="ff f11"><%=vDay%></b></a>
<%				Else %>
											<td width="30" class="ct"><a href="?shipid=<%=shipid%>&yy=<%=vyy%>&mm=<%=vmm%>&dd=<%=vDay%>" class="ff f11"><%=vDay%></a>
<%				End If
				vDay = vDay + 1
			Else
%>
											<td width="30">&nbsp;
<%			End If %>
											</td>
<%			If k = 28 Or k = 35 Then %>
											<td width="10"></td>
<%			End If
			k = k + 1
			n = n + 1
		Wend
		Call rsc()
%>
											<td width="30">&nbsp;</td>
										</tr>
									</table>
								</td>
							</tr>

							<tr>
								<td><img src="/img/calen/line02.gif" width="710" height="4" /></td>
							</tr>
							<tr>
								<td height="18">&nbsp;</td>
							</tr>
							<tr>
								<td align="center">

				<!-- Start Start photosgallery-std -->
				<div id="standardPhotosgallery" class="sliderkit photosgallery-std">
					<div class="sliderkit-nav">
						<div class="sliderkit-btn sliderkit-nav-btn sliderkit-nav-prev"><a rel="nofollow" href="#" title="이전사진"><span>이전</span></a></div>
						<div class="sliderkit-btn sliderkit-nav-btn sliderkit-nav-next"><a rel="nofollow" href="#" title="다음사진"><span>다음</span></a></div>

						<div class="sliderkit-nav-clip">
							<ul>
<%
		Call rso()
		SQL = " SELECT idx, seq, fpath, fnm, fsz, fwd, ext, best FROM _obbst021 WHERE seq = "& seq
		rs.open SQL, dbcon
		While Not rs.eof
%>
								<li><a href="#" rel="nofollow" title="마우스 휠을 이용하여 사진을 넘길 수 있습니다."><img src="<%=rs("fpath")%>/<%=rs("fnm")%>" width="120" alt="<%=title%>" /></a></li>
<%
			rs.MoveNext
		Wend
		Call rsc()
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
		Call rso()
		SQL = " SELECT idx, seq, fpath, fnm, fsz, fwd, ext, best FROM _obbst021 WHERE seq = "& seq
		rs.open SQL, dbcon
		While Not rs.eof
%>
						<div class="sliderkit-panel" title="마우스 휠을 이용하여 사진을 넘길 수 있습니다."><img src="<%=rs("fpath")%>/<%=rs("fnm")%>" alt="<%=title%>" /></div>
<%
			rs.MoveNext
		Wend
		Call rsc()
%>
					</div>
				</div>
				<!-- // end of photosgallery-std -->

								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td><img src="/img/bbs_line02.gif" width="710" height="5" /></td>
							</tr>
							<tr>
								<td height="8"></td>
							</tr>

							<tr>
								<td height="8"></td>
							</tr>
							<tr>
								<td class="rg">
									<table border="0" cellspacing="0" cellpadding="0" align="right">
										<tr>
											<td><img src="/img/btn_album.gif" width="62" height="28"></td>
											<td width="12"></td>
											<td><a href="gallery.asp"><img src="/img/btn_list.gif" width="62" height="28"></a></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
					<td width="140" valign="top"><!-- #include virtual = "/inc/quick.asp" --></td>
				</tr>
			</table>

		</td>
	</tr>
</table>

</body>
</html>
<!-- #include virtual = "/inc/footer.asp" -->