<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	shipid						= SQLI(Request("shipid"))
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	page						= SQLI(Request("page"))
	op							= SQLI(Request("op"))
	setsize						= 10							'보여지는 페이지 수
	pgsize						= 15							'보여지는 게시물 수

	If cd1 = "" Then cd1 = "title"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If

	stpage						= Int((page - 1) * pgsize)		'각 페이지에 맞게 잘라올 시작값

	Set cx = New BsfCode

	If cd2 <> "" Then
		If cd1 = "shipnm" Then		'선박검색
			param = " WHERE shipid IN (SELECT shipid FROM _oshpt010 WHERE shipnm LIKE '%"& cd2 &"%') "
		Else
			param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' "
		End If
	Else
		param = " WHERE 1=1 "
	End If

	If shipid <> "" Then
		param = param &" AND shipid = "& shipid
	End If

	rso()
	SQL = " SELECT COUNT(*) FROM _ogalt020 "& param
	rs.open SQL, dbcon, 3
		recordcount = CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
%>

<script type="text/javascript">
<!--
$(document).ready(function(){
	$("#cd2").keypress(function(event){
		if(event.which == 13){
			goSearch();
		}
	});
});

function goSearch(){
	var f = document.fm1;
	f.page.value = 1;
	f.action = "gallery3.asp";
	f.method = "post";
	f.submit();
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
				<div id="poptitle2">

<form name="fm1">
<input type="hidden" name="page" value="<%=page%>">

					<p class="lf">
						<span class="tt2">갤러리 관리 :: <%=shipid%></span>
						<span class="ib fright">
							<select name="cd1" style="width:100px;">
								<option value=""<%If cd1 = "" Then%> selected<%End If%>>선택</option>
								<option value="shipnm"<%If cd1 = "shipnm" Then%> selected<%End If%>>해당선박</option>
								<option value="title"<%If cd1 = "title" Then%> selected<%End If%>>제목</option>
							</select>
							<input type="text" name="cd2" id="cd2" style="width:100px;" />
							<a href="javascript:goSearch();" class="btn btn25"><span>검색</span></a>
							<select name="shipid" id="shipid" class="vm" style="width:150px;" onChange="location='?shipid='+ this.options[this.selectedIndex].value +''">
								<option value=""<%If shipid = "" Then%> selected<%End If%>>전체</option>
<%
	rso()
	SQL = " SELECT shipid, shipnm FROM _oshpt010 "
	rs.open SQL, dbcon
	While Not rs.eof
%>
								<option value="<%=rs("shipid")%>"<%If shipid = Trim(rs("shipid")) Then%> selected<%End If%>><%=rs("shipnm")%> [<%=rs("shipid")%>]</option>
<%
		rs.MoveNext
	Wend
	rsc()
%>
							</select>
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
							<col style="width:70px;" /><!-- 사진수 -->
							<col style="width:70px;" /><!-- 조회수 -->
						</colgroup>
						<thead>
							<tr>
								<th class="bdr-dash-r ct">번호</th>
								<th class="bdr-dash-r ct">해당선박</th>
								<th class="bdr-dash-r ct">제목</th>
								<th class="bdr-dash-r ct">촬영일자</th>
								<th class="bdr-dash-r ct">작성일</th>
								<th class="bdr-dash-r ct">사진수</th>
								<th class="ct">조회수</th>
							</tr>
						</thead>
						<tbody>
<%
		rso()
		SQL = " SELECT TOP "& pgsize &" * FROM _ogalt020 "& param _
			& " AND wdate NOT IN (SELECT TOP "& ((page-1) * pgsize) &" wdate FROM _ogalt020 "& param _
			& " ORDER BY wdate DESC) ORDER BY wdate DESC "
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
				SQL = " SELECT ISNULL(COUNT(*),0) FROM _ogalt021 WHERE seq = "& rs("seq")
				rs3.open SQL, dbcon
					pcnt = rs3(0)
				rs3.close
				Set rs3 = Nothing
%>
							<tr height="32">
								<td align="center" bgcolor="#f1f1f1" class="fc2 ff ls"><%=j%></td>
								<td align="center" bgcolor="#f1f1f1" class="fc2">
									<a href="gallery_ww.asp?seq=<%=rs("seq")%>&sdate=<%=rs("wdate")%>&cd1=<%=cd1%>&cd2=<%=cd2%>&page=<%=page%>">[<%=rs("shipid")%>]<%=shipInfo(rs("shipid"),"shipnm")%></a>
								</td>
								<td bgcolor="#f1f1f1" class="fc2 lf">&nbsp;
									<a href="gallery_ww.asp?seq=<%=rs("seq")%>&sdate=<%=rs("wdate")%>&cd1=<%=cd1%>&cd2=<%=cd2%>&page=<%=page%>"><%=rs("title")%></a></td>
								<td align="center" bgcolor="#f1f1f1" class="fc2 ff ls"><%=rs("wdate")%></td>
								<td align="center" bgcolor="#f1f1f1" class="fc2 ff ls"><%=Left(rs("ddate"),10)%></td>
								<td align="center" bgcolor="#f1f1f1" class="fc2 ff ls"><%=pcnt%></td>
								<td align="center" bgcolor="#f1f1f1" class="fc2 ff ls"><%=rs("cnt")%></td>
							</tr>
<%
					rs.MoveNext
					i = i + 1
					j = j - 1
			Loop
		Else
%>
							<tr height="100">
								<td class="ct vm" colspan="10">등록된 사진이 없습니다.</td>
							</tr>
<%
		End If
		rsc()
%>
						</tbody>
					</table>
					<!-- 리스트 끝 -->
				</div>

				<div class="pt10 ct">
<%
		blockpage = Int((page-1)/10)*10+1
		If blockpage = 1 Then %>
<%		Else %>
					<a href="?page=1&cd1=<%=cd1%>&cd2=<%=cd2%>&shipid=<%=shipid%>" class="btn btn18"><span>처음으로</span></a>
					<a href="?page=<%=blockpage-1%>&cd1=<%=cd1%>&cd2=<%=cd2%>&shipid=<%=shipid%>" class="btn btn18"><span>이전</span></a>&nbsp;&nbsp;
<%		End If
		i = 0
		Do Until i = 10 Or (blockpage+i) > totalpage
			If Int(page) = blockpage+i Then
%>
					<a href="?page=<%=blockpage+i%>&cd1=<%=cd1%>&cd2=<%=cd2%>&shipid=<%=shipid%>" class="ff fb vm ls"><%=setP(blockpage+i)%></a>&nbsp;&nbsp;
<%			Else %>
					<a href="?page=<%=blockpage+i%>&cd1=<%=cd1%>&cd2=<%=cd2%>&shipid=<%=shipid%>" class="ff vm ls"><%=setP(blockpage+i)%></a>&nbsp;&nbsp;
<%			End If
			i = i + 1
		Loop
		If (blockpage+i-1) = totalpage Then %>
<%		Else %>
					&nbsp;&nbsp;<a href="?page=<%=blockpage+10%>&cd1=<%=cd1%>&cd2=<%=cd2%>&shipid=<%=shipid%>" class="btn btn18"><span>다음</span></a>
					<a href="?page=<%=totalpage%>&cd1=<%=cd1%>&cd2=<%=cd2%>&shipid=<%=shipid%>" class="btn btn18"><span>끝으로</span></a>
<%		End If %>
				</div>
				<div id="btnarea1">
					<a href="gallery_ww.asp?shipid=<%=shipid%>" class="btn btn25"><span>사진등록</span></a>
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

