<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
'	Call checkLevel(FID_AUTH, 100, Request.ServerVariables("PATH_INFO"))

	bbs_id						= 120
	'10-공지/20-메모/50-요리/60-초보자/120-제임스/130-상품소개 (2017.04.01 개편)
	'10-공지/20-메모/50-요리/60-초보자/70-노하우/80-매니아/90-카풀/100-중고/110-레시피/120-제임스/130-상품소개
	seq							= SQLI(Request("seq"))
	cd1							= SQLI(Request("cd1"))			'검색조건
	cd2							= SQLI(Request("cd2"))			'검색단어
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))
	inpwd						= SQLI(Request("pwd"))
	vw							= SQLI(Request("vw"))
	tag							= 8

	If cd1 = "" Then cd1 = "title"
	If page = "" Then page = 1

	If seq <> "" Then
		rso()
		SQL = " SELECT title, gubn, uno, nicknm, uip, cnt, ddate, contents FROM _obbst010 WHERE bbs_id = "& bbs_id &" AND seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			title				= rs("title")
			gubn				= rs("gubn")
			uno					= rs("uno")
			nicknm				= rs("nicknm")
			uip					= rs("uip")
			cnt					= rs("cnt")
			ddate				= rs("ddate")
			contents			= rs("contents")
		End If
		rsc()

		rso()					'이미지 갯수
		SQL = " SELECT ISNULL(COUNT(*),0) FROM _obbst011 WHERE seq = "& seq &" AND ext NOT IN ('flv','wmv') "
		rs.open SQL, dbcon
			fcnt1 = CInt(rs(0))
		rsc()

		rso()					'동영상 갯수
		SQL = " SELECT ISNULL(COUNT(*),0) FROM _obbst011 WHERE seq = "& seq &" AND ext IN ('flv','wmv','movie') "
		rs.open SQL, dbcon
			fcnt2 = CInt(rs(0))
		rsc()
	Else
		Call noAlertGo("news.asp?page="& page &"&cd1="& cd1 &"&cd2="& cd2)
		Response.End
	End If

	pvP = 0
	ntP = 0

	rso()					'이전글
	SQL = " SELECT TOP 1 seq, title FROM _obbst010 WHERE bbs_id = "& bbs_id &" AND seq < "& seq &" ORDER BY seq DESC "
	rs.open SQL, dbcon
	If Not rs.eof Then
		pvP = rs(0)
		pvTitle = rs(1)
	End If
	rsc()

	rso()					'다음글
	SQL = "	SELECT TOP 1 seq, title FROM _obbst010 WHERE bbs_id = "& bbs_id &" AND seq > "& seq &" ORDER BY seq "
	rs.open SQL, dbcon
	If Not rs.eof Then
		ntP = rs(0)
		ntTitle = rs(1)
	End If
	rsc()

	SQL = " UPDATE _obbst010 SET cnt = cnt + 1 WHERE seq = "& seq
	dbcon.Execute SQL
%>

<!-- jQuery Plugin scripts -->
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-core.css" media="screen, projection" />
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-bbs01.css" media="screen, projection" />

<!-- <script type="text/javascript" src="/lib/js/external/_oldies/jquery-1.3.min.js"></script> dialog Event 에 문제 발생 -->
<script type="text/javascript" src="/lib/js/external/jquery.easing.1.3.min.js"></script>
<script type="text/javascript" src="/lib/js/external/jquery.mousewheel.min.js"></script>

<!-- Site styles : 2016.02.05 top이 10px 정도 벌어짐 -->
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-site.css" media="screen, projection" />

<script type="text/javascript" src="/lib/js/sliderkit/jquery.sliderkit.1.9.2.pack.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.delaycaptions.1.1.pack.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.counter.1.0.pack.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.timer.1.0.pack.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/addons/sliderkit.imagefx.1.0.pack.js"></script>

