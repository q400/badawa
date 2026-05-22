<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	Call checkLevel(FID_AUTH, 100, Request.ServerVariables("PATH_INFO"))

	cd1							= SQLI(Request("cd1"))				'검색조건
	cd2							= SQLI(Request("cd2"))				'검색단어
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))
	setsize						= 10								'보여지는 페이지 수
	pgsize						= 15								'보여지는 게시물 수
	tag							= 3
'	Response.Write "<font color=#ffffff>FID_ID : "& FID_ID &"</font><br>"

	If cd1 = "" Then cd1 = "note"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If
	stpage						= Int((page - 1) * pgsize)			'각 페이지에 맞게 잘라올 시작값

	Set cx = New BsfCode

	If cd2 <> "" Then
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' AND uno = "& FID_NO
	Else
		param = " WHERE uno = "& FID_NO
	End If

	rso()
	SQL = " SELECT	COUNT(*) FROM _opntt010 "& param
	rs.open SQL, dbcon, 3
		recordcount1 = CInt(rs(0))
	rsc()

	rso()
	SQL = " SELECT	COUNT(*) FROM _opntt020 "& param
	rs.open SQL, dbcon, 3
		recordcount2 = CInt(rs(0))
	rsc()

	recordcount = recordcount1 + recordcount2
	totalpage = Int((recordcount-1)/pgsize) + 1
%>

<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-core.css" media="screen, projection" />
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-demos.css" media="screen, projection" />

<!-- Slider Kit compatibility -->
<!--[if IE 6]><link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-demos-ie6.css" /><![endif]-->
<!--[if IE 7]><link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-demos-ie7.css" /><![endif]-->
<!--[if IE 8]><link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-demos-ie8.css" /><![endif]-->

<!-- Site styles -->
<link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-site.css" media="screen, projection" />

