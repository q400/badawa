<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	seq							= SQLI(Request("seq"))
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	page						= SQLI(Request("page"))
	op							= SQLI(Request("op"))

	If seq = "" Then
			Call JSalert("선택된 조황후기가 없습니다.        ")
			Response.End
	End If

	If seq <> "" Then
		rso()
		SQL = " SELECT seq, shipid, title, uno, unm, uip, cnt, rdate, ddate FROM _obbst050 WHERE seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			shipid				= rs("shipid")
			title				= rs("title")
			uno					= rs("uno")
			unm					= rs("unm")
			uip					= rs("uip")
			cnt					= rs("cnt")
			rdate				= rs("rdate")
			ddate				= rs("ddate")
		End If
		rsc()

		rso()
		SQL = " SELECT IFNULL(COUNT(*),0) FROM _obbst051 WHERE seq = "& seq
		rs.open SQL, dbcon
			file_cnt = CInt(rs(0))
		rsc()
	End If

	pvP = 0
	ntP = 0

	rso()					'이전글
	SQL = " SELECT	seq, title FROM _obbst050 WHERE seq < "& seq &" ORDER BY seq DESC LIMIT 1 "
	rs.open SQL, dbcon
	If Not rs.eof Then
		pvP = rs(0)
		pvTitle = rs(1)
	End If
	rsc()

	rso()					'다음글
	SQL = "	SELECT	seq, title FROM _obbst050 WHERE seq > "& seq &" ORDER BY seq LIMIT 1 "
	rs.open SQL, dbcon
	If Not rs.eof Then
		ntP = rs(0)
		ntTitle = rs(1)
	End If
	rsc()

	rso()					'포인트 적립여부
	SQL = " SELECT	COUNT(*) FROM _opntt010 WHERE seq = "& seq &" AND op = '+' "
	rs.open SQL, dbcon
	If Not rs.eof Then
		cpnt = CInt(rs(0))
	End If
	rsc()

	msg = "조황후기로 포인트를 적립해 드립니다. 앞으로도 많은 참여 부탁드립니다...^^"
%>

<!-- jQuery Plugin scripts -->
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-core.css" media="screen, projection" />
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-demos.css" media="screen, projection" />

<script type="text/javascript" src="/lib/js/external/_oldies/jquery-1.3.min.js"></script>
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

