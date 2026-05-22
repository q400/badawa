<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
'	Call checkLevel(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	seq							= SQLI(Request("seq"))
	cd1							= SQLI(Request("cd1"))			'검색조건
	cd2							= SQLI(Request("cd2"))			'검색단어
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))
	inpwd						= SQLI(Request("pwd"))
	tag							= 3

	If cd1 = "" Then cd1 = "title"
	If page = "" Then page = 1

	If cd2 <> "" Then
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' "
	Else
		param = " WHERE 1 = 1 "
	End If

	If seq <> "" Then
		rso()
		SQL = " SELECT	title, uno, uname, pwd, uip, cnt, secret, ddate, contents, answer FROM _obbst030 WHERE seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			title				= rs("title")
			uno					= rs("uno")
			uname				= rs("uname")
			pwd					= rs("pwd")
			uip					= rs("uip")
			cnt					= rs("cnt")
			secret				= rs("secret")
			ddate				= rs("ddate")
			contents			= rs("contents")
			answer				= rs("answer")
		End If
		rsc()
'		If answer = "" Then answer = "<font class='fc9'>답변 준비중입니다.</font>"
	End If
'	Response.Write "FID_NO : "& FID_NO &"<br>"
'	Response.Write "uno : "& uno &"<br>"

	If secret Then
		If FID_NO <> "" And FID_NO <> CInt(uno) Then				'로그인 상태이고 작성자가 아닌 경우
			If pwd <> inpwd Then
				Call directGo("비밀글입니다.","qna.asp?page="& page &"&cd1="& cd1 &"&cd2="& cd2)
				Response.End
			End If
		End If
	End If

	pvP = 0
	ntP = 0

	rso()					'이전글
	SQL = " SELECT TOP 1 seq, title FROM _obbst030 "& param &" AND seq < "& seq &" ORDER BY seq DESC "
	rs.open SQL, dbcon
	If Not rs.eof Then
		pvP = rs(0)
		pvTitle = Trim(rs(1))
		If pvTitle = "" Then pvTitle = "글이 없습니다."
	End If
	rsc()

	rso()					'다음글
	SQL = "	SELECT TOP 1 seq, title FROM _obbst030 "& param &" AND seq > "& seq &" ORDER BY seq "
	rs.open SQL, dbcon
	If Not rs.eof Then
		ntP = rs(0)
		ntTitle = Trim(rs(1))
		If ntTitle = "" Then ntTitle = "글이 없습니다."
	End If
	rsc()

	SQL = " UPDATE _obbst030 SET cnt = cnt + 1 WHERE seq = "& seq
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
						<img src="/img/comu_qna_tle.gif" alt="문의게시판" />
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
							<li class="ib lh32 bd9"><span class="pl10">글쓴이</span></li>
							<li style="width:140px;" class="ib lh32"><span class="pl10"><%=uname%></span></li>
							<li class="ib lh32 bd91"><span class="pl10">글쓴날짜</span></li>
							<li style="width:180px;" class="ib lh32"><span class="pl10"><%=ddate%></span></li>
							<li class="ib lh32 bd91"><span class="pl10">조회수</span></li>
							<li class="ib lh32"><span class="pl10"><%=cnt%></span></li>
						</ul>
					</div>
					<hr style="border:1px dotted #999;">

					<p class="vt mt10 ml10"><img src="/img/bbs/qna_q.png" alt="문의합니다" /></p>
					<p style="height:100%;" class="vt mt10 mb20 ml10 mr10"><%=db2html(contents)%></p>
					<p class="vt mt20 ml10"><img src="/img/bbs/qna_a.png" alt="답변드려요" /></p>
<%		If answer = "" Then %>
					<p style="height:100%;" class="vt mt10 mb20 ml10 mr10">"답변 준비 중입니다."</p>
<%		Else %>
					<p style="height:100%;" class="vt mt10 mb20 ml10 mr10"><%=db2html(answer)%></p>
<%		End If %>
					<hr style="border:1px dotted #999;">

					<div class="pt10 pb10 rg">
<%		If answer = "" Then %>
						<a href="qna_w.asp?seq=<%=seq%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&pwd=<%=inpwd%>&flag=M" class="btn btn25"><span>수정/삭제</span></a>
<%		End If %>
						<a href="qna.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn25"><span>목록</span></a>
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