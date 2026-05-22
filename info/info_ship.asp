<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	shipid						= SQLI(Request("shipid"))

	If shipid <> "" Then
		rso()
		SQL = " SELECT	shipnm, captain, sz, capa0, capa, speed, equip, seat, tel, hp, homp, bank, acc, cost, chuljo0, chuljo, comfort, service, blog, smart, ddate, active_yn, captel, capaddr, memo" _
			& "	FROM _oshpt010 " _
			& " WHERE shipid = "& shipid
		rs.open SQL, dbcon
		If Not rs.eof Then
			shipnm				= rs("shipnm")
			captain				= rs("captain")
			sz					= rs("sz")
			capa0				= rs("capa0")
			capa				= rs("capa")
			speed				= rs("speed")
			equip				= rs("equip")
			seat				= rs("seat")
			tel					= rs("tel")
			hp					= rs("hp")
			homp				= rs("homp")
			bank				= rs("bank")
			acc					= rs("acc")
			cost				= rs("cost")
			chuljo0				= rs("chuljo0")
			chuljo				= rs("chuljo")
			comfort				= rs("comfort")
			service				= rs("service")
			blog				= rs("blog")
			smart				= rs("smart")
			ddate				= rs("ddate")
			active_yn			= rs("active_yn")
			captel				= rs("captel")
			capaddr				= rs("capaddr")
			memo				= rs("memo")
		End If
		rsc()
		flag = "M"
	End If
%>

<!-- jQuery library -->
<script type="text/javascript" src="/lib/js/external/_oldies/jquery-1.3.min.js"></script>
<!--<script type="text/javascript" src="../lib/js/external/jquery-1.6.2.min.js"></script>-->

<!-- jQuery Plugin scripts -->
<script type="text/javascript" src="/lib/js/external/jquery.easing.1.3.min.js"></script>
<script type="text/javascript" src="/lib/js/external/jquery.mousewheel.min.js"></script>

<!-- Slider Kit scripts -->
<script type="text/javascript" src="/lib/js/sliderkit/jquery.sliderkit.1.9.2.pack.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.delaycaptions.1.1.pack.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.counter.1.0.pack.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.timer.1.0.pack.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.imagefx.1.0.pack.js"></script>

