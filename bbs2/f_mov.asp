<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	page						= SQLI(Request("page"))
	op							= SQLI(Request("op"))
	pgsize						= 50							'보여지는 게시물 수
	tag							= 2

	If cd1 = "" Then cd1 = "title"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If

	Set cx = New BsfCode

	If cd2 <> "" Then
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' "
	Else
		param = " WHERE 1=1 "
	End If

	rso()
	SQL = " SELECT COUNT(*) FROM _obbst020 "& param
	rs.open SQL, dbcon, 3
		recordcount = CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
%>


<div id="wrap">
	<div>
		<ul>
			<li class="ib vt" style="width:230px;"><!-- #include virtual = "/inc/left/fish.asp" --></li>
			<li class="ib vt">
				<div id="mainwrap4">
					<div class="mt20">
						<img src="/img/fish_info_tle.gif" alt="조황정보" title="조황정보" />
					</div>
					<div class="mt10 mb10">
						<img src="/img/fish_gallery.gif" alt="조황갤러리" title="조황갤러리" />
					</div>

					<div style="width:810px; border:0px solid #000;" class="mb10">
						<ul>
							<li class="ct ib" style="width:100px; border:1px solid #ccc;" onClick="location='gallery3.asp'">전체</a></li>
<%
	rso()
	i = 0
	SQL = " SELECT shipid, shipnm, captain, sz, capa, speed, equip, tel, hp, homp, bank, acc, ddate, active_yn, memo " _
		& " FROM _oshpt010 "
	rs.open SQL, dbcon
	While Not rs.eof
%>
							<li class="ct ib pt" style="width:100px; border:1px solid #ccc;" onClick="location='gallery3_v.asp?shipid=<%=rs("shipid")%>'"><%=rs("shipnm")%></a></li>
<%
		rs.MoveNext
		i = i + 1
	Wend
	rsc()
%>
						</ul>
					</div>
					<hr style="border:1px solid #ccc;">
					<div style="width:810px;">
<%
		rso()
		SQL = " SELECT TOP 50 * FROM _oshpt010 "& param _
			& " AND shipid NOT IN (SELECT TOP "& ((page-1) * 50) &" shipid FROM _oshpt010 "& param _
			& " ORDER BY shipid ASC) ORDER BY shipid ASC "
		rs.open SQL, dbcon, 0, 3

		j = recordcount

		If Not (rs.eof And rs.bof) Then
			If page <> 1 Then
				j = j - (page - 1) * pgsize
			End If

			i = 1
			rs.MoveFirst
			Do Until rs.EOF
				Set rs3 = Server.CreateObject("ADODB.Recordset")
				SQL = " SELECT TOP 1 seq, title, uno, shipid, wdate, chuljo, multime, weather, pago, ipzil, jogwa, bestfish, fishsize, ddate, contents " _
					& " FROM _ogalt020 " _
					& " WHERE shipid = "& CInt(rs("shipid")) _
					& " ORDER BY wdate DESC "
				rs3.open SQL, dbcon

				If Not rs3.eof Then
					seq			= rs3("seq")
					shipid		= CInt(rs3("shipid"))
					wdate		= rs3("wdate")
					chuljo		= rs3("chuljo")
					multime		= rs3("multime")
					weather		= rs3("weather")
					pago		= rs3("pago")
					ipzil		= rs3("ipzil")
					jogwa		= rs3("jogwa")
					bestfish	= rs3("bestfish")
					fishsize	= rs3("fishsize")
					hdate		= rs3("ddate")

					Set rs5 = Server.CreateObject("ADODB.Recordset")
					SQL = " SELECT TOP 1 idx, seq, fpath, fnm, onm, fsz, fwd, ext, best, ddate "_
						& " FROM _ogalt021 "_
						& " WHERE seq = "& seq _
						& " AND best = 1 "
					'Response.Write SQL &"<br>"
					rs5.open SQL, dbcon

					If Not rs5.eof Then
						pphoto		= rs5("fpath") &"/"& rs5("fnm")
					Else
						pphoto		= "/img/icon/noimages.gif"
					End If
					rs5.close
					Set rs5 = Nothing
				Else
						wdate		= "1990-01-01"
						chuljo		= "-"
						multime		= "-"
						weather		= "-"
						pago		= "-"
						ipzil		= "-"
						jogwa		= "-"
						bestfish	= "-"
						fishsize	= "-"
						pphoto		= "/img/icon/noimages.gif"
				End If
				rs3.close
				Set rs3 = Nothing
%>
						<div style="width:380px;" class="ib mt20 mr20">
							<span class="ib vt mr10"><a href="gallery3_v.asp?shipid=<%=rs("shipid")%>"><img src="<%=pphoto%>" width="150" class="gbox03" /></a></span>
							<span class="ib vt mr10">
								<table width="200" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="24">
											<table width="200" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="24"><img src="/img/icon_boat.gif" width="20" height="23" /></td>
													<td class="f12 fb fc9">
														<a href="gallery3_v.asp?shipid=<%=rs("shipid")%>"><%=rs("shipnm")%> / <font class="fc2 f11 ls"><%=wdate%></font></a>
														<%If Date() - CDate(wdate) < 5 Then%><img src="/img/icon/new05.gif" width="23" height="15" class="vm"><%End If%>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td height="1" background="/img/dot.gif"></td>
									</tr>
									<tr>
										<td height="23">
											<table width="200" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="40" class="fb">출조:</td>
													<td class="fc2"><%=chuljo%>/<%=multime%></td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td height="1" background="/img/dot.gif"></td>
									</tr>
									<tr>
										<td height="23">
											<table width="200" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="40" class="fb">날씨:</td>
													<td width="40" class="fc2"><%=weather%></td>
													<td width="40" class="fb">파고:</td>
													<td class="fc2"><%=pago%></td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td height="1" background="/img/dot.gif"></td>
									</tr>
									<tr>
										<td height="23">
											<table width="200" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="40" class="fb">입질:</td>
													<td width="40" class="fc2"><%=ipzil%></td>
													<td width="40" class="fb">조과:</td>
													<td class="fc2"><%=jogwa%></td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td height="1" background="/img/dot.gif"></td>
									</tr>
									<tr>
										<td height="23">
											<table width="200" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="50" class="fb">최대어:</td>
													<td class="fc2"><%=bestfish%><%=fishsize%></td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
							</span>
						</div>
<%
				rs.MoveNext
				i = i + 1
				j = j - 1
			Loop
		Else
%>
						<div class="ct vm" colspan=10>등록된 조황정보가 없습니다.</div>
<%
		End If
		rsc()
%>
					</div>
					<div class="pt20 pb20"></div>
				</div>
			</li>
			<li class="ib vt"><!-- #include virtual = "/inc/quick.asp" --></li>
		</ul>
	</div>
</div>
<!-- #include virtual = "/inc/footer.asp" -->
