<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	Call checkLevel(FID_AUTH, 100, Request.ServerVariables("PATH_INFO"))

	cd1							= SQLI(Request("cd1"))				'검색조건
	cd2							= SQLI(Request("cd2"))				'검색단어
	cd3							= SQLI(Request("cd3"))				'선박
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))
	setsize						= 10								'보여지는 페이지 수
	pgsize						= 15								'보여지는 게시물 수
	tag							= 3

	If cd1 = "" Then cd1 = "note"
	If cd3 = "" Then cd3 = 0
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If

	Set cx = New BsfCode

	If cd2 <> "" Then
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' AND uno = "& FID_NO
	Else
		param = " WHERE uno = "& FID_NO
	End If

	If cd3 <> 0 Then
		param = param & " AND shipid = "& cd3
	End If

	rso()
	SQL = " SELECT	COUNT(*) FROM _opntt020 "& param
	rs.open SQL, dbcon, 3
		recordcount = CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
%>

<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-core.css" media="screen, projection" />
<link rel="stylesheet" type="text/css" href="/lib/css/kit-point01.css" media="screen, projection" />

<!-- Slider Kit compatibility -->
<!--[if IE 6]><link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-demos-ie6.css" /><![endif]-->
<!--[if IE 7]><link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-demos-ie7.css" /><![endif]-->
<!--[if IE 8]><link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-demos-ie8.css" /><![endif]-->

<!-- Site styles -->
<!-- <link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-site.css" media="screen, projection" /> -->

<script language="JavaScript">
<!--
function goSearch(){
	var f = document.fm1;
	f.action = "point01.asp";
	f.method = "post";
	f.submit();
}
function writeKeyDown(){
	if(event.keyCode == 13)	goSearch();
}
//-->
</script>
<script type="text/javascript">
	$(window).load(function(){ //$(window).load() must be used instead of $(document).ready() because of Webkit compatibility

		// Tabs > Standard
		$(".tabs-standard").sliderkit({
			auto:false,
			tabs:true,
			mousewheel:true,
			circular:true,
			panelfx:"none"
		});

		// Tabs > No height
		$(".tabs-noheight").sliderkit({
			auto:false,
			tabs:true,
			freeheight:true,
			circular:true
		});

		// Tabs > Imbricated
		$(".tabs-imbricate").sliderkit({
			cssprefix:"customtabs",
			auto:false,
			tabs:true
		});

		// Carousel > Demo #2
		$(".carousel-demo2").sliderkit({
			auto:false,
			shownavitems:4,
			scroll:1,
			mousewheel:true,
			circular:true
		});

		// Pagination
		$(".pagination-basic").sliderkit({
			auto:false,
			tabs:true,
			freeheight:true
		});

		// Button : Make the standard tabs menu slide
		var myStandardTabs = $(".tabs-standard").data("sliderkit");
		$("#tabs-standard-slide").click(
			function(){
				// Applies only once
				if($(".sliderkit-panels-wrapper",myStandardTabs.domObj).size() == 0){
					// Set the transition effect to "sliding"
					myStandardTabs.options.panelfx = "sliding";
					// The sliding effect requires a wrapper around the panels
					myStandardTabs._wrapPanels();
				}
				// Stops the click
				return false;
			}
		);
	});
</script>


<div id="wrap">
	<div>
		<ul>
			<li class="ib vt" style="width:230px;"><!-- #include virtual = "/inc/left/my.asp" --></li>
			<li class="ib vt">
				<div id="mainwrap1">
					<div class="mt20">
						<img src="/img/bbs/mypage_tle.png" alt="마이페이지" title="마이페이지" />
					</div>
					<div class="mt10 mb10">
						<img src="/img/my_point.gif" alt="포인트내역" title="포인트내역" />
					</div>
					<div>
						<div class="gbox01">
							<dl>* 회원의 <b class="fc7">쉽포인트(Ship Point)</b> 현황을 확인할 수 있습니다.</dl>
							<dl>* 쉽포인트는 출조가 성공적으로 이루어진 경우 <span class="fc7">각 선박마다 적립되는</span> 포인트입니다.</dl>
							<dl>* 해당 선박에서 적립된 쉽포인트는 <span class="fc7">다시 해당 선박을 이용할 때만</span> 사용 가능합니다.</dl>
						</div>
					</div>
					<div>
						<div class="mt10 mb10 rg">
							현재 <b><%=FID_NAME%></b>님의 사용가능한 <b class="fce">쉽/톡</b> 포인트&nbsp;&nbsp;&nbsp;
							<b class="fce ff f11 ls"><%=FormatNumber(chkPoint(FID_NO,"ship"),0)%> / <%=FormatNumber(chkPoint(FID_NO,"talk"),0)%></b>
							&nbsp;&nbsp;&nbsp;포인트
						</div>
					</div>

					<div>
						<span class="vb ib"><a href="point01.asp" title="쉽포인트"><img src="/img/box/ship_on.gif" class="vb"></a><a href="point02.asp" title="톡포인트"><img src="/img/box/talk_off.gif" class="vb"></a></span>
						<span class="vb ib rg">
							<select name="cd3" class="vt" style="width:150px;" onChange="location='?cd3='+ this.options[this.selectedIndex].value +''">
							<option value=""<%If cd3 = 0 Then%> selected<%End If%>>전체</option>
