<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	page						= SQLI(Request("page"))

	setsize						= 10								'보여지는 페이지 수
	pgsize						= 15								'보여지는 게시물 수

	If cd1 = "" Then cd1 = "uno"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If
	stpage						= Int((page - 1) * pgsize)		'각 페이지에 맞게 잘라올 시작값

	pagesize = 20
	Set cx = New BsfCode

	If cd2 <> "" Then
		If cd1 = "uno" Then
			param = " WHERE uno IN (SELECT seq FROM _omemt010 WHERE uname LIKE '%"& cd2 &"%') AND status <> 'A' "
		Else
			param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' AND status <> 'A' "
		End If
	Else
		param = " WHERE status <> 'A' "
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
function goSearch(){
	var f = document.fm1;
	f.page.value = 1;
	f.action = "order.asp";
	f.method = "post";
	f.submit();
}
function writeKeyDown(){
	if(event.keyCode == 13)	goSearch();
}
function goOK(vidx){
	var f = document.fm1;
//	if(confirm("완료처리 하시겠습니까?       ")){
		f.idx.value = vidx;
		f.flag.value = "OK";
		f.action = "order_x.asp";
		f.method = "post";
		f.target = "nullframe";
		f.submit();
//	}
}
function goDelete(vidx){
	var f = document.fm1;
	if(confirm("취소 하시겠습니까?       ")){
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
<input type="hidden" name="idx">
<input type="hidden" name="flag">

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
														<td width="200" class="fc2 fb">사진 인화/액자 신청</td>
														<td class="rg">
															<select name="cd1" id="search" style="width:110px;">
															<option value=""<%If cd1 = "" Then%> selected<%End If%>>선택</option>
															<option value="uno"<%If cd1 = "uno" Then%> selected<%End If%>>신청자</option>
															<option value="wdate"<%If cd1 = "wdate" Then%> selected<%End If%>>사진등록일자</option>
															</select>
															<input type="text" name="cd2" value="<%=cd2%>" class="bx1" style="width:100px;ime-mode:active;" />
															<a href="javascript:goSearch()" class="btn btn21"><span>검색</span></a>
															<a href="/_adm/gall/order.asp" class="btn btn21"><span>새로고침</span></a>
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
																	<th width="60" bgcolor="#f1f1f1" class="fc2">번호</th>
																	<th width="70" bgcolor="#f1f1f1" class="fc2">선택사진</th>
																	<th width="90" bgcolor="#f1f1f1" class="fc2">사진위치</th>
																	<th width="80" bgcolor="#f1f1f1" class="fc2">신청자</th>
																	<th width="100" bgcolor="#f1f1f1" class="fc2">상태</th>
																	<th width="70" bgcolor="#f1f1f1" class="fc2">규격</th>
																	<th width="60" bgcolor="#f1f1f1" class="fc2">갯수</th>
																	<th width="90" bgcolor="#f1f1f1" class="fc2">등록일자</th>
																	<th bgcolor="#f1f1f1" class="fc2">신청/처리일자</th>
																	<th width="40" bgcolor="#f1f1f1" class="fc2">취소</th>
																	<th width="40" bgcolor="#f1f1f1" class="fc2">완료</th>
																</tr>
																<tr>
																	<td height="1" bgcolor="#b0b0b0" colspan="15"></td>
																</tr>
																<tr>
																	<td height="1" bgcolor="#fafafa" colspan="15"></td>
																</tr>
<%
		rso()
		SQL = " SELECT	* FROM _oalbt010 "& param &" ORDER BY xdate DESC LIMIT "& stpage &","& pgsize
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
				Select Case rs("status")
					Case "A"		: stat = "신청완료"
					Case "C"		: stat = "<b class=fc7>인화신청</b>"
					Case "E"		: stat = "<b class=fc8>액자신청</b>"
					Case "ZC"		: stat = "인화완료"
					Case "ZE"		: stat = "액자완료"
				End Select
				Select Case rs("op")
					Case "gallery"	: op = "조황갤러리"
					Case "ps"		: op = "조황후기"
				End Select
				Select Case rs("sz")
					Case "1"		: sz = "8×10"
					Case "2"		: sz = "11×14"
					Case Else		: sz = "기타"
				End Select
%>
																<tr height="32">
																	<td bgcolor="#f1f1f1" class="fc2 ct"><%=j%></td>
																	<td bgcolor="#f1f1f1" class="fc2 ct">
																		<a href="javascript:Popup('/inc/imgv_album.asp?idx=<%=rs("photo")%>&op=<%=rs("op")%>',820,770,100,50,1,1,1);">
																		<img src="<%=photoInfo(rs("photo"),rs("op"))%>" width="60"></a>
																	</td>
																	<td bgcolor="#f1f1f1" class="fc2 ct"><%=op%></td>
																	<td bgcolor="#f1f1f1" class="fc2 ct"><%=meminfo(rs("uno"),"uname")%></td>
																	<td bgcolor="#f1f1f1" class="fc2 ct"><%=stat%></td>
																	<td bgcolor="#f1f1f1" class="fc2 ct ff"><%=sz%></td>
																	<td bgcolor="#f1f1f1" class="fc2 ct ff"><%=rs("cnt")%></td>
																	<td bgcolor="#f1f1f1" class="fc2 ct ff"><%=rs("wdate")%></td>
																	<td bgcolor="#f1f1f1" class="fc2 ct ff"><%=Left(rs("xdate"),10)%></td>
																	<td bgcolor="#f1f1f1" class="fc2 ct"><input type="checkbox" name="cbox" value="<%=rs("idx")%>" onClick="goDelete(<%=rs("idx")%>)"></td>
																	<td bgcolor="#f1f1f1" class="fc2 ct"><input type="checkbox" name="cbox" value="<%=rs("idx")%>" onClick="goOK(<%=rs("idx")%>)"></td>
																</tr>
<%
					rs.MoveNext
					i = i + 1
					j = j - 1
			Loop
		Else
%>
																<tr height="100">
																	<td class="ct" colspan="15">등록된 정보가 없습니다.</td>
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
										<!--
										<tr>
											<td align="center" background="/img/adm/box03.gif">
												<a href="album_w.asp" class="btn btn25"><span>사진등록</span></a>
											</td>
										</tr>
										//-->
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