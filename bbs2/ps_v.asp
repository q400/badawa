<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	seq							= SQLI(Request("seq"))
	cd1							= SQLI(Request("cd1"))			'검색조건
	cd2							= SQLI(Request("cd2"))			'검색단어
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))
'	Response.Write "<font color=#ffffff>auth : "& FID_AUTH &"</font><br>"

	If seq = "" Then
			Call JSalert("선택된 조황후기가 없습니다.        ")
			Response.End
	End If

	If seq <> "" Then
		rso()
		SQL = " SELECT seq, shipid, title, uno, uip, cnt, rdate, ddate FROM _obbst050 WHERE seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			shipid				= rs("shipid")
			title				= rs("title")
			uno					= rs("uno")
			uip					= rs("uip")
			cnt					= rs("cnt")
			rdate				= rs("rdate")
			ddate				= rs("ddate")
		End If
		rsc()

		rso()
		SQL = " SELECT ISNULL(COUNT(*),0) FROM _obbst051 WHERE seq = "& seq
		rs.open SQL, dbcon
			file_cnt = rs(0)
		rsc()
	End If

	pvP = 0
	ntP = 0

	rso()					'이전글
	SQL = " SELECT TOP 1 seq, title FROM _obbst050 WHERE seq < "& seq &" ORDER BY seq DESC "
	rs.open SQL, dbcon
	If Not rs.eof Then
		pvP = rs(0)
		pvTitle = rs(1)
	End If
	rsc()

	rso()					'다음글
	SQL = "	SELECT TOP 1 seq, title FROM _obbst050 WHERE seq > "& seq &" ORDER BY seq "
	rs.open SQL, dbcon
	If Not rs.eof Then
		ntP = rs(0)
		ntTitle = rs(1)
	End If
	rsc()

	SQL = " UPDATE _obbst050 SET cnt = cnt + 1 WHERE seq = "& seq
	dbcon.Execute SQL
%>

<!-- jQuery Plugin scripts -->
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-core.css" media="screen, projection" />
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-ps.css" media="screen, projection" />

<!-- <script type="text/javascript" src="/lib/js/external/_oldies/jquery-1.3.min.js"></script> dialog Event 에 문제 발생 -->
<script type="text/javascript" src="/lib/js/external/jquery.easing.1.3.min.js"></script>
<script type="text/javascript" src="/lib/js/external/jquery.mousewheel.min.js"></script>

<script type="text/javascript" src="/lib/js/sliderkit/jquery.sliderkit.1.9.2.pack.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.delaycaptions.1.1.pack.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.counter.1.0.pack.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.timer.1.0.pack.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.imagefx.1.0.pack.js"></script>

<!-- Slider Kit launch -->

<script language="javascript">
<!--
function goDelete() {
	var f = document.fm1;
	if (confirm("삭제하시겠습니까?")) {
		f.flag.value = "D";
		f.action = "ps_x.asp";
		f.method = "post";
//		f.target = "nullframe";
		f.submit();
	}
}
function goAfter() {
	var f = document.fm1;
<%	If FID_ID = "" Then %>
	alert("로그인이 필요합니다.         ");
	this.document.location = "/mem/login.asp?preURL=/bbs2/ps_v.asp?seq=<%=seq%>&page=<%=page%>";
	return;
<%	End If %>
	if (f.comment.value == "") {
		alert("덧글 내용을 입력하세요.       ");
		f.comment.focus();
	} else if (f.comment.value.length < 5) {
		alert("최소 5자 이상은 입력하세요.       ");
		f.comment.focus();
	} else if (f.comment.value.length > 1000) {
		alert("내용이 너무 깁니다. 줄이세요... -_-       ");
		f.comment.focus();
	} else {
		f.flag.value = "A";
		f.action = "ps_x.asp";
		f.method = "post";
//		f.target = "nullframe";
		f.submit();
	}
}
function delAfter(vSeq) {
	var f = document.fm1;
	if(!confirm("삭제하겠습니까?     ")) {
		return;
	}
	f.idx.value = vSeq;
	f.flag.value = "AD";
//	f.target = "nullframe";
	f.action = "ps_x.asp";
	f.submit();
}
function showAlert() {
	alert("로그인이 필요합니다.         ");
	this.document.location = "/mem/login.asp?preURL=/bbs2/ps_v.asp?seq=<%=seq%>&page=<%=page%>";
	return;
}
function goBasket(gcode) {					//액자신청하기
	var f = document.fm2;
<%	If FID_NO = "" Then %>
	alert("My앨범에 담으시려면 로그인이 필요합니다.         ");
	this.document.location = "/mem/login.asp?preURL=/bbs2/ps_v.asp?seq=<%=seq%>";
	return;
<%	End If %>
	if (confirm("["+ gcode +"] 이 사진을 My앨범에 담겠습니까?         ")) {
		f.idx.value = gcode;
		f.op.value = "ps";
		f.method = "post";
		f.action = "basket_x.asp";
		f.submit();
		if (confirm("My앨범에 담겼습니다. My앨범을 보시겠습니까?         ")) {
			f.method = "post";
			f.target = "_top";
			f.action = "/my/album.asp";
			f.submit();
		} else {
			return;
		}
	} else {
		return;
	}
}
//-->
</script>
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
			mousewheel:true,
			keyboard:true,
			shownavitems:7,
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