<%
	rso()
	SQL = " SELECT shipid, shipnm FROM _oshpt010 "
	rs.open SQL, dbcon
	While Not rs.eof
%>
							<option value="<%=rs("shipid")%>"<%If CInt(cd3) = rs("shipid") Then%> selected<%End If%>><%=rs("shipnm")%></option>
<%
		rs.MoveNext
	Wend
	rsc()
%>
							</select>
						</span>
					</div>
					<hr style="border:1px solid #777;">
					<div>
						<ul class="mt5 mb5">
							<li style="width:50px;" class="ib ct">번호</li>
							<li style="width:50px;" class="ib ct">구분</li>
							<li style="width:60px;" class="ib ct">예약번호</li>
							<li style="width:80px;" class="ib ct">적립포인트</li>
							<li style="width:120px;" class="ib ct">해당선박</li>
							<li style="width:80px;" class="ib ct">출조일자</li>
							<li style="width:240px;" class="ib ct">적립/차감 사유</li>
						</ul>
					</div>
					<hr style="border:1px dotted #777;">
					<div>
<%
		rso()
		SQL = " SELECT TOP "& pgsize &" * FROM _opntt020 "& param _
			& " AND idx NOT IN (SELECT TOP "& ((page-1) * pgsize) &" idx FROM _opntt020 "& param _
			& " ORDER BY idx DESC) ORDER BY idx DESC "
		rs.open SQL, dbcon

		j = recordcount

		If Not (rs.eof And rs.bof) Then
			If page <> 1 Then
				j = j - (page - 1) * pgsize
			End If

			i = 1
			rs.MoveFirst
			Do Until rs.EOF
				rdate			= rsvInfo3(rs("rsvid"),"rdate")
				rdate01			= Left(rdate,4)
				rdate02			= Mid(rdate,5,2)
				rdate03			= Right(rdate,2)
%>
						<ul class="mt5 mb5">
							<li style="width:50px;" class="ib ct"><%=j%></li>
							<li style="width:50px;" class="ib ct"><b><%=rs("op")%></b></li>
							<li style="width:60px;" class="ib ct"><%=rs("rsvid")%></li>
							<li style="width:80px;" class="ib ct"><%=FormatNumber(rs("point"),0)%></li>
							<li style="width:120px;" class="ib ct"><%=shipinfo(rs("shipid"),"shipnm")%></li>
							<li style="width:80px;" class="ib ct"><%=rdate01%>-<%=rdate02%>-<%=rdate03%></li>
							<li style="width:240px;" class="ib rg ls"><%=rs("note")%></li>
						</ul>
						<hr style="border:1px dotted #ccc;">
<%
				rs.MoveNext
				i = i + 1
				j = j - 1
			Loop
		Else
%>
						<ul>
							<li style="height:200px;" class="ct">포인트 적립/차감 정보가 없습니다.</li>
							<hr style="border:1px dotted #ccc;">
						</ul>
<%
		End If
		rsc()
%>
					</div>

					<div class="pt10 ct">
<%
		blockpage = Int((page-1)/10)*10 + 1
		If blockpage = 1 Then %>
<%		Else %>
<a href="?page=1&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn21"><span>처음으로</span></a>
<a href="?page=<%=blockpage-1%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn21"><span>이전</span></a>
<%		End If
		i = 0
		Do Until i = 10 Or (blockpage + i) > totalpage
			If Int(page) = blockpage + i Then %>
<a href="?page=<%=blockpage + i%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="ff fb ls"><%=setP(blockpage + i)%></a>&nbsp;
<%			Else %>
<a href="?page=<%=blockpage + i%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="ff ls"><%=setP(blockpage + i)%></a>&nbsp;
<%			End If
			i = i + 1
		Loop
		if(blockpage + i - 1) = totalpage Then %>
<%		Else %>
<a href="?page=<%=blockpage+10%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn21"><span>다음</span></a>
<a href="?page=<%=totalpage%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn21"><span>끝으로</span></a>
<%		End If %>
					</div>

					<div class="rg">
<%		If FID_AUTH <> "" Then %>
						<a href="point01.asp" class="btn btn25"><span>새로고침</span></a>
<%		End If %>
					</div>
					<div class="pt20 pb20"></div>
				</div>
			</li>
			<li class="ib vt"><!-- #include virtual = "/inc/quick.asp" --></li>
		</ul>
	</div>
</div>
<!-- #include virtual = "/inc/footer.asp" -->
