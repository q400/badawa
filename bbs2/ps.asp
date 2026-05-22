<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	shipid						= SQLI(Request("shipid"))
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	page						= SQLI(Request("page"))
	op							= SQLI(Request("op"))
	setsize						= 10							'보여지는 페이지 수
	pgsize						= 10							'보여지는 게시물 수
	tag							= 33

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

	If shipid <> "" Then
		param = param & " AND shipid = "& shipid
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
function goSearch() {
	var f = document.fm1;
	f.action = "ps.asp";
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
			<table width="1200" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="250" valign="top"><!-- #include virtual = "/inc/left/fish.asp" --></td>
					<td width="810" valign="top">
						<table width="810" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="21"></td>
							</tr>
							<tr>
								<td><img src="/img/fish_info_tle.gif" width="335" height="24" /></td>
							</tr>
							<tr>
								<td height="15"></td>
							</tr>
							<tr>
								<td><img src="/img/fish_ps.gif" width="180" height="18" alt="조황후기" /></td>
							</tr>
							<tr>
								<td height="20"></td>
							</tr>

							<tr>
								<td>

					<div style="width:810px; border:0px solid #000;" class="mb10">
						<ul>
							<li class="ct ib pt" style="width:80px; border:1px solid #ccc;" onClick="location='ps.asp'">전체</a></li>
<%
	rso()
	i = 0
	SQL = " SELECT shipid, shipnm, captain, sz, capa, speed, equip, tel, hp, homp, bank, acc, ddate, active_yn, memo FROM _oshpt010 "
	rs.open SQL, dbcon
	While Not rs.eof
		If shipid = rs("shipid") Then
			bgcolor = "#59c"
			fncolor = "#fff"
		Else
			bgcolor = "#fff"
			fncolor = "#000"
		End If
%>
							<li class="ct ib pt" style="width:80px; border:1px solid #ccc;" onClick="location='?shipid=<%=rs("shipid")%>'"><%=rs("shipnm")%></a></li>
<%
		rs.MoveNext
		i = i + 1
	Wend
	rsc()
%>
						</ul>
					</div>

								</td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>

							<tr>
								<td class="rg" bgcolor="#ffffff">
									<!-- 게시물 검색 시작 -->
<form name="fm1" method="post">

									<table border="0" cellspacing="0" cellpadding="0" align="right">
										<tr>
											<td>&nbsp;</td>
											<td width="50">
												<select name="cd1" class="bx1" id="search" style="width:110px;">
												<option value=""<%If cd1 = "" Then%> selected<%End If%>>선택</option>
												<option value="unm"<%If cd1 = "unm" Then%> selected<%End If%>>작성자(닉네임)</option>
												<option value="title"<%If cd1 = "title" Then%> selected<%End If%>>글제목</option>
												</select>
											</td>
											<td width="5"></td>
											<td><input type="text" name="cd2" maxlength="10" class="bx1" onKeyDown="writeKeyDown()" style="width:120px; ime-mode:active;"></td>
											<td width="5"></td>
											<td><a href="javascript:goSearch()" class="btn btn18"><span>검색</span></a></td>
										</tr>
									</table>
</form>
									<!-- 게시물 검색 끝 -->
								</td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>

							<tr>
								<td><hr style="border:1px dashed #83d4cd;" /></td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>
							<tr>
								<td>

									<table width="810" border="0" cellspacing="0" cellpadding="0">
										<tr>
<%
		rso()
		SQL = " SELECT seq, shipid, title, uno, unm, cnt, rdate, ddate FROM _obbst050 "& param &" ORDER BY ddate ASC LIMIT "& stpage &","& pgsize
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
				pphoto = "/img/icon/noimages.png"'"/img/noimg120.png"

				Set rs5 = Server.CreateObject("ADODB.Recordset")
				SQL = " SELECT idx, seq, fpath, fnm, ext, best FROM _obbst051 WHERE seq = "& rs("seq") &" ORDER BY seq DESC LIMIT 1 "
				rs5.open SQL, dbcon
				If Not rs5.eof Then
					pphoto		= rs5("fpath") &"/"& rs5("fnm")
				End If
				rs5.close
				Set rs5 = Nothing

				Set rs5 = Server.CreateObject("ADODB.Recordset")
				SQL = " SELECT ISNULL(COUNT(*),0) FROM _obbst051 WHERE seq = "& rs("seq")
				rs5.open SQL, dbcon
				If Not rs5.eof Then
					pcnt		= CInt(rs5(0))
				End If
				rs5.close
				Set rs5 = Nothing

				Set rs5 = Server.CreateObject("ADODB.Recordset")
				SQL = " SELECT ISNULL(COUNT(*),0) FROM _obbst052 WHERE seq = "& rs("seq")
				rs5.open SQL, dbcon
					commcnt		= CInt(rs5(0))
				rs5.close
				Set rs5 = Nothing
%>
											<td valign="top">
												<table width="400" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="120" valign="top">
															<a href="ps_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>"><img src="<%=pphoto%>" width="120" class="pt5 pb5" /></a>
														</td>
														<td width="10"></td>
														<td valign="top">
															<table width="270" border="0" cellspacing="0" cellpadding="0">
																<tr height="30">
																	<td>
																		<a href="ps_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>"><font class="f13 ff fb fc9 ls"><%=rs("rdate")%>
																		&nbsp;&nbsp;(<%=shipinfo(rs("shipid"),"shipnm")%>)</font></a>
																		<%If Date() - CDate(rs("rdate")) < 7 Then%><img src="/img/icon/new01.gif" width="29" height="12" class="vm"><%End If%>
																	</td>
																</tr>
																<tr>
																	<td><a href="ps_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>"><b><%=rs("unm")%></b>님의 조황</a></td>
																</tr>
																<tr>
																	<td><%=Left(rs("ddate"),10)%>&nbsp;&nbsp;&nbsp;<span class="fc7">사진수 : <b><%=pcnt%></b></span> / <span class="fc7">덧글수 : <b><%=commcnt%></b></span></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
<%				If i Mod 2 = 0 Then %>
										</tr>
										<tr>
											<td height="5"></td>
										</tr>
										<tr>
											<td height="1" colspan="10" bgcolor="#d8d8d8"></td>
										</tr>
										<tr>
<%				End If
				rs.MoveNext
				i = i + 1
				j = j - 1
			Loop
		Else
%>
											<td class="ct" colspan="10" height="100">등록된 조황후기가 없습니다.</td>
<%
		End If
		rsc()
%>

										</tr>
									</table>

								</td>
							</tr>

							<tr>
								<td></td>
							</tr>
							<tr>
								<td><img src="/img/bbs_line02.gif" width="810" height="5" /></td>
							</tr>
							<tr>
								<td class="ct" bgcolor="#ffffff">

		<div class="bxPaging">
<%
		blockpage = Int((page-1)/10)*10 + 1
		If blockpage = 1 Then %>
<%		Else %>
<a href="?page=1&cd1=<%=cd1%>&cd2=<%=cd2%>&shipid=<%=shipid%>" class="btn btn21"><span>처음으로</span></a>
<a href="?page=<%=blockpage-1%>&cd1=<%=cd1%>&cd2=<%=cd2%>&shipid=<%=shipid%>" class="btn btn21"><span>이전</span></a>
<%		End If
		i = 0
		Do Until i = 10 Or (blockpage + i) > totalpage
			If CInt(page) = blockpage + i Then %>
<a href="?page=<%=blockpage + i%>&cd1=<%=cd1%>&cd2=<%=cd2%>&shipid=<%=shipid%>" class="ff fb ls"><%=setP(blockpage + i)%></a>&nbsp;
<%			Else %>
<a href="?page=<%=blockpage + i%>&cd1=<%=cd1%>&cd2=<%=cd2%>&shipid=<%=shipid%>" class="ff ls"><%=setP(blockpage + i)%></a>&nbsp;
<%			End If
			i = i + 1
		Loop
		If (blockpage + i - 1) = totalpage Then %>
<%		Else %>
<a href="?page=<%=blockpage+10%>&cd1=<%=cd1%>&cd2=<%=cd2%>&shipid=<%=shipid%>" class="btn btn21"><span>다음</span></a>
<a href="?page=<%=totalpage%>&cd1=<%=cd1%>&cd2=<%=cd2%>&shipid=<%=shipid%>" class="btn btn21"><span>끝으로</span></a>
<%		End If %>
		</div>
								</td>
							</tr>
							<tr>
								<td class="rg" bgcolor="#ffffff">
<%		If FID_ID <> "" Then %>
									<!-- <a href="ps_w.asp" class="btn btn25"><span>후기쓰기</span></a> -->
<%		Else %>
									<!-- <a href="/mem/login.asp?preURL=/bbs2/ps.asp">로그인 후 글을 쓸 수 있습니다.</a> -->
<%		End If %>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
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