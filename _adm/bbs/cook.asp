<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	bbs_id						= 50								'10-공지/20-메모/50-요리/60-초보자/70-노하우/80-매니아/90-카풀/100-중고/110-레시피/120-잡다한소식/130-상품소개
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	page						= SQLI(Request("page"))
	op							= SQLI(Request("op"))
	setsize						= 10								'보여지는 페이지 수
	pgsize						= 20								'보여지는 게시물 수

	If cd1 = "" Then cd1 = "title"
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

	rso()
	SQL = " SELECT	COUNT(*) FROM _obbst010 "& param
	rs.open SQL, dbcon, 3
		recordcount = CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
	pageParam = "cd1="& cd1 &"&cd2="& cd2 &"&shipid="& shipid
%>

<script type="text/javascript">
<!--
function goSearch(){
	var f = document.fm1;
	f.page.value = 1;
	f.action = "cook.asp";
	f.method = "post";
	f.submit();
}
function writeKeyDown(){
	if(event.keyCode == 13)	goSearch();
}
//-->
</script>


<form name="fm1">
<input type="hidden" name="page" value="<%=page%>">
<div id="wrap">
	<div>
		<!-- #include virtual = "/_adm/inc/top.asp" -->
	</div>
	<center>
		<div id="admwrap0">
			<div class="ib vt" id="admLeft"><!-- #include virtual = "/_adm/inc/left.asp" --></div>
			<div class="ib vt" id="admwrap1">
				<div id="poptitle2">
					<p class="lf">
						<span class="tt2">요리교실</span>
						<span class="ib fright">
							<select name="cd1" style="width:120px;">
							<option value=""<%If cd1 = "" Then%> selected<%End If%>>선택</option>
							<option value="title"<%If cd1 = "title" Then%> selected<%End If%>>제목</option>
							</select>
							<input type="text" name="cd2" style="width:100px;ime-mode:active;" />
							<a href="javascript:goSearch();" class="btn btn25"><span>검색</span></a>
						</span>
					</p>

					<!-- 리스트 시작 -->
					<table id="list1" class="wrapSub">
						<colgroup>
							<col style="width:50px;" />
							<col style="width:120px;" /><!-- 음식종류 -->
							<col /><!-- 제목 -->
							<col style="width:100px;" /><!-- 작성일자 -->
							<col style="width:100px;" /><!-- 조회수 -->
						</colgroup>
						<thead>
							<tr style="height:30px;">
								<th class="bdr-dash-r ct">번호</th>
								<th class="bdr-dash-r ct">음식종류</th>
								<th class="bdr-dash-r ct">제목</th>
								<th class="bdr-dash-r ct">작성일자</th>
								<th class="ct">조회수</th>
							</tr>
						</thead>
						<tbody>
<%
		rso()
		SQL = " SELECT TOP "& pgsize &" * FROM _obbst010 "& param _
			& " AND seq NOT IN (SELECT TOP "& ((page-1) * pgsize) &" seq FROM _obbst010 "& param _
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
				Set rs3 = Server.CreateObject("ADODB.Recordset")
				SQL = " SELECT ISNULL(COUNT(*),0) FROM _obbst011 WHERE seq = "& rs("seq")
				rs3.open SQL, dbcon
					pcnt = rs3(0)
				rs3.close
				Set rs3 = Nothing
%>
							<tr height=30>
								<td class="ct"><%=j%></td>
								<td class="ct">
									<a href="cook_w.asp?seq=<%=rs("seq")%>&<%=pageParam%>&page=<%=page%>"><%=rs("gubn")%></a>
								</td>
								<td>&nbsp;
									<a href="cook_w.asp?seq=<%=rs("seq")%>&<%=pageParam%>&page=<%=page%>"><%=rs("title")%></a></td>
								<td class="ct"><%=Left(rs("ddate"),10)%></td>
								<td class="ct"><%=rs("cnt")%></td>
							</tr>
<%
					rs.MoveNext
					i = i + 1
					j = j - 1
			Loop
		Else
%>
							<tr height="100">
								<td class="ct vm" colspan=10>등록된 자료가 없습니다.</td>
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
					<a href="cook_w.asp" class="btn btn25"><span>글쓰기</span></a>
				</div>
			</div>
			<!-- admwrap1 E -->
		</div>
	</center>
	<div>
		<!-- #include virtual = "/_adm/inc/footer.asp" -->
	</div>
</div>
</form>
<%	Set cx = Nothing %>