<script language="javascript">
<!--
function PointPlus(ppnt){
	var f = document.fm1;
	if(confirm("<%=unm%>님에게 "+ ppnt +"원을 적립합니까?       ")){
		f.flag.value = "PP";
		f.action = "ps_x.asp";
		f.method = "post";
		f.target = "nullframe";
		f.submit();
	}
}
function PointMinus(ppnt){
	var f = document.fm1;
	if(confirm("<%=unm%>님의 "+ ppnt +"원을 차감합니까?       ")){
		f.flag.value = "PM";
		f.action = "ps_x.asp";
		f.method = "post";
		f.target = "nullframe";
		f.submit();
	}
}
function goDelete(){
	var f = document.fm1;
	if(confirm("삭제하시겠습니까?       ")){
		f.flag.value = "D";
		f.action = "ps_x.asp";
		f.method = "post";
		//f.target = "nullframe";
		f.submit();
	}
}
function goAfter(){
	var f = document.fm1;
<%	If FID_ID = "" Then %>
	alert("로그인이 필요합니다.         ");
	this.document.location = "/mem/login.asp?preURL=/my/ps_v.asp?seq=<%=seq%>&page=<%=page%>";
	return;
<%	End If %>
	if(f.comment.value == ""){
		alert("덧글 내용을 입력하세요.       ");
		f.comment.focus();
	}else if(f.comment.value.length < 5){
		alert("최소 5자 이상은 입력하세요.       ");
		f.comment.focus();
	}else if(f.comment.value.length > 1000){
		alert("내용이 너무 깁니다. 줄이세요... -_-       ");
		f.comment.focus();
	}else{
		f.flag.value = "A";
		f.action = "ps_x.asp";
		f.method = "post";
		f.target = "nullframe";
		f.submit();
	}
}
function delAfter(vSeq){
	var f = document.fm1;
	if(!confirm("삭제하겠습니까?     ")){
		return;
	}
	f.idx.value = vSeq;
	f.flag.value = "AD";
	f.target = "nullframe";
	f.action = "ps_x.asp";
	f.submit();
}
function showAlert(){
	alert("로그인이 필요합니다.         ");
	this.document.location = "/mem/login.asp?preURL=/my/ps_v.asp?seq=<%=seq%>&page=<%=page%>";
	return;
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


<table width="100%" border="0" cellspacing="0" cellpadding="0">
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
						<table width="854" border="0" cellspacing="0" cellpadding="0">

<form name="fm1" method="post">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="cd1" value="<%=cd1%>">
<input type="hidden" name="cd2" value="<%=cd2%>">
<input type="hidden" name="pnt" value="<%=file_cnt * pnt_ps%>">
<input type="hidden" name="flag">
<input type="hidden" name="idx">

							<tr>
								<td>
									<table width="854" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td><img src="/img/adm/box01.gif" width="854" height="14"></td>
										</tr>
										<tr>
											<td align="center" background="/img/adm/box03.gif">
												<table width="800" border="0" cellspacing="0" cellpadding="0" class="lf">
													<tr height="46">
														<td width="200" class="fc2 fb">조황후기</td>
														<td align="right"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td height="2" align="center" background="/img/adm/box03.gif">
												<table width="800" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="2" bgcolor="666666"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr class="vm">
											<td background="/img/adm/box03.gif" class="rg pt10 pb10 pr20">
												<span class="ff fcb f12">등록자 : <%=unm%> (<%=ddate%>)</span>&nbsp;&nbsp;&nbsp;
											</td>
										</tr>
										<tr>
											<td align="center" background="/img/adm/box03.gif">

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
								<div class="sliderkit-panel">
									<img src="<%=rs("fpath") &"/"& rs("fnm")%>" alt="<%=rs("comment")%>" title="<%=rs("comment")%>" />
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
										<tr class="vm">
											<td background="/img/adm/box03.gif" class="lf pl20 pt10 pb10">&nbsp;&nbsp;&nbsp;
												<span class="ff fc7">※ 사진 개수 <b><%=file_cnt%></b> 장 × 사진 당 포인트 <%=pnt_ps%> 점 = <b><%=file_cnt * pnt_ps%></b> 원 적립합니다.</span>
											</td>
										</tr>

										<!-- 한줄 댓글 시작 -->
										<tr>
											<td background="/img/adm/box03.gif">
												<table width="800" border="1" cellspacing="0" cellpadding="0" align="center" bordercolor="#CCCCCC" style="border-collapse:collapse;">
													<tr>
														<td align="center">
															<table width="796" border="0" cellspacing="0" cellpadding="0" align="center">
																<tr height="56">
																	<td width="180" bgcolor="#ffffff"><img src="/img/reply_tle.gif" width="144" height="23"></td>
																	<td bgcolor="#ffffff">
																		<textarea name="comment" style="width:500px; height:50px; ime-mode:active;" class="tarea"><%=msg%></textarea>
																	</td>
																	<td width="100" class="ct" bgcolor="#ffffff"><a href="javascript:goAfter();"><img src="/img/btn_reply.gif" width="61" height="38"></a></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td background="/img/adm/box03.gif">
												<table width="800" border="0" cellspacing="0" cellpadding="0" align="center">
<%		'덧글
		rso()
		SQL = " SELECT idx, seq, uno, ddate, comment FROM _obbst052 WHERE seq = "& seq &" ORDER BY idx DESC "
		rs.open SQL, dbcon
		If Not rs.eof Then
			While Not rs.eof
%>
													<tr>
														<td height="30" class="lf">
															<b><%=meminfo(rs("uno"),"unamee")%></b> (<%=rs("ddate")%>)
															<a href="javascript:delAfter(<%=rs("idx")%>);"><img src="/img/rpy_delete.gif" width="13" height="13" align="absmiddle"></a>
														</td>
													</tr>
													<tr>
														<td class="lf" style="padding:0 0 5px 20px;"><%=db2html(rs("comment"))%></td>
													</tr>
													<tr>
														<td height="1" bgcolor="d8d8d8"></td>
													</tr>
<%
				rs.MoveNext
			Wend
		End If
		rsc()
%>
												</table>
											</td>
										</tr>

										<tr>
											<td height="10" background="/img/adm/box03.gif"></td>
										</tr>
										<tr>
											<td background="/img/adm/box03.gif" class="ct">
<%		If cpnt = 0 Then %>
												<a href="javascript:PointPlus(<%=file_cnt * pnt_ps%>);" class="btn btn25"><span>포인트적립</span></a>
<%		Else %>
												<a href="javascript:PointMinus(<%=file_cnt * pnt_ps%>);" class="btn btn25"><span>포인트차감</span></a>
<%		End If %>
												<a href="javascript:goDelete();" class="btnr btn25"><span>삭제</span></a>
												<a href="ps.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn25"><span>목록</span></a>
											</td>
										</tr>
										<tr>
											<td height="10" background="/img/adm/box03.gif"></td>
										</tr>
										<tr>
											<td height="30" background="/img/adm/box03.gif"></td>
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
</form>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<!-- #include virtual = "/_adm/inc/footer.asp" -->