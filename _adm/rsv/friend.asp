<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	If FID_NO = "" Then
		AlertClose("회원 로그인 후 선택 가능합니다.")
		Response.End
	End If

	cd1							= SQLI(Request("cd1"))				'검색조건
	cd2							= SQLI(Request("cd2"))				'검색단어
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))
	nn							= SQLI(Request("nn"))
	setsize						= 10								'보여지는 페이지 수
	pgsize						= 15								'보여지는 게시물 수

	If cd1 = "" Then cd1 = "rname"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If

	Set cx = New BsfCode

	If cd2 <> "" Then
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' AND uno = "& FID_NO
	Else
		param = " WHERE uno = "& FID_NO
	End If

	rso()
	SQL = " SELECT COUNT(*) FROM _omemt020 "& param
	rs.open SQL, dbcon
		recordcount = CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
%>

<script language="JavaScript">
<!--
function goSearch() {
	var f = document.fm1;
	f.action = "friend.asp";
	f.method = "post";
	f.submit();
}
function writeKeyDown() {
	if (event.keyCode == 13)	goSearch();
}
function manSelect(pArr) {
	var arrValue = pArr.split("-");
	opener.document.all.rname[<%=nn%>].value = arrValue[0];		//rname
	opener.document.all.hp[<%=nn%>].value = arrValue[1];		//hp
	opener.document.all.addr[<%=nn%>].value = arrValue[2];		//addr
//	opener.document.all.rel.value = arrValue[3];				//rel
	this.window.close();
//	parent.parent.document.all.showimage.style.visibility = "hidden";
//	parent.parent.document.all.overlay.style.visibility = "hidden";
}
//-->
</script>


<form name="fm1" method="post">
<input type="hidden" name="cd1" value="rname">
<input type="hidden" name="nn" value="<%=nn%>">
<div id="wrap">
	<div id="mwrap2">
		<div id="poptitle2">
			<span><p class="tt">일행관리</p></span>
			<!--
			<div class="gbox01">
				<dl>로그인 후 "선택"을 눌러 마이페이지의 "일행관리"에 등록된 정보를 가져 올 수 있습니다.</dl>
			</div>
			-->
			<table width=700 id="list1">
				<colgroup>
				<col style="width:500px;" />
				<col width="*" />
				</colgroup>
				<!-- 게시물 검색 시작 -->
				<tr>
					<td class="rg">
						<input type="text" name="cd2" id="cd2" maxlength="10" onKeyDown="writeKeyDown()" style="width:120px;">
						<a href="javascript:goSearch()" class="btn btn21"><span>검색</span></a>
					</td>
				</tr>
				<!-- 게시물 검색 끝 -->
			</table>
			<table width=700 id="list1">
				<colgroup>
				<col style="width:50px;" />
				<col style="width:100px;" />
				<col style="width:120px;" />
				<col width="*" />
				<col style="width:60px;" />
				</colgroup>
				<thead>
					<tr>
						<td class="bdr-ds1 ct">순번</td>
						<td class="bdr-ds1 ct">이름</td>
						<td class="bdr-ds1 ct">연락처</td>
						<td class="bdr-ds1 ct">주소지</td>
						<td class="ct">관계</td>
					</tr>
				</thead>
				<tbody>
<%
		rso()
		SQL = " SELECT TOP "& pgsize &" * FROM _omemt020 "& param _
			& " AND idx NOT IN (SELECT TOP "& ((page-1) * pgsize) &" idx FROM _omemt020 "& param _
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
				addr = ""
				addr = rs("addr1") &" "& rs("addr2")
%>
					<tr>
						<td class="ct"><%=j%></td>
						<td class="ct">
							<a href="javascript:manSelect('<%=rs("rname") &"-"& rs("hp") &"-"& rs("addr1") &" "& rs("addr2") &"-"& rs("rel")%>')"><b><%=rs("rname")%></b></a>
						</td>
						<td class="ct">
							<a href="javascript:manSelect('<%=rs("rname") &"-"& rs("hp") &"-"& rs("addr1") &" "& rs("addr2") &"-"& rs("rel")%>')"><%=rs("hp")%></a>
						</td>
						<td class="lf ls">&nbsp;&nbsp;&nbsp;
							<a href="javascript:manSelect('<%=rs("rname") &"-"& rs("hp") &"-"& rs("addr1") &" "& rs("addr2") &"-"& rs("rel")%>')"><%=trimtext(addr,25)%></a>
						</td>
						<td class="ct">
							<a href="javascript:manSelect('<%=rs("rname") &"-"& rs("hp") &"-"& rs("addr1") &" "& rs("addr2") &"-"& rs("rel")%>')"><%=rs("rel")%></a>
						</td>
					</tr>
<%
				rs.MoveNext
				i = i + 1
				j = j - 1
			Loop
		Else
%>
					<tr height="200">
						<td class="ct" colspan="10">등록된 일행이 없습니다.</td>
					</tr>
<%
		End If
		rsc()
%>
				</tbody>
			</table>
		</div>
		<div id="btnarea3">
			<center>
<%
		blockpage = Int((page-1)/10)*10 + 1
		If blockpage = 1 Then %>
<%		Else %>
<a href="?page=1&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn21"><span>처음으로</span></a>
<a href="?page=<%=blockpage-1%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn21"><span>이전</span></a>
<%		End If
		i = 0
		Do Until i = 10 Or (blockpage + i) > totalpage
			If Int(page) = blockpage + i Then %>
<a href="?page=<%=blockpage + i%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="ff fb ls"><%=setP(blockpage + i)%></a>&nbsp;
<%			Else %>
<a href="?page=<%=blockpage + i%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="ff ls"><%=setP(blockpage + i)%></a>&nbsp;
<%			End If
			i = i + 1
		Loop
		If (blockpage + i - 1) = totalpage Then %>
<%		Else %>
<a href="?page=<%=blockpage+10%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn21"><span>다음</span></a>
<a href="?page=<%=totalpage%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn21"><span>끝으로</span></a>
<%		End If %>
			</center>
		</div>
		<div id="btnarea1">
<%		If FID_AUTH <> "" Then %>
			<a href="/my/friend.asp" target="_blank" class="btn btn25"><span>일행등록</span></a>
<%		End If %>
			<a href="javascript:window.close();" class="btn btn25"><span>닫기</span></a>
		</div>
	</div>
</div>
</form>

<div id="upload" style="top:0; left:0; width:220px; height:50px; position:absolute; visibility:hidden; z-index:10;"><img src="/img/icon/loader05.gif"></div>

<%	Set cx = Nothing %>
<%	dbc() %>