<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td>
			<table width="1200" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="250" valign="top"><!-- #include virtual = "/inc/left/fish.asp" --></td>
					<td width="710" valign="top">

<form name="fm1" method="post" enctype="multipart/form-data">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="cd1" value="<%=cd1%>">
<input type="hidden" name="cd2" value="<%=cd2%>">
<input type="hidden" name="flag">
<input type="hidden" name="idx">
<input type="hidden" name="op">

						<table width="710" border="0" cellspacing="0" cellpadding="0">
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
								<td><img src="/img/fish_ps.gif" width="180" height="18" alt="조황후기" /></td>
							</tr>
							<tr>
								<td height="15"></td>
							</tr>
							<tr>
								<td>
									<table width="800" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="600"><font class="f17 fz fb fc8 ls"><%=rdate%>&nbsp;&nbsp;<%=meminfo(uno,"unamee")%> 님의 조황후기입니다.</font></td>
											<td class="rg">
												<meta name="description" content="<%=title%>"/>
												<a href="#" onClick="twitterOpen('<%=snsRoots%>/bbs1/ps_v.asp?shipid=<%=shipid%>&seq=<%=seq%>');return false;"><img alt="트위터에 공유하기" src="/img/icon/_twitter.gif" /></a> &nbsp;<a href="#" onClick="facebookOut('<%=snsRoots%>/bbs1/ps_v.asp?shipid=<%=shipid%>&seq=<%=seq%>');return false;"><img alt="페이스북에 공유하기" src="/img/icon/_facebook.gif" /></a> &nbsp;<a href="#" onClick="me2DayOpen('<%=snsRoots%>/bbs1/ps_v.asp?shipid=<%=shipid%>&seq=<%=seq%>');return false;"><img alt="미투데이에 공유하기" src="/img/icon/_me2day.gif" /></a> &nbsp;<a href="#" onClick="yozmOpen('<%=snsRoots%>/bbs1/ps_v.asp?shipid=<%=shipid%>&seq=<%=seq%>');return false;"><img alt="요즘에 공유하기" src="/img/icon/_yozm.gif" /></a>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="6"></td>
							</tr>
							<tr>
								<td height="1" bgcolor="dfdfdf" colspan="3"></td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>
							<tr>
								<td align="center">

						<!-- Start photosgallery-captions -->
						<div class="sliderkit photosgallery-captions">
							<div class="sliderkit-nav">

								<div class="sliderkit-nav-clip">
									<ul>
<%
		rso()				'하단 썸네일 navi
		SQL = " SELECT idx, seq, fpath, fnm, fwd, fsz, ext, comment FROM _obbst051 WHERE seq = "& seq
		rs.open SQL, dbcon
		While Not rs.eof
