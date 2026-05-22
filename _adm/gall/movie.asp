<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	page						= SQLI(Request("page"))

	setsize						= 10							'보여지는 페이지 수
	pgsize						= 20							'보여지는 게시물 수

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
	SQL = " SELECT	COUNT(*) FROM _obbst040 "& param
	rs.open SQL, dbcon, 3
		recordcount = CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
	pageParam = "cd1="& cd1 &"&cd2="& cd2
%>

<script language="JavaScript">
<!--
function goSearch(){
	var f = document.fm1;
	f.page.value = 1;
	f.action = "movie.asp";
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
		<!-- #include virtual = "/_adm/inc/top.asp" -->
	</div>
	<center>
		<div id="admwrap0">
			<div class="ib vt" id="admLeft"><!-- #include virtual = "/_adm/inc/left.asp" --></div>
			<div class="ib vt" id="admwrap1">

<form name="fm1">
<input type="hidden" name="page" value="<%=page%>">

				<div id="poptitle2">
					<p class="lf">
						<span class="tt2">낚시동영상</span>
						<span class="ib fright">
							<select name="cd1" style="width:100px;">
								<option value=""<%If cd1 = "" Then%> selected<%End If%>>선택</option>
								<option value="shipnm"<%If cd1 = "shipnm" Then%> selected<%End If%>>해당선박</option>
								<option value="title"<%If cd1 = "title" Then%> selected<%End If%>>제목</option>
							</select>
							<input type="text" name="cd2" style="width:100px;" />
							<a href="javascript:goSearch();" class="btn btn25"><span>검색</span></a>
						</span>
					</p>

					<!-- 리스트 시작 -->
					<table id="list1" class="wrapSub">
						<colgroup>
							<col style="width:40px;" />
							<col style="width:130px;" /><!-- 해당선박 -->
							<col /><!-- 제목 -->
							<col style="width:100px;" /><!-- 촬영일자 -->
							<col style="width:100px;" /><!-- 작성일 -->
							<col style="width:100px;" /><!-- 조회수 -->
						</colgroup>
						<thead>
							<tr>
								<th class="bdr-dash-r ct">번호</th>
								<th class="bdr-dash-r ct">해당선박</th>
								<th class="bdr-dash-r ct">제목</th>
								<th class="bdr-dash-r ct">촬영일자</th>
								<th class="bdr-dash-r ct">작성일</th>
								<th class="ct">조회수</th>
							</tr>
						</thead>
						<tbody>
<%
		rso()
		SQL = " SELECT TOP "& pgsize &" * FROM _obbst040 "& param _
			& " AND seq NOT IN (SELECT TOP "& ((page-1) * pgsize) &" seq FROM _obbst040 "& param _
			& " ORDER BY seq DESC) ORDER BY seq DESC "
		rs.open SQL, dbcon, 0, 3
		rs.pagesize = 20
		j = recordcount

		If Not (rs.eof And rs.bof) Then
			If page <> 1 Then
				j = j - (page - 1) * rs.pagesize
			End If

			i = 1
			rs.MoveFirst
			Do Until rs.EOF
%>
							<tr height="32">
								<td class="ct"><%=j%></td>
								<td class="ct">
									<a href="movie_w.asp?seq=<%=rs("seq")%>&sdate=<%=rs("wdate")%>&page=<%=page%>&<%=pageParam%>"><%=shipInfo(rs("shipid"),"shipnm")%></a>
								</td>
								<td>&nbsp;&nbsp;&nbsp;
									<a href="movie_w.asp?seq=<%=rs("seq")%>&sdate=<%=rs("wdate")%>&page=<%=page%>&<%=pageParam%>"><%=rs("title")%></a></td>
								<td class="ct"><%=rs("wdate")%></td>
								<td class="ct"><%=Left(rs("ddate"),10)%></td>
								<td class="ct"><%=FormatNumber(rs("cnt"),0)%></td>
							</tr>
<%
					rs.MoveNext
					i = i + 1
					j = j - 1
			Loop
		Else
%>
							<tr height="100">
								<td class="ct vm" colspan=10>등록된 사진이 없습니다.</td>
							</tr>
<%
		End If
		rsc()
%>
						</tbody>
					</table>
					<!-- 리스트 끝 -->
				</div>
				<div class="ct mt10"><%=fnPaging(totalpage, page, 10, pageParam)%></div>
				<div id="btnarea1">
					<a href="movie_w.asp" class="btn btn25"><span>동영상등록</span></a>
				</div>
</form>
			</div>
		</div>
	</center>
	<div>
		<!-- #include virtual = "/_adm/inc/footer.asp" -->
	</div>
</div>
<%	Set cx = Nothing %>