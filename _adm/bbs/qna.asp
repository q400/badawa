<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

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

<script type="text/javascript">
<!--
function goSearch(){
	var f = document.fm1;
	f.page.value = 1;
	f.action = "qna.asp";
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
						<span class="tt2">문의게시판</span>
						<span class="ib fright">
							<select name="cd1" style="width:120px;">
							<option value=""<%If cd1 = "" Then%> selected<%End If%>>선택</option>
							<option value="title"<%If cd1 = "title" Then%> selected<%End If%>>제목</option>
							</select>
							<input type="text" name="cd2" id="cd2" style="width:100px;ime-mode:active;" />
							<a href="javascript:goSearch();" class="btn btn25"><span>검색</span></a>
						</span>
					</p>

					<!-- 리스트 시작 -->
					<table id="list1" class="wrapSub">
						<colgroup>
							<col style="width:50px;" />
							<col /><!-- 제목 -->
							<col style="width:50px;" /><!-- 답변 -->
							<col style="width:100px;" /><!-- 글쓴이 -->
							<col style="width:80px;" /><!-- 작성일자 -->
							<col style="width:80px;" /><!-- 조회수 -->
						</colgroup>
						<thead>
							<tr style="height:30px;">
								<th class="bdr-dash-r ct">번호</th>
								<th class="bdr-dash-r ct">제목</th>
								<th class="bdr-dash-r ct">답변</th>
								<th class="bdr-dash-r ct">글쓴이</th>
								<th class="bdr-dash-r ct">작성일자</th>
								<th class="ct">조회수</th>
							</tr>
						</thead>
						<tbody>
<%
		rso()
		SQL = " SELECT TOP "& pgsize &" * FROM _obbst030 "& param _
			& " AND seq NOT IN (SELECT TOP "& ((page-1) * pgsize) &" seq FROM _obbst030 "& param _
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
				SQL = " SELECT ISNULL(COUNT(*),0) FROM _obbst031 WHERE seq = "& rs("seq")
				rs3.open SQL, dbcon
					pcnt = rs3(0)
				rs3.close
				Set rs3 = Nothing

				state = "<font class='fc7'>대기</font>"
				If rs("answer") <> "" Then state = "<font class='fc1'>완료</font>"
%>
						<tr height=30>
							<td class="ct"><%=j%></td>
							<td>&nbsp;<%If rs("secret") Then%><img src="/img/icon/secret.gif">&nbsp;<%End If%>
								<a href="qna_w.asp?seq=<%=rs("seq")%>&cd1=<%=cd1%>&cd2=<%=cd2%>&page=<%=page%>"><%=rs("title")%></a></td>
							<td class="ct"><%=state%></td>
							<td class="ct"><%=rs("uname")%></td>
							<td class="ct"><a href="qna_w.asp?seq=<%=rs("seq")%>&cd1=<%=cd1%>&cd2=<%=cd2%>&page=<%=page%>"><%=Left(rs("ddate"),10)%></a></td>
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
				<!-- poptitle2 E -->

				<div class="pt10 ct">
<%
		blockpage = Int((page-1)/10)*10+1
		If blockpage = 1 Then %>
<%		Else %>
					<a href="?page=1&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn18"><span>처음으로</span></a>
					<a href="?page=<%=blockpage-1%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn18"><span>이전</span></a>&nbsp;&nbsp;
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
					&nbsp;&nbsp;<a href="?page=<%=blockpage+10%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn18"><span>다음</span></a>
					<a href="?page=<%=totalpage%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn18"><span>끝으로</span></a>
<%		End If %>
				</div>
				<div id="btnarea1"></div>
			</div>
			<!-- admwrap1 E -->
		</div>
	</center>
</form>
	<div>
		<!-- #include virtual = "/_adm/inc/footer.asp" -->
	</div>
</div>
<%	Set cx = Nothing %>
