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
'	Response.Write "<font color=#ffffff>FID_ID : "& FID_ID &"</font><br>"

	If cd1 = "" Then cd1 = "rname"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If

	stpage						= Int((page - 1) * pgsize)		'각 페이지에 맞게 잘라올 시작값

	If cd2 <> "" Then
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' AND uno = "& FID_NO
	Else
		param = " WHERE uno = "& FID_NO
	End If

	rso()
	SQL = " SELECT	ISNULL(COUNT(*),0) FROM _omemt020 "& param
	rs.open SQL, dbcon
		recordcount = CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
%>

<script language="JavaScript">
<!--
function goSearch() {
	unoRequest("fm1", "friendList.asp", "_top");
}
function writeKeyDown() {
	if (event.keyCode == 13)	goSearch();
}
function personSelect(pArr) {
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


<div id="wrap">
	<div style="width:620px;" class="pl20">
		<ul>
			<li style="width:200px;" class="ib mt20 mb20"><b class="f17">일행관리</b></li>
			<li style="width:400px;" class="ib">

				<!-- 게시물 검색 시작 -->
<form name="fm1" id="fm1" method="post">
<input type="hidden" name="cd1" value="rname">

				<div class="fright vm">
					<input type="text" name="cd2" id="cd2" maxlength="10" onKeyDown="writeKeyDown()" style="width:120px; ime-mode:active;">
					<a href="javascript:goSearch()" class="btn btn25"><span>검색</span></a>
				</div>
</form>
				<!-- 게시물 검색 끝 -->
			</li>

			<div style="width:600px; border:1px solid #28abd1;" class="pt5 pb5 vm">
				<ul>
					<li style="width:40px;" class="fc3 ct vm ib">번호</li>
					<li style="width:70px;" class="fc3 ct vm ib">일행이름</li>
					<li style="width:90px;" class="fc3 ct vm ib">연락처</li>
					<li style="width:320px;" class="fc3 ct vm ib">주소지</li>
					<li style="width:60px;" class="fc3 ct vm ib">관계</li>
				</ul>
			</div>
			<div style="width:600px;">
<%
		rso()
		SQL = " SELECT	TOP 15 * FROM _omemt020 "& param _
			& " AND seq NOT IN (SELECT TOP "& ((page-1) * 15) &" seq FROM _omemt020 "& param _
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
%>
				<ul class="pt5 pb5 vm">
					<li style="width:40px;" class="ct ib"><%=j%></li>
					<li style="width:70px;" class="ct ib">
						<a href="javascript:;" onClick="personSelect('<%=rs("rname") &"-"& rs("hp") &"-"& rs("addr1") &" "& rs("addr2") &"-"& rs("rel")%>')"><b><%=rs("rname")%></b></a>
					</li>
					<li style="width:90px;" class="ct ib">
						<a href="javascript:;" onClick="personSelect('<%=rs("rname") &"-"& rs("hp") &"-"& rs("addr1") &" "& rs("addr2") &"-"& rs("rel")%>')"><%=rs("hp")%></a>
					</li>
					<li style="width:320px;" class="lf ls ib">
						&nbsp;&nbsp;<a href="javascript:;" onClick="personSelect('<%=rs("rname") &"-"& rs("hp") &"-"& rs("addr1") &" "& rs("addr2") &"-"& rs("rel")%>')"><%=trimtext(rs("addr1"),30)%></a>
					</li>
					<li style="width:60px;" class="ct ib">
						<a href="javascript:;" onClick="personSelect('<%=rs("rname") &"-"& rs("hp") &"-"& rs("addr1") &" "& rs("addr2") &"-"& rs("rel")%>')"><%=rs("rel")%></a>
					</li>
				</ul>
				<hr style="width:600px; border:1px dotted #ccc;">
<%
				rs.MoveNext
				i = i + 1
				j = j - 1
			Loop
		Else
%>
				<ul>
					<li style="width:600px; height:200px;" class="ct">등록된 일행이 없습니다.</li>
				</ul>
<%
		End If
		rsc()
%>
			</div>
		</ul>
	</div>
	<div class="mt10 mb20">
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
			If Int(page) = blockpage + i Then
%>
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
	<div class="mb30">
		<center>
<%		If FID_AUTH <> "" Then %>
		<a href="/my/friend.asp" target="_blank" class="btnp btn25"><span>일행등록</span></a>
<%		End If %>
		<a href="javascript:;" onClick="window.close();" class="btn btn25"><span>닫기</span></a>
		</center>
	</div>
</div>
<%	dbc() %>
