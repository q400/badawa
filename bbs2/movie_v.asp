<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	seq							= SQLI(Request("seq"))
	cd1							= SQLI(Request("cd1"))			'검색조건
	cd2							= SQLI(Request("cd2"))			'검색단어
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))
	inpwd						= SQLI(Request("pwd"))
	tag							= 7

	If cd1 = "" Then cd1 = "title"
	If page = "" Then page = 1

	If seq <> "" Then
		rso()
		SQL = " SELECT	seq, shipid, title, cnt, wdate, ddate, tnm, fnm, onm, fsz, ext, recom, contents FROM _obbst040 WHERE seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			shipid				= rs("shipid")
			title				= rs("title")
			cnt					= rs("cnt")
			wdate				= rs("wdate")
			ddate				= rs("ddate")
			tnm					= rs("tnm")
			fnm					= rs("fnm")
			onm					= rs("onm")
			fsz					= rs("fsz")
			ext					= rs("ext")
			recom				= rs("recom")
			contents			= rs("contents")
		End If
		rsc()
	Else
		Call noAlertGo("movie.asp?page="& page &"&cd1="& cd1 &"&cd2="& cd2)
		Response.End
	End If

	pvP = 0
	ntP = 0

	rso()					'이전글
	SQL = " SELECT TOP 1 seq, title FROM _obbst040 WHERE seq < "& seq &" ORDER BY seq DESC "
	rs.open SQL, dbcon
	If Not rs.eof Then
		pvP = rs(0)
		pvTitle = rs(1)
	End If
	rsc()

	rso()					'다음글
	SQL = "	SELECT TOP 1 seq, title FROM _obbst040 WHERE seq > "& seq &" ORDER BY seq "
	rs.open SQL, dbcon
	If Not rs.eof Then
		ntP = rs(0)
		ntTitle = rs(1)
	End If
	rsc()

	SQL = " UPDATE _obbst040 SET cnt = cnt + 1 WHERE seq = "& seq
	dbcon.Execute SQL
%>

<script language="javascript">
<!--
function goAfter(){
	var f = document.fm1;
<%	If FID_ID = "" Then %>
	alert("로그인이 필요합니다.         ");
	this.document.location = "/mem/login.asp?preURL=/bbs2/movie_v.asp?seq=<%=seq%>&page=<%=page%>";
	return;
<%	End If %>
	if(f.comment.value == ""){
		alert("덧글 내용을 입력하세요.");
		f.comment.focus();
	}else if(f.comment.value.length < 5){
		alert("최소 5자 이상은 입력하세요.");
		f.comment.focus();
	}else if(f.comment.value.length > 1000){
		alert("내용이 너무 깁니다. 줄이세요... -_-");
		f.comment.focus();
	}else{
		f.flag.value = "A";
		f.action = "movie_x.asp";
		f.method = "post";
		f.submit();
	}
}
function delAfter(vSeq){
	var f = document.fm1;
	if(!confirm("삭제하겠습니까?")){
		return;
	}
	f.idx.value = vSeq;
	f.flag.value = "AD";
	f.action = "movie_x.asp";
	f.submit();
}
function goRecomm(){
	var f = document.fm1;
	f.flag.value = "RECOM";
	f.action = "movie_x.asp";
	f.method = "post";
	f.submit();
}
function showAlert(){
	alert("로그인이 필요합니다.");
	this.document.location = "/mem/login.asp?preURL=/bbs2/movie_v.asp?seq=<%=seq%>&page=<%=page%>";
	return;
}
//-->
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
						<img src="/img/comu_beginner_tle.gif" alt="낚시동영상" title="낚시동영상" />
					</div>
					<div class="pt20"></div>
					<hr style="border:1px solid #ccc;">

