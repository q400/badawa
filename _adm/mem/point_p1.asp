<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	uno							= SQLI(Request("uno"))				'회원번호
	cd1							= SQLI(Request("cd1"))				'검색조건
	cd2							= SQLI(Request("cd2"))				'검색단어
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))
	setsize						= 10								'보여지는 페이지 수
	pgsize						= 10								'보여지는 게시물 수

	If cd1 = "" Then cd1 = "note"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If

	If cd2 <> "" Then
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' AND uno = "& uno
	Else
		param = " WHERE uno = "& uno
	End If

	'쉽 포인트
	rso()
	SQL = " SELECT COUNT(*) FROM _opntt020 "& param
	rs.open SQL, dbcon, 3
		recordcount = CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
%>

<script language="JavaScript">
<!--
function goSearch(){
	var f = document.fm1;
	f.page.value = 1;
	f.action = "point_p1.asp";
	f.method = "post";
	f.submit();
}
function writeKeyDown(){
	if(event.keyCode == 13)	goSearch();
}
function goDelete(vidx){
	var f = document.fm1;
	if(confirm("완전히 삭제하시겠습니까?")){
		f.idx.value = vidx;
		f.flag.value = "D01";
		f.action = "point_x.asp";
		f.method = "post";
		f.submit();
	}
}
//-->
</script>


<form name="fm1" method="post">
<input type="hidden" name="uno" value="<%=uno%>">
<input type="hidden" name="page">
<input type="hidden" name="flag">
<div id="wrap">
	<div id="mwrap2">
		<div id="poptitle2">
			<div>
				<font class="fc8">※ <b class="fce"><%=meminfo(uno,"uname")%></b> 님의 쉽포인트 정보는 전체 <b class="fcr"><%=recordcount%></b> 건 입니다.</font>
			</div>
			<div class="rg">
				<select name="cd1" id="search" class="bx1" style="width:60px;">
				<option value=""<%If cd1 = "" Then%> selected<%End If%>>선택</option>
				<option value="point"<%If cd1 = "point" Then%> selected<%End If%>>금액</option>
				<option value="note"<%If cd1 = "note" Then%> selected<%End If%>>내용</option>
				</select>
				<input type="text" name="cd2" style="width:100px;" />
				<a href="javascript:goSearch()" class="btn btn25"><span>검색</span></a>
			</div>
			<div style="border-bottom:1px solid #999;">
				<a href="point_p1.asp?uno=<%=uno%>"><img src="/img/box/ship_on.gif" title="쉽포인트" /></a><a href="point_p2.asp?uno=<%=uno%>"><img src="/img/box/talk_off.gif" title="톡포인트" /></a>
			</div>
			<table width=700 id="list1">
				<colgroup>
					<col style="width:60px;" />
					<col style="width:80px;" />
					<col style="width:100px;" />
					<col style="width:100px;" />
					<col style="width:80px;" />
					<col width="*" />
				</colgroup>
				<thead>
					<tr>
						<td class="bdr-ds1 ct">번호</td>
						<td class="bdr-ds1 ct">구분</td>
						<td class="bdr-ds1 ct">적립포인트</td>
						<td class="bdr-ds1 ct">해당선박</td>
						<td class="bdr-ds1 ct">처리일자</td>
						<td class="ct">사유</td>
					</tr>
				</thead>
				<tbody>
<%
		rso()
		SQL = " SELECT TOP "& pgsize &" * FROM _opntt020 "& param _
			& " AND idx NOT IN (SELECT TOP "& ((page-1) * pgsize) &" idx FROM _opntt020 "& param _
			& " ORDER BY idx DESC) ORDER BY idx DESC "
		rs.open SQL, dbcon, 0, 3

		j = recordcount

		If Not (rs.eof And rs.bof) Then
			If page <> 1 Then
				j = j - (page - 1) * pgsize
			End If

			i = 1
			rs.MoveFirst
			Do Until rs.EOF
%>
					<tr>
						<td class="ff ct"><%=j%></td>
						<td class="f15 ct"><b><%=rs("op")%></b></td>
						<td class="ff ct"><%=FormatNumber(rs("point"),0)%></td>
						<td class="ct"><%=shipinfo(rs("shipid"),"shipnm")%></td>
						<td class="ff ct lf ls"><%=Left(rs("ddate"),10)%></td>
						<td class="ct lf ls"><%=rs("note")%></td>
					</tr>
<%
				rs.MoveNext
				i = i + 1
				j = j - 1
			Loop
		Else
%>
					<tr height="200">
						<td class="ct" colspan="10">포인트 적립/차감 정보가 없습니다.</td>
					</tr>
<%
		End If
		rsc()
%>
				</tbody>
			</table>

			<div class="pt10 ct">
<%
		blockpage = Int((page-1)/10)*10 + 1
		If blockpage = 1 Then %>
<%		Else %>
<a href="?page=1&cd1=<%=cd1%>&cd2=<%=cd2%>&uno=<%=uno%>" class="btn btn21"><span>처음으로</span></a>
<a href="?page=<%=blockpage-1%>&cd1=<%=cd1%>&cd2=<%=cd2%>&uno=<%=uno%>" class="btn btn21"><span>이전</span></a>
<%		End If
		i = 0
		Do Until i = 10 Or (blockpage + i) > totalpage
			If Int(page) = blockpage + i Then %>
<a href="?page=<%=blockpage + i%>&cd1=<%=cd1%>&cd2=<%=cd2%>&uno=<%=uno%>" class="ff fb ls"><%=setP(blockpage + i)%></a>&nbsp;
<%			Else %>
<a href="?page=<%=blockpage + i%>&cd1=<%=cd1%>&cd2=<%=cd2%>&uno=<%=uno%>" class="ff ls"><%=setP(blockpage + i)%></a>&nbsp;
<%			End If
			i = i + 1
		Loop
		If (blockpage + i - 1) = totalpage Then %>
<%		Else %>
<a href="?page=<%=blockpage+10%>&cd1=<%=cd1%>&cd2=<%=cd2%>&uno=<%=uno%>" class="btn btn21"><span>다음</span></a>
<a href="?page=<%=totalpage%>&cd1=<%=cd1%>&cd2=<%=cd2%>&uno=<%=uno%>" class="btn btn21"><span>끝으로</span></a>
<%		End If %>
			</div>
			<div id="btnarea1">
				<span class="ff">가용포인트 : <b><%=FormatNumber(chkPoint(uno,"ship"),0)%></b> 점</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="point_p1.asp?uno=<%=uno%>" class="btn btn25"><span>새로고침</span></a>
			</div>
		</div>
		<!-- poptitle2 E -->
	</div>
</div>
</form>
<%	dbc() %>
