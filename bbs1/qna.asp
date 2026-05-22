<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	cd1							= SQLI(Request("cd1"))				'검색조건
	cd2							= SQLI(Request("cd2"))				'검색단어
	page						= SQLI(Request("page"))
	cate						= SQLI(Request("cate"))
	flag						= SQLI(Request("flag"))
	setsize						= 10								'보여지는 페이지 수
	pgsize						= 15								'보여지는 게시물 수
	tag							= 3

	If cd1 = "" Then cd1 = "title"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If

	pagesize = 20
	Set cx = New BsfCode

	If cd2 <> "" Then
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' "
	Else
		param = " WHERE 1 = 1 "
	End If

	rso()
	SQL = " SELECT	COUNT(*) FROM _obbst030 "& param
	rs.open SQL, dbcon, 3
		recordcount = CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
%>

<script language="JavaScript">
<!--
function goSearch(){
	unoRequest("fm1", "qna.asp");
}
function writeKeyDown(){
	if (event.keyCode == 13)	goSearch();
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
						<img src="/img/comu_qna_tle.gif" alt="문의게시판" />
					</div>
					<div class="mb20">
						<center>
							<div class="gbox01" style="width:700px;">
								<dl class="mt5 mb5">저작권에 위반되거나 광고성 글, 기타 사이트 운영에 저해되는 게시물은 예고없이 삭제될 수 있습니다.</dl>
							</div>
						</center>
					</div>

					<!-- 게시물 검색 시작 -->
<form name="fm1" id="fm1" method="post">
					<div class="rg">
						<select name="cd1" id="search" style="width:100px;">
						<option value=""<%If cd1 = "" Then%> selected<%End If%>>선택</option>
						<option value="uname"<%If cd1 = "uname" Then%> selected<%End If%>>작성자</option>
						<option value="title"<%If cd1 = "title" Then%> selected<%End If%>>글제목</option>
						</select>
						<input type="text" name="cd2" value="<%=cd2%>" maxlength="10" onKeyDown="writeKeyDown()" style="width:120px; ime-mode:active;">
						<a href="javascript:;" onClick="goSearch()" class="btn btn25"><span>검색</span></a>
					</div>
</form>
					<!-- 게시물 검색 끝 -->
					<div class="pt10"></div>
					<hr style="border:1px solid #777;">
					<div>
						<ul class="mt5 mb5">
							<li style="width:50px;" class="ib ct">번호</li>
							<li style="width:400px;" class="ib ct">제목</li>
							<li style="width:100px;" class="ib ct">글쓴이</li>
							<li style="width:80px;" class="ib ct">글쓴날짜</li>
							<li style="width:60px;" class="ib ct">읽음</li>
						</ul>
					</div>
					<hr style="border:1px solid #777;">
					<div>
<%
		rso()
		SQL = " SELECT	TOP "& pgsize &" * FROM _obbst030 "& param _
			& " AND seq NOT IN (SELECT TOP "& ((page-1) * pgsize) &" seq FROM _obbst030 "& param _
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
							<li style="width:50px;" class="ib ct"><%=j%></li>
							<li style="width:400px;" class="ib">
<%
				If rs("secret") Then
					If FID_NO <> "" And FID_NO <> CInt(rs("uno")) Then
%>
								<a href="qna_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>"><img src="/img/icon/secret.gif" class="mr10" /><%=trimtext(rs("title"),40)%></a>
<%					Else %>
								<a href="#" onClick="return mpop5('/inc/pwd.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&op=qna','ev','center',400,200,0);">
								<img src="/img/icon/secret.gif" class="mr10" /><%=trimtext(rs("title"),40)%></a>
<%
					End If
				Else
%>
								<a href="qna_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>"><%=trimtext(rs("title"),40)%></a>
<%				End If %>
<%				If pcnt <> 0 Then %>
								&nbsp;<img src="/img/icon/file.gif" width="9" height="9" alt="첨부파일" />
<%				End If %>
								<%If Date()-rs("ddate") < 3 Then%><img src="/img/icon/new03.gif" width="11" height="11" class="vm" alt="신규글" /><%End If%>
							</li>
							<li style="width:100px;" class="ib ct"><%=rs("uname")%></li>
							<li style="width:80px;" class="ib ct"><a href="qna_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>"><%=Left(rs("ddate"),10)%></a></li>
							<li style="width:60px;" class="ib ct"><%=rs("cnt")%></li>
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

					<div class="rg">
						<a href="qna_w.asp" class="btn btn25"><span>글쓰기</span></a>
					</div>
					<div class="pt20 pb20">&nbsp;</div>
				</div>
			</li>
			<li class="ib vt"><!-- #include virtual = "/inc/quick.asp" --></li>
		</ul>
	</div>
</div>
<!-- #include virtual = "/inc/footer.asp" -->
