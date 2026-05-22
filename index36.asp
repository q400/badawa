<!-- #include virtual = "/inc/header2.asp" -->
<%
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

	If op <> "pc" Then
'		Response.Write "value : "& mobile_device_detect() &"<br>"
		If mobile_device_detect() = True Then
			Us = "https://www.badawa.co.kr/m/"		'Mobile 메인
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
	End If
%>

<!-- jQuery Plugin scripts -->
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-core.css" media="screen, projection" />
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-index.css" media="screen, projection" />

<script type="text/javascript" src="/lib/js/jquery-ui-1.8.17.custom.min.js"></script>
<script type="text/javascript" src="/lib/js/external/_oldies/jquery-1.3.min.js"></script>
<script type="text/javascript" src="/lib/js/external/jquery.easing.1.3.min.js"></script>
<script type="text/javascript" src="/lib/js/external/jquery.mousewheel.min.js"></script>

<!-- Site styles -->
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-site.css" media="screen, projection" />

<script type="text/javascript" src="/lib/js/sliderkit/jquery.sliderkit.1.9.2.pack.js"></script>
<!-- <script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.delaycaptions.1.1.pack.js"></script> -->
<!-- <script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.counter.1.0.pack.js"></script> -->
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.timer.1.0.pack.js"></script>

<!-- Slider Kit launch -->
<script type="text/javascript">
	$(document).ready(function(){		// ie6 체크 스크립트
		var isIe6 = false;
		if (isIe6){
			alert("인터넷 익스플로러 8.0 이상을 사용해 주세요.");
		}
	});
	$(window).load(function(){ //$(window).load() must be used instead of $(document).ready() because of Webkit compatibility
			// Photo gallery > Standard
			$( '.photosgallery-std' ).sliderkit({
				shownavitems:5,
				auto:true,
				autospeed:5000,
				autostill:true,
				circular:true,
				timer:{
					fadeout:5
				}
			});
	});
</script>

<!-- #include virtual = "/inc/top_m.asp" -->


<div id="wrap">
	<!-- Start photosgallery-std -->
	<div class="sliderkit photosgallery-std timer-demo02" id="bg-img" style="top:-10px; min-width:100%; height:80%; z-index:20;">
		<div class="sliderkit-timer-wrapper">
			<div class="sliderkit-timer"></div>
		</div>
		<div class="sliderkit-panels">
			<div class="sliderkit-panel">
				<img src="/img/box/m0001.jpg" style="width:100%;height:100%;" alt="바다와" />
			</div>
			<div class="sliderkit-panel">
				<img src="/img/box/m0002.jpg" style="width:100%;height:100%;" alt="바다와" />
			</div>
			<div class="sliderkit-panel">
				<img src="/img/box/m0003.jpg" style="width:100%;height:100%;" alt="바다와" />
			</div>
			<div class="sliderkit-panel">
				<img src="/img/box/m0004.jpg" style="width:100%;height:100%;" alt="바다와" />
			</div>
			<!--
			<div class="sliderkit-panel">
				<img src="/img/box/m_img01.jpg" alt="바다와" />
			</div>
			//-->
			<div class="sliderkit-panel">
				<img src="/img/box/m0005.jpg" style="width:100%;height:100%;" alt="바다와" />
			</div>
			<div class="sliderkit-panel">
				<img src="/img/box/m0006.jpg" style="width:100%;height:100%;" alt="바다와" />
			</div>
			<div class="sliderkit-panel">
				<img src="/img/box/m0007.jpg" style="width:100%;height:100%;" alt="바다와" />
			</div>
			<div class="sliderkit-panel">
				<img src="/img/box/m0008.jpg" style="width:100%;height:100%;" alt="바다와" />
			</div>
		</div>
	</div>
	<!-- // end of photosgallery-std -->

	<!-- #include virtual = "/inc/calen.asp" -->
<%
	rso()
	SQL = " SELECT max(seq) FROM _obbst040 "
	rs.open SQL, dbcon
	If Not rs.eof Then
		maxseq = rs(0)
	End If
	rsc()
