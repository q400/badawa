<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	cd3							= SQLI(Request("cd3"))
	page						= SQLI(Request("page"))

	setsize						= 10								'보여지는 페이지 수
	pgsize						= 20								'보여지는 게시물 수

	If cd1 = "" Then cd1 = "uno"
	If cd3 = "" Then cd3 = 0
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If
	stpage						= Int((page - 1) * pgsize)			'각 페이지에 맞게 잘라올 시작값

	pagesize = 20
	Set cx = New BsfCode

	If cd2 <> "" Then
		If cd1 = "uno" Then
			param = " WHERE uno IN (SELECT seq FROM _omemt010 WHERE uname LIKE '%"& cd2 &"%') "
		Else
			param = " WHERE shipid IN (SELECT shipid FROM _oshpt010 WHERE shipnm LIKE '%"& cd2 &"%') "
		End If
	Else
		param = " WHERE 1 = 1 "
	End If

	If cd3 <> 0 Then
		param = param & " AND shipid = "& cd3
	End If

	rso()
	SQL = " SELECT	COUNT(*) FROM _opntt020 "& param
	rs.open SQL, dbcon
		recordcount = CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
	pageParam = "cd1="& cd1 &"&cd2="& cd2 &"&cd3="& cd3
%>

<script language="JavaScript">
<!--
function goSearch(){
	var f = document.fm1;
	f.page.value = 1;
	f.action = "point01.asp";
	f.method = "post";
	f.submit();
}
function writeKeyDown(){
	if(event.keyCode == 13)	goSearch();
}
function goDelete(vidx){
	var f = document.fm1;
	if(confirm("완전히 삭제하시겠습니까?       ")){
		f.idx.value = vidx;
		f.flag.value = "D01";
		f.action = "point_x.asp";
		f.method = "post";
		f.submit();
	}
}
//-->
</script>


<form name="fm1">
<input type="hidden" name="idx" value="<%=idx%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="flag">
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
						<span class="tt2">쉽포인트 관리</span>
						<span class="ib fright">
							<select name="cd1" style="width:120px;">
								<option value=""<%If cd1 = "" Then%> selected<%End If%>>선택</option>
								<option value="uno"<%If cd1 = "uno" Then%> selected<%End If%>>회원이름</option>
								<option value="shipid"<%If cd1 = "shipid" Then%> selected<%End If%>>선박이름</option>
							</select>
							<input type="text" name="cd2" style="width:100px;ime-mode:active;" />
							<a href="javascript:goSearch();" class="btn btn25"><span>검색</span></a>
							<a href="/_adm/mem/point01.asp" class="btn btn25"><span>새로고침</span></a>
							<select name="cd3" style="width:130px;" onChange="location='?cd3='+ this.options[this.selectedIndex].value +''">
								<option value=""<%If cd3 = 0 Then%> selected<%End If%>>전체</option>
<%
	rso()
	SQL = " SELECT shipid, shipnm FROM _oshpt010 "
	rs.open SQL, dbcon
	While Not rs.eof
%>
								<option value="<%=rs("shipid")%>"<%If CInt(cd3) = rs("shipid") Then%> selected<%End If%>><%=rs("shipnm")%></option>
<%
		rs.MoveNext
	Wend
	rsc()
%>
							</select>
						</span>
					</p>

					<!-- 리스트 시작 -->
					<table id="list2" class="wrapSub">
						<colgroup>
							<col style="width:50px;" /><!-- 번호 -->
							<col style="width:40px;" /><!-- 구분 -->
							<col style="width:60px;" /><!-- 적용포인트 -->
							<col style="width:80px;" /><!-- 회원이름 -->
							<col style="width:100px;" /><!-- 해당선박 -->
							<col style="width:80px;" /><!-- 출조일자 -->
							<col style="width:80px;" /><!-- 처리일자 -->
							<col /><!-- 내용 -->
							<col style="width:40px;" /><!-- 취소 -->
						</colgroup>
						<thead>
							<tr style="height:30px;">
								<th class="bdr-dash-r ct">번호</th>
								<th class="bdr-dash-r ct">구분</th>
								<th class="bdr-dash-r ct">적용포인트</th>
								<th class="bdr-dash-r ct">회원이름</th>
								<th class="bdr-dash-r ct">해당선박</th>
								<th class="bdr-dash-r ct">출조일자</th>
								<th class="bdr-dash-r ct">처리일자</th>
								<th class="bdr-dash-r ct">내용</th>
								<th class="ct">취소</th>
							</tr>
						</thead>
						<tbody>
<%
		rso()
		SQL = " SELECT TOP "& pgsize &" * FROM _opntt020 "& param _
			& " AND ddate NOT IN (SELECT TOP "& ((page-1) * pgsize) &" ddate FROM _opntt020 "& param _
			& " ORDER BY ddate DESC) ORDER BY ddate DESC "
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
							<tr height=30>
								<td class="ct"><%=j%></td>
								<td class="ct f15"><b class="fcr"><%=rs("op")%></b></td>
								<td class="ct"><a href="#" onClick="return mpop5('point_w.asp?idx=<%=rs("idx")%>&gubn=ship','ev','center',480,350,0);"><%=FormatNumber(rs("point"),0)%></a></td>
								<td class="ct"><a href="#" onClick="return mpop5('point_w.asp?idx=<%=rs("idx")%>&gubn=ship','ev','center',480,350,0);"><%=meminfo(rs("uno"),"uname")%></a></td>
								<td class="ct"><a href="#" onClick="return mpop5('point_w.asp?idx=<%=rs("idx")%>&gubn=ship','ev','center',480,350,0);"><%=shipinfo(rs("shipid"),"shipnm")%></a></td>
								<td class="ct">
									<a href="#" onClick="return mpop5('point_w.asp?idx=<%=rs("idx")%>&gubn=ship','ev','center',480,350,0);"><%=setd(rsvinfo3(rs("rsvid"),"rdate"))%></a>
								</td>
								<td class="ct"><%=Left(rs("ddate"),10)%></td>
								<td>&nbsp;&nbsp;&nbsp;
									<a href="#" onClick="return mpop5('point_w.asp?idx=<%=rs("idx")%>&gubn=ship','ev','center',480,350,0);"><%=rs("note")%></a>
								</td>
								<td class="ct"><input type="checkbox" name="cbox" value="<%=rs("idx")%>" onClick="goDelete(<%=rs("idx")%>)"></td>
							</tr>
<%
					rs.MoveNext
					i = i + 1
					j = j - 1
			Loop
		Else
%>
							<tr height="100">
								<td class="ct vm" colspan="10">등록된 포인트가 없습니다.</td>
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
					<!-- <a href="news_w.asp" class="btn btn25"><span>글쓰기</span></a> -->
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
