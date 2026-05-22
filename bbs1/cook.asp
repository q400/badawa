<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	bbs_id						= 50								'10-공지/20-메모/50-요리/60-초보자/70-노하우/80-매니아/90-카풀/100-중고/110-레시피/120-잡다한소식/130-상품소개
	cd1							= SQLI(Request("cd1"))				'검색조건
	cd2							= SQLI(Request("cd2"))				'검색단어
	page						= SQLI(Request("page"))
	cate						= SQLI(Request("cate"))
	flag						= SQLI(Request("flag"))
	vw							= SQLI(Request("vw"))				'list/thumb
	setsize						= 10								'보여지는 페이지 수
	pgsize						= 15								'보여지는 게시물 수
	tag							= 7

	If cd1 = "" Then cd1 = ""
	If vw = "" Then vw = "thumb"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If

	pagesize = 20
	Set cx = New BsfCode

	param = " WHERE bbs_id = "& bbs_id

	If cd1 <> "" Then
		param = param &" AND gubn = '"& cd1 &"' "
	End If

	rso()
	SQL = " SELECT COUNT(*) FROM _obbst010 "& param
	rs.open SQL, dbcon
		recordcount = CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
%>

<script language="JavaScript">
<!--
function goSearch(){
	var f = document.fm1;
	f.action = "cook.asp";
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
			<li class="ib vt" style="width:230px;"><!-- #include virtual = "/inc/left/comu.asp" --></li>
			<li class="ib vt">
				<div id="mainwrap1">
					<div class="mt20">
						<img src="/img/commu_tle.gif" width="195" height="24" alt="커뮤니티" />
					</div>
					<div class="mt10 mb10">
						<img src="/img/comu_cook_tle.gif" alt="요리교실" />
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
							<select name="cd1" id="search" style="width:120px;" onChange="location='?cd1='+ this.options[this.selectedIndex].value +''">
							<option value=""<%If cd1 = "" Then%> selected<%End If%>>선택</option>
<%
	rso()
	sql = " SELECT code_nm FROM _ocodt010 WHERE gubn = '요리종류' ORDER BY idx "
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
						</div>
					<!-- 게시물 검색 끝 -->
					</div>
</form>
					<div class="pt10"></div>
					<hr style="border:1px solid #777;">
<%
	If vw = "thumb" Then	'썸네일형
%>
					<div>
						<ul>
<%
		rso()
		SQL = " SELECT TOP "& pgsize &" * FROM _obbst010 "& param _
			& " AND seq NOT IN (SELECT TOP "& ((page-1) * pgsize) &" seq FROM _obbst010 "& param _
			& " ORDER BY seq DESC) ORDER BY seq DESC "
		rs.open SQL, dbcon

		j = recordcount

		If Not (rs.eof And rs.bof) Then
			If page <> 1 Then
				j = j - (page - 1) * pgsize
			End If

			i = 1
			rs.MoveFirst
			Do Until rs.EOF
				Set rs3 = Server.CreateObject("ADODB.Recordset")
				SQL = " SELECT TOP 1 idx, fpath, ISNULL(fnm, 'noimages.gif') fnm, onm, fwd, fsz, ext, best " _
					& " FROM _obbst011 " _
					& " WHERE seq = "& rs("seq") &" AND ext NOT IN ('flv','wmv') " _
					& " ORDER BY idx DESC "
				rs3.open SQL, dbcon
				If Not rs3.EOF Then
					idx			= rs3("idx")
					fpath		= rs3("fpath")
					fnm			= rs3("fnm")
					onm			= rs3("onm")
				End If
				rs3.close
				Set rs3 = Nothing
%>
							<li style="width:160px;" class="vt mt20 ib">
								<div>
									<a href="cook_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&vw=<%=vw%>"><img src="/data/cook/<%=fnm%>" width="160" class="gbox03" /></a>
								</div>
								<p>
									<a href="cook_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&vw=<%=vw%>"><%=trimtext(rs("title"),20)%></a>
									<%If Date() - rs("ddate") < 2 Then%><img src="/img/icon/new03.gif" width="11" height="11" class="vm"><%End If%>
								</p>
								<p>조회수 : <%=FormatNumber(rs("cnt"),0)%></p>
							</li>
<%
				rs.MoveNext
				i = i + 1
				j = j - 1
			Loop
		Else
%>
							<li style="height:200px;" class="ct">내용이 없습니다.</li>
							<hr style="border:1px dotted #ccc;">
<%
		End If
		rsc()
%>
						</ul>
					</div>
<%
	Else	'리스트형
%>
					<div>
						<ul class="mt5 mb5">
							<li style="width:540px;" class="ib ct">제목</li>
							<li style="width:100px;" class="ib ct">등록일자</li>
							<li style="width:60px;" class="ib ct">읽음</li>
						</ul>
					</div>
					<hr style="border:1px solid #777;">
					<div>
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
				Set rs3 = Server.CreateObject("ADODB.Recordset")
				SQL = " SELECT TOP 1 idx, fpath, fnm, onm, fwd, fsz, ext, best FROM _obbst011 WHERE seq = "& rs("seq") &" AND ext NOT IN ('flv','wmv') ORDER BY idx DESC "
				rs3.open SQL, dbcon
					idx			= rs3("idx")
					fpath		= rs3("fpath")
					fnm			= rs3("fnm")
					onm			= rs3("onm")
				rs3.close
				Set rs3 = Nothing
%>
						<ul class="mt5 mb5">
							<li style="width:70px;" class="ib ct">
								<a href="cook_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&vw=<%=vw%>"><img src="/data/cook/<%=fnm%>" width="60" /></a>
							</li>
							<li style="width:460px;" class="ml10 ib">
								<a href="cook_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&vw=<%=vw%>"><%=trimtext(rs("title"),20)%></a>
								<%If Date() - rs("ddate") < 2 Then%><img src="/img/icon/new03.gif" width="11" height="11" class="vm"><%End If%>
							</li>
							<li style="width:90px;" class="ib ct"><%=Left(rs("ddate"),10)%></li>
							<li style="width:60px;" class="ib ct"><%=FormatNumber(rs("cnt"),0)%></li>
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
<%
	End If
%>
					<div class="pt10 ct">
<%
		blockpage = Int((page-1)/10)*10+1
		If blockpage = 1 Then %>
<%		Else %>
						<a href="?page=1&cd1=<%=cd1%>&cd2=<%=cd2%>&vw=<%=vw%>" class="btn btn18"><span>처음으로</span></a>
						<a href="?page=<%=blockpage-1%>&cd1=<%=cd1%>&cd2=<%=cd2%>&vw=<%=vw%>" class="btn btn18"><span>이전</span></a>
						&nbsp;&nbsp;
<%		End If
		i = 0
		Do Until i = 10 Or (blockpage+i) > totalpage
			If Int(page) = blockpage+i Then
%>
						<a href="?page=<%=blockpage+i%>&cd1=<%=cd1%>&cd2=<%=cd2%>&vw=<%=vw%>" class="ff fb vm ls"><%=setP(blockpage+i)%></a>&nbsp;&nbsp;
<%			Else %>
						<a href="?page=<%=blockpage+i%>&cd1=<%=cd1%>&cd2=<%=cd2%>&vw=<%=vw%>" class="ff vm ls"><%=setP(blockpage+i)%></a>&nbsp;&nbsp;
<%			End If
			i = i + 1
		Loop
		if(blockpage+i-1) = totalpage Then %>
<%		Else %>
						&nbsp;&nbsp;
						<a href="?page=<%=blockpage+10%>&cd1=<%=cd1%>&cd2=<%=cd2%>&vw=<%=vw%>" class="btn btn18"><span>다음</span></a>
						<a href="?page=<%=totalpage%>&cd1=<%=cd1%>&cd2=<%=cd2%>&vw=<%=vw%>" class="btn btn18"><span>끝으로</span></a>
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
