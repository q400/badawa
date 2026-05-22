<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	page						= SQLI(Request("page"))
	op							= SQLI(Request("op"))
	setsize						= 10							'보여지는 페이지 수
	pgsize						= 20							'보여지는 게시물 수

	If cd1 = "" Then cd1 = "title"
	If page = "" Then
		page = 1
		startpage = 1
	Else
		page = CInt(page)
		startpage = Int(page/setsize)
		If startpage = (page/setsize) Then
			startpage = page - setsize + 1
		Else
			startpage = Int(page / setsize) * setsize + 1
		End If
	End If
	stpage						= Int((page - 1) * pgsize)		'각 페이지에 맞게 잘라올 시작값

	pagesize = 20
	Set cx = New BsfCode

	If cd2 <> "" Then
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' "
	Else
		param = " WHERE 1 = 1 "
	End If

	Call rso()
	SQL = " SELECT	COUNT(*) FROM _obbst020 "& param
	rs.open SQL, dbcon, 3
		recordcount = CInt(rs(0))
	Call rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
%>

<table width="100%"  border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td bgcolor="#ffffff">
			<table width="1100" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="250" valign="top"><!-- #include virtual = "/inc/left/fish.asp" --></td>
					<td width="710" valign="top">
						<table width="710" border="0" cellspacing="0" cellpadding="0">
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
								<td><img src="/img/fish_myps.gif" width="180" height="18" /></td>
							</tr>
							<tr>
								<td height="30">&nbsp;</td>
							</tr>
							<tr>
								<td>
									<table width="710" border="0" cellspacing="0" cellpadding="0">
										<tr>
<%
	Call rso()
	SQL = " SELECT shipid, shipnm, captain, sz, capa, speed, equip, tel, hp, homp, bank, acc, ddate, active_yn, memo FROM _oshpt010 "
	rs.open SQL, dbcon
	While Not rs.eof
%>
											<td width="75" class="fb ct ls"><a href="gallery_v.asp?shipid=<%=rs("shipid")%>"><%=rs("shipnm")%></a></td>
											<td width="2"><img src="/img/gall_line.gif" width="2" height="11" /></td>
<%
		rs.MoveNext
	Wend
	Call rsc()
%>
											<td>&nbsp;</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>
							<tr>
								<td><img src="/img/bbs_line02.gif" width="710" height="5" /></td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>
							<tr>
								<td>

									<table width="710" border="0" cellspacing="0" cellpadding="0">
										<tr>
<%
		Call rso()
		SQL = " SELECT	TOP 15 * FROM _oshpt010 "& param _
			& " AND seq NOT IN (SELECT TOP "& ((page-1) * 15) &" seq FROM _oshpt010 "& param _
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
				SQL = " SELECT TOP 1 seq, title, uno, shipid, wdate, chuljo, multime, weather, pago, ipzil, jogwa, bestfish, fishsize, ddate, contents FROM _obbst020 WHERE shipid = "& rs("shipid") &" ORDER BY seq DESC "
				rs3.open SQL, dbcon
				If Not rs3.eof Then
					Set rs5 = Server.CreateObject("ADODB.Recordset")
					SQL = " SELECT TOP 1 idx, seq, fpath, fnm, ext, best FROM _obbst021 WHERE seq = "& rs3("seq") &" ORDER BY seq DESC "
					rs5.open SQL, dbcon
					If Not rs5.eof Then
						pphoto		= rs5("fpath") &"/"& rs5("fnm")
						wdate		= rs3("wdate")
						chuljo		= rs3("chuljo")
						multime		= rs3("multime")
						weather		= rs3("weather")
						pago		= rs3("pago")
						ipzil		= rs3("ipzil")
						jogwa		= rs3("jogwa")
						bestfish	= rs3("bestfish")
						fishsize	= rs3("fishsize")
					End If
					rs5.close
					Set rs5 = Nothing
				Else
						pphoto		= "/img/icon/camera04.gif"
						wdate		= "-"
						chuljo		= "-"
						multime		= "-"
						weather		= "-"
						pago		= "-"
						ipzil		= "-"
						jogwa		= "-"
						bestfish	= "-"
						fishsize	= "-"
				End If
				rs3.close
				Set rs3 = Nothing
%>
											<td>
												<table width="350" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="90" valign="top">
															<a href="gallery_v.asp?shipid=<%=rs("shipid")%>">
															<img src="<%=pphoto%>" width="90" /><br>
															<span class="f11">출조 :&nbsp;&nbsp;<b><%=chuljo%>/<%=multime%></b></span></a>
														</td>
														<td width="5"></td>
														<td width="255">
															<table width="250" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="160"><a href="gallery_v.asp?shipid=<%=rs("shipid")%>"><b><%=rs("shipnm")%> 조황</b></a></td>
																	<td width="90" class="ff f11 ls"><%=wdate%></td>
																</tr>
																<tr>
																	<td colspan="2" onClick="location='gallery_v.asp?shipid=<%=rs("shipid")%>'">
																		<table width="250" border="1" cellspacing="0" cellpadding="0" bordercolor="#ffffff" style="border-collapse:collapse;">
																			<tr>
																				<td width="50" class="f11 ct">날씨</td>
																				<td width="50" class="f11 ct">파고</td>
																				<td width="50" class="f11 ct">입질</td>
																				<td width="50" class="f11 ct">조과</td>
																				<td width="50" class="f11 ct">최대어</td>
																			</tr>
																			<tr>
																				<td class="f11 ct"><%=weather%></td>
																				<td class="f11 ct"><%=pago%></td>
																				<td class="f11 ct"><%=ipzil%></td>
																				<td class="f11 ct"><%=jogwa%></td>
																				<td class="f11 ct"><%=bestfish%><br><%=fishsize%></td>
																			</tr>
																		</table>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
<%				If i Mod 2 = 0 Then %>
										</tr>
										<tr>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td height="1" colspan="10" bgcolor="#d8d8d8"></td>
										</tr>
										<tr>
											<td>&nbsp;</td>
										</tr>
										<tr>
<%				End If
				rs.MoveNext
				i = i + 1
				j = j - 1
			Loop
		Else
%>
											<td align="center" valign="middle" colspan="10">등록된 조황정보가 없습니다.</td>
<%
		End If
		Call rsc()
%>

										</tr>
									</table>

								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td height="1" bgcolor="#d8d8d8"></td>
							</tr>

							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td><img src="/img/bbs_line02.gif" width="710" height="5" /></td>
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

</body>
</html>
<!-- #include virtual = "/inc/footer.asp" -->