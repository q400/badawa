<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	bbs_id						= 120								'10-공지/20-메모/50-요리/60-초보자/70-노하우/80-매니아/90-카풀/100-중고/110-레시피/120-잡다한소식/130-상품소개
	cd1							= SQLI(Request("cd1"))				'검색조건
	cd2							= SQLI(Request("cd2"))				'검색단어
	cd3							= SQLI(Request("cd3"))
	page						= SQLI(Request("page"))
	cate						= SQLI(Request("cate"))
	flag						= SQLI(Request("flag"))
	vw							= SQLI(Request("vw"))				'list/thumb
	setsize						= 10								'보여지는 페이지 수
	pgsize						= 15								'보여지는 게시물 수
	tag							= 8

	If cd1 = "" Then cd1 = "title"
	If vw = "" Then vw = "thumb"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If

	pagesize = 20
	Set cx = New BsfCode

	If cd2 <> "" Then
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' AND bbs_id = "& bbs_id
	Else
		param = " WHERE bbs_id = "& bbs_id
	End If

	If cd3 <> "" Then
		param = param &" AND gubn = '"& cd3 &"'"
	End If

	rso()
	SQL = " SELECT COUNT(*) FROM _obbst010 "& param
	rs.open SQL, dbcon, 3
		recordcount = CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
%>

<script language="JavaScript">
<!--
function goSearch(){
	var f = document.fm1;
	f.action = "news.asp";
	f.method = "post";
	f.submit();
}
function writeKeyDown(){
	if(event.keyCode == 13)	goSearch();
}
//-->
</script>


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
						<img src="/img/bbs/comu_news_tle2.png" alt="제임스이야기" title="제임스이야기" />
					</div>

<form name="fm1" id="fm1" method="post">

					<!-- 게시물 검색 시작 -->
					<div class="mt20">
						<div style="width:300px;" class="ib">
							<img src="/img/icon_list.gif" width="15" height="15" class="vm" alt="리스트형" />&nbsp;<a href="?vw=list">리스트형</a>
							&nbsp;&nbsp;
							<img src="/img/icon_img.gif" width="15" height="15" class="vm" alt="이미지형" />&nbsp;<a href="?vw=thumb">이미지형</a>
						</div>
						<div class="ib fright">
							글 제목&nbsp;&nbsp;
							<input type="text" name="cd2" style="width:100px;" class="vm" />
							<a href="javascript:goSearch()" class="btn btn25"><span>검색</span></a>
						</div>
					</div>
					<!-- 게시물 검색 끝 -->
</form>
					<div class="pt10"></div>
					<hr style="border:1px solid #777;">

<%
	If vw = "thumb" Then		'이미지형
%>
					<div>
						<ul>
<%
		rso()
		SQL = " SELECT	TOP "& pgsize &" * FROM _obbst010 "& param _
			& " AND seq NOT IN (SELECT TOP "& ((page-1) * pgsize) &" seq FROM _obbst010 "& param _
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
				fnm = ""
				Set rs3 = Server.CreateObject("ADODB.Recordset")
				SQL = " SELECT TOP 1 idx, fpath, fnm, onm, fwd, fsz, ext, best FROM _obbst011 WHERE seq = "& rs("seq") &" AND ext NOT IN ('flv','wmv','movie') ORDER BY idx DESC "
				rs3.open SQL, dbcon
				If Not rs3.eof Then
					idx			= rs3("idx")
					fpath		= rs3("fpath")
					fnm			= rs3("fnm")
					onm			= rs3("onm")
				End If
				rs3.close
				Set rs3 = Nothing
				If fnm = "" Then fnm = "noimages.gif"
%>
							<li style="width:160px; margin:20px 2px 0px 10px;" class="vt ib">
								<div>
									<a href="news_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&vw=<%=vw%>"><img src="/data/news/<%=fnm%>" width="160" class="gbox03" alt="사진" title="사진" /></a>
								</div>
								<p>
									<a href="news_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&vw=<%=vw%>"><b><%=trimtext(rs("title"),20)%></b></a>
									<%If Date() - rs("ddate") < 3 Then%><img src="/img/icon/new04.gif" width="19" height="8" class="vm"><%End If%>
								</p>
								<p class="fc2 ff ls">분류 : <%=rs("gubn")%></p>
								<p>조회수 : <%=FormatNumber(rs("cnt"),0)%></p>
							</li>
<%
				rs.MoveNext
				i = i + 1
				j = j - 1
			Loop
		Else
%>
							<li style="height:200px;" class="ct">등록된 소식이 없습니다.</li>
							<hr style="border:1px dotted #ccc;">
<%
		End If
		rsc()
%>
						</ul>
					</div>
<%
	Else		'리스트형
%>
					<div>
						<ul>
							<li width="70"></li>
							<li width="120"><font class="fz f13 fc9">분류</font></li>
							<li width="380"><font class="fz f13 fc9">제목</font></li>
							<li width="80"><font class="fz f13 fc9">등록일자</font></li>
							<li width="60"><font class="fz f13 fc9">조회수</font></li>
						</ul>
<%
		rso()
		SQL = " SELECT TOP "& pgsize &" * FROM _obbst010 "& param _
			& " AND seq NOT IN (SELECT TOP "& ((page-1) * pgsize) &" seq FROM _obbst010 "& param _
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
				fnm = ""
				Set rs3 = Server.CreateObject("ADODB.Recordset")
				SQL = " SELECT TOP 1 idx, fpath, fnm, onm, fwd, fsz, ext, best FROM _obbst011 WHERE seq = "& rs("seq") &" AND ext NOT IN ('flv','wmv') ORDER BY idx DESC "
				rs3.open SQL, dbcon
				If Not rs3.eof Then
					idx			= rs3("idx")
					fpath		= rs3("fpath")
					fnm			= rs3("fnm")
					onm			= rs3("onm")
				End If
				rs3.close
				Set rs3 = Nothing
				If fnm = "" Then fnm = "noimages.gif"
%>
						<ul>
							<li class="ct"><a href="news_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&vw=<%=vw%>"><img src="/data/news/<%=fnm%>" width="60" /></a></li>
							<li class="ct"><a href="news_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&vw=<%=vw%>"><%=rs("gubn")%></a></li>
							<li>&nbsp;&nbsp;&nbsp;<a href="news_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&vw=<%=vw%>"><%=trimtext(rs("title"),20)%></a></li>
							<li class="ct fc2 f11"><%=Left(rs("ddate"),10)%></li>
							<li class="ct fc2 f11"><%=FormatNumber(rs("cnt"),0)%></li>
						</ul>
<%
				rs.MoveNext
				i = i + 1
				j = j - 1
			Loop
		Else
%>
						<ul>
							<li class="ct" colspan="10">등록된 소식이 없습니다.</li>
						</ul>
<%
		End If
		rsc()
%>
					</div>
<%
	End If
%>
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