%>

	<div style="position:absolute; bottom:10%; z-index:300; background:#eee;" class="">
		<div style="">
			<div id="menu" style="width:100%; height:120px; margin-left:35px;">
				<img src="/img/box/middle3.png" usemap="#map09">
				<map name="map09">
				<area shape="rect" coords="1, 10, 160, 110" style="cursor:pointer;" href="/rsv/" alt="낚시배예약">
				<area shape="rect" coords="170, 10, 350, 110" style="cursor:pointer;" href="/bbs2/gallery3.asp" alt="조황갤러리">
				<area shape="rect" coords="360, 10, 530, 110" style="cursor:pointer;" href="/bbs2/movie.asp" alt="낚시동영상">
				<!-- <area shape="rect" coords="360, 10, 530, 110" style="cursor:pointer;" href="/bbs2/movie_v.asp?seq=<%=maxseq%>" alt="낚시동영상"> -->
				<area shape="rect" coords="550, 17, 700, 55" style="cursor:pointer;" href="http://www.kma.go.kr/weather/forecast/marine_daily.jsp?topArea=12A20000&midArea=12A20100&btmArea=12A20103&x=18&y=12" target="_blank" alt="한국기상정보">
				<area shape="rect" coords="707, 17, 860, 55" style="cursor:pointer;" href="/info/weather02.asp" alt="일본기상정보">
				<area shape="rect" coords="866, 17, 1015, 55" style="cursor:pointer;" href="https://www.windfinder.com/forecast/sinjindo?utm_source=www.windfinder.com&utm_medium=web&utm_campaign=redirect&utm_content=http://bluefishingho.co.kr/ " target="_blank" alt="미국기상정보">
				<area shape="rect" coords="550, 63, 700, 105" style="cursor:pointer;" href="#" onClick="return mpop3('/info/help.asp','ev','center',860,880,55);" alt="예약도우미">
				<area shape="rect" coords="707, 63, 860, 105" style="cursor:pointer;" href="/bbs1/faq.asp" alt="자주묻는질문">
				<area shape="rect" coords="866, 63, 1015, 105" style="cursor:pointer;" href="/info/time.asp" alt="조석/물때표">
				</map>
			</div>
		</div>

		<div style="">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#ffffff">
					<td>
						<table width="1100" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="40"></td>
								<td width="280" class="vt">
									<table width="280" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="23"><a href="/bbs1/notice.asp"><img src="/img/m_news_tle.gif" width="64" height="13" class="vb" alt="공지사항" title="공지사항"></a></td>
										</tr>
										<tr>
											<td height="6"></td>
										</tr>
<%
	rso()
	SQL = " SELECT TOP 3 seq, title, ddate FROM _obbst010 WHERE bbs_id = 10 AND seq <> 59 ORDER BY ddate DESC "
	rs.open SQL, dbcon
	If Not rs.eof Then
		While Not rs.eof
%>
										<tr>
											<td class="vt">
												<img src="/img/dot01.gif" width="4" height="3" class="vm">
												<a href="/bbs1/notice_v.asp?seq=<%=rs("seq")%>"><%=trimtext(rs("title"),17)%>&nbsp;&nbsp;<font class="fc1 ff ls"><%=Left(rs("ddate"),10)%></font></a>
												<%If Date() - rs("ddate") < 2 Then%><img src="/img/icon/new03.gif" width="11" height="11"><%End If%>
											</td>
										</tr>
<%
			rs.MoveNext
		Wend
	Else
%>
										<tr>
											<td height="50" class=""><img src="/img/dot01.gif" width="4" height="3" class="vm">&nbsp;"공지사항이 없습니다."</td>
										</tr>
<%
	End If
	rsc()
%>
										<tr>
											<td height="6"></td>
										</tr>
									</table>
								</td>
								<td width="28">&nbsp;</td>
								<td width="280" class="vt">
									<table width="280" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="23"><a href="/bbs1/qna.asp"><img src="/img/m_qna_tle.gif" width="72" height="13" class="vb" alt="문의게시판" title="문의게시판"></a></td>
										</tr>
										<tr>
											<td height="6"></td>
										</tr>
										<tr>
<%
	rso()
	SQL = " SELECT TOP 3 seq, title, ddate FROM _obbst030 ORDER BY ddate DESC "
	rs.open SQL, dbcon
	If Not rs.eof Then
		While Not rs.eof
%>
										<tr>
											<td class="vt">
												<img src="/img/dot01.gif" width="4" height="3" class="vm">
												<a href="/bbs1/qna_v.asp?seq=<%=rs("seq")%>"><%=trimtext(rs("title"),17)%>&nbsp;&nbsp;<font class="fc1 ff ls"><%=Left(rs("ddate"),10)%></font></a>
												<%If Date() - rs("ddate") < 2 Then%><img src="/img/icon/new03.gif" width="11" height="11"><%End If%>
											</td>
										</tr>
<%
			rs.MoveNext
		Wend
	Else
%>
										<tr>
											<td height="50" class=""><img src="/img/dot01.gif" width="4" height="3" class="vm">&nbsp;"문의글이 없습니다."</td>
										</tr>
<%
	End If
	rsc()
