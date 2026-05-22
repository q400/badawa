<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	bbs_id						= 20								'10-공지/20-메모/50-요리/60-초보자/70-노하우/80-매니아/90-카풀/100-중고/110-레시피/120-잡다한소식/130-상품소개
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	page						= SQLI(Request("page"))
	op							= SQLI(Request("op"))
	setsize						= 10								'보여지는 페이지 수
	pgsize						= 15								'보여지는 게시물 수

	If cd1 = "" Then cd1 = "title"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If
	stpage						= Int((page - 1) * pgsize)			'각 페이지에 맞게 잘라올 시작값

	pagesize = 20
	Set cx = New BsfCode

	If cd2 <> "" Then
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' "
	Else
		param = " WHERE 1 = 1 "
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
function goSearch(){
	var f = document.fm1;
	f.page.value = 1;
	f.action = "gallery.asp";
	f.method = "post";
	f.submit();
}
function writeKeyDown(){
	if(event.keyCode == 13)	goSearch();
}
//-->
</script>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="68" align="center" valign="top"><!-- #include virtual = "/_adm/inc/top.asp" --></td>
	</tr>
	<tr>
		<td height="11"></td>
	</tr>
	<tr>
		<td align="center" valign="top">
			<table width="1040" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="176" valign="top"><!-- #include virtual = "/_adm/inc/left.asp" --></td>
					<td width="10"></td>
					<td width="854" valign="top">
						<table width="854" border="0" cellspacing="0" cellpadding="0">

<form name="fm1">
<input type="hidden" name="page" value="<%=page%>">

							<tr>
								<td>
									<table width="854" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td><img src="/img/adm/box01.gif" width="854" height="14"></td>
										</tr>
<!--
										<tr>
											<td align="center" background="/img/adm/box03.gif">&nbsp;</td>
										</tr>
										<tr>
											<td height="10" background="/img/adm/box03.gif"></td>
										</tr> -->
										<tr>
											<td align="center" background="/img/adm/box03.gif">
												<table width="790" border="0" cellspacing="0" cellpadding="0" class="lf">
													<tr height="46">
														<td width="200" class="fc2 fb">긴급한줄메모</td>
														<td align="right">
															<table border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="10"></td>
																	<td width="90" height="46"></td>
																	<td width="10"></td>
																	<td width="100"><input type="text" name="cd2" class="bx1" style="width:100px;ime-mode:active;" align="absmiddle" /></td>
																	<td width="10"></td>
																	<td width="46"><a href="javascript:goSearch()" class="btn btn21"><span>검색</span></a></td>
																	<td>&nbsp;</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td height="2" align="center" background="/img/adm/box03.gif">
												<table width="790" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="2" bgcolor="666666"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td align="center" background="/img/adm/box03.gif">
												<table width="790" border="1" cellspacing="0" cellpadding="0" align="center" bordercolor="#CCCCCC" style="border-collapse:collapse;">
													<tr>
														<td align="center">

															<!-- 회원리스트 시작 -->
															<table width="788" border="0" cellspacing="0" cellpadding="0">
																<tr height="32">
																	<td width="60" align="center" bgcolor="f1f1f1" class="fc2 fb">번호</td>
																	<td width="80" align="center" bgcolor="f1f1f1" class="fc2 fb">해당선박</td>
																	<td align="center" bgcolor="f1f1f1" class="fc2 fb">제 목</td>
																	<td width="90" align="center" bgcolor="f1f1f1" class="fc2 fb">촬영일자</td>
																	<td width="110" align="center" bgcolor="f1f1f1" class="fc2 fb">작성일</td>
																	<td width="60" align="center" bgcolor="f1f1f1" class="fc2 fb">사진수</td>
																	<td width="80" align="center" bgcolor="f1f1f1" class="fc2 fb">조회수</td>
																</tr>
																<tr>
																	<td height="1" bgcolor="#b0b0b0" colspan="10"></td>
																</tr>
																<tr>
																	<td height="1" bgcolor="#fafafa" colspan="10"></td>
																</tr>
