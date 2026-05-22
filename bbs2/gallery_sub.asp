<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>안흥낚시에 오신걸 환영합니다. <%=FID_ID%></title>
<link rel="stylesheet" type="text/css" href="/inc/css/base.css">
<script language="JavaScript" src="/inc/js/shared.js"></script>
</head>


<body style="background-color:#ffffff;">
<%
	dbo()
	shipid						= SQLI(Request("shipid"))
'	dt							= SQLI(Request("dt"))

	rso()
	SQL = " SELECT TOP 30 * FROM _obbst020 WHERE shipid = "& shipid &" ORDER BY wdate DESC "
	rs.open SQL, dbcon
	While Not rs.eof
				Set rs3 = Server.CreateObject("ADODB.Recordset")
				SQL = " SELECT TOP 30 seq, title, uno, shipid, wdate, chuljo, multime, weather, pago, ipzil, jogwa, bestfish, fishsize, ddate, contents " _
					& " FROM _obbst020 " _
					& " WHERE shipid = "& rs("shipid") &" AND seq = "& rs("seq") _
					& " ORDER BY wdate DESC "
				rs3.open SQL, dbcon

				If Not rs3.eof Then
					wdate		= rs3("wdate")
					chuljo		= rs3("chuljo")
					multime		= rs3("multime")
					weather		= rs3("weather")
					pago		= rs3("pago")
					ipzil		= rs3("ipzil")
					jogwa		= rs3("jogwa")
					bestfish	= rs3("bestfish")
					fishsize	= rs3("fishsize")

					Set rs5 = Server.CreateObject("ADODB.Recordset")
					SQL = " SELECT TOP 1 idx, seq, shipid, yymmdd, imgur, ext, ddate " _
						& " FROM _ogalt010 " _
						& " WHERE seq = "& rs3("seq") _
						& " ORDER BY seq DESC "
					rs5.open SQL, dbcon

					If Not rs5.eof Then
						pphoto		= rs5("imgur") &"."& rs5("ext")
					Else
						pphoto		= "/img/icon/noimages.gif"
					End If
					rs5.close
					Set rs5 = Nothing
				Else
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
<table width="250" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="5"></td>
	</tr>
	<tr>
		<td width="106" height="75" class="ct vm" style="background-color:#cfcfcf;">
			<a href="gallery_v.asp?shipid=<%=rs("shipid")%>&dt=<%=rs("wdate")%>" target="_top"><img src="<%=pphoto%>" width="100" /></a>
		</td>
		<td width="10"></td>
		<td width="134">
			<table width="130" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td style="padding-bottom:5px;" class="lf"><a href="gallery_v.asp?shipid=<%=rs("shipid")%>&dt=<%=rs("wdate")%>" target="_top"><b class="ff f17 fc9 ls"><%=wdate%></b></a></td>
				</tr>
				<tr>
					<td>
						<a href="gallery_v.asp?shipid=<%=shipid%>&dt=<%=rs("wdate")%>" target="_top"><b class="f15 ls2"><%=shipInfo(shipid, "shipnm")%> 조황</b></a>
						<br>
						<span class="f11">(출조 :&nbsp;<%=chuljo%>/<%=multime%>)</span>
					</td>
				</tr>
				<!--
				<tr>
					<td colspan="2">
						<table width="370" border="1" cellspacing="0" cellpadding="0" bordercolor="#ffffff" style="border-collapse:collapse;">
							<tr>
								<td width="70" class="f11 ct">날씨</td>
								<td width="70" class="f11 ct">파고</td>
								<td width="70" class="f11 ct">입질</td>
								<td width="80" class="f11 ct">조과</td>
								<td width="80" class="f11 ct">최대어</td>
							</tr>
							<tr>
								<td class="f11 ct"><%=weather%></td>
								<td class="f11 ct"><%=pago%></td>
								<td class="f11 ct"><%=ipzil%></td>
								<td class="f11 ct"><%=jogwa%></td>
								<td class="f11 ct"><%=bestfish%><%=fishsize%></td>
							</tr>
						</table>
					</td>
				</tr>
				//-->
			</table>
		</td>
	</tr>
	<tr>
		<td height="5"></td>
	</tr>
</table>
<%
		rs.MoveNext
	Wend
	rsc()
	dbc()
%>
<table>
	<tr>
		<td height="30">&nbsp;</td>
	</tr>
</table>
</body>
</html>