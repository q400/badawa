<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	page						= SQLI(Request("page"))
	op							= SQLI(Request("op"))
	setsize						= 10							'보여지는 페이지 수
	pgsize						= 15							'보여지는 게시물 수

	If cd1 = "" Then cd1 = "unm"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If
	stpage						= Int((page - 1) * pgsize)		'각 페이지에 맞게 잘라올 시작값

	Set cx = New BsfCode

	If cd2 <> "" Then
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' "
	Else
		param = " WHERE 1 = 1 "
	End If

	rso()
	SQL = " SELECT	COUNT(*) FROM _obbst050 "& param
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
	f.action = "ps.asp";
	f.method = "post";
	f.submit();
}
function writeKeyDown(){
	if(event.keyCode == 13)	goSearch();
}
function PointPlus(vseq,sid,rdt,ppnt){
	var f = document.fm1;
	if(confirm("기본 500 포인트 + "+ ppnt +" 포인트를 적립합니까?       ")){
		f.seq.value = vseq;
		f.shipid.value = sid;
		f.rdate.value = rdt;
		f.pnt.value = ppnt;
		f.flag.value = "PP";
		f.action = "ps_x.asp";
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
<input type="hidden" name="seq">
<input type="hidden" name="shipid">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="pnt">
<input type="hidden" name="flag">
<input type="hidden" name="rdate">
<input type="hidden" name="idx">

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
										</tr>
										//-->
										<tr>
											<td align="center" background="/img/adm/box03.gif">
												<table width="790" border="0" cellspacing="0" cellpadding="0" class="lf">
													<tr height="46">
														<td width="200" class="fc2 fb">조황후기관리</td>
														<td align="right">
															<table border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="10"></td>
																	<td width="90" height="46">
																		<select name="cd1" style="width:70px;">
																		<option value=""<%If cd1 = "" Then%> selected<%End If%>>선택</option>
																		<option value="unm"<%If cd1 = "unm" Then%> selected<%End If%>>작성자</option>
																		<option value="title"<%If cd1 = "title" Then%> selected<%End If%>>글제목</option>
																		</select>
																	</td>
																	<td width="10"></td>
																	<td width="100"><input type="text" name="cd2" class="bx1" style="width:100px;ime-mode:active;" align="absmiddle" /></td>
																	<td width="10"></td>
																	<td width="36"><a href="javascript:goSearch()" class="btn btn18"><span>검색</span></a></td>
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
														<td height=1 bgcolor="#777"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td align="center" background="/img/adm/box03.gif">
												<table width="790" border=0 cellspacing="0" cellpadding="0" align="center" style="border-collapse:collapse; border:1px solid #bbb;">
													<tr>
														<td align="center">

															<!-- 리스트 시작 -->
															<table width="788" border="0" cellspacing="0" cellpadding="0">
																<tr height="32">
																	<th width="60" bgcolor="f1f1f1" class="fc2 fb">번호</th>
																	<th width="80" bgcolor="f1f1f1" class="fc2 fb">해당선박</th>
																	<th bgcolor="f1f1f1" class="fc2 fb">제 목</th>
																	<th width="80" bgcolor="f1f1f1" class="fc2 fb">글쓴이</th>
																	<th width="80" bgcolor="f1f1f1" class="fc2 fb">출조일자</th>
																	<th width="80" bgcolor="f1f1f1" class="fc2 fb">작성일</th>
																	<th width="50" bgcolor="f1f1f1" class="fc2 fb">사진수</th>
																	<th width="70" bgcolor="f1f1f1" class="fc2 fb">포인트</th>
																</tr>
																<tr>
																	<td height="1" bgcolor="#b0b0b0" colspan="10"></td>
																</tr>
																<tr>
																	<td height="1" bgcolor="#fafafa" colspan="10"></td>
																</tr>
<%
		rso()
		SQL = " SELECT	* FROM _obbst050 "& param &" ORDER BY ddate DESC LIMIT "& stpage &","& pgsize
		rs.open SQL, dbcon, 0, 3
'		rs.pagesize = 20
		j = recordcount

		If Not (rs.eof And rs.bof) Then
			If page <> 1 Then
				j = j - (page - 1) * pgsize
			End If

			i = 1
			rs.MoveFirst
			Do Until rs.EOF
				point = 0
				Set rs3 = Server.CreateObject("ADODB.Recordset")
				SQL = " SELECT IFNULL(COUNT(*),0) FROM _obbst051 WHERE seq = "& rs("seq")
				rs3.open SQL, dbcon
					pcnt = CInt(rs3(0))
				rs3.close
				Set rs3 = Nothing
				Set rs3 = Server.CreateObject("ADODB.Recordset")
				SQL = " SELECT point FROM _opntt010 WHERE seq = "& rs("seq") &" AND op = '+' AND note LIKE '조황후기%' "
				rs3.open SQL, dbcon
				If Not rs3.eof Then
					point = rs3(0)
				End If
				rs3.close
				Set rs3 = Nothing
%>
																<tr height="32">
																	<td bgcolor="f1f1f1" class="fc2 ct"><%=j%></td>
																	<td bgcolor="f1f1f1" class="fc2 ct">
																		<a href="ps_v.asp?seq=<%=rs("seq")%>&sdate=<%=rs("rdate")%>&cd1=<%=cd1%>&cd2=<%=cd2%>&page=<%=page%>"><%=shipInfo(rs("shipid"),"shipnm")%></a>
																	</td>
																	<td bgcolor="f1f1f1" class="fc2 lf">&nbsp;
																		<a href="ps_v.asp?seq=<%=rs("seq")%>&sdate=<%=rs("rdate")%>&cd1=<%=cd1%>&cd2=<%=cd2%>&page=<%=page%>"><%=rs("title")%></a></td>
																	<td bgcolor="f1f1f1" class="fc2 ct"><%=meminfo(rs("uno"),"uname")%></td>
																	<td bgcolor="f1f1f1" class="fc2 ct"><%=rs("rdate")%></td>
																	<td bgcolor="f1f1f1" class="fc2 ct"><%=Left(rs("ddate"),10)%></td>
																	<td bgcolor="f1f1f1" class="ff fc2 f11 ls ct"><%=pcnt%></td>
																	<td bgcolor="f1f1f1" class="ct">
<%					If point = 0 Then %>
																		<a href="javascript:PointPlus(<%=rs("seq")%>,<%=rs("shipid")%>,'<%=rs("rdate")%>',<%=pcnt * pnt_ps%>);"><span class="ff fcr f11 ls"><%=FormatNumber(point,0)%></span></a>
<%					Else %>
																		<span class="ff fcr f11 ls"><%=FormatNumber(point,0)%></span>
<%					End If %>
																	</td>
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
															<!-- 리스트 끝 -->

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
											<td background="/img/adm/box03.gif" height="20"></td>
										</tr>
										<tr>
											<td height="10" background="/img/adm/box03.gif" class="lf">
												<span class="fc9 pl30">※ 이 목록에서 포인트가 0 인 경우 "포인트"를 눌러 바로 적립 가능합니다.</span>
												<br>
												<span class="fc9 pl30">※ 실제 해당 일자에 등록자 아이디의 출조가 없으면 적립이 불가능합니다.</span>
											</td>
										</tr>
										<tr>
											<td background="/img/adm/box03.gif" height="50"></td>
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
	<tr>
		<td height="50"></td>
	</tr>
</table>
<!-- #include virtual = "/_adm/inc/footer.asp" -->