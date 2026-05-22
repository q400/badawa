<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	page						= SQLI(Request("page"))
	op							= SQLI(Request("op"))
	setsize						= 10								'보여지는 페이지 수
	pgsize						= 20								'보여지는 게시물 수

	If cd1 = "" Then cd1 = "shipNm"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If

	If cd2 <> "" Then
		param = " WHERE shipid = (SELECT shipid FROM _oshpt010 WHERE shipnm LIKE '%"& cd2 &"%') "
	Else
		param = " WHERE 1=1 "
	End If

	rso()
	SQL = " SELECT COUNT(*) FROM _orsvt010 "& param
	rs.open SQL, dbcon, 3
		recordcount = rs(0)
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
%>

<script type="text/javascript">
function goSearch(){
	var f = document.fm1;
	f.page.value = 1;
	f.action = "rsv.asp";
	f.method = "post";
	f.submit();
}
function writeKeyDown(){
	if(event.keyCode == 13)	goSearch();
}
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
<input type="hidden" name="page" id=page value="<%=page%>">

				<div id="poptitle2">
					<p class="lf">
						<span class="tt2">예약현황(전체)</span>
						<span class="ib fright">
							<select name="cd1" style="width:120px;">
								<option value=""<%If cd1 = "" Then%> selected<%End If%>>선택</option>
								<option value="shipNm"<%If cd1 = "shipNm" Then%> selected<%End If%>>선박이름</option>
							</select>
							<input type="text" name="cd2" id="cd2" style="width:100px;" />
							<a href="javascript:goSearch();" id=search class="btn btn25"><span>검색</span></a>
							<a href="rsv.asp" id=btnReset class="btn btn25"><span>새로고침</span></a>
						</span>
					</p>

					<!-- 리스트 시작 -->
					<table id="list1" class="wrapSub">
						<colgroup>
							<col style="width:80px;" /><!-- ridx -->
							<col style="width:100px;" /><!-- 예약일자 -->
							<col /><!-- 예약자이름 -->
							<col style="width:120px;" /><!-- 해당선박 -->
							<col style="width:50px;" /><!-- 인원 -->
							<col style="width:100px;" /><!-- 연락처 -->
							<col style="width:180px;" /><!-- 이메일 -->
							<col style="width:80px;" /><!-- 예약경로 -->
							<col style="width:80px;" /><!-- 관리자예약 -->
						</colgroup>
						<thead>
							<tr style="height:30px;">
								<th class="bdr-dash-r ct">번호</th>
								<th class="bdr-dash-r ct">예약일자</th>
								<th class="bdr-dash-r ct">예약자이름</th>
								<th class="bdr-dash-r ct">해당선박</th>
								<th class="bdr-dash-r ct">인원</th>
								<th class="bdr-dash-r ct">연락처</th>
								<th class="bdr-dash-r ct">이메일</th>
								<th class="bdr-dash-r ct">예약경로</th>
								<th class="ct">관리자예약</th>
							</tr>
						</thead>
						<tbody>
<%
		rso()
		SQL = " SELECT TOP "& pgsize &" * FROM _orsvt010 "& param _
			& " AND ridx NOT IN (SELECT TOP "& ((page-1) * pgsize) &" ridx FROM _orsvt010 "& param _
			& " ORDER BY ridx DESC) ORDER BY ridx DESC "
'		Response.Write "<br>"& SQL &"<br>"
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
				state = "PC"
				admRsv = ""
				If rs("mobile") = "Y" Then state = "모바일"
				If rs("memo") = "관리자예약" Then admRsv = "Y"
%>
						<tr height=30>
							<td class="ct"><%=rs("ridx")%></td>
							<td class="ct"><%=rs("rdate")%></td>
							<td>
								<a href="rsv_w.asp?ridx=<%=rs("ridx")%>&cd1=<%=cd1%>&cd2=<%=cd2%>&page=<%=page%>"><%=rs("rnm")%></a>
							</td>
							<td class="ct"><%=shipInfo(rs("shipid"),"shipnm")%></td>
							<td class="ct"><%=rs("inwon")%></td>
							<td class="ct"><%=rs("hp")%></td>
							<td class="ct"><%=rs("email")%></td>
							<td class="ct"><%=state%></td>
							<td class="ct"><%=admRsv%></td>
						</tr>
<%
					rs.MoveNext
					i = i + 1
					j = j - 1
			Loop
		Else
%>
						<tr height="100">
							<td class="ct vm" colspan=10>No Data</td>
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
