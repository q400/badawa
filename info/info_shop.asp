<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	tag							= 2
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
			mousewheel:true,
			keyboard:true,
			shownavitems:5,
			auto:true,
			panelfxspeed:50,				//하단 text 뿌려지는 속도
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
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-info-shop.css" media="screen, projection" />

<!-- Slider Kit compatibility -->
<!--[if IE 6]><link rel="stylesheet" type="text/css" href="../lib/css/sliderkit-demos-ie6.css" /><![endif]-->
<!--[if IE 7]><link rel="stylesheet" type="text/css" href="../lib/css/sliderkit-demos-ie7.css" /><![endif]-->
<!--[if IE 8]><link rel="stylesheet" type="text/css" href="../lib/css/sliderkit-demos-ie8.css" /><![endif]-->

<!-- Site styles -->
<!-- <link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-site.css" media="screen, projection" /> -->
<style type="text/css">
#videobcg {
	/*position: relative;*/
	top: 0px;
	left: 0px;
	min-width: 100%;
	min-height: 100%;
	width: 400px;
	height: auto;
	z-index: -1000;
	overflow: hidden;
	volume: 10%;
}
</style>


<div id="wrap">
	<div>
		<ul>
			<li class="ib vt" style="width:230px;"><!-- #include virtual = "/inc/left/info.asp" --></li>
			<li class="ib vt">
				<div id="mainwrap4">
					<div class="mt20"><img src="/img/info_tle.gif" width="209" height="24" alt="낚시배소개" /></div>
					<div class="mt10 mb30"><img src="/img/info_ah_tle.gif" width="193" height="18" title="안흥낚시소개"></div>
					<div style="width:840px; height:100%; border:0px solid #000;">
						<!-- Start photosgallery-captions -->
						<div style="width:400px;" class="ib">
							<div class="sliderkit photosgallery-captions">
								<div class="sliderkit-nav">

									<div class="sliderkit-nav-clip">
										<ul>
<%
		rso()				'하단 썸네일 navi
		SQL = " SELECT idx, gubn, fnm, fwd, fsz, ext, comment FROM _ocmmt010 WHERE gubn = 'photo' "
		rs.open SQL, dbcon
		While Not rs.eof
%>
											<li><a href="#" rel="nofollow" title="<%=rs("comment")%>"><img src="/data/intro/<%=rs("fnm")%>" width="100%" alt="<%=rs("comment")%>" /></a></li>
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
		SQL = " SELECT idx, gubn, fpath, fnm, fwd, fsz, ext, comment FROM _ocmmt010 WHERE gubn = 'photo' "
		rs.open SQL, dbcon
		While Not rs.eof
%>
									<div class="sliderkit-panel">
										<img src="/<%=rs("fpath")%>/<%=rs("fnm")%>" alt="<%=rs("comment")%>" title="<%=rs("comment")%>" />
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
						</div>
						<!-- // end of photosgallery-captions -->
						<div class="vt ml10 ib" style="width:400px;">
							<ul class="vt">
								<li><img src="/img/bbs/intro01.gif"></li>
								<li style="height:40px;" class="mt30 f13">안흥낚시는 선상낚시로 유명한 <b>충남 태안군 안흥항</b>에 위치하고 있으며,</li>
								<li style="height:60px;" class="f13">30여년전 시작한 선상낚시의 오랜 경험에서 비롯된 노하우를 바탕으로,<br/>다양한 낚시를 즐기실 수 있는 선박을 보유하고 있습니다.</li>
								<li class="f13">낚시인 여러분이 원하는 정보와 서비스를 가지고<br/>성심 성의껏 최선을 다해 모실 것을 약속 드리면서</li>
								<li style="height:50px;" class="mt30 f13">언제나 즐겁고 행복한 바다낚시가 되시기를 진심으로 기원합니다.</li>
							</ul>
						</div>
					</div>
					<div style="width:840px; height:100%; border:0px solid #000;">
						<div style="width:400px;" class="ib">
							<video id="videobcg" preload="auto" autoplay="false" loop="noloop" controls muted>
<%
		rso()				'동영상
		SQL = " SELECT idx, gubn, fpath, fnm, fwd, fsz, ext, comment FROM _ocmmt010 WHERE gubn = 'movie' "
		rs.open SQL, dbcon
		If Not rs.eof Then
%>
								<source src="/<%=rs("fpath")%>/<%=rs("fnm")%>" type="video/mp4" />
								<!-- <source src="http://badawa.negagea.com/vod/intro/title01.mp4" type="video/mp4" /> -->
<%
		End If
		rsc()
%>
							</video>
						</div>
						<div class="vt ml10 ib" style="width:400px;">
							<ul class="vt">
								<li class="ib mt30"><span class="f13"><b>○ 전&nbsp;화&nbsp;번&nbsp;호</b>&nbsp;: <font class="ff f15 ls fc9 fb">041-675-1133 / 041 674-1295</font><span></li>
								<li class="ib mt30"><span class="f13"><b>○ 휴대폰번호</b>&nbsp;: <font class="ff f15 ls fc9 fb">010-3669-2911 / 010-2052-6632</font></span></li>
								<li class="ib mt30"><span class="f13"><b>○ 주 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</b> : 충남 태안군 근흥면 정죽리 1302</span></li>
								<li class="ib mb20"><span style="padding-left:87px;" class="f13">(신주소 안흥1길 30-1)</span></li>
								<li class="ib mt30"><span height="60" style="padding-left:87px;" class="f17">안흥낚시 대표&nbsp;&nbsp;&nbsp; <b>양 주 영</b></span></li>
							</ul>
						</div>
					</div>
					<div class="pt20 pb20">&nbsp;</div>
				</div>
			</li>
			<li class="ib vt"><!-- #include virtual = "/inc/quick.asp" --></li>
		</ul>
	</div>
</div>
<!-- #include virtual = "/inc/footer.asp" -->