<form name="fm1" method="post">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="cd1" value="<%=cd1%>">
<input type="hidden" name="cd2" value="<%=cd2%>">
<input type="hidden" name="flag">
<input type="hidden" name="idx">
<input type="hidden" name="op">

					<div>
						<ul style="">
							<li class="ib lh32 bd9"><span class="pl10">글제목</span></li>
							<li style="width:590px;" class="ib lh32"><b class="pl10"><%=title%></b></li>
						</ul>
					</div>
					<hr style="border:1px dotted #ccc;">
					<div>
						<ul>
							<li class="ib lh32 bd9"><span class="pl10">글쓴날짜</span></li>
							<li style="width:480px;" class="ib lh32"><span class="pl10"><%=ddate%></span></li>
							<li class="ib lh32 bd91"><span class="pl10">조회수</span></li>
							<li class="ib lh32"><span class="pl10"><%=FormatNumber(cnt,0)%></span></li>
						</ul>
					</div>
					<hr style="border:1px dotted #ccc;">
<%
		rso()				'동영상
		SQL = " SELECT seq, shipid, title, cnt, wdate, ddate, tnm, fnm, onm, fsz, ext, recom, contents FROM _obbst040 WHERE seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			ext = rs("ext")
			tnm = rs("tnm")
			fnm = rs("fnm")
		End If
		rsc()
%>
					<div>
						<div class="ct mt10">
<%		If ext = "flv" Then %>
							<p id="player"><a href="http://www.adobe.com/kr/products/flashplayer/" target="_blank"><b>플래시플레이어9</b></a>를 다운받아야 정상적으로 작동됩니다</p>
							<script type="text/javascript">
							var s1 = new SWFObject("/inc/swf/jwplayer.swf","mp3","400","326","7");
							s1.addVariable("file","/data/vod/<%=fnm%>");
							s1.addVariable("start",'5');
							s1.addVariable("backcolor","0xffffff");
							s1.addVariable("frontcolor","0x222222");
							s1.addVariable("lightcolor","0xff3300");
							//s1.addVariable("image","/vod/clip/vod01_<%=code%>.jpg");
							s1.addVariable("overstretch","true");
							s1.addVariable("autostart","true");
							s1.addVariable("repeat","false");
							s1.addVariable("shuffle","true");
							s1.addVariable("showvolume","true");
							s1.addVariable("volume","20");
							s1.addVariable("usefullscreen","true");
							s1.addVariable("bufferlength","5");
							s1.addVariable("showdownload","false");
							s1.addVariable("enablejs","true");
							s1.addVariable("javascriptid","mp3");
							s1.write("player");
							</script>
<%		ElseIf ext = "wmv" Then %>
<%		ElseIf ext = "flv" Then %>
<%		Else %>
							<iframe allowfullscreen="true" allowscriptaccess="always" preload="auto" autoplay="true" frameborder="0" width="600" height="400" scrolling="no" src="<%=contents%>"></iframe>
<%		End If %>
						</div>
					</div>
					<hr style="border:1px dotted #ccc;">
					<div>
						<ul>
							<li class="ib lh32 ml20"><b class="fcr">[<%=shipinfo(shipid,"shipnm")%> | <%=wdate%>]</b>&nbsp;<%=title%></li>
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
		SQL = " SELECT idx, seq, uno, ddate, comment FROM _obbst042 WHERE seq = "& seq &" ORDER BY idx DESC "
		rs.open SQL, dbcon
		If Not rs.eof Then
			While Not rs.eof
%>
						<div>
							<div id="app" class="mt10 mb10 vt">
								<span><img src="<%=memPhoto(rs("uno"))%>" width="60" class="vt gbox03" alt="회원사진" title="회원사진" /></span>
								<span class="ib pl15">
									<b><%=meminfo(rs("uno"),"unamee")%></b> (<%=rs("ddate")%>)
									<%If CInt(FID_NO) = rs("uno") Or FID_AUTH <= 10 Then%>
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
					<div class="mt10 mb10 mr5 rg">
						<a href="movie.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn25"><span>목록</span></a>
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
