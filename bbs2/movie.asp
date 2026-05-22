<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	cd1							= SQLI(Request("cd1"))			'검색조건
	cd2							= SQLI(Request("cd2"))			'검색단어
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))
	setsize						= 10							'보여지는 페이지 수
	pgsize						= 8								'보여지는 게시물 수
	tag							= 7

	If cd1 = "" Then cd1 = "shipnm"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If

	If cd2 <> "" Then					'검색조건이 있는 경우
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' "
	Else								'검색조건이 없는 경우
		param = " WHERE 1 = 1 "
	End If

	'게시물 개수
	rso()
	SQL = " SELECT	COUNT(*) FROM _obbst040 "& param
	rs.open SQL, dbcon
		recordcount				= CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
%>


<div id="wrap">
	<div>
		<ul>
			<li class="ib vt" style="width:230px;"><!-- #include virtual = "/inc/left/fish.asp" --></li>
			<li class="ib vt">
				<div id="mainwrap1">
					<div class="mt20">
						<img src="/img/fish_info_tle.gif" alt="조황정보" title="조황정보" />
					</div>
					<div class="mt10 mb10">
						<img src="/img/comu_beginner_tle.gif" alt="낚시동영상" title="낚시동영상" />
					</div>

<form name="fm1" id="fm1" method="post">

					<!-- 게시물 검색 시작 --
					<div class="mt20">
						<div style="width:300px;" class="ib">
							<!--
							<img src="/img/icon_list.gif" width="15" height="15" class="vm" alt="리스트형" />&nbsp;<a href="?vw=list">리스트형</a>
							&nbsp;&nbsp;
							<img src="/img/icon_img.gif" width="15" height="15" class="vm" alt="이미지형" />&nbsp;<a href="?vw=thumb">이미지형</a>
							--
						</div>
						<div class="ib fright">
							<!--
							<select name="cd1" id="search" style="width:120px;" onChange="location='?cd1='+ this.options[this.selectedIndex].value +''">
							<option value=""<%If cd1 = "" Then%> selected<%End If%>>선택</option>
<%
	rso()
	sql = " SELECT code_nm FROM _ocodt010 WHERE gubn = '낚시종류' ORDER BY idx "
	rs.open SQL, dbcon
	While Not rs.eof
%>
							<option value="<%=rs("code_nm")%>"<%If cd1 = rs("code_nm") Then%> selected<%End If%>><%=rs("code_nm")%></option>
<%
		rs.MoveNext
	Wend
	rsc()
%>
							</select>
							--
						</div>
					</div>
					<!-- 게시물 검색 끝 -->
</form>
					<div class="pt10"></div>
					<hr style="border:1px solid #777;">
					<div>
						<ul>
<%
		rso()
		SQL = " SELECT TOP "& pgsize &" * FROM _obbst040 "& param _
			& " AND seq NOT IN (SELECT TOP "& ((page-1) * pgsize) &" seq FROM _obbst040 "& param _
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
							<li style="width:160px; margin:20px 2px 0px 10px;" class="vt ib">
								<div>
									<a href="movie_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>"><img src="/data/vod/<%=rs("tnm")%>" width="160" alt="사진" title="사진" /></a>
								</div>
								<p>
									<a href="movie_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>"><b class="fz f13"><%=trimtext(rs("title"),10)%></b></a>
									<%If Date() - CDate(rs("ddate")) < 5 Then%><img src="/img/icon/new05.gif" width="23" height="15" class="vm"><%End If%>
								</p>
								<p class="fc2 ff ls">해당선박 : <a href="movie_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>"><b class="fc8"><%=shipinfo(rs("shipid"),"shipnm")%></b></a></p>
								<p class="fc2 ff ls">출조일자 : <a href="movie_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>"><%=Left(rs("wdate"),10)%></a></p>
								<p>
									<span>조회수 : <%=FormatNumber(rs("cnt"),0)%></span>
									<span class="ml10 fc7 ff"><img src="/img/icon_cook02.gif" width="14" height="16" class="vm">&nbsp;<%=FormatNumber(rs("recom"),0)%></span>
								</p>
							</li>
<%
				rs.MoveNext
				i = i + 1
				j = j - 1
			Loop
		Else
%>
							<li style="height:200px;" class="ct">등록된 동영상이 없습니다.</li>
							<hr style="border:1px dotted #ccc;">
<%
		End If
		rsc()
%>
						</ul>
					</div>
					<div class="pt10 ct">
<%
		blockpage = Int((page-1)/10)*10+1
		If blockpage = 1 Then %>
<%		Else %>
						<a href="?page=1&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn18"><span>처음으로</span></a>
						<a href="?page=<%=blockpage-1%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn18"><span>이전</span></a>
						&nbsp;&nbsp;
<%		End If
		i = 0
		Do Until i = 10 Or (blockpage+i) > totalpage
			If Int(page) = blockpage+i Then
%>
						<a href="?page=<%=blockpage+i%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="ff fb vm ls"><%=setP(blockpage+i)%></a>&nbsp;&nbsp;
<%			Else %>
						<a href="?page=<%=blockpage+i%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="ff vm ls"><%=setP(blockpage+i)%></a>&nbsp;&nbsp;
<%			End If
			i = i + 1
		Loop
		if(blockpage+i-1) = totalpage Then %>
<%		Else %>
						&nbsp;&nbsp;
						<a href="?page=<%=blockpage+10%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn18"><span>다음</span></a>
						<a href="?page=<%=totalpage%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn18"><span>끝으로</span></a>
<%		End If %>
					</div>

					<div>
<%		If FID_AUTH <> "" And FID_AUTH < 10 Then %>
						<!-- <a href="" class="btn btn25"><span>글쓰기</span></a> -->
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