<script language="JavaScript">
<!--
function goSearch() {
	var f = document.fm1;
	f.action = "point.asp";
	f.method = "post";
	f.submit();
}
function writeKeyDown() {
	if (event.keyCode == 13)	goSearch();
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

<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td>
			<table width="1100" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="250" valign="top"><!-- #include virtual = "/inc/left/my.asp" --></td>
					<td width="710" valign="top">
						<table width="710" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="21"></td>
							</tr>
							<tr>
								<td><img src="/img/my_point.gif" alt="포인트내역"></td>
							</tr>
							<tr>
								<td height="20"></td>
							</tr>
							<tr>
								<td>
									<div class="gbox01">
									<dl>
										* 회원의 포인트 현황을 확인할 수 있습니다.
									</dl>
									</div>
								</td>
							</tr>
							<tr>
								<td height="30"></td>
							</tr>

							<tr>
								<td>

				<!-- Start tabs-standard -->
				<div class="sliderkit tabs-standard">
					<div class="sliderkit-nav">
						<div class="sliderkit-nav-clip">
							<ul>
								<li><a href="#" title="쉽포인트">쉽포인트</a></li>
								<li><a href="#" title="톡포인트">톡포인트</a></li>
							</ul>
						</div>
					</div>
					<div class="sliderkit-panels">
						<div class="sliderkit-panel">
							<div class="sliderkit-news">
									<table width="710" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<th width="60" class="fc3">번호</th>
											<th width="80" class="fc3">구분</th>
											<th width="100" class="fc3">적립포인트</th>
											<th width="100" class="fc3">해당선박</th>
											<th width="80" class="fc3">처리일자</th>
											<th class="fc3">사유</th>
										</tr>
										<tr>
											<td colspan="10"><img src="/img/bbs_line01.gif" width="710" height="1"></td>
										</tr>
<%
		rso()
		SQL = " SELECT	TOP 15 * FROM _opntt010 "& param _
			& " AND seq NOT IN (SELECT TOP "& ((page-1) * 15) &" seq FROM _opntt010 "& param _
			& " ORDER BY seq DESC) ORDER BY seq DESC "
		rs.open SQL, dbcon, 0, 3

		j = recordcount

		If Not (rs.eof And rs.bof) Then
			If page <> 1 Then
				j = j - (page - 1) * pgsize
			End If

			i = 1
			rs.MoveFirst
			Do Until rs.EOF
%>
										<tr height="31">
											<td class="ct"><%=j%></td>
											<td class="ct"><b><%=rs("op")%></b></td>
											<td class="ct"><%=FormatNumber(rs("point"),0)%></td>
											<td class="ct lf ls"><%=Left(rs("ddate"),10)%></td>
											<td class="ct lf ls"><%=rs("note")%></td>
										</tr>
										<tr>
											<td height="1" bgcolor="d8d8d8" colspan="10"></td>
										</tr>
<%
				rs.MoveNext
				i = i + 1
				j = j - 1
			Loop
		Else
%>
										<tr height="200">
											<td class="ct" colspan="10">포인트 적립/차감 정보가 없습니다.</td>
										</tr>
<%
		End If
		rsc()
%>
										<tr>
											<td colspan="10"><img src="/img/bbs_line02.gif" width="710" height="5"></td>
										</tr>
										<tr>
											<td colspan="10" class="ct">
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
		If (blockpage + i - 1) = totalpage Then %>
<%		Else %>
<a href="?page=<%=blockpage+10%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn21"><span>다음</span></a>
<a href="?page=<%=totalpage%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn21"><span>끝으로</span></a>
<%		End If %>
								</td>
							</tr>
							<tr>
								<td class="rg">
<%		If FID_AUTH <> "" Then %>
									<a href="point.asp" class="btn btn25"><span>새로고침</span></a>
<%		End If %>
											</td>
										</tr>
									</table>
							</div>
						</div>
						<div class="sliderkit-panel">
							<div class="sliderkit-news">
									<table width="710" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<th width="60" class="fc3">번호</th>
											<th width="80" class="fc3">구분</th>
											<th width="100" class="fc3">적립포인트</th>
											<th width="100" class="fc3">해당선박</th>
											<th width="80" class="fc3">처리일자</th>
											<th class="fc3">사유</th>
										</tr>
										<tr>
											<td colspan="10"><img src="/img/bbs_line01.gif" width="710" height="1"></td>
										</tr>
<%
		rso()
		SQL = " SELECT	TOP 15 * FROM _opntt020 "& param _
			& " AND seq NOT IN (SELECT TOP "& ((page-1) * 15) &" seq FROM _opntt020 "& param _
			& " ORDER BY seq DESC) ORDER BY seq DESC "
		rs.open SQL, dbcon, 0, 3

		j = recordcount

		If Not (rs.eof And rs.bof) Then
			If page <> 1 Then
				j = j - (page - 1) * pgsize
			End If

			i = 1
			rs.MoveFirst
			Do Until rs.EOF
%>
										<tr height="31">
											<td class="ct"><%=j%></td>
											<td class="ct"><b><%=rs("op")%></b></td>
											<td class="ct"><%=FormatNumber(rs("point"),0)%></td>
											<td class="ct lf ls"><%=Left(rs("ddate"),10)%></td>
											<td class="ct lf ls"><%=rs("note")%></td>
										</tr>
										<tr>
											<td height="1" bgcolor="d8d8d8" colspan="10"></td>
										</tr>
<%
				rs.MoveNext
				i = i + 1
				j = j - 1
			Loop
		Else
%>
										<tr height="200">
											<td class="ct" colspan="10">포인트 적립/차감 정보가 없습니다.</td>
										</tr>
<%
		End If
		rsc()
%>
										<tr>
											<td colspan="10"><img src="/img/bbs_line02.gif" width="710" height="5"></td>
										</tr>
										<tr>
											<td colspan="10" class="ct">

		<div class="bxPaging">
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
		If (blockpage + i - 1) = totalpage Then %>
<%		Else %>
<a href="?page=<%=blockpage+10%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn21"><span>다음</span></a>
<a href="?page=<%=totalpage%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn21"><span>끝으로</span></a>
<%		End If %>
		</div>
								</td>
							</tr>
							<tr>
								<td class="rg">
<%		If FID_AUTH <> "" Then %>
									<a href="point.asp" class="btn btn25"><span>새로고침</span></a>
<%		End If %>
											</td>
										</tr>
									</table>
							</div>
						</div>
					</div>
				</div>
				<!-- // end of tabs-standard -->

								</td>
							</tr>


							<tr>
								<td>&nbsp;</td>
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