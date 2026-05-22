<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	bbs_id						= 20								'10-공지/20-메모/50-요리/60-초보자/70-노하우/80-매니아/90-카풀/100-중고/110-레시피/120-잡다한소식/130-상품소개
	cd1							= SQLI(Request("cd1"))				'검색조건
	cd2							= SQLI(Request("cd2"))				'검색단어
	page						= SQLI(Request("page"))
	cate						= SQLI(Request("cate"))
	flag						= SQLI(Request("flag"))
	setsize						= 10								'보여지는 페이지 수
	pgsize						= 15								'보여지는 게시물 수
	tag							= 4

	If cd1 = "" Then cd1 = "title"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If
	stpage						= Int((page - 1) * pgsize)		'각 페이지에 맞게 잘라올 시작값

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
%>

<script language="JavaScript">
<!--
function goSearch() {
	var f = document.fm1;
	f.action = "memo.asp";
	f.method = "post";
	f.submit();
}
function writeKeyDown() {
	if (event.keyCode == 13)	goSearch();
}
//-->
</script>

<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td bgcolor="#ffffff">
			<table width="1100" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="250" valign="top"><!-- #include virtual = "/inc/left/comu.asp" --></td>
					<td width="710" valign="top">
						<table width="710" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="21"></td>
							</tr>
							<tr>
								<td><img src="/img/commu_tle.gif" width="195" height="24"></td>
							</tr>
							<tr>
								<td height="15"></td>
							</tr>
							<tr>
								<td bgcolor="#ffffff"><img src="/img/comu_memo_tle.gif"></td>
							</tr>
							<tr>
								<td height="26" bgcolor="#ffffff"></td>
							</tr>
							<tr>
								<td class="rg" bgcolor="#ffffff">
									<!-- 게시물 검색 시작 -->
									<table border="0" cellspacing="0" cellpadding="0" align="right">
<form name="fm1" method="post">
										<tr>
											<td>&nbsp;</td>
											<td width="50">
												<select name="cd1" class="bx1" id="search" style="width:70px;">
												<option value=""<%If cd1 = "" Then%> selected<%End If%>>선택</option>
												<option value="uname"<%If cd1 = "uname" Then%> selected<%End If%>>작성자</option>
												<option value="title"<%If cd1 = "title" Then%> selected<%End If%>>글제목</option>
												</select>
											</td>
											<td width="5"></td>
											<td><input type="text" name="cd2" maxlength="10" class="bx1" onKeyDown="writeKeyDown()" style="width:120px; ime-mode:active;"></td>
											<td width="5"></td>
											<td><a href="javascript:goSearch()" class="btn btn21"><span>검색</span></a></td>
										</tr>
</form>
									</table>
									<!-- 게시물 검색 끝 -->
								</td>
							</tr>
							<tr>
								<td height="8" bgcolor="#ffffff"></td>
							</tr>
							<tr>
								<td bgcolor="#ffffff"><img src="/img/bbs_line01.gif" width="710" height="1"></td>
							</tr>
							<tr>
								<td height="30" bgcolor="#ffffff">
									<table width="710" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="80" class="ct"><img src="/img/b_t_no.gif" width="24" height="14"></td>
											<td class="ct"><img src="/img/b_t_subject.gif" width="24" height="14"></td>
											<td width="100" class="ct"><img src="/img/b_t_name.gif" width="34" height="14"></td>
											<td width="100" class="ct"><img src="/img/b_t_date.gif" width="34" height="14"></td>
											<td width="80" class="ct"><img src="/img/b_t_read.gif" width="24" height="14"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td bgcolor="#ffffff"><img src="/img/bbs_line01.gif" width="710" height="1"></td>
							</tr>
							<tr>
								<td bgcolor="#ffffff">
									<table width="710" border="0" cellspacing="0" cellpadding="0">
<%
		rso()
		SQL = " SELECT	TOP 15 * FROM _obbst010 "& param _
			& " AND seq NOT IN (SELECT TOP "& ((page-1) * 15) &" seq FROM _obbst010 "& param _
			& " ORDER BY seq DESC) ORDER BY seq DESC "
		rs.open SQL, dbcon, 0, 3

		rs.pagesize = 15
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
					pcnt = CInt(rs3(0))
				rs3.close
				Set rs3 = Nothing
%>
										<tr height="31">
											<td width="80" class="ct"><%=j%></td>
											<td>
												<a href="memo_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>"><%=rs("contents")%></a>
											</td>
											<td width="100" class="ct"><%=meminfo(rs("uno"),"unamee")%></td>
											<td width="100" class="ct"><%=Left(rs("ddate"),10)%></td>
											<td width="80" class="ct"><%=rs("cnt")%></td>
										</tr>
										<tr>
											<td height="1" bgcolor="d8d8d8"></td>
											<td height="1" bgcolor="d8d8d8"></td>
											<td height="1" bgcolor="d8d8d8"></td>
											<td height="1" bgcolor="d8d8d8"></td>
											<td height="1" bgcolor="d8d8d8"></td>
										</tr>
<%
				rs.MoveNext
				i = i + 1
				j = j - 1
			Loop
		Else
%>
										<tr height="200">
											<td class="ct" colspan="10">내용이 없습니다.</td>
										</tr>
<%
		End If
		rsc()
%>
									</table>
								</td>
							</tr>
							<tr>
								<td bgcolor="#ffffff"><img src="/img/bbs_line02.gif" width="710" height="5"></td>
							</tr>
							<tr>
								<td class="ct" bgcolor="#ffffff">
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
								<td class="rg" bgcolor="#ffffff">
<%		If FID_AUTH <> "" Then %>
									<a href="#" onClick="return mpop5('memo_w.asp','ev','center',400,200,0);" class="btn btn25"><span>메모남기기</span></a>
<%		End If %>
								</td>
							</tr>
							<tr>
								<td bgcolor="#ffffff">&nbsp;</td>
							</tr>
							<tr>
								<td bgcolor="#ffffff">&nbsp;</td>
							</tr>
							<tr>
								<td bgcolor="#ffffff">&nbsp;</td>
							</tr>
						</table>
					</td>
					<td width="140" valign="top"><!-- #include virtual = "/inc/quick.asp" --></td>
				</tr>
			</table>

		</td>
	</tr>
</table>
<!-- #include virtual = "/inc/footer.asp" -->