<!-- Slider Kit launch -->
<script type="text/javascript">
	var autoSpeed = [0,100,300];
	$(window).load(function(){ //$(window).load() must be used instead of $(document).ready() because of Webkit compatibility

		// Photo gallery > Standard
		$("#standardPhotosgallery").sliderkit({
			mousewheel:true,
			shownavitems:4,
			//navfx:"none",
			panelbtnshover:true,
			auto:false,
			circular:true,
			navscrollatend:true,
			counter:true
		});

		// Photo gallery > With captions
		$(".photosgallery-captions").sliderkit({
			mousewheel: true,
			keyboard: true,
			shownavitems: 7,
			auto: true,						//default 4초
//			autospeed: 3000,				//3초
			panelfxspeed: 50,				//하단 text 뿌려지는 속도
			delaycaptions: true
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
			shownavitems:8,
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

		$(".anytagselector").sliderkit({
			delaycaptions:{
				delay:100,
				position:"bottom",
				transition:"sliding",
				duration:300,
				easing:"easeOutExpo",
				hold:true
			}
		});
	});
</script>

<!-- Slider Kit styles -->
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-core.css" media="screen, projection" />
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-info-ship.css" media="screen, projection" />

<!-- Slider Kit compatibility -->
<!--[if IE 6]><link rel="stylesheet" type="text/css" href="../lib/css/sliderkit-demos-ie6.css" /><![endif]-->
<!--[if IE 7]><link rel="stylesheet" type="text/css" href="../lib/css/sliderkit-demos-ie7.css" /><![endif]-->
<!--[if IE 8]><link rel="stylesheet" type="text/css" href="../lib/css/sliderkit-demos-ie8.css" /><![endif]-->

<!-- Site styles -->
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-site.css" media="screen, projection" />


<table width=1150 border=0 cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td colspan=4>
			<div style="width:1100px;">
<%
		rso()
		SQL = " SELECT shipid, shipnm, captain, sz, capa, speed, equip, tel, hp, homp, bank, acc, cost, chuljo, comfort, service, blog, smart, ddate, active_yn, memo "_
			& " FROM _oshpt010 "
		rs.open SQL, dbcon

		While Not rs.eof
			shortNm = rs("shipnm")
			If Len(shortNm) > 5 Then shortNm = Left(shortNm, 5)
%>
				<div style="width:80px;" class="mt5 ct ls ib"><a href="?shipid=<%=rs("shipid")%>"><%=shortNm%></a></div>
<%
			rs.MoveNext
		Wend
		rsc()
%>
			</div>
		</td>
	</tr>
	<tr>
		<td width="20"></td>
		<td width="810" class="ct vt">
			<table width="810" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="810">
						<!-- Start photosgallery-captions -->
						<div class="sliderkit photosgallery-captions">
							<div class="sliderkit-nav">
								<div class="sliderkit-nav-clip">
									<ul>
<%
		rso()				'하단 썸네일 navi
		SQL = " SELECT idx, shipid, fpath, fnm, fwd, fsz, ext, comment FROM _oshpt011 WHERE shipid = "& shipid
		rs.open SQL, dbcon
		While Not rs.eof
%>
										<li><a href="#" rel="nofollow" title="<%=rs("comment")%>"><img src="<%=rs("fpath") &"/thumb/"& rs("fnm") &".gif"%>" width="100%" alt="<%=rs("comment")%>" /></a></li>
<%			rs.MoveNext
		Wend
		rsc()
%>
									</ul>
								</div>
								<div class="sliderkit-btn sliderkit-nav-btn sliderkit-nav-prev"><a rel="nofollow" href="#" title="Previous line"><span>Previous line</span></a></div>
								<div class="sliderkit-btn sliderkit-nav-btn sliderkit-nav-next"><a rel="nofollow" href="#" title="Next line"><span>Next line</span></a></div>
								<div class="sliderkit-btn sliderkit-go-btn sliderkit-go-prev"><a rel="nofollow" href="#" title="Previous photo"><span>Previous photo</span></a></div>
								<div class="sliderkit-btn sliderkit-go-btn sliderkit-go-next"><a rel="nofollow" href="#" title="Next photo"><span>Next photo</span></a></div>
							</div>

							<div class="sliderkit-panels">
<%
		rso()				'메인 이미지
		SQL = " SELECT idx, shipid, fpath, fnm, fwd, fsz, ext, comment FROM _oshpt011 WHERE shipid = "& shipid
		rs.open SQL, dbcon
		While Not rs.eof
%>
								<div class="sliderkit-panel">
									<img src="<%=rs("fpath") &"/"& rs("fnm") &"."& rs("ext")%>" alt="<%=rs("comment")%>" title="<%=rs("comment")%>" />
									<div class="sliderkit-panel-text">
										<div class="sliderkit-panel-textbox">
											<div class="sliderkit-panel-text">
												<h4><%=rs("comment")%></h4>
											</div>
											<div class="sliderkit-panel-overlay"></div>
										</div>
									</div>
								</div>
<%			rs.MoveNext
		Wend
		rsc()
%>
							</div>

						</div>
						<!-- // end of photosgallery-captions -->

					</td>
				</tr>
			</table>
		</td>
		<td width="300" class="vt">
			<table width="300" border="0" cellspacing="3" cellpadding="0">
				<tr>
					<td height="10" colspan="2"></td>
				</tr>
				<tr height="20">
					<th width="90" bgcolor="#eeeeee" class="f11 ls">선박명</th>
					<td width="210" class="pl5 f11 ff fb fc7 ls"><%=shipnm%></td>
				</tr>
				<tr height="20">
					<th bgcolor="#eeeeee" class="f11 ls">선장이름</th>
					<td class="pl5 f11 ff ls"><%=captain%></td>
				</tr>
				<tr height="20">
					<th bgcolor="#eeeeee" class="f11 ls">선박크기</th>
					<td class="pl5 f11 ff ls"><%=sz%> t</td>
				</tr>
				<tr height="20">
					<th bgcolor="#eeeeee" class="f11 ls">정원</th>
					<td class="pl5 f11 ff ls"><%=capa0%> 명&nbsp;(선장포함)</td>
				</tr>
				<tr height="20">
					<th bgcolor="#eeeeee" class="f11 ls">예약인원</th>
					<td class="pl5 f11 ff ls"><%=capa%> 명</td>
				</tr>
				<tr height="20">
					<th bgcolor="#eeeeee" class="f11 ls">자리배정</th>
					<td class="pl5 f11 ff ls fc2 fb"><%=seat%></td>
				</tr>
				<tr height="20">
					<th bgcolor="#eeeeee" class="f11 ls">선박비용</th>
					<td class="pl5 f11 ff ls fc7 fb"><%=FormatNumber(cost,0)%> 원</td>
				</tr>
				<tr height="20">
					<th bgcolor="#eeeeee" class="f11 ls">주요출조</th>
					<td class="pl5 f11 ff ls fc2 fb"><%=chuljo0%></td>
				</tr>
				<tr height="20">
					<th bgcolor="#eeeeee" class="f11 ls">기타출조</th>
					<td class="pl5 f11 ff ls"><%=chuljo%></td>
				</tr>
				<tr height="20">
					<th bgcolor="#eeeeee" class="f11 ls">선박속도</th>
					<td class="pl5 f11 ff ls"><%=speed%></td>
				</tr>
				<tr height="20">
					<th bgcolor="#eeeeee" class="f11 ls">주요편의시설</th>
					<td class="pl5 f11 ff ls"><%=comfort%></td>
				</tr>
				<tr height="20">
					<th bgcolor="#eeeeee" class="f11 ls">보유장비</th>
					<td class="pl5 f11 ff ls"><%=equip%></td>
				</tr>
				<tr height="20">
					<th bgcolor="#eeeeee" class="f11 ls">서비스</th>
					<td class="pl5 f11 ff ls fc2 fb"><%=service%></td>
				</tr>
				<tr height="20">
					<th bgcolor="#eeeeee" class="f11 ls">홈페이지</th>
					<td class="pl5 f11 ff ls"><a href="http://<%=homp%>" target="_blank"><font class="fc4"><%=homp%></font></a></td>
				</tr>
				<tr height="20">
					<th bgcolor="#eeeeee" class="f11 ls">블로그</th>
					<td class="pl5 f11 ff ls"><a href="http://<%=blog%>" target="_blank"><font class="fc4"><%=blog%></font></a></td>
				</tr>
				<tr height="20">
					<th bgcolor="#eeeeee" class="f11 ls">E-mail</th>
					<td class="pl5 f11 ff ls"><font class="fc4"><%=smart%></font></td>
				</tr>
				<tr height="20">
					<th bgcolor="#eeeeee" class="f11 ls">계좌번호</th>
					<td class="pl5 f11 ff ls"><%=bank%><br>(<%=acc%>)</td>
				</tr>
				<tr height="20">
					<th bgcolor="#eeeeee" class="f11 ls">대표예약전화</th>
					<td class="pl5 f11 ff ls fc2 fb"><%=tel%></td>
				</tr>
				<tr height="20">
					<th bgcolor="#eeeeee" class="f11 ls">선장연락처</th>
					<td class="pl5 f11 ff ls fc2"><%=captel%></td>
				</tr>
				<!--
				<tr height="20">
					<th bgcolor="#eeeeee" class="f11 ls">선장주소</th>
					<td class="pl5 f11 ff ls"><%=capaddr%></td>
				</tr>
				//-->
				<tr height="30">
					<td class="ct vb" colspan="2"><img src="/img/box/boss_talk.png" title="선장님 한마디" /></td>
				</tr>
				<tr>
					<td class="fc9 pl5 pb20" colspan="2"><%=db2html(memo)%></td>
				</tr>
			</table>
		</td>
		<td width="20"></td>
	</tr>
</table>
<%	dbc() %>