%>
										<li><a href="#" rel="nofollow" title="<%=rs("comment")%>"><img src="<%=rs("fpath") &"/"& rs("fnm")%>" width="100%" alt="<%=rs("comment")%>" /></a></li>
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
		SQL = " SELECT idx, seq, fpath, fnm, fwd, fsz, ext, comment FROM _obbst051 WHERE seq = "& seq
		rs.open SQL, dbcon
		While Not rs.eof
%>
								<div class="sliderkit-panel" title="마우스 휠을 이용하여 다음 사진을 볼 수 있습니다.     사진을 클릭하여 액자신청을 할 수 있습니다.">
									<img src="<%=rs("fpath") &"/"& rs("fnm")%>" alt="<%=rs("comment")%>" title="<%=rs("comment")%>" onClick="goBasket(<%=rs("idx")%>);" />
									<div class="sliderkit-panel-text">
										<div class="sliderkit-panel-textbox" style="padding-bottom:20px;">
											<div class="sliderkit-panel-text" class="vt">
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
							<tr>
								<td height="6"></td>
							</tr>
							<tr>
								<td height="1" bgcolor="dfdfdf" colspan="3"></td>
							</tr>

							<!-- 한줄 댓글 시작 -->
							<tr>
								<td height="2" bgcolor="83d4cd"></td>
							</tr>
							<tr>
								<td bgcolor="#83d4cd" class="ct">
									<table width="796" border="0" cellspacing="0" cellpadding="0" align="center">
										<tr height="56" bgcolor="#ffffff">
											<td width="180"><img src="/img/reply_tle.gif" width="144" height="23"></td>
											<td>
												<textarea name="comment" style="width:500px; height:50px; ime-mode:active;" class="tarea"<%If FID_ID = "" Then%> onClick="showAlert();" onKeyDown="showAlert();"<%End If%>></textarea>
											</td>
											<td width="100" class="ct"><a href="javascript:goAfter();"><img src="/img/btn_reply.gif" width="61" height="38"></a></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="2" bgcolor="83d4cd"></td>
							</tr>
							<tr>
								<td height="5"></td>
							</tr>
<%		'덧글
		rso()
		SQL = " SELECT idx, seq, uno, ddate, comment FROM _obbst052 WHERE seq = "& seq &" ORDER BY idx DESC "
		rs.open SQL, dbcon
		If Not rs.eof Then
			While Not rs.eof
%>
							<tr>
								<td height="70">
									<div id="app">
										<span><img src="<%=memPhoto(rs("uno"))%>" width="60" class="vt gbox03"></span>
										<span class="ib pl15">
											<b><%=meminfo(rs("uno"),"unamee")%></b> (<%=rs("ddate")%>)
											<%If CInt(FID_NO) = rs("uno") Or FID_AUTH <= 10 Then%>
											<a href="javascript:delAfter(<%=rs("idx")%>);"><img src="/img/rpy_delete.gif" width="13" height="13" class="vm"></a>
											<%End If%>
											<br>
											<%=db2html(rs("comment"))%>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<td height="1" bgcolor="#d8d8d8"></td>
							</tr>
<%
				rs.MoveNext
			Wend
		End If
		rsc()
%>
							<tr>
								<td>&nbsp;</td>
							</tr>
</form>
<form name="fm2" method="post">
<input type="hidden" name="flag">
<input type="hidden" name="idx">
<input type="hidden" name="op">
<input type="hidden" name="wdate" value="<%=rdate%>">
</form>
							<tr>
								<td height="10"></td>
							</tr>
							<tr>
								<td class="rg">
<%
		If FID_NO <> "" Then
			If CInt(FID_NO) = uno Or FID_AUTH = 1 Then
%>
									<a href="ps_w.asp?seq=<%=seq%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&flag=M" class="btn btn25"><span>수정</span></a>
									<a href="javascript:goDelete();" class="btnr btn25"><span>삭제</span></a>
<%
			End If
		End If
%>
									<a href="ps.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn25"><span>목록</span></a>
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
<!-- #include virtual = "/inc/footer.asp" -->