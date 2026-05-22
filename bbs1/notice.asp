<!-- #include virtual = "/inc/header.asp" -->
<%
	bbs_id						= 10								'10-공지/20-메모/50-요리/60-초보자/70-노하우/80-매니아/90-카풀/100-중고/110-레시피/120-잡다한소식/130-상품소개
	cd1							= SQLI(Request("cd1"))				'검색조건
	cd2							= SQLI(Request("cd2"))				'검색단어
	page						= SQLI(Request("page"))
	cate						= SQLI(Request("cate"))
	flag						= SQLI(Request("flag"))
	setsize						= 10								'보여지는 페이지 수
	pgsize						= 15								'보여지는 게시물 수
	tag							= 1

	If cd1 = "" Then cd1 = "title"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If
	stpage						= Int((page - 1) * pgsize)		'각 페이지에 맞게 잘라올 시작값

	pagesize = 20
	Set cx = New BsfCode

	If cd2 <> "" Then
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' AND bbs_id = "& bbs_id &" AND seq <> 59 "
	Else
		param = " WHERE bbs_id = "& bbs_id &" AND seq <> 59 "
	End If

	rso()
	SQL = " SELECT	COUNT(*) FROM _obbst010 "& param
	rs.open SQL, dbcon, 3
		recordcount = CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
%>

<script language="JavaScript">
<!--
function goSearch(){
	unoRequest("fm1", "notice.asp");
}
function writeKeyDown(){
	if (event.keyCode == 13)	goSearch();
}
//-->
</script>

<!-- #include virtual = "/inc/top.asp" -->

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
						<img src="/img/comu_gongji_tle.gif" alt="공지사항" />
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
						<a href="javascript:goSearch()" class="btn btn25"><span>검색</span></a>
					</div>
</form>
					<!-- 게시물 검색 끝 -->
					<div class="pt10"></div>
					<hr style="border:1px solid #777;">
					<div>
						<ul class="mt5 mb5">
							<li style="width:70px;" class="ib ct">번호</li>
							<li style="width:450px;" class="ib ct">제목</li>
							<li style="width:100px;" class="ib ct">글쓴이</li>
							<li style="width:70px;" class="ib ct">읽음</li>
						</ul>
					</div>
					<hr style="border:1px solid #777;">
					<div>
<%
		rso()
		SQL = " SELECT	TOP 15 * FROM _obbst010 "& param _
			& " AND seq NOT IN (SELECT TOP "& ((page-1) * 15) &" seq FROM _obbst010 "& param _
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
				Set rs3 = Server.CreateObject("ADODB.Recordset")
				SQL = " SELECT ISNULL(COUNT(*),0) FROM _obbst011 WHERE seq = "& rs("seq")
				rs3.open SQL, dbcon
					pcnt = CInt(rs3(0))
				rs3.close
				Set rs3 = Nothing
%>
						<ul class="mt5 mb5">
							<li style="width:70px;" class="ib ct"><%=j%></li>
							<li style="width:450px;" class="ib">
								<a href="notice_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>"><%=trimtext(rs("title"),40)%></a>
<%				If pcnt <> 0 Then %>
								&nbsp;<img src="/img/icon/file.gif" width="9" height="9">
<%				End If %>
								<%If Date() - rs("ddate") < 3 Then%><img src="/img/icon/new03.gif" width="11" height="11" class="vm"><%End If%>
							</li>
							<li style="width:100px;" class="ib ct"><%=Left(rs("ddate"),10)%></li>
							<li style="width:70px;" class="ib ct"><%=rs("cnt")%></li>
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