%>
										</tr>
										<tr>
											<td height="6"></td>
										</tr>
									</table>
								</td>
								<td width="30">&nbsp;</td>
								<td width="182"><img src="/img/m_baner_bank.png" width="182" height="99"></td>
								<td width="35">&nbsp;</td>
								<td><img src="/img/m_baner_tell.gif" width="182" height="99"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>

<%
	nowdate = Date()

	rso()
	SQL = " SELECT	seq, sdate, edate, title, fnm, ttop, lleft, winw, winh, link, ddate, contents " _
		& " FROM	_opopt010 " _
		& " WHERE	'"& nowdate &"' BETWEEN sdate AND edate "
'	Response.Write SQL &"<br>"
	rs.open SQL, dbcon
	j = 1
	While Not rs.eof
		sdate					= ""
		edate					= ""
		title					= ""
		fnm						= ""
		ttop					= ""
		lleft					= ""
		winw					= ""
		winh					= ""
		link					= ""
		contents				= ""
		sdate					= rs("sdate")
		edate					= rs("edate")
		title					= rs("title")
		fnm						= rs("fnm")
		ttop					= rs("ttop")
		lleft					= rs("lleft")
		winw					= rs("winw")
		winh					= rs("winh")
		link					= rs("link")
		contents				= rs("contents")
%>

<div class="popupLayer<%=j%>" style="display:none; z-index:10; position:absolute; top:<%=ttop%>px; left:<%=lleft%>px; border:2px solid #fff; background-color:#000; <%If title <> "제목없음" Then%>opacity:0.8; filter:alpha(opacity=70);"<%End If%>>
<table width="<%=winw%>" height="<%=winh%>" align="center" border="0" cellpadding="0" cellspacing="0">
<form name="pop<%=j%>">
	<tr>
		<td height="15"></td>
	</tr>
	<tr>
		<td class="vt">
			<table width="<%=winw-30%>" height="<%=winh-30%>" align="center" border="0" cellpadding="0" cellspacing="0">
<%		If title <> "제목없음" Then %>
				<tr>
					<td height="50"><b class="fcw"><%=title%></b></td>
				</tr>
<%		End If %>
<%		If contents <> "" Then %>
				<tr>
					<td class="vt">
<%			If link = "" Then %>
						<span class="fcw"><%=db2html(contents)%></span>
<%			Else %>
						<a href="<%=link%>"><span class="fcw"><%=db2html(contents)%></span></a>
<%			End If %>
					</td>
				</tr>
<%		End If %>
<%		If fnm <> "" Then %>
				<tr>
					<td class="vt ct">
<%			If link = "" Then %>
						<img src="/data/notice/<%=fnm%>">
<%			Else %>
						<a href="<%=link%>"><img src="/data/notice/<%=fnm%>"></a>
<%			End If %>
					</td>
				</tr>
<%		End If %>
			</table>
		</td>
	</tr>
	<tr height="20">
		<td bgcolor="#dfdfdf" class="rg">
			<a href="javascript:javascript:closeWin('pop<%=j%>',<%=j%>);">
			<img src="/img/icon/delete_2.gif" class="vm">&nbsp;&nbsp;<span class="fc1 ff f11">오늘 하루 창을 열지 않습니다.</span>&nbsp;
			</a>
		</td>
	</tr>
</form>
</table>
</div>
<%
		rs.MoveNext
		j = j + 1
	Wend
	rsc()
%>
<script type="text/javascript">
<!--
function getCookie(name){
	var nameOfCookie = name + "=";
	var x = 0;
	while (x <= document.cookie.length){
		var y = (x+nameOfCookie.length);
		if (document.cookie.substring(x,y) == nameOfCookie){
			if ((endOfCookie = document.cookie.indexOf(";",y)) == -1)
				endOfCookie = document.cookie.length;
			return unescape(document.cookie.substring(y,endOfCookie));
		}
		x = document.cookie.indexOf(" ",x) + 1;
		if (x == 0)
			break;
	}
	return "";
};
//쿠키생성
function setCookie(name,value,expiredays){
	var todayDate = new Date();
	todayDate.setDate(todayDate.getDate() + expiredays);
	document.cookie = name + "="+ escape(value) +"; path=/; expires="+ todayDate.toGMTString() +";";
};
function closeWin(ele,ix){
	setCookie(ele,"done",1);
	$('.popupLayer'+ ix).css('display','none');
};
if (getCookie("pop1") != "done"){
	$('.popupLayer1').css('display','block');
}
if (getCookie("pop2") != "done"){
	$('.popupLayer2').css('display','block');
}
if (getCookie("pop3") != "done"){
	$('.popupLayer3').css('display','block');
}
//-->
</script>

<!-- #include virtual = "/inc/footer.asp" -->
