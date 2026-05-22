<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	Call checkLevel(FID_AUTH, 100, Request.ServerVariables("PATH_INFO"))

	cd1							= SQLI(Request("cd1"))				'검색조건
	cd2							= SQLI(Request("cd2"))				'검색단어
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))
	setsize						= 10								'보여지는 페이지 수
	pgsize						= 15								'보여지는 게시물 수
	tag							= 6
'	Response.Write "<font color=#ffffff>FID_ID : "& FID_ID &"</font><br>"

	If cd1 = "" Then cd1 = "rnm"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If
	stpage						= Int((page - 1) * pgsize)			'각 페이지에 맞게 잘라올 시작값

	Set cx = New BsfCode

	If cd2 <> "" Then
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' AND uno = "& FID_NO &" AND status <> 'A'"
	Else
		param = " WHERE uno = "& FID_NO &" AND status <> 'A'"
	End If

	rso()
	SQL = " SELECT	COUNT(*) FROM _oalbt010 "& param
	rs.open SQL, dbcon, 3
		recordcount = CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
%>

<script language="JavaScript">
<!--
function goSearch() {
	var f = document.fm1;
	f.action = "order.asp";
	f.method = "post";
	f.submit();
}
function writeKeyDown() {
	if (event.keyCode == 13)	goSearch();
}
function goDelete(vidx) {
	var f = document.fm1;
	if (confirm("취소 하시겠습니까?       ")) {
		f.idx.value = vidx;
		f.flag.value = "D";
		f.action = "order_x.asp";
		f.method = "post";
//		f.target = "nullframe";
		f.submit();
	}
}
//-->
</script>

<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td>
			<table width="1100" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="250" valign="top"><!-- #include virtual = "/inc/left/my.asp" --></td>
					<td width="710" valign="top">
						<table width="710" border="0" cellspacing="0" cellpadding="0">

<form name="fm1" method="post">
<input type="hidden" name="idx">
<input type="hidden" name="flag">

							<tr>
								<td height="21"></td>
							</tr>
							<tr>
								<td><img src="/img/my_order.gif" width="180" height="18" alt="액자신청내역" title="액자신청내역"></td>
							</tr>
							<tr>
								<td height="20"></td>
							</tr>
							<tr>
								<td>
									<div class="gbox01">
									<dl>
										* 회원님의 액자(사진) 신청 내역을 확인할 수 있습니다.
									</dl>
									</div>
								</td>
							</tr>
							<tr>
								<td height="20"></td>
							</tr>
							<tr>
								<td></td>
							</tr>
							<tr>
								<td height="8"></td>
							</tr>
							<tr>
								<td><img src="/img/bbs_line01.gif" width="710" height="1"></td>
							</tr>
							<tr>
								<td height="30">
									<table width="710" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<th width="60" class="fc3 ct">순번</th>
											<th width="100" class="fc3 ct">선택사진</th>
											<th width="100" class="fc3 ct">사진위치</th>
											<th width="100" class="fc3 ct">상태</th>
											<th width="100" class="fc3 ct">등록일자</th>
											<th class="fc3 ct">신청일자</th>
											<th width="60" class="fc3 ct">취소</th>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td><img src="/img/bbs_line01.gif" width="710" height="1"></td>
							</tr>
							<tr>
								<td>
									<table width="710" border="0" cellspacing="0" cellpadding="0">
<%
		rso()
		SQL = " SELECT	TOP 15 * FROM _oalbt010 "& param _
			& " AND seq NOT IN (SELECT TOP "& ((page-1) * 15) &" seq FROM _oalbt010 "& param _
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
				Select Case rs("status")
					Case "C"			: stat = "인화신청"
					Case "E"			: stat = "액자신청"
					Case "Z"			: stat = "완료"
				End Select
				Select Case rs("op")
					Case "gallery"		: op = "조황갤러리"
					Case "ps"			: op = "조황후기"
				End Select
%>
										<tr height="31">
											<td width="60" class="ct"><%=j%></td>
											<td width="100" class="ct"><img src="<%=photoInfo(rs("photo"),rs("op"))%>" width="60"></td>
											<td width="100" class="ct ls ff"><%=op%></td>
											<td width="100" class="ct ls ff"><%=stat%></td>
											<td width="100" class="ct lf ls ff"><%=rs("wdate")%></td>
											<td class="ct lf ls ff"><%=rs("ddate")%></td>
											<td width="60" class="ct"><input type="checkbox" name="cbox" value="<%=rs("idx")%>" onClick="goDelete(<%=rs("idx")%>)"></td>
										</tr>
										<tr>
											<td height="1" bgcolor="d8d8d8" colspan="10"></td>
										</tr>
<%
				rs.MoveNext
				i = i + 1
				j = j - 1
			Loop
		Else
%>
										<tr height="200">
											<td class="ct" colspan="10">등록된 액자 신청 내역이 없습니다.</td>
										</tr>
<%
		End If
		rsc()
%>
									</table>
								</td>
							</tr>
							<tr>
								<td><img src="/img/bbs_line02.gif" width="710" height="5"></td>
							</tr>
							<tr>
								<td class="ct">
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
								</td>
							</tr>
							<tr>
								<td class="rg">
<%		If FID_AUTH <> "" Then %>
									<a href="order.asp" class="btn btn25"><span>새로고침</span></a>
<%		End If %>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
</form>
						</table>
					</td>
					<td width="140" valign="top"><!-- #include virtual = "/inc/quick.asp" --></td>
				</tr>
			</table>

		</td>
	</tr>
</table>
<!-- #include virtual = "/inc/footer.asp" -->