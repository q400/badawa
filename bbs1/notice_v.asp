<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
'	Call checkLevel(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	bbs_id						= 10							'10-공지/20-메모/50-요리/60-초보자/70-노하우/80-매니아/90-카풀/100-중고/110-레시피/120-잡다한소식/130-상품소개
	seq							= SQLI(Request("seq"))
	cd1							= SQLI(Request("cd1"))			'검색조건
	cd2							= SQLI(Request("cd2"))			'검색단어
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))
	inpwd						= SQLI(Request("pwd"))
	tag							= 1

	If cd1 = "" Then cd1 = "title"
	If page = "" Then page = 1

	If cd2 <> "" Then
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' "
	Else
		param = " WHERE 1 = 1 "
	End If

	If seq <> "" Then
		rso()
		SQL = " SELECT	title, uno, uip, cnt, ddate, contents FROM _obbst010 WHERE bbs_id = "& bbs_id &" AND seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			title				= rs("title")
			uno					= rs("uno")
			uip					= rs("uip")
			cnt					= rs("cnt")
			ddate				= rs("ddate")
			contents			= rs("contents")
		End If
		rsc()

		rso()
		SQL = " SELECT ISNULL(COUNT(*),0) FROM _obbst011 WHERE seq = "& seq
		rs.open SQL, dbcon
			file_cnt = rs(0)
		rsc()
	End If

	pvP = 0
	ntP = 0

	rso()					'이전글
	SQL = " SELECT TOP 1 seq, title FROM _obbst010 "& param &" AND bbs_id = "& bbs_id &" AND seq < "& seq &" AND seq <> 59 ORDER BY seq DESC "		'59번은 모바일 공지용
	rs.open SQL, dbcon
	If Not rs.eof Then
		pvP = rs(0)
		pvTitle = rs(1)
	End If
	rsc()

	rso()					'다음글
	SQL = "	SELECT TOP 1 seq, title FROM _obbst010 "& param &" AND bbs_id = "& bbs_id &" AND seq > "& seq &" AND seq <> 59  ORDER BY seq "
	rs.open SQL, dbcon
	If Not rs.eof Then
		ntP = rs(0)
		ntTitle = rs(1)
	End If
	rsc()

	SQL = " UPDATE _obbst010 SET cnt = cnt + 1 WHERE seq = "& seq
	dbcon.Execute SQL
%>

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
					<div class="pt20"></div>
					<hr style="border:1px solid #777;">
					<div>
						<ul style="">
							<li class="ib lh32 bd9"><span class="pl10">글제목</span></li>
							<li style="width:590px;" class="ib lh32"><b class="pl10"><%=title%></b></li>
						</ul>
					</div>
					<hr style="border:1px dotted #999;">
					<div>
						<ul>
							<li class="ib lh32 bd9"><span class="pl10">작성일</span></li>
							<li style="width:300px;" class="ib lh32"><span class="pl10"><%=ddate%></span></li>
							<li class="ib lh32 bd91"><span class="pl10">조회수</span></li>
							<li class="ib lh32"><span class="pl10"><%=cnt%></span></li>
						</ul>
					</div>
					<hr style="border:1px dotted #999;">
					<p style="height:100%;" class="vt mt20 mb20 ml10 mr10"><%=db2html(contents)%></p>
					<hr style="border:1px solid #777;">
					<div>
						<ul>
							<li class="ib lh32 bd9"><span class="pl10">첨부파일</span></li>
							<li style="width:590px;" class="ib lh32">
								<span class="pl10">
<%
		If seq <> "" Then
			rso()
			SQL = " SELECT	idx, seq, fpath, fnm, fsz, fwd, ext, best FROM _obbst011 WHERE seq = "& seq
			rs.open SQL, dbcon
			k = 1
			While Not rs.eof
%>
								<a href="/data/dld.asp?path=notice&file=<%=rs("fnm")%>"><%=rs("fnm")%></a><br>
<%
				k = k + 1
				rs.MoveNext
			Wend
			rsc()
		End If
%>
								</span>
							</li>
						</ul>
					</div>
					<hr style="border:1px dotted #999;">
					<div class="pt10 pb10">
						<p class="rg"><a href="notice.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn25"><span>목록</span></a></p>
					</div>
					<hr style="border:1px solid #777;">
					<div>
						<ul>
							<li class="ib lh32 bd9"><span class="pl10">윗글</span></li>
							<li style="width:590px;" class="ib lh32"><span class="pl10"><a href="?seq=<%=ntP%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>"><%=ntTitle%></a></span></li>
						</ul>
					</div>
					<hr style="border:1px dotted #999;">
					<div>
						<ul>
							<li class="ib lh32 bd9"><span class="pl10">아래글</span></li>
							<li style="width:590px;" class="ib lh32"><span class="pl10"><a href="?seq=<%=pvP%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>"><%=pvTitle%></a></span></li>
						</ul>
					</div>
					<hr style="border:1px dotted #999;">
					<div class="pt20 pb20">&nbsp;</div>
				</div>
			</li>
			<li class="ib vt"><!-- #include virtual = "/inc/quick.asp" --></li>
		</ul>
	</div>
</div>
<!-- #include virtual = "/inc/footer.asp" -->