<script language="javascript">
<!--
function goDelete(){					//삭제
	var f = document.fm1;
	if(!confirm("정말 삭제하시겠습니까?       ")){
		return;
	}
	f.flag.value = "D";
//	f.target = "nullframe";
	f.action = "zbbs_x.asp";
	f.submit();
}
function goAfter(){
	var f = document.fm1;
<%	If FID_ID = "" Then %>
	alert("로그인이 필요합니다.         ");
	this.document.location = "/mem/login.asp?preURL=/bbs1/news_v.asp?seq=<%=seq%>&page=<%=page%>";
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
		f.action = "zbbs_x.asp";
		f.method = "post";
//		f.target = "nullframe";
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
//	f.target = "nullframe";
	f.action = "zbbs_x.asp";
	f.submit();
}
function showAlert(){
	alert("로그인이 필요합니다.         ");
	this.document.location = "/mem/login.asp?preURL=/bbs1/news_v.asp?seq=<%=seq%>&page=<%=page%>";
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
						<img src="/img/bbs/comu_news_tle2.png" alt="제임스이야기" title="제임스이야기" />
					</div>
					<div class="pt20"></div>
					<hr style="border:1px solid #ccc;">

<form name="fm1" method="post" enctype="multipart/form-data">
<input type="hidden" name="bbs_id" value="<%=bbs_id%>">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="cd1" value="<%=cd1%>">
<input type="hidden" name="cd2" value="<%=cd2%>">
<input type="hidden" name="vw" value="<%=vw%>">
<input type="hidden" name="flag">
<input type="hidden" name="idx">

					<div>
						<ul style="">
							<li class="ib lh32 bd9"><span class="pl10">글제목</span></li>
							<li style="width:590px;" class="ib lh32"><b class="pl10"><%=title%></b></li>
						</ul>
					</div>
					<hr style="border:1px dotted #ccc;">
					<div>
						<ul>
							<li class="ib lh32 bd9"><span class="pl10">글쓴이</span></li>
							<li style="width:200px;" class="ib lh32"><span class="pl10"><%=nicknm%></span></li>
							<li class="ib lh32 bd91"><span class="pl10">글쓴날짜</span></li>
							<li style="width:200px;" class="ib lh32"><span class="pl10"><%=ddate%></span></li>
							<li class="ib lh32 bd91"><span class="pl10">조회수</span></li>
							<li class="ib lh32"><span class="pl10"><%=FormatNumber(cnt,0)%></span></li>
						</ul>
					</div>
					<hr style="border:1px dotted #ccc;">
<%
	If fcnt1 <> 0 Then
%>
					<div>
						<div class="ct mt10">
							<!-- Start photosgallery-captions -->
							<div class="sliderkit photosgallery-captions">
								<div class="sliderkit-nav">

									<div class="sliderkit-nav-clip">
										<ul>
<%
		rso()				'하단 썸네일 navi
		SQL = " SELECT idx, seq, fpath, fnm, fwd, fsz, ext, comment FROM _obbst011 WHERE seq = "& seq &" AND ext NOT IN ('flv','wmv','movie') "
		rs.open SQL, dbcon
		If Not rs.eof Then
			While Not rs.eof
%>
											<li><a href="#" rel="nofollow" title="<%=rs("comment")%>"><img src="<%=rs("fpath") &"/"& rs("fnm")%>" width="100%" alt="<%=rs("comment")%>" /></a></li>
<%				rs.MoveNext
			Wend
		Else
		End If
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
		SQL = " SELECT idx, seq, fpath, fnm, fwd, fsz, ext, comment FROM _obbst011 WHERE seq = "& seq &" AND ext NOT IN ('flv','wmv','movie') "
		rs.open SQL, dbcon
		k = 1
		If Not rs.eof Then
			While Not rs.eof
%>
<script type="text/javascript">
$(function(){
	// Dialog
	$('#dialog<%=k%>').dialog({
			autoOpen: false
		,	width: 830
		,	height: 700
	});
	// Dialog Link
	$('#dialog_link<%=k%>').click(function(){
		$('#dialog<%=k%>').dialog('enable').dialog('open');
		return false;
	});
	$('#dialog<%=k%>').click(function(){
		$('#dialog<%=k%>').dialog('enable').dialog('close');
		return false;
	});
});
</script>
									<div class="sliderkit-panel">
										<a href="#" id="dialog_link<%=k%>"><img src="<%=rs("fpath") &"/"& rs("fnm")%>" alt="<%=rs("comment")%>" title="<%=rs("comment")%>" /></a>
										<div class="sliderkit-panel-text">
											<div class="sliderkit-panel-textbox" style="padding-bottom:20px;">
												<div class="sliderkit-panel-text">
													<h4><%=rs("comment")%></h4>
												</div>
												<div class="sliderkit-panel-overlay"></div>
												<!-- ui-dialog -->
												<div id="dialog<%=k%>" title="이미지 크게보기" style="display:none;">
													<p class="ct"><img src="<%=rs("fpath") &"/"& rs("fnm")%>" class="ct" style="cursor:pointer;"></p>
												</div>
											</div>
										</div>
									</div>
<%
				k = k + 1
				rs.MoveNext
			Wend
		Else
		End If
		rsc()
%>
								</div>
							</div>
							<!-- // end of photosgallery-captions -->
						</div>
					</div>
<%
	End If
%>
<!-- 동영상 부분 -->
<%
	If fcnt2 <> 0 Then
		rso()
		SQL = " SELECT TOP 1 idx, seq, fpath, fnm, fsz, fwd, ext, best " _
			& " FROM _obbst011 " _
			& " WHERE seq = "& seq &" AND ext IN ('flv','wmv','movie') " _
			& " ORDER BY idx DESC "
		rs.open SQL, dbcon

		If Not rs.eof Then
			ext = rs("ext")
			fnm = rs("fnm")
%>
					<div>
						<div class="ct mt10">
							<iframe allowfullscreen="true" allowscriptaccess="always" preload="auto" autoplay="true" frameborder="0" width="600" height="400" scrolling="no" src="<%=fnm%>"></iframe>
						</div>
					</div>
					<hr style="border:1px dotted #ccc;">
<%
		End If
		rsc()
	End If
%>
					<div>
						<ul>
							<li class="ib lh32 ml20"><%=db2html(contents)%></li>
						</ul>
					</div>
					<hr style="border:1px solid #ccc;">

					<!-- 한줄댓글 시작 -->
					<div style="background:#cfcfcf;" class="mt20">
						<ul>
							<li style="width:146px;margin:10px;" class="ib"><img src="/img/bbs/reply_tle.png" class="vm" alt="나도한마디" title="나도한마디" /></li>
							<li style="width:500px;" class="ct vm ib">
								<input type="text" name="comment" id="comment" style="width:490px;" <%If FID_ID = "" Then%>onClick="showAlert();" onKeyDown="showAlert();"<%End If%> />
							</li>
							<li style="" class="ct ib"><a href="javascript:;" onClick="goAfter();" class="btn btn25"><span>확인</span></a></li>
							<li style="" class="ct ib"><a href="javascript:;" onClick="goRecomm();" class="btng btn25"><span>추천</span></a></li>
						</ul>
					</div>
					<div class="mt10 vt">
<%		'덧글
		rso()
		SQL = " SELECT idx, seq, uno, ddate, comment FROM _obbst012 WHERE seq = "& seq &" ORDER BY idx DESC "
		rs.open SQL, dbcon
		If Not rs.eof Then
			While Not rs.eof
%>
						<div>
							<div id="app" class="mt10 mb10 vt">
								<!-- <span><img src="<%=memPhoto(rs("uno"))%>" width="60" class="vt gbox03" alt="회원사진" title="회원사진" /></span> -->
								<span class="ib pl15">
									<b><%=meminfo(rs("uno"),"unamee")%></b> (<%=rs("ddate")%>)
									<%If FID_NO = Trim(rs("uno")) Or FID_AUTH <= 10 Then%>
									<a href="javascript:;" onClick="delAfter(<%=rs("idx")%>);"><img src="/img/rpy_delete.gif" class="vm" alt="덧글삭제" title="덧글삭제" /></a>
									<%End If%>
									<br>
									<%=db2html(rs("comment"))%>
								</span>
							</div>
						</div>
						<hr style="border:1px dotted #ccc;">
<%
				rs.MoveNext
			Wend
		End If
		rsc()
%>
					</div>
					<div class="mt10 mb10 rg">
						<a href="news.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn25"><span>목록</span></a>
					</div>
					<hr style="border:1px solid #ccc;">
					<div>
						<ul>
							<li style="width:146px;" class="ib"><img src="/img/rpy_nxt.gif" alt="다음글" title="이전글" /></li>
							<li style="width:500px;" class="vm ib">&nbsp;<a href="?seq=<%=ntP%>"><%=ntTitle%></a></li>
						</ul>
						<hr style="border:1px dotted #ccc;">
						<ul>
							<li style="width:146px;" class="ib"><img src="/img/rpy_pre.gif" alt="이전글" title="이전글" /></li>
							<li style="width:500px;" class="vm ib">&nbsp;<a href="?seq=<%=pvP%>"><%=pvTitle%></a></li>
						</ul>
					</div>
					<hr style="border:1px solid #ccc;">
</form>
				</div>
			</li>
			<li class="ib vt"><!-- #include virtual = "/inc/quick.asp" --></li>
		</ul>
	</div>
</div>
<!-- #include virtual = "/inc/footer.asp" -->
