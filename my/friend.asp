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
	tag							= 8

	If cd1 = "" Then cd1 = "title"
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

	rso()
	SQL = " SELECT COUNT(*) FROM _omemt020 "& param
	rs.open SQL, dbcon, 3
		recordcount = CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
%>

<script language="JavaScript">
<!--
function goSearch() {
	var f = document.fm1;
	f.action = "friend.asp";
	f.method = "post";
	f.submit();
}
function writeKeyDown() {
	if (event.keyCode == 13)	goSearch();
}
//-->
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
						<img src="/img/my_friends.gif" alt="일행관리" title="일행관리" />
					</div>
					<div>
						<div class="gbox01">
							<dl>* 자주 동행하는 분들을 등록하여 출항명부 작성시 번거로움을 없애고 보다 빨리 바다로 나갈 수 있습니다.</dl>
							<dl>* 출항명부는 법적으로 반드시 작성해야 하며 가명이나 허위사실을 입력하시면 불이익을 당하실 수 있습니다.</dl>
							<dl>* 당일(출항일) 주민등록번호만 따로 기입하시면 됩니다.</dl>
						</div>
					</div>

					<!-- 게시물 검색 시작 -->
<form name="fm1" method="post">
<input type="hidden" name="cd1" value="rname">

					<div>
						<div class="mt10 mb10 rg">
							<input type="text" name="cd2" id="cd2" maxlength="10" class="bx1" onKeyDown="writeKeyDown()" style="width:120px;">
							<a href="javascript:goSearch()" class="btn btn25"><span>검색</span></a>
						</div>
					</div>
</form>
					<!-- 게시물 검색 끝 -->
					<hr style="border:1px solid #777;">
					<div>
						<ul class="mt5 mb5">
							<li style="width:50px;" class="ib ct">번호</li>
							<li style="width:100px;" class="ib ct">일행이름</li>
							<li style="width:100px;" class="ib ct">연락처</li>
							<li style="width:360px;" class="ib ct">주소지</li>
							<li style="width:70px;" class="ib ct">관계</li>
						</ul>
					</div>
					<hr style="border:1px dotted #777;">
					<div>
<%
		rso()
		SQL = " SELECT TOP "& pgsize &" * FROM _omemt020 "& param _
			& " AND idx NOT IN (SELECT TOP "& ((page-1) * pgsize) &" idx FROM _omemt020 "& param _
			& " ORDER BY idx DESC) ORDER BY idx DESC "
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
						<ul class="mt5 mb5">
							<li style="width:50px;" class="ib ct"><%=j%></li>
							<li style="width:100px;" class="ib ct">
								<a href="#" onClick="return mpop5('friend_w.asp?idx=<%=rs("idx")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&flag=M','ev','center',580,400,0);"><b><%=rs("rname")%></b></a>
							</li>
							<li style="width:100px;" class="ib ct"><%=rs("hp")%></li>
							<li style="width:360px;" class="ib">&nbsp;&nbsp;&nbsp;<%=rs("addr1")%>&nbsp;<%=rs("addr2")%></li>
							<li style="width:70px;" class="ib ls"><%=rs("rel")%></li>
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
							<li style="height:200px;" class="ct">등록된 일행이 없습니다.</li>
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
						<a href="friend.asp" class="btn btn25"><span>새로고침</span></a>
						<a href="#" onClick="return mpop5('friend_w.asp','ev','center',580,400,0);" class="btn btn25"><span>일행등록</span></a>
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
