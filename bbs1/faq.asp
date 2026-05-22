<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	cd1							= SQLI(Request("cd1"))				'검색조건
	cd2							= SQLI(Request("cd2"))				'검색단어
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))
	setsize						= 10								'보여지는 페이지 수
	pgsize						= 15								'보여지는 게시물 수
	tag							= 2

	If cd1 = "" Then cd1 = "question"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If
	stpage						= Int((page - 1) * pgsize)		'각 페이지에 맞게 잘라올 시작값

	pagesize = 20
	Set cx = New BsfCode

	If cd2 <> "" Then
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' "
	Else
		param = " WHERE 1 = 1 "
	End If

	rso()
	SQL = " SELECT	COUNT(*) FROM _ofaqt010 "& param
	rs.open SQL, dbcon, 3
		recordcount = CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
%>

<script language="JavaScript">
<!--
function goSearch() {
	var f = document.fm1;
	f.action = "faq.asp";
	f.method = "post";
	f.submit();
}
function writeKeyDown() {
	if (event.keyCode == 13)	goSearch();
}
function layer_toggle(obj) {
	if (obj.style.display == 'none') obj.style.display = 'block';
	else if (obj.style.display == 'block') obj.style.display = 'none';
}
//-->
</script>


<div id="wrap">
	<div>
		<ul>
			<li class="ib vt" style="width:230px;"><!-- #include virtual = "/inc/left/comu.asp" --></li>
			<li class="ib vt">
				<div id="mainwrap1">
					<div class="mt20">
						<img src="/img/commu_tle.gif" width="195" height="24" alt="커뮤니티" />
					</div>
					<div class="mt10 mb10">
						<img src="/img/comu_faq_tle.gif" alt="FAQ" />
					</div>

					<!-- 게시물 검색 시작 -->
<form name="fm1" id="fm1" method="post">
<input type="hidden" name="cd1" value="question">
					<div class="rg">
						<input type="text" name="cd2" maxlength="10" onKeyDown="writeKeyDown()" style="width:120px; ime-mode:active;">
						<a href="javascript:goSearch()" class="btn btn25"><span>검색</span></a>
					</div>
</form>
					<!-- 게시물 검색 끝 -->
					<div class="pt10"></div>
					<hr style="border:1px solid #777;">
					<div>
<%
		rso()
		SQL = " SELECT	TOP 15 * FROM _ofaqt010 "& param _
			& " AND seq NOT IN (SELECT TOP "& ((page-1) * 15) &" seq FROM _ofaqt010 "& param _
			& " ORDER BY seq DESC) ORDER BY seq DESC "
		rs.open SQL, dbcon, 0, 3

		rs.pagesize = 15
		j = recordcount

		If Not (rs.eof And rs.bof) Then
			If page <> 1 Then
				j = j - (page - 1) * rs.pagesize
			End If

			i = 1
			rs.MoveFirst
			Do Until rs.EOF
%>
						<ul class="mt5 mb5">
							<li style="width:100%;" class="ib">
								<div id="faq<%=i%>a" style="display:block; padding:10px 40px;">
								<a href="#" onClick="layer_toggle(document.getElementById('faq<%=i%>a')); layer_toggle(document.getElementById('faq<%=i%>b'));return false;">
								<img src="/img/icon/icon_q.gif" width="14" height="13" class="vm">&nbsp;&nbsp;<b><%=rs("question")%></b></a>
								</div>
								<div id="faq<%=i%>b" style="display:none; padding:10px 40px;">
								<a href="#" onClick="layer_toggle(document.getElementById('faq<%=i%>a')); layer_toggle(document.getElementById('faq<%=i%>b'));return false;">
								<img src="/img/icon/icon_q.gif" width="14" height="13" class="vm">&nbsp;&nbsp;<b><%=rs("question")%></b></a>
								<p class="pt10 pl20"><%=db2html(rs("answer"))%></p>
								</div>
							</li>
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
							<li style="height:200px;" class="ct">내용이 없습니다.</li>
							<hr style="border:1px dotted #ccc;">
						</ul>
<%
		End If
		rsc()
%>
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
		If (blockpage+i-1) = totalpage Then %>
<%		Else %>
						&nbsp;&nbsp;
						<a href="?page=<%=blockpage+10%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn18"><span>다음</span></a>
						<a href="?page=<%=totalpage%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn18"><span>끝으로</span></a>
<%		End If %>
					</div>

					<div>
<%		If FID_AUTH <> "" And FID_AUTH < 10 Then %>
									<!-- <a href="notice_w.asp" class="btn btn25"><span>글쓰기</span></a> -->
<%		End If %>
					</div>
					<div class="pt20 pb20">&nbsp;</div>
				</div>
			</li>
			<li class="ib vt"><!-- #include virtual = "/inc/quick.asp" --></li>
		</ul>
	</div>
</div>
<!-- #include virtual = "/inc/footer.asp" -->