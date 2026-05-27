<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	dbo()
	shipid						= SQLI(Request("shipid"))
	idx							= SQLI(Request("idx"))
	op							= SQLI(Request("op"))
	flag						= SQLI(Request("flag"))

	If idx = "" Then
		Call AlertClose("문제가 있습니다.")
		Response.End
	End If

	Select Case op
		Case "ship"		: title = "선박사진"			: tblnm = "_oshpt011" :
		Case Else		: title = ""				: tblnm = "_obbst011" :
	End Select

	rso()
	SQL = " SELECT	idx, shipid, fpath, fnm, fsz, fwd, ext, comment FROM "& tblnm &" WHERE idx = "& idx
	rs.open SQL, dbcon, 3
	If Not rs.eof Then
		shipid					= rs("shipid")
		fpath					= rs("fpath")
		fnm						= rs("fnm")
		fsz						= rs("fsz")
		fwd						= rs("fwd")
		ext						= rs("ext")
		comment					= rs("comment")
	Else
		Call AlertClose("해당 이미지가 없습니다.        ")
		Response.End
	End If
	rsc()

	pvP = 0
	ntP = 0

	rso()
	SQL = " SELECT TOP 1 idx FROM "& tblnm &" WHERE shipid = "& shipid &" AND idx < "& idx &" ORDER BY idx DESC "
	rs.open SQL, dbcon
	If Not rs.eof Then
		pvP = rs(0)
	End If
	rsc()

	rso()
	SQL = "	SELECT TOP 1 idx FROM "& tblnm &" WHERE shipid = "& shipid &" AND idx > "& idx &" ORDER BY idx "
	rs.open SQL, dbcon
	If Not rs.eof Then
		ntP = rs(0)
	End If
	rsc()
%>

<script language="javascript">
<!--
function goSave() {
	var f = document.fm1;
	f.action = "imgv_ship_x.asp";
	f.method = "post";
	f.submit();
}
//-->
</script>

<table width="700" border="0" cellpadding="0" cellspacing="0" align="center">
<form name="fm1" method="post">
<input type="hidden" name="idx" value="<%=idx%>">

	<tr>
		<td class="ct">
			<table width="680" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="10"></td>
				</tr>
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td class="ct"><img src="<%=fpath &"/"& fnm &"."& ext%>" style="cursor:point;" onClick="window.close();"></td><!-- onClick="goClose(0)" -->
							</tr>
						</table>
					</td>
				</tr>
				<tr height="30">
					<td align="center">
						<input type="text" name="comment" value="<%=comment%>" style="width:500px; ime-mode:active;">
						<a href="javascript:goSave();" class="btn btn25"><span>설명저장</span></a>
<%		If pvp <> 0 Then %>
						<a href="?shipid=<%=shipid%>&idx=<%=pvP%>&op=ship" class="btn btn25" title="이전사진"><span>◁</span></a>
<%		End If %>
<%		If ntp <> 0 Then %>
						<a href="?shipid=<%=shipid%>&idx=<%=ntP%>&op=ship" class="btn btn25" title="다음사진"><span>▷</span></a>
<%		End If %>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>
</body>
</html>
<%	dbc() %>