<%
		rso()
		SQL = " SELECT	TOP 15 * FROM _obbst010 "& param _
			& " AND seq NOT IN (SELECT TOP "& ((page-1) * 15) &" seq FROM _obbst010 "& param _
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
																<tr height="32">
																	<td align="center" bgcolor="f1f1f1" class="fc2"><%=j%></td>
																	<td align="center" bgcolor="f1f1f1" class="fc2">
																		<a href="gallery_w.asp?seq=<%=rs("seq")%>&sdate=<%=rs("wdate")%>&cd1=<%=cd1%>&cd2=<%=cd2%>&page=<%=page%>"><%=shipInfo(rs("shipid"),"shipnm")%></a>
																	</td>
																	<td bgcolor="f1f1f1" class="fc2 lf">&nbsp;
																		<a href="gallery_w.asp?seq=<%=rs("seq")%>&sdate=<%=rs("wdate")%>&cd1=<%=cd1%>&cd2=<%=cd2%>&page=<%=page%>"><%=rs("title")%></a></td>
																	<td align="center" bgcolor="f1f1f1" class="fc2"><%=rs("wdate")%></td>
																	<td align="center" bgcolor="f1f1f1" class="fc2"><%=Left(rs("ddate"),10)%></td>
																	<td align="center" bgcolor="f1f1f1" class="fc2"><%=pcnt%></td>
																	<td align="center" bgcolor="f1f1f1" class="fc2"><%=rs("cnt")%></td>
																</tr>
<%
					rs.MoveNext
					i = i + 1
					j = j - 1
			Loop
		Else
%>
																<tr height="100">
																	<td align="center" valign="middle" colspan="10">등록된 사진이 없습니다.</td>
																</tr>
<%
		End If
		rsc()
%>
															</table>
															<!-- 회원리스트 끝 -->

														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td height="10" background="/img/adm/box03.gif"></td>
										</tr>
										<tr>
											<td align="center" background="/img/adm/box03.gif">
												<!-- 페이지처리 -->
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td align="center">
<%	blockpage = Int((page-1)/10)*10 + 1
	If blockpage <> 1 Then %>
			<input type="button" value="처음" class="p0 ff f11" onclick="location='?page=1&cd1=<%=cd1%>&cd2=<%=cd2%>&gubn=<%=gubn%>'">
			<input type="button" value="이전" class="p0 ff f11" onclick="location='?page=<%=blockpage-1%>&cd1=<%=cd1%>&cd2=<%=cd2%>&gubn=<%=gubn%>'">&nbsp;
<%	End If
	i = 0
	Do Until i = 10 Or (blockpage + i) > totalpage
		If Int(page) = blockpage + i Then %>
			<input type="button" value="<%=setP(blockpage + i)%>" class="p1 ff fb f10" onclick="location='?page=<%=blockpage + i%>&cd1=<%=cd1%>&cd2=<%=cd2%>&gubn=<%=gubn%>'">
<%		Else %>
			<input type="button" value="<%=setP(blockpage + i)%>" class="p0 ff f10" onclick="location='?page=<%=blockpage + i%>&cd1=<%=cd1%>&cd2=<%=cd2%>&gubn=<%=gubn%>'">
<%		End If
		i = i + 1
	Loop
	If (blockpage + i - 1) <> totalpage Then %>
			<input type="button" value="다음" class="p0 ff f11" onclick="location='?page=<%=blockpage+10%>&cd1=<%=cd1%>&cd2=<%=cd2%>&gubn=<%=gubn%>'">
			<input type="button" value=" 끝 " class="p0 ff f11" onclick="location='?page=<%=totalpage%>&cd1=<%=cd1%>&cd2=<%=cd2%>&gubn=<%=gubn%>'">
<%	End If %>
														</td>
													</tr>
												</table>
												<!-- 버튼 끝 -->

											</td>
										</tr>
										<tr>
											<td background="/img/adm/box03.gif">&nbsp;</td>
										</tr>
										<tr>
											<td align="center" background="/img/adm/box03.gif">
												<a href="gallery_w.asp" class="btn btn25"><span>사진등록</span></a>
											</td>
										</tr>
										<tr>
											<td height="10" background="/img/adm/box03.gif"></td>
										</tr>
										<tr>
											<td><img src="/img/adm/box02.gif" width="854" height="14"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
</form>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<!-- #include virtual = "/_adm/inc/footer.asp" -->