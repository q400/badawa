<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->

<link rel="stylesheet" type="text/css" href="/inc/css/base.css">
<script type="text/javascript" src="/inc/js/shared.js"></script>


<div style="background-color:#ffd200;margin-top:10px;">
<table width=100% height=100 border=0 cellspacing=5 cellpadding=0>
	<tr>
<%
	dbo()
	shipid						= SQLI(Request("shipid"))
'	dt							= SQLI(Request("dt"))

	rso()
	SQL = " SELECT TOP 30 * FROM _ogalt020 WHERE shipid = "& shipid &" ORDER BY wdate DESC "
	rs.open SQL, dbcon
	While Not rs.eof
				Set rs3 = Server.CreateObject("ADODB.Recordset")
				SQL = " SELECT TOP 30 seq, title, uno, shipid, wdate, chuljo, multime, weather, pago, ipzil, jogwa, bestfish, fishsize, ddate, contents " _
					& " FROM _ogalt020 " _
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
					SQL = " SELECT TOP 1 idx, seq, fpath, fnm, onm, fsz, fwd, ext, best, ddate " _
						& " FROM _ogalt021 " _
						& " WHERE seq = "& rs3("seq") _
						& " ORDER BY seq DESC "
					rs5.open SQL, dbcon

					If Not rs5.eof Then
						pphoto		= rs5("fpath") &"/"& rs5("fnm")
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
		<td width=100 class="ct vt">
			<a href="gallery5_v.asp?shipid=<%=rs("shipid")%>&dt=<%=rs("wdate")%>#<%=rs("wdate")%>" target="_top">
			<img src="<%=pphoto%>" width="100" id="<%=rs("wdate")%>" title="<%=rs("wdate")%>" class="vm" style="margin-top:8px;border-radius:5px;" /></a>
		</td>
		<td class="vt pt10">
			<div style="width:90px;">
				<a href="gallery5_v.asp?shipid=<%=rs("shipid")%>&dt=<%=rs("wdate")%>#<%=rs("wdate")%>" target="_top"><b class="ff fcb ls"><%=wdate%></b></a>
			</div>
			<div>
				<!-- <a href="gallery5_v.asp?shipid=<%=shipid%>&dt=<%=rs("wdate")%>" target="_top"><b class="f15 ls2"><%=shipInfo(shipid, "shipnm")%> 조황</b></a>
				<br> -->
				<p class="f11" style="line-height:14px;">종류 : <%=chuljo%></p>
				<p class="f11" style="line-height:14px;">물떄 : <%=multime%></p>
				<p class="f11" style="line-height:14px;">조과 : <%=jogwa%></p>
			</div>
		</td>
<%
		rs.MoveNext
	Wend
	rsc()
	dbc()
%>
	</tr>
</table